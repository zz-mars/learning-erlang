-module(even_odd).
-export([even_odd_acc/1]).

even_odd_acc(L) -> even_odd_acc(L,[],[]).

even_odd_acc([H|T],E,O) -> 
	case H rem 2 of
		0 -> even_odd_acc(T,[H|E],O);
		1 -> even_odd_acc(T,E,[H|O])
	end;

even_odd_acc([],E,O) ->
	{E,O}.

