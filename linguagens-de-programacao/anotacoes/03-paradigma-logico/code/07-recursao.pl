% Fatos
homem(tom).
homem(bob).
homem(jim).

mulher(pam).
mulher(ann).
mulher(pat).
mulher(liz).

genitor(tom, bob).
genitor(tom, liz).
genitor(pam, bob).
genitor(bob, ann).
genitor(bob, pat).
genitor(pat, jim).

% Regras
prole(X,Y) :- genitor(Y,X).
mae(X,Y) :- genitor(X,Y), mulher(X).
avos(X,Z) :- genitor(X,Y) , genitor(Y,Z).

/*
descendente(X,Y) :- genitor(Y,X).
descendente(X,Y) :- genitor(Y,Z), genitor(Z,X). 
descendente(X,Y) :- genitor(Y,Z), genitor(Z,W), genitor(W,X). 
*/

descendente(X,Y) :- genitor(Y,X).
descendente(X,Y) :- genitor(Y,Z), descendente(X,Z).

% Fatorial 
/*
fatorial(5) = fatorial(4) * 5
            (fatorial(3) * 4) * 5
            ((fatorial(2) * 3) * 4) * 5
            (((fatorial(1) * 2) * 3) * 4) * 5
            ((((fatorial(0) * 1) * 2) * 3) * 4) * 5
            ((((1 * 1) * 2) * 3) * 4) * 5         
*/

fat(0,1). 
fat(N,F) :- 
    N > 0, 
    N1 is N-1,
    fat(N1, F1), 
    F is N * F1.

% Exercícios
animal(urso).
animal(peixe).
animal(peixinho).
animal(lince).
animal(raposa).
animal(coelho).
animal(veado).
animal(guaxinim).

planta(alga).
planta(grama).

come(urso, peixe).
come(urso, raposa).
come(urso, veado).
come(lince, veado).
come(peixe, peixinho).
come(peixinho, alga).
come(guaxinim, peixe).
come(raposa, coelho).
come(coelho, grama).
come(veado, grama).
come(urso, guaxinim).

pertenceCadeia(X,Y) :- animal(X), come(Y,X).
pertenceCadeia(X,Y) :- come(Y,Z), pertenceCadeia(X,Z).

regraRecorrencia(N,2) :-  N = 1.
% regraRecorrencia(N,Result) :- N = 1, Result = 2. -> funciona tambem
regraRecorrencia(N,Result) :- 
    N >= 2,
    N1 is N-1,
    regraRecorrencia(N1,Result1),
    Result is Result1 - 3 * (N * N).

fib(N,F) :- fibx(N,1,1,F), !.
fibx(0,A,_,A).
fibx(N,A,B,F) :- N1 is N - 1, AB is A + B, fibx(N1,B,AB,F).

% Exercício 03
imprimeAte(N) :- rec(0,N).

rec(Ini,Fim) :- Ini > Fim.
rec(Ini, Fim) :- 
    write(Ini), write(' '), 
    I is Ini + 1, 
    rec(I, Fim).

% Exercício 04
potencia(_,0, 1).
potencia(X,1, X).
potencia(X,Y, R) :-
    Y > 1,
    Y1 is Y - 1,
    potencia(X,Y1,R1),
    R is X * R1. 
