-module(undo).
-export([doit/1]).

doit(S) ->
    Command = "undo\n",
    gen_tcp:send(S, list_to_binary(Command)),
    gen_tcp:send(S, list_to_binary(Command)).

    
