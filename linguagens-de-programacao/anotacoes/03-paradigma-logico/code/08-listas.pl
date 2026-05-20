% Um elemento pertence a uma lista
pertence(X, [X|_]).
pertence(X, [_|T]) :- pertence(X, T).

% Um elemento é o último elemento de uma lista
eh_ultimo(X, [X]). % Ou [X|[]]
eh_ultimo(X, [_|T]) :- eh_ultimo(X,T).

% Dois elementos são consecutivos
% 1 e 2 são consecutivos na lista [2,3,4,5,1,2].
consecutivos(X,Y, [X,Y|_]).
consecutivos(X,Y, [_|T]) :- consecutivos(X,Y,T).

% Tamanho de uma lista
tamanho([],0).
tamanho([_|T],N) :- tamanho(T,N1), N is N1 + 1.

% Pegar os primeiros N elementos de uma lista
take(0,_,[]).
take(_,[],[]).
take(N,[X|Xs],[X|Ys]) :- N > 0, N1 is N - 1, take(N1,Xs,Ys).

% Retirar os primeiros N elementos de uma lista
drop(0,Xs,Xs).
drop(_,[],[]).
drop(N,[X|Xs],Ys) :- N>0, N1 is N - 1, drop(N1,Xs,Ys).

% Concatenacao
concat([],Ys,Ys).
concat([X|Xs],Ys,[X|Zs]) :- concat(Xs,Ys,Zs).

% Verificar se um determinado numero faz parte da lista
membro(X,[X|_]).
membro(X,[_|Xs]) :- membro(X,Xs).

% Exercício 01
prefixo([], _).
prefixo([H1|T1], [H2|T2]) :- H1 = H2, prefixo(T1,T2).

% Exercício 02
sufixo(L,L).
sufixo(L1,[_|T2]) :- sufixo(L1, T2).

% Exercício 03
pares([], []). 
pares([H|T], S) :- 
    pares(T,T1), 
    (  
        (H mod 2) =:= 0 -> S = [H|T1]
        ;
        S = T1
    ). 

% Exercício 04
todos_as([a]).
todos_as([a|T]) :- todos_as(T).

% Exercício 05
contem_1([1|_]).
contem_1([H|T]) :- H \= 1, contem_1(T).

contem1([1]).
contem1([H|T]) :- (H = 1, !) ; contem1(T).

% Exercício 06
traducao(one,um).
traducao(two,dois).
traducao(three,tres).
traducao(four,quatro).
traducao(five, cinco).
traducao(six, seis).
traducao(seven, sete).
traducao(eight, oito).
traducao(nine, nove).

lista_traducao([],[]).
lista_traducao([H1|T1],[H2|T2]) :- traducao(H1,H2), lista_traducao(T1,T2).
