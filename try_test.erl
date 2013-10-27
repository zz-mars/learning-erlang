-module(try_test).
-export([demo1/0]).
generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT',a};
generate_exception(5) -> erlang:error(a).

demo1() ->
	[catcher(I) || I <- [1,2,3,4,5]].

catcher(I) ->
	try generate_exception(I) of
		Val -> {I,normal,Val}
	catch
		throw:X -> {I,caught,thrown,X};
		exit:X -> {I,caught,exited,X};
		error:X -> {I,caught,error,X}
	end.

