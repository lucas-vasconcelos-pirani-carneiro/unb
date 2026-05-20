% Exemplos de Estruturas
parent(pam,bob).
deseja(cruzeiro,voltar(serie,a)).
deseja(cruzeiro,voltar(serie,a),ano(2020)).
data(28,setembro,2020).

% Fatos
gosta(marcelo, leda).
gosta(marcelo, cruzeiro).
homem(x). % Siginifica que "x é um homem"
mulher(x). % Siginifica que "x é um mulher"
genitor(x,y). % Significa que "x é genitor de y" ou "y é gerado de x"

% Aridade
gosta(joao, ler, livros).
gosta(joao,maria).

% Fatos Universais
mais(0,X,X).                % fato
mais(A,B,C) :- C is A + B.  % regra
vezes(1,X,X).               % fato
vezes(A,B,C) :- C is A * B. % regra

% Exemplo - Arvore Genealógica
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

% Consultas
% pam é mulher ?
?- mulher(pam). 
true.

% Quem são as mulheres na nossa base de conhecimento ?
?- mulher(X). 
X = pam ;
X = ann ;
X = pat ;
X = liz.

% Quem são os filhos de Bob ?
?- genitor(bob,X).
X = ann ;
X = pat.

% Quem são os pais de Bob ?
?- genitor(X,bob).
X = tom ;
X = pam.

% Quem é genitor de quem ?
?- genitor(X,Y).
X = tom,
Y = bob ;
X = tom,
Y = liz ;
X = pam,
Y = bob ;
X = bob,
Y = ann ;
X = bob,
Y = pat ;
X = pat,
Y = jim.

% Exemplos - Consultas
% Base de Conhecimeto
pai(joao,mane).
pai(joao, ze).
pai(joao, quim).
pai(mane,maria).
pai(ze, zefa).
pai(ze, ruth).

irmas(A,B) :- pai(P,A), pai(P,B),  A \== B. 
avo(A,N) :- pai(P,N), pai(A,P).
tio(T,S) :- pai(P,S), irmas(P,T).

% Execução
?- pai(P,zefa).
P = ze 

?- irmas(quim,A).
A = mane;
A = ze;
false.

?- tio(T,zefa).
T = mane;
T = quim;
false.

?- avo(A,N).
A = joao , N = maria;
A = joao , N = zefa;
A = joao , N = ruth;
false

% Consulta Existencial
?- mais(3,X,8).  % existe um X + 3 = 8 ?
?- pai(P,joao).  % existe um P pai de joao ?

% Consulta Conjuntiva
?- pai(joao, F), pai(F,N).  % Quem são os netos de joão? 
?- pai(P,maria), tio(T,P).  % Quem é o tio avó de Maria?

% Quem é pai ou mae de quem?
?- parent(X,Y).
X = pam;
Y = bob;
X = tom;
Y = bob;
X = tom;
Y = liz

% Conectivo AND
% Está querendo saber se ann e pat sao irmaos
?- parent(X,ann),parent(X,pat).
X = bob

% Exemplo 01
?- parent(bob,pat). % Query
true.
?- parent(liz,pat).
fail. 
?- parent(X,liz). % Pergunta quem é o pai/mãe da liz, X é uma variável.
X = tom 
?- parent(bob, X). % Quer saber quem são os filhos de bob.
X = ann;
X = pat

% Exemplo 02

% Fatos
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

% Consultas
% Quem são as plantas ?
?- planta(X).
X = alga ;
X = grama.

% A raposa come algum outro animal ou planta ?
?- come(raposa,_).
true.

% Tem algum animal que come algum outro animal ou planta ?
?- come(_,_).
true .

% Existe algum animal que come a grama e Quem são ?
?- come(X,grama).
X = coelho ;
X = veado.

% Quem são os animais herbívoros ?
?- come(X, grama) ; come(X, alga).
X = coelho ;
X = veado ;
X = peixinho.

?- come(X,Y), planta(Y).
X = peixinho,
Y = alga ;
X = coelho,
Y = grama ;
X = veado,
Y = grama ;
false.

% Regras
% Exemplo 01
?- predecessor(pam,X).
X = bob;
X = ann;
X = pat;
X = jim;
fail.

?- predecessor(W,jim).
W = pat

% Exemplo 02
/* Regras:
* prole(X,Y) :- genitor(Y,X)
* mae(X,Y) :- genitor(X,Y), mulher(X);
* avos(X,Z) :- genitor(X,Y) , genitor(Y,Z).
*/

% Pam é filho de Bob ?
?- prole(pam,bob).
false.

% Bob é filho de Pam ?
?- prole(bob,pam).
true.

% Bob e filho de Quem/ Quem sao os pais de Bob ?
?- prole(bob,X).
X = tom ;
X = pam.

% Tom e filho de Quem/ Quem sao os pais de Tom ?
?- prole(tom,X).
false.

% Tom tem algum filho ?
?- prole(_,tom).
true .

% Quem sao os filhos de Tom ?
?- prole(X,tom).
X = bob ;
X = liz

% Pam e mae de Bob ?
?- mae(pam,bob).
true.

% Tom e mae de Bob ?
?- mae(tom,bob).
false.

% Quem e a mae de Bob ?
?- mae(X,bob).
X = pam.

