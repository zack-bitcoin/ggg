-module(internal_handler).

-export([init/3, handle/2, terminate/3, doit/1]).
%example of talking to this handler:
%curl -i -d '[-6,"test"]' http://localhost:3011

handle(Req, State) ->
    {ok, Data, _} = cowboy_req:body(Req),
    true = is_binary(Data),
    io:fwrite("got message: "),
    io:fwrite(Data),
    io:fwrite("\n"),
    A = jiffy:decode(Data),
    B = doit(A),
    D = jiffy:encode(B),
    Headers = [{<<"content-type">>, <<"application/octet-stream">>},
    {<<"Access-Control-Allow-Origin">>, <<"*">>}],
    {ok, Req2} = cowboy_req:reply(200, Headers, D, Req),
    {ok, Req2, State}.
init(_Type, Req, _Opts) -> {ok, Req, no_state}.
terminate(_Reason, _Req, _State) -> ok.
doit([<<"new_game">>]) ->
    board_user:start();
doit([<<"undo">>]) ->
    board_user:undo(),
    board_user:refresh();
doit([<<"refresh">>]) ->
    board_user:refresh();
doit([<<"play">>, X, Y]) ->
    board_user:play(X, Y),
    board_user:refresh();
doit([<<"example">>]) ->
    io:fwrite("example \n"),
    [<<"it works">>];
doit(X) ->
    io:fwrite("don't know how to handle it \n"),
    io:fwrite(jiffy:encode(X)),
    io:fwrite("\n"),
    [<<"error">>].
