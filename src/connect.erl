-module(connect).
-export([test/0,start/0,start/2,quit/1]).

connect() -> connect(10).
connect(0) -> fail;
connect(N) ->
    Port = constants:gnu_port(),
    case gen_tcp:connect({127,0,0,1}, Port, [binary,{active, true}]) of
	{ok, Socket} -> Socket;
	{error, econnrefused} ->
	    timer:sleep(50),
	    connect(N-1)
    end.
	    
start() -> start(constants:difficulty(), constants:ram()).
start(Level, Ram) ->
    GPort = constants:gnu_port(),
    P = integer_to_list(GPort),
    L = integer_to_list(Level),
    R = integer_to_list(Ram), %default is about 11.
    Command = "gnugo --mode gtp --gtp-listen "++P++" --level "++L++" --cache-size " ++ R,
    erlang:open_port({spawn, Command}, []),
    connect(10).
quit(Socket) ->
    gen_tcp:send(Socket, <<"quit\n">>),
    gen_tcp:close(Socket).
test() ->
    S = connect(),
    draw:draw(get_board:doit(S)).
