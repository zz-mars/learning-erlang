-module(ptests).
-export([tests/1,fib/1]).
-import(lists,[map/2]).
-import(mymap,[mypmap/2]).

tests([N]) -> 
	Nsched = list_to_integer(atom_to_list(N)),
	run_test(1,Nsched).

run_test(N,Nsched) -> 
	case test(N) of
		stop ->
			init:stop();
		Val ->
			io:format("~p.~n",[{Nsched,Val}]),
			run_test(N+1,Nsched)
	end.

