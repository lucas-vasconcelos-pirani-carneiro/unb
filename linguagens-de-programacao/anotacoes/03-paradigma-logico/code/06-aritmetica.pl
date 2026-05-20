soma(A, B, S) :-  S is A + B.

% Exercício 01
maiorQueCem() :- 
    write('Digite um número inteiro: '),
    read(X),
    (
        (X > 100, write('Maior que 100'))
        ;
        (X =< 100, write('Menor ou igual 100'))
    ).

% Exercício 02
nota(joao, 5.0).
nota(mariana, 9.0).
nota(joaquim, 4.5).
nota(maria, 6.0).
nota(cleuza, 8.5).
nota(mara, 4.0).
nota(joana, 8.0).
nota(jose, 6.5).
nota(mary, 10.0).

situacao(Nome) :- 
    nota(Nome, Nota),
    (
        (Nota >= 7, Nota =< 10, write('Aprovado'))
        ;
        (Nota >= 5, Nota < 7, write('Recuperação'))
        ;
        (Nota >= 0, Nota < 5, write('Reprovado'))
    ).

% Exercício 03
imc() :- 
    write('Informe seu Peso(Kg): '),
    read(Peso),
    write('Informe sua Altura(m): '),
    read(Altura),
    Imc is Peso / (Altura * Altura),
    write(Imc). 

imc2(Peso, Altura, Imc) :- Imc is Peso / (Altura * Altura).

imc3(Peso,Altura) :- 
    X is Peso / (Altura * Altura),
    write('Seu Imc é: '), write(X).

