++([X|Xs],Ys,[X|Zs]) :- ++(Xs,Ys,Zs). 
++([],Ys,Ys).
