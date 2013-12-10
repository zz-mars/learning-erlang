-module(mymap).
-import(lists,[foreach/2,map/2]).
-export([map/2]).
% call map() function with parameter F = process_doc_word
map(F,L) -> 
	S = self(),
	Ref = erlang:make_ref(),
	foreach(fun(I) -> 
			spawn(fun() -> do_f(S,Ref,F,I) end)
			end,L),
	gather(length(L),Ref,[]).

% process for each ( doc : <word1,word2,word3..> ) in F
% send the result back after processing done
do_f(Parent,Ref,F,I) ->
	Parent ! {Ref,(catch F(I))}.
% do the reducing, gather the result 
gather(0,_,Res) -> Res;
gather(N,Ref,Res) ->
	receive
	{Ref,Ret} -> gather(N-1,Ref,[Ret|Res])
	end.

% process the {doc,[word1,word2,word3..]}
% return a list, e.g.[{word1,doc},{word2,doc}, {word3,doc}..]
process_doc_word({Docid,[]},Res) -> Res;	% processing done
process_doc_word({Docid,[Next_word|To_be_processing],Res) ->	% still need to process
	process_doc_word({Docid,To_be_processing},[{Next_word,Docid}|Res]).


