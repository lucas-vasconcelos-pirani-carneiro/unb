:- dynamic mulher/1.
:- dynamic homem/1.
:- dynamic genitor/2.
:- dynamic sala/6.

/*
* listing: Lista todos os **fatos** ou **regras** por um determinado nome;
* assert/1: Acresenta um fato ou regra como último item do predicado;
* asserta/1: Acresenta um fato ou regra como primeiro item do predicado.
*/

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

% Exemplo Prático
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
