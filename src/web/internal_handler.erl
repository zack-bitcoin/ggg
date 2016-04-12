-module(internal_handler).

-export([init/3, handle/2, terminate/3, doit/1]).
%example of talking to this handler:
%curl -i -d '[-6,"test"]' http://localhost:3011

handle(Req, State) ->
    {ok, Data, _} = cowboy_req:body(Req),
    true = is_binary(Data),
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
    board:start();
doit([<<"play">>, X, Y]) ->
    board:refresh(),
    S = socket:fetch(),
    io:fwrite("X is "),
    io:fwrite(integer_to_list(X)),
    io:fwrite("\n"),
    play_move:doit(S, X, Y),
    board:refresh();
    %B = get_board:doit(S),
%io:fwrite(B),
%draw:draw(B);
doit([<<"example">>]) ->
    io:fwrite("example \n"),
    [<<"it works">>];
doit(X) ->
    io:fwrite("don't know how to handle it \n"),
    io:fwrite(jiffy:encode(X)),
    io:fwrite("\n"),
    [<<"error">>].
