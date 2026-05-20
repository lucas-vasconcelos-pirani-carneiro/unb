# Recursão

A **recursão** é um dos elementos mais importantes da linguagem `Prolog`, este conceito permite a resolução de problemas significamente complexos de maneira relativamente simples.

Uma **regra** é **recursiva** se sua condição depende dela mesma, tal como:

```prolog
a(X) :- b(X), a(X). 
```

Um conjunto de regras com mesmo nome é denominado **procedimento**.

### Exemplo

A importância do uso da recursão pode ser ilustrada na implementação da relação `descendente(X,Y)`, significando que "X é descendente de y".

```prolog
descendente(X,Y) :- genitor(Y,X). 
?- descendente(bob, pam).
true ;
false.

% Ocorre um erro quando executados esse caso
?- descendente(pat, pam).
false.

% Para corrigir sem usar recursão seria preciso fazer isso
descendente(X,Y) :- genitor(Y,X).
descendente(X,Y) :- genitor(Y,Z), genitor(Z,X). 
descendente(X,Y) :- genitor(Y,Z), genitor(Z,W), genitor(W,X). 

% Consultas
?- descendente(pat, pam).
true.

?- descendente(jim, pam).
true.

% Usando Recursão
descendente(X,Y) :- genitor(Y,X).
descendente(X,Y) :- genitor(Y,Z), descendente(X,Z).

% Consultas
?- descendente(jim, pam).
true ;
false.

?- descendente(ann, tom).
true ;
false.

?- descendente(liz, ann).
false.
```

Outro exemplo clássico é o uso do **fatorial** e da sequência de **fibonacci**.

```prolog
fat(0,1). 
fat(N,F) :- 
    N > 0, 
    N1 is N-1,
    fat(N1, F1), 
    F is N * F1.

% Consulta
?- fat(5,F).
F = 120 ;
false.

?- fat(5,120).
true ;
false.

?- fat(5,121).
false.

% Fibonacci
fib(N,F) :- fibx(N,1,1,F), !.
fibx(0,A,_,A).
fibx(N,A,B,F) :- N1 is N - 1, AB is A + B, fibx(N1,B,AB,F).

% Consulta
?- fib(0,F).
F = 1

?- fib(1,1).
true.

?- fib(10,F).
F = 89

?- fib(20,F).
F = 10946

?- fib(100,F).
F = 573147844013817084101.

?- fib(N,1).
N = 0

?- fib(N,89).
ERROR: Arguments are not sufficiently instantiated
```

## Exercício

### 1. Descreva uma regra para determinar quais animais pertencem a cadeia alimentar de outro:

```prolog
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

?- pertenceCadeia(peixe,urso).
true ;
true ;
false.

?- pertenceCadeia(X,raposa).
X = coelho ;
false.

?- pertenceCadeia(X,urso).
X = peixe ;
X = raposa ;
X = veado ;
X = guaxinim ;
X = peixinho ;
X = coelho ;
X = peixe ;
X = peixinho ;
false.
```

### 2. Crie um programa em Prolog para resolver a equação de recorrência:
- **Regra:** 
    - Caso base: $x_1 = 2$
    - $x_n = x_{n-1} - 3n^2$

- **Predicado:** regraRecorrencia/2

```prolog
regraRecorrencia(N,2) :-  N = 1.
% regraRecorrencia(N,Result) :- N = 1, Result = 2. -> funciona tambem
regraRecorrencia(N,Result) :- 
    N >= 2,
    N1 is N-1,
    regraRecorrencia(N1,Result1),
    Result is Result1 - 3 * (N * N).

% Consultas
?- regraRecorrencia(3,X).
X = -37 ;
false.

?- regraRecorrencia(3,-37).
true ;
false.
```

### 3. Crie uma regra recursiva com um parâmetro que é um número inteiro, a regra deve imprimir os valores de zero até o número informada.

Ex:
```prolog
?- imprimeAte(3).
0 1 2 3
```

```prolog
imprimeAte(N) :- rec(0,N).

rec(Ini,Fim) :- Ini > Fim.
rec(Ini, Fim) :- 
    write(Ini), write(' '), 
    I is Ini + 1, 
    rec(I, Fim).

% Consulta
?- imprimeAte(3).
0 1 2 3 
```

### 4. Usando um acumulador, e somente as operações (+), (-), (*), crie uma regra que calcule X elevado a Y. Assuma X e Y inteiros.

```prolog
potencia(_,0, 1).
potencia(X,1, X).
potencia(X,Y, R) :-
    Y > 1,
    Y1 is Y - 1,
    potencia(X,Y1,R1),
    R is X * R1.

?- potencia(2,2,R).
R = 4 ;
false.

?- potencia(2,5,R).
R = 32 ;
false.
```
