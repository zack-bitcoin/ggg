-module(play_move).
-export([doit/3]).

doit(S, X, Y) ->
    A = to_letter(X),
    B = integer_to_list(Y),
    C = A++B,
    Command = "black "++C++"\n",
    gen_tcp:send(S, list_to_binary(Command)),
    board:refresh(),
    gen_tcp:send(S, <<"genmove white\n">>).
    
to_letter(1) -> "A";
to_letter(2) -> "B";
to_letter(3) -> "C";
to_letter(4) -> "D";
to_letter(5) -> "E";
to_letter(6) -> "F";
to_letter(7) -> "G";
to_letter(8) -> "H";
to_letter(9) -> "J";
to_letter(10) -> "K";
to_letter(11) -> "L";
to_letter(12) -> "M";
to_letter(13) -> "N";
to_letter(14) -> "O";
to_letter(15) -> "P";
to_letter(16) -> "Q";
to_letter(17) -> "R";
to_letter(18) -> "S";
to_letter(19) -> "T".

		
    
