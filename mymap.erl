-module(mymap).
-import(lists,[foreach/2,map/2]).
-export([mypmap/2]).
-export([mypmap1/2]).

mypmap(F,L) -> 
	S = self(),
	Ref = erlang:make_ref(),
	Pids = map(fun(I) -> spawn(fun() -> do_f(S,Ref,F,I) end) end,L),
	gather(Pids,Ref).

do_f(Parent,Ref,F,I) -> 
	Parent ! {self(),Ref,(catch F(I))}.

gather([Pid|T],Ref) -> 
	receive
	{Pid,Ref,Ret} -> [Ret|gather(T,Ref)]
	end;
gather([],_) -> 
	[].

mypmap1(F,L) -> 
	S = self(),
	Ref = erlang:make_ref(),
	foreach(fun(I) -> 
			spawn(fun() -> do_f1(S,Ref,F,I) end)
			end,L),
	gather1(length(L),Ref,[]).

do_f1(Parent,Ref,F,I) ->
	Parent ! {Ref,(catch F(I))}.

gather1(0,_,Res) -> Res;
gather1(N,Ref,Res) ->
	receive
	{Ref,Ret} -> gather1(N-1,Ref,[Ret|Res])
	end.

