-module(board).
-behaviour(gen_server).
-export([start_link/0,code_change/3,handle_call/3,handle_cast/2,handle_info/2,init/1,terminate/2, start/0,refresh/0,board/0]).
init(ok) -> {ok, null}.
%S = connect:start(),
%draw:draw(get_board:doit(S)),
%{ok, S}.
start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, ok, []).
code_change(_OldVsn, State, _Extra) -> {ok, State}.
terminate(_, _) -> io:format("died!"), ok.
handle_info(_, X) -> {noreply, X}.
handle_cast(refresh, _) -> 
    S = socket:fetch(),
    %draw:draw(get_board:doit(S)),
    B = get_board:doit(S),
    spawn(draw, draw, [B]),
    timer:sleep(500),
    {noreply, S};
handle_cast(start, _) -> 
    S = connect:start(),
    socket:store(S),
    B = get_board:doit(S),
    spawn(draw, draw, [B]),
    timer:sleep(500),
    %draw:draw(get_board:doit(S)),
    {noreply, S};
handle_cast(_, X) -> {noreply, X}.
handle_call(board, _From, X) -> 
    S = socket:fetch(),
    B = get_board:doit(S),
    {reply, B, X};
handle_call(_, _From, X) -> {reply, X, X}.
start() -> gen_server:cast(?MODULE, start).
refresh() -> gen_server:cast(?MODULE, refresh).
board() -> gen_server:call(?MODULE, board).
    
