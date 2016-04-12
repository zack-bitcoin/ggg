-module(serve).
-export([start/0]).
start() ->
    Port = constants:port(),
    io:fwrite("start server\n"),
    D = [
	 {'_', [
		{"/:file", main_handler, []},
		{"/", internal_handler, []}
	       ]}
	],
    Dispatch = cowboy_router:compile(D),
    K = [{env, [{dispatch, Dispatch}]} ],
    {ok, _} = cowboy:start_http(http, 100, [{ip, {0,0,0,0}},{port, Port}], K).

