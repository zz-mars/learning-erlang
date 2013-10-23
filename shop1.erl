-module(shop1).
-export([total/1]).

total([{What,Num}|T]) -> shop:cost(What) * Num + total(T);
total([]) -> 0.

