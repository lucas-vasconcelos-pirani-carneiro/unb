# Manipulação Base de Conhecimento

A princípio, os predicados carregados pela instrução `consult` na base de conhecimento são **estáticos**.

Porém, existem predicados pré-definidos que permitem fazer a manipulação da base de conhecimento. Ou seja, predicados que permitem **acresentar** e/ou **retirar** factos e regras da base de conhecimento, durante a **execução de um programa**.

Para criar predicados dinâmicos é necessário utilizar a diretiva:

```prolog
:- dynamic NomeDoPredicado/Aridade
```

> Contudo as alterações serão voláteis, ou seja, o arquivo original não é alterado.

```prolog
/*
* listing: Lista todos os **fatos** ou **regras** por um determinado nome;
* assert/1: Acresenta um fato ou regra como último item do predicado;
* asserta/1: Acresenta um fato ou regra como primeiro item do predicado;
* retract/1: Remove da base de conhecimento a primeira cláusula (fato ou regra) que unifica com o termo que é passado como parâmetro;
* retractall/1: Remove da base de conhecimento todas as cláusula (fato ou regra) que unifica com o termo que é passado como parâmetro;
* abolish/1: Remove da base de conhecimento todos os fatos e regras pelo nome da regra ou fato/aridade que é passada como parâmetro (são removidos predicados estáticos). 
* abolish/2: Semelhante a abolish/1, mas passando o nome da regra/fato e a sua aridade 
separadamente (são removidos predicados estáticos também).
*/

?- listing(mulher/1).
:- dynamic mulher/1.

mulher(pam).
mulher(ann).
mulher(pat).
mulher(liz).

true.

?- asserta(mulher(janes)).
true.

?- listing(mulher/1).
:- dynamic mulher/1.

mulher(janes).
mulher(pam).
mulher(ann).
mulher(pat).
mulher(liz).

true.

?- mulher(janes).
true.

?- mulher(janess).
false.

?- listing(mulher/1).
:- dynamic mulher/1.

mulher(pam).
mulher(ann).
mulher(pat).
mulher(liz).

true.

?- asserta(mulher(janes)).
true.

?- listing(mulher/1).
:- dynamic mulher/1.

mulher(janes).
mulher(pam).
mulher(ann).
mulher(pat).
mulher(liz).

true.

?- mulher(janes).
true.

?- mulher(janess).
false.

?- retract(mulher(janes)).
true.

?- listing(mulher/1).
:- dynamic mulher/1.

mulher(pam).
mulher(ann).
mulher(pat).
mulher(liz).

true.

?- listing(genitor(_, bob)).
:- dynamic genitor/2.

genitor(tom, bob).
genitor(pam, bob).

true.

?- listing(genitor(_, bob)).
:- dynamic genitor/2.

genitor(tom, bob).
genitor(pam, bob).

true.

?- retractall(genitor(_, bob)).
true.

?- listing(genitor(_, bob)).
:- dynamic genitor/2.


true.
```

### Exemplo Prático

```prolog
:- dynamic sala/6.

% sala(num,dia,inicio,fim,disciplina,tipo)
sala(cp1103, seg, 10, 13, aaa, p).
sala(cp2301, ter, 10, 11, aaa, t).
sala(di011, sab, 12, 10, xxx, p). % Erro
sala(cp3204, dom, 8, 10, zzz, p).
sala(di011, sex, 14, 16, xxx, p).
sala(cp204, sab, 15, 17, zzz, tp).
sala(di011, qui, 14, 13, bbb, tp). % Erro
sala(di104, qui, 9, 10, aaa, tp).
sala(dial, dom, 14, 16, bbb, t).
sala(cp1220, sab, 14, 18, sss, p).
```

Removendo os casos que contém erros e adicionando-os corretamente.
```prolog
?- sala(_,_,Ini,Fim,_,_),
|    Ini > Fim,
|    retractall(sala(_,_,Ini,Fim,_,_)).
Ini = 12,
Fim = 10 ;
Ini = 14,
Fim = 13 ;
false.

?- listing(sala/6).
:- dynamic sala/6.

sala(cp1103, seg, 10, 13, aaa, p).
sala(cp2301, ter, 10, 11, aaa, t).
sala(cp3204, dom, 8, 10, zzz, p).
sala(di011, sex, 14, 16, xxx, p).
sala(cp204, sab, 15, 17, zzz, tp).
sala(di104, qui, 9, 10, aaa, tp).
sala(dial, dom, 14, 16, bbb, t).
sala(cp1220, sab, 14, 18, sss, p).

?- assert(sala(di011, qui, 13, 14, bbb, tp)).
true.

?- assert(sala(di011, sab, 10, 12, xxx, p)).
true.

?- listing(sala/6).
:- dynamic sala/6.

sala(cp1103, seg, 10, 13, aaa, p).
sala(cp2301, ter, 10, 11, aaa, t).
sala(cp3204, dom, 8, 10, zzz, p).
sala(di011, sex, 14, 16, xxx, p).
sala(cp204, sab, 15, 17, zzz, tp).
sala(di104, qui, 9, 10, aaa, tp).
sala(dial, dom, 14, 16, bbb, t).
sala(cp1220, sab, 14, 18, sss, p).
sala(di011, qui, 13, 14, bbb, tp).
sala(di011, sab, 10, 12, xxx, p).
```

### Outro Exemplo
`asserta(clausula).` : Inclui clausula na BC, no **início das cláusulas** com mesmo nome.
```prolog
?- dynamic(pai/2).
true.
?- asserta(pai(joao, maria)).
true.
?- listing(pai/2).
:- dynamic(pai/2).
pai(joao, maria ).
true.
```

`assertz(cláusula).` : Inclui no **final das cláusulas** de mesmo nome.
```prolog
?- assertz((irmao(A,B) :- pai(P,A), pai(P,B), A \== B) ).
true.

?- listing(irmao/2).
:- dynamic irmao/2.
irmao(A, C) :- pai(B, A), pai(B, C), A\==C.
true.
```

> ![NOTE]
> 
> Observe que a regra precisa estar entre parêntesis por conta da prioridade do operador :-/2 ser maior que 1000.
