-module(tester).
-export([test/0]).

test() ->
    S = connect:start(),
    play_move:doit(S, 4, 4),
    draw:draw(get_board:doit(S)),
    S.
   