% Pam e mae de quem ?
?- mae(pam,X).
X = bob.

% Liz e mae de alguem ?
?- mae(liz,X).
false.

% Existe alguma mae na base ?
?- mae(X,Y).
X = pam,
Y = bob.

% Tom e avô de Ann ?
?- avos(tom,ann).
true.

% Pam e avó de Ann ?
?- avos(pam,ann).
true.

% Quem são os avós de Ann ?
?- avos(X,ann).
X = tom ;
X = pam.

% De quem Tom e avô ?
?- avos(tom,X).
X = ann ;
X = pat.

% Liz possui netos ?
?- avos(liz,X).
false.

% Exercicio 01
% Fatos
aluno(joao, calculo)
aluno(maria, calculo)
aluno(joel, programacao)
aluno(joel, estrutura)

frequenta(joao, puc)
frequenta(maria, puc)
frequenta(joel, ufrj)

professor(carlos, calculo)
professor(ana_paula, programacao)
professor(pedro, programacao)

funcionario(pedro, ufrj)
funcionario(ana_paula, puc)
funcionario(carlos, puc)

% a. Quem são os alunos do Professor X ?
% Regra
sao_alunos_do_professor(A,X) :- professor(X,Materias) , aluno(A,Materias).

% Consulta
?- sao_alunos_do_professor(A,pedro).
A = joel.

?- sao_alunos_do_professor(joel,P).
P = ana_paula ;
P = pedro ;
false.

% Joel é aluno de algum professor ?
?- sao_alunos_do_professor(joel,_).
true ;

% b. Quem sao as pessoas que estao associadas a uma universidade X ? (alunos e professores)
alunos_associados(Aluno, Faculdade) :- frequenta(Aluno, Faculdade). 
professores_associados(Professor, Faculdade) :- funcionario(Professor, Faculdade). 
associados(Pessoa, Faculdade) :- alunos_associados(Pessoa, Faculdade) ; professores_associados(Pessoa, Faculdade). 

% Consulta
?- associados(joel, _).
true .

?- associados(joel, C).
C = ufrj ;
false.

?- associados(mary, C).
false.

?- associados(pedro, C).
C = ufrj.

?- associados(pedro, ufrj).
true.

?- associados(pedro, ifmg).
false.

% Exercicio 02
estados(rj, 'Rio de Janeiro').
estados(sp, 'São Paulo').
estados(mg, 'Belo Horizonte').
estados(es, 'Vitória').

capital(Estado, Capital) :- estados(Estado, Capital). 

% Consulta
?- capital(mg,C).
C = 'Belo Horizonte'.

% Exercicio 03
doa(a,a). 
doa(a,ab). 
doa(b,b). 
doa(b,ab). 
doa(ab,ab). 
doa(o,a). 
doa(o,b). 
doa(o,ab). 
doa(o,o). 

recebe(a,a).
recebe(a,o).
recebe(b,b).
recebe(b,o).
recebe(ab,a).
recebe(ab,b).
recebe(ab,ab).
recebe(ab,o).
recebe(o,o).

% Consultas
?- doa(a,X).
X = a ;
X = ab.

?- recebe(a,X).
X = a ;
X = o.

?- doa(a,o).
false.

?- doa(a,ab).
true.

?- recebe(a,ab).
false.

% Predicados Bidirecionais
% Base de Conhecimento
pai(joao,mane).
pai(joao, ze).
pai(joao, quim).
pai(mane,maria).
pai(ze, zefa).
pai(ze, ruth).

irmas(A,B) :- pai(P,A), pai(P,B), A \= B. 
avo(A,N) :- pai(P,N), pai(A,P).
tio(T,S) :- pai(P,S), irmas(P,T).

% Execução
?- pai(P,zefa).
P = ze 

?- pai(ze, F)
F = zefa;
F=ruth;
false.

?- tio(T,zefa).
T = mane;
T = quim;
false.

?- avo(A,N).
A = joao, N = maria;
A = joao, N = zefa;
A = joao, N = ruth;
false.

livro(autor('Fernando Albuquerque'), titulo('Orientacao a Objetos')).
livro(autor('Pedro Rezende'), titulo('Criptografia em Redes')).
livro(autor('Maristela Holanda'), titulo('Modelos de BD')).
livro(autor('Marcelo Ladeira'), titulo('Mineração de Dados')).
livro(autor('Fernando Albuquerque'), titulo('Redes de Computadores')).
livro(autor('Maria Emilia'), titulo('Genoma Humano')).
livro(autor('Mauricio Ayala'), titulo('Funcoes de Reescrita')).
livro(autor('Andre Drummond'), titulo('Infraestrutura de TI')).
livro(autor('Thiago de Paulo'), titulo('Mineração de Textos')).
livro(autor('Maria de Fatima'), titulo('IA na Educacao')).
livro(autor('Wilson Veneziano'), titulo('Informatica na Educacao')).
livro(autor('Li Weigang'), titulo('Transporte Aereo')).
livro(autor('Genaina Nunes'), titulo('Especificacoes de Requisitos')).
artigo(autor('Marcelo Ladeira'), titulo('UnBBayes: A Java Framework for Reasoning')).
artigo(autor('Marcos Caetano'), titulo('5G the next generation')).
artigo(autor('Rodrigo Bonifacio'), titulo('Adopting DevOps')).
