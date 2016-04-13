-module(get_board).
-export([doit/1, interpret/1]).

doit(S) ->
    gen_tcp:send(S, <<"showboard\n">>),
    receive_loop(S, <<"">>).
receive_loop(S, B) ->
    receive 
	{tcp, S, X} -> 
	    C = <<B/binary, X/binary>>,
	    L = binary_to_list(C),
	    Bool = full_board(L),
	    if
		Bool -> L;
		true -> receive_loop(S, C)
	    end
    after
	constants:wait_on_gnu() -> fail
    end.



interpret(L) ->
    read2(read_board(strip_front(strip_captures(L)))).
strip_captures([87,72,73,84,69|L]) -> %WHITE
    strip_captures2(L);
strip_captures([66,76,65,67,75|L]) -> %BLACK
    strip_captures2(L);
strip_captures([H|T]) -> [H|strip_captures(T)];
strip_captures([]) -> [].
strip_captures2([115,116,111,110,101,115|L]) -> %"stones"
    strip_captures(L);
strip_captures2([_|T]) -> strip_captures2(T);
strip_captures2([]) -> [].
    
strip_front([65,32,66,32,67,32,68,32,69,32,70,32,71,32,72,32|T]) -> T; %A B C D E F G H
strip_front([_|X]) -> strip_front(X).





full_board(C) ->
    D = lists:reverse(C),
    full_2(D).
full_2([84,32,83,32,82,32,81,32,80,32,79,32,78,32,77,32,76,32,75,32,74,32,72,32,71,32,70,32,69,32,68,32,67,32,66,32,65,32,32,32,10,49|_]) -> true; %the last line we care about looks like this: A B C D E F ...
full_2([_|X]) -> full_2(X);
full_2([]) -> false.
read_board([Y|[_|X]]) when (Y < 58) and (Y > 48)-> %the digits 1-9.
    {Row, Rest} = lists:splitwith(fun(A) -> Y =/= A end, X),
    B = case hd(Row) of
	    32 -> Row;%32 is " "
	    _ -> [32|Row]
	end,
    A = read_row(B),
    case Rest of
	[] -> [A];
	R -> [A|read_board(tl(tl(R)))]
    end;
read_board([_|X]) -> read_board(X);
read_board([]) -> [].
read_row([]) -> [];
read_row(R) ->    
    case lists:splitwith(fun(A) -> A =/= hd(" ") end, R) of
	{_, [_|[D|X]]}  -> [D|read_row(X)];
	{_,_} -> []
    end.
read2([Row|T]) -> [read_row2(Row)|read2(T)];
read2([]) -> [].
read_row2([46|T]) -> [32|read_row2(T)]; % "."
read_row2([C|T]) ->  [C|read_row2(T)];
read_row2([]) -> [].
