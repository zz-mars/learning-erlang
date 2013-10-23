-module(sum).
-export([sum/1]).

sum(L) -> asum(L,0).
asum([H|T],N) -> asum(T,H+N);
asum([],N) -> N.

