-module(ggg_sup).
-behaviour(supervisor).
%% API
-export([start_link/0]).
%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).
-define(children, [board, socket, board_user]).
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).
child_maker([]) -> [];
child_maker([H|T]) -> [?CHILD(H, worker)|child_maker(T)].
init([]) ->
    Children = child_maker(?children),
    {ok, { {one_for_one, 5, 10}, Children} }.

