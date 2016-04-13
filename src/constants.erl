-module(constants).
-compile(export_all).
port() -> 4040.
gnu_port() -> 4041.
wait_on_gnu() -> 120000.%if the AI takes more than 2 minutes to think, their move wont get updated, and you have to click the "refresh" button eventually.
difficulty() -> 17.
ram() -> 500.%in megabytes
    
    
