-module(sum1).
-export([sum1/1]).

sum1([]) -> 0;
sum1([H|T]) -> H + sum1(T).

