drop(0,Xs,Xs).
drop(_,[],[]).
drop(N,[X|Xs],Ys) :- N>0, N1 is N - 1, drop(N1,Xs,Ys).