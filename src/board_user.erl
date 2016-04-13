%interpret_draw is likely to crash. this gen_server exists so that the board gen_server wont die.
-module(board_user).
-behaviour(gen_server).
-export([start_link/0,code_change/3,handle_call/3,handle_cast/2,handle_info/2,init/1,terminate/2, start/0,refresh/0,play/2,undo/0]).
init(ok) -> 
    {ok, null}.
start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, ok, []).
code_change(_OldVsn, State, _Extra) -> {ok, State}.
terminate(_, _) ->     
    io:format("died!"), ok.
handle_info(_, X) -> {noreply, X}.
handle_cast(refresh, _) -> 
    refresh2(),
    {noreply, 0};
handle_cast(undo, _) -> 
    S = socket:fetch(),
    undo:doit(S),
    refresh2(),
    {noreply, 0};
handle_cast({play, X, Y}, _) -> 
    S = socket:fetch(),
    play_move:doit(S, X, Y),
    refresh2(),
    board:flush(),
    play_move:ai(S),
    board:wait_on_gnugo(),
    refresh2(),
    {noreply, 0};
handle_cast(start, _) -> 
    B = board:start(),
    draw:interpret_draw(B),
    {noreply, 0}.
handle_call(_, _From, X) -> X.
start() -> gen_server:cast(?MODULE, start).
undo() -> gen_server:cast(?MODULE, undo).
refresh() -> gen_server:cast(?MODULE, refresh).
play(X, Y) -> gen_server:cast(?MODULE, {play, X, Y}).

refresh2() ->
    B = board:board(),
    draw:interpret_draw(B).
    
