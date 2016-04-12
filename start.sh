./rebar get-deps
./rebar compile
echo "GO TO THIS WEBSITE -------> http://localhost:4040/main.html"
erl -pa ebin deps/*/ebin/ -eval "application:ensure_all_started(ggg)"
