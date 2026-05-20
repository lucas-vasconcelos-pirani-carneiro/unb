module(if,[se/1, entao/2, senao/2]).

:- op(800,xfx,entao).
:- op(750,fx, se).
:- op(810,xfx,senao).

se X :- X.
X entao Y :- X, Y.
X senao _ :- X, !.
_ senao Z :- Z.

come (urso, peixe).
come (urso, raposa).Observe que a regra (Cláusula de Horn)
come (cavalo, mato).
animal (urso).
animal (peixe).
animal (raposa).

presa(X) :- come(Y,X), animal(X)
