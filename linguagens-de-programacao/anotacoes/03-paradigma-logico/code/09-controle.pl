:- dynamic cidade/1.
:- dynamic vizinhos/2.

a(1).
b(1).
c(2).

p(X) :-
    c(X).

p(X) :-
    a(X),
    b(X),
    !.

f(X,0) :-
    X < 3,
    !.

f(X,2) :-
    X >= 3,
    X < 6,
    !.

f(X,4) :-
    X >= 6.

f1(X,0) :-
    X < 3,
    !.

f1(X,2) :-
    X < 6,
    !.

f1(_,4).

aluno(marcelo).
aluno(andre).
aluno(roberto).

escreverSemFail :-
    aluno(X),
    write(X).

escreverComFail :-
    aluno(X),
    write(X),
    nl,
    fail.

escreverComFail.

lerDados(G) :-
    write('Digite um número de 1 a 5: '),
    read(G).

processarDados(G,N) :-
    G =:= N,
    write('Acertou!!!'),
    nl.

processarDados(G,N) :-
    G =\= N,
    write('Tente novamente'),
    nl,
    fail.

adivinheNumero :-
    N is random(5) + 1,
    repeat,
        lerDados(G),
        processarDados(G,N),
    !.

repete :-
    repeat,
        write('Digite uma palavra: '),
        read(Palavra),
        (
            Palavra == fim
            ->
            !
            ;
            write('Errou, tente novamente!!'),
            nl,
            fail
        ).

fat(0,1).

fat(N,F) :-
    N > 0,
    N1 is N - 1,
    fat(N1,F1),
    F is N * F1.

append1([],Ys,Ys).

append1([X|Xs],Ys,[X|Zs]) :-
    append1(Xs,Ys,Zs).

:- op(500, xfy, ++).

++([],Ys,Ys).

++([X|Xs],Ys,[X|Zs]) :-
    ++(Xs,Ys,Zs).

simNao(Msg) :-
    nl,
    write(Msg),
    repeat,
        write(' (s/n) '),
        get_char(N),
        nl,
        member(N,['s','S','n','N']),
    !,
    member(N,['s','S']).

cidades :-
    repeat,
        nl,
        write('Cidade (ultima = fim) > '),
        read(X),
        assertz(cidade(X)),
        X == fim,
    !.

vizinhos :-
    cidade(X),
    X \== fim,
    nl,
    write('Informe os vizinhos de '),
    write(X),
    write(': '),
    read(Ys),
    assertz(vizinhos(X,Ys)),
    fail.

vizinhos.

elegivel(X) :-
    analfabeto(X),
    fail.

elegivel(X) :-
    cidadao(X),
    idade(X,Y),
    Y >= 18.

elegivel1(X) :-
    cidadao(X),
    \+ analfabeto(X),
    idade(X,Y),
    Y >= 18.

cidadao(joao).
cidadao(susana).
cidadao(roberta).
cidadao(ricardo).
cidadao(marcelo).

idade(joao,36).
idade(susana,15).
idade(roberta,31).
idade(ricardo,22).
idade(marcelo,17).

analfabeto(joao).

temRG(X) :- homem(X), idade(X,Y),!,Y > 18.
homem(joao).
homem(marcelo).
homem(ricardo).
mulher(susana).
mulher(roberta).

souma(P) :- P, !.
temRG1(X) :- homem(X), souma(idade(X,Y)), Y > 18.
