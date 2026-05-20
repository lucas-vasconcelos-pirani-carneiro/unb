# Operadores e Unificação

## Operadores
Esse código implementa uma pequena “linguagem” em Prolog para representar estruturas condicionais de forma mais próxima da linguagem natural.

```prolog
module(if,[se/1, entao/2, senao/2]).

:- op(800,xfx,entao).
:- op(750,fx, se).
:- op(810,xfx,senao).

se X :- X.
X entao Y :- X, Y.
X senao _ :- X, !.
_ senao Z :- Z.

% Exemplos
?- X = 12, se X = 10.
false.

?- X = 12, X = 12 entao Y = 1. % implicação
X = 12,
Y = 1.

?- X = 10, X == 10 senao Y = 2. % ou X = 10.

?- X = 12, se X = 10 entao
Y = 1.
false.

?- X = 12, se X = 10 entao Y = 1 senao Y = 2.
X = 12,
Y = 2.

?- X = 10, se X = 10 entao Y = 1 senao Y = 2.
X = 10,
Y = 1.
```

### Especificadores de Operadores em Prolog

| Especificador | Classe   | Associatividade |
|---|---|---|
| `fx`  | prefix  | não associativo |
| `fy`  | prefix  | associativo à direita |
| `xfx` | infix   | não associativo |
| `xfy` | infix   | associativo à direita |
| `yfx` | infix   | associativo à esquerda |
| `xf`  | postfix | não associativo |
| `yf`  | postfix | associativo à esquerda |


### Operadores Pré-definidos em Prolog

| Prioridade | Especificador | Operador(es) |
|---|---|---|
| `1200` | `xfx` | `:-` |
| `1200` | `fx`  | `:-` |
| `1100` | `xfy` | `;` |
| `1050` | `xfy` | `->` |
| `1000` | `xfy` | `,` |
| `900`  | `fy`  | `\+` |
| `700`  | `xfx` | `=`, `\=` |
| `700`  | `xfx` | `==`, `\==`, `@<`, `@=<`, `@>`, `@>=` |
| `700`  | `xfx` | `is`, `=:=`, `=\=`, `<`, `=<`, `>`, `>=` |
| `500`  | `yfx` | `+`, `-`, `/\`, `\/` |
| `400`  | `yfx` | `*`, `/`, `//`, `rem`, `mod`, `<<`, `>>` |
| `200`  | `xfx` | `**` |
| `200`  | `xfy` | `^` |
| `200`  | `fy`  | `-`, `\` |

### Outros Operadores

| Prioridade | Especificador | Operador(es) |
|---|---|---|
| `1000` | `xfy` | `\|` |
| `900`  | `fy`  | `not` |
| `700`  | `xfx` | `is_string` |
| `600`  | `yfx` | `&` |
| `200`  | `fy`  | `+` |

## Unificação
É o processo que torna **dois termos idênticos**, ainda que para isso se faça substituição de variáveis em termos por outros termos.

- O termo $t_1$ unifica com o termo $t$ se existe uma substituição $\theta_1$ que torna $t_1$ idêntico a $t$ representada por $t \equiv t_1 \theta_1$.
- Seja $t, t_1 \text{ e } t_2$ termos, $t$ é uma instância comum de $t_1$ e $t_2$
se $\exist t_1 \text{ e } t_2$ substituições tais que $t \equiv t_1 \theta_1$ e $t \equiv t_2 \theta_2$.

Exemplo:
```prolog
t1= concat([1,2,3],[4,5],Rs),
t2= concat([X|XS],Ys,[X|Zs]),
t = concat([1,2,3],[4,5],[1|Zs]).
```
onde $\theta_1 = $ (Rs/[1|Zs]) e $\theta_2 = $ (X/1, Xs/[2,3], Ys/[4,5])

Um unificador de dois termos $t$ e $t_1$ é uma substituição $\theta$ que torna $t \equiv t_1 / \theta$, $t$ e $t_1$ ficam idênticos.

### Regras de Unificação

a. Variáveis unificam com variáveis
```prolog
X = Y.
```

b. Variáveis unificam com termos
```prolog
X = gosta(joao,ler).
```

c. Termos unificam com termos, se eles casam
```prolog
pai(P,F) = pai(joao, ze)
2 = 2, joao = 'joao'.
```

com $\theta =$ (P/joao, F/ze).

d. Um termo não-atômico unifica com outro se houver correspondência estrutural.
```prolog
livro(autor(Sn,N),titulo('Clarissa')) = livro(autor('Verissimo','Erico'), T).

?- livro(autor(Sn,N),titulo('Clarissa')) = livro(autor('Verissimo','Erico'), T).
Sn = 'Verissimo',
N = 'Erico',
T = titulo('Clarissa').
```
com $\theta =$ (Sn/'Verissimo', N/'Erico', T/titulo('Clarissa') )

### Exemplos

#### Unificando com Variável
```prolog
/* X = Y, 
--> X unifica com Y e retorna true
--> Passam a representar a mesma variável.
*/
?- X = Y.
X = Y

