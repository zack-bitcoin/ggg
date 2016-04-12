-module(draw).
-export([test/0, draw/1]).
draw(B) ->
    L = length(B),
    convert_rows(1, B),
    os:cmd("convert " ++ rows(L) ++ " -append images/board.png"),
    os:cmd("rm row*.png").
format_number(N) ->
    lists:flatten(io_lib:format("~2.10.0B", [N])).
rows(0) -> "";
rows(N) ->
    R = rows(N-1),
    R ++ "row" ++ format_number(N) ++ ".png ".
convert_rows(_, []) -> ok;
convert_rows(N, [H|T]) -> 
    os:cmd("convert " ++ make_row(H) ++ "+append row" ++ format_number(N) ++ ".png"),
    convert_rows(N+1, T).
make_row([]) -> [];
make_row([43|X]) -> 
    "images/star.png "++make_row(X);
make_row([88|X]) -> 
    "images/black.png "++make_row(X);
make_row([79|X]) -> 
    "images/white.png "++make_row(X);
make_row([32|X]) -> 
    "images/empty.png "++make_row(X).
test() ->
    B = [ "                   ",
	  "                   ",
	  "               X   ",
	  "   +     +     +   ",
	  "               O   ",
	  "                   ",
	  "                   ",
	  "                   ",
	  "                   ",
	  "   +     +     +   ",
	  "                   ",
	  "                   ",
	  "                   ",
	  "                   ",
	  "                   ",
	  "   +     +     +   ",
	  "                   ",
	  "                   ",
	  "                   "],
    draw(B).