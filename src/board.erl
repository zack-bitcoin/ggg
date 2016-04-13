-module(board).
-behaviour(gen_server).
-export([start_link/0,code_change/3,handle_call/3,handle_cast/2,handle_info/2,init/1,terminate/2, start/0,board/0,wait_on_gnugo/0,flush/0]).
init(ok) -> 
    {ok, null}.
start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, ok, []).
code_change(_OldVsn, State, _Extra) -> {ok, State}.
terminate(_, _) -> io:format("died!"), ok.
handle_info(_, X) -> {noreply, X}.
handle_cast(flush, _) -> 
    %flush(),
    dump(),
    {noreplay, 0};
handle_cast(_, X) -> {noreply, X}.
handle_call(wait, _From, _) -> 
    S = socket:fetch(),
    receive_eq(S),
    {reply, 0, 0};
handle_call(start, _From, _) -> 
    S = connect:start(),
    socket:store(S),
    B = get_board:doit(S),
    {reply, B, 0};
handle_call(board, _From, _) -> 
    S = socket:fetch(),
    B = get_board:doit(S),
    {reply, B, 0};
handle_call(_, _From, X) -> {reply, X, X}.
start() -> gen_server:call(?MODULE, start).
flush() -> gen_server:call(?MODULE, flush).
board() -> gen_server:call(?MODULE, board).
wait_on_gnugo() -> gen_server:call(?MODULE, wait, constants:wait_on_gnu()).
    
receive_eq(S) ->
    receive
	{tcp, S, X} ->
	    B = has_eq(X),
	    if
		B -> ok;
		true -> receive_eq(S)
	    end
    after
	constants:wait_on_gnu() -> fail
    end.

has_eq(<<61, _/binary>>) -> true;
has_eq(<<>>) -> false;
has_eq(<<_, X/binary>>) -> has_eq(X).
			 
dump() ->
    receive
        _ ->
	     dump()
    after 10 ->
	    
        ok
    end.