/* X \= Y, 
--> Retorna sempre false.
*/
?- X \= Y.
false.
```

#### Variável em Dados Estruturados
há unificação se as estruturas forem **isomórficas** e se houver uma
**substituição** sobre as variáveis que torne as estruturas idênticas.

```prolog
?- X = arco(a,b,10).
X = arco(a,b,10)

?- livro(autor(gilberto, joao), Titulo) = livro(Autor, titulo('Amor e Paz')).
Titulo = titulo('Amor e Paz') ,
Autor = autor(gilberto, joao)
```

#### Variável com Constante
```prolog
?- [X|Xs] = [a,b,c,d].
X = a , Xs = [b,c,d]

?- [X1,X2,c,d] = [a,b,c,d].
X1 = a , X2 = b

?- [[X|Xs],Y,c,d] = [[1,2,3],a,c,d].
X = 1 , Xs = [2,3] , Y = a

?- [[X,2,3],Y,b,c] = [[1|Xs],a,Z1,Z2].
X = 1 , Y = a , Xs = [2,3] , Z1 = b , Z2 = c
```

#### Unificando Constantes
T1 = T2 Unificam se tiverem **valores idênticos** e forem estruturalmente **isomórficos**.

```prolog
?- 10 = 10.
true.

?- arco(a,b,10) = arco(a,b,10).
true.

?- ‘hamilton' = hamilton.
true.

?- "a b" = "a b".
true.
```

### Comparação de Termos Arbitrários Segundo Ordem Padrão
O Prolog permite comparar termos arbitrários utilizando **operadores específicos**.

| Operador | Significado |
|---|---|
| `==/2` | termos idênticos |
| `\==/2` | termos diferentes |
| `@</2` | menor que |
| `@=</2` | menor ou igual |
| `@>/2` | maior que |
| `@>=/2` | maior ou igual |

Dependendo do tipo do termo, o Prolog realiza diferentes formas de comparação.

| Tipo | Comparação |
|---|---|
| variáveis | comparação de endereços |
| números | valor numérico |
| átomos | valor ASCII |

O Prolog utiliza a seguinte ordem padrão para comparação:

```text
variáveis < números < strings < átomos < listas < termos compostos
```

Quando os termos pertencem ao mesmo tipo:
- O Prolog realiza uma comparação específica daquele tipo;
  - Números $\rightarrow$ valor numérico;
  - Átomos $\rightarrow$ ordem lexicográfica (ASCII);
  - Variáveis $\rightarrow$ endereço interno.

## Resolução
Resolução é uma regra de inferência.

### Prova por Refutação
$$
\begin{aligned}
BC \Rightarrow P
&\Leftrightarrow \neg \neg (BC \Rightarrow P) \\
&\Leftrightarrow \neg \neg (\neg BC \lor P) \\
&\Leftrightarrow \neg (BC \land \neg P) \\
&\Leftrightarrow \neg (BC \land \neg P) \lor \text{False} \\
&\Leftrightarrow (BC \land \neg P) \Rightarrow \text{False}
\end{aligned}
$$

$$
\begin{aligned}
& a)\;
\frac{A \vee B,\; \neg B \vee C}
     {A \vee C}
\\[1.2em]
& b)\;
\text{Sejam os literais } p_i, q, r \text{ e } s_i,
\\
& \text{onde o unificador } \theta = (p_j/\neg q), \text{ então}
\\[1em]
& r :- p_1, \ldots, p_j, \ldots, p_m
\\
& q :- s_1, \ldots, s_n
\\[1em]
& \frac{\phantom{xxxxxxxxxxxxxxxxxxxxxxxx}}
        {\; r :- p_1,\ldots,p_{j-1},p_{j+1},\ldots,p_m \;}
\end{aligned}
$$

Duas cláusulas de Horn são <u>resolvidas</u> em uma nova cláusula se uma delas **contiver um predicado <u>negado</u> que corresponda a um predicado <u>não-negado</u> na outra cláusula.**
- Tautologia

A **nova cláusula elimina o termo de correspondência** e fica disponível para uso em resposta a pergunta.
- As variáveis são substituídas por constantes associadas de maneira consistente.

### Exemplo
```prolog
come (urso, peixe).
come (urso, raposa).Observe que a regra (Cláusula de Horn)
come (cavalo, mato).
animal (urso).
animal (peixe).
animal (raposa).

presa(X) :- come(Y,X), animal(X)
```

Observe que a regra `presa(X) :- come(Y,X), animal(X)`, corresponde a wff:  
$\forall X \forall Y (come(Y,X) \land animal(X) \rightarrow presa(X))$

Corresponde a cláusula:   
$\neg (come(Y,X) \land animal(X)) \lor presa(X)$  
$\neg come(Y,X) \lor \neg animal(X) \lor presa(X)$ 

```prolog
?- presa(X).
```

- O Prolog procura na BC por uma regra com o predicado presa(X) como o consequente.
- Busca outras cláusulas que possam ser resolvidas com a regra.
- Faz as substituições das variáveis na cláusula regra.

Ordem da Busca:
1. $\neg come(Y,X) \lor \neg animal(X) \lor presa(X)$.
2. come(urso,peixe). 
3. $\neg animal(peixe) \lor presa(peixe)$.
4. animal(peixe).
5. presa(peixe).
