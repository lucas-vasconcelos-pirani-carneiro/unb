# Introdução - Linguagem Prolog

- Programação em Lógica:
    - Definições lógicas são vistas como programas. 
    - Em Prolog definições lógicas são **cláusulas de Horn**.
- É praxe representar apenas o conhecimento **positivo** como **asserções afirmativas**.
- Hipótese do Mundo Fechado: As declarações **relevantes e verdadeiras** estão **contidas** na BC ou podem ser **derivadas** a partir de fatos, regras e a BC.
- Negação: Ausência da declaração.
    - Não é uma negação lógica.
- Resolução por **refutação**: $P$ é consistente **se falhar a prova** de $\neg P$.

### Cláusulas de Horn
- **Cláusula que tem, no máximo, um literal positivo**
    - "Well Formed Formula" em forma conjuntiva normal e sem conectivo $\land$.
    - Prefixo quantificadores universais ($\forall$) aplicado a predicados conectados por $\lor$.

### Lógica Decidível
- <u>Notação Lógica</u>
    - $\forall x ( (\text{estimacao}(x) \land \text{pequeno}(x)) \to \text{bichoapt}(x) ) $
    - $\forall x ( ( \text{gato}(x) \lor \text{cachorro}(x)) \to \text{estimacao}(x) ) $
    - $\forall x ( \text{poodle}(x) \to (\text{cachorro}(x) \land \text{pequeno}(x)) ) $
    - $\text{poodle}(fido)$

- <u>Cláusulas de Horn</u>
    - $\neg \text{estimacao}(x) \lor \neg \text{pequeno}(x) \lor \text{bichoapt}(x)$, foi aplicado Demorgan.
    - $\neg \text{gato}(x) \lor \text{estimacao}(x)$, Após aplicar Demorgan foi divido em duas parte.
    - $\neg \text{cachorro}(x) \lor \text{estimacao}(x)$, parte dois. 
    - $\neg \text{poodle}(x) \lor \text{cachorro}(x)$, Dividiu em duas partes pois só pode ter um literal,só "ou", pela Cláusula de Horn.
    - $\neg \text{poodle}(x) \lor \text{pequeno}(x)$
    - $\text{poodle}(fido)$

> [!NOTE]
>
> Uma teória em sistema lógico é decidível se existe um algoritmo eficiente para determinar se fórmulas arbitrárias pertencem a ela.

## Características
- Quantificadores universais **não** são explicitados.
- Conectivos `,` e `;`, respectivamente $\land$ e $\lor$.
- A regra $p \to q$ é representada como `q :- p`. 
- **Cabeça** `:-` lista de predicados.

- <u>Cláusulas de Horn</u>
    - $\neg \text{estimacao}(x) \lor \neg \text{pequeno}(x) \lor \text{bichoapt}(x)$
    - $\neg \text{gato}(x) \lor \text{estimacao}(x)$
    - $\neg \text{cachorro}(x) \lor \text{estimacao}(x)$
    - $\neg \text{poodle}(x) \lor \text{cachorro}(x)$
    - $\neg \text{poodle}(x) \lor \text{pequeno}(x)$
    - $\text{poodle}(fido)$

### Notação Prolog

```prolog
bichoapt(X) :- estimação(X), pequeno(X).
estimação(X) :- gato(X). 
estimação(X) :- cachorro(X).
cachorro(X) :- poodle(X).
pequeno(X) :- poodle(X).
poodle(fido).
```

### Fatos Prolog
- Cláusulas de Horn com premissa única **True** implícita.
    - $C. \Leftrightarrow True \to C$

- Regras Prolog: utiliza cláusulas de Horn 
```prolog
C :- P1, ... ,Pn. <-> P1 & ... & Pn -> C
```

- Premissas de cláusulas com a mesma conclusão são implicitamente **disjuntivas**:
```prolog
C :- P1, ... ,Pn.
C :- Q1, ... ,Qm.
<-> (P1 & ... & Pn) v (Q1 & ... & Qm) -> C
```

### Máquina de Inferências
- **Inferência:**
    -  Resolução por <u>refutação</u>.
- **Seleção das regras:**
    - Raciocínio **para trás** com indexação das regras pelo **functor** e **casamento** (*matching*) precedido pelas instanciações das variáveis das regras (**unificação**).
- **Resolução de conflitos:**
    - Preferência baseada em regras (ordem).

## Interpretador Prolog

### Controle e busca
- **Aplica regra de resolução:**
    - Possui estratégia **linear** 
        - Sempre tenta unificar **último fato** a provar com a **conclusão** de uma cláusula do programa;
    - Na ordem de escrita das cláusulas no programa;
    - Encadeamento de regras **para trás**,
    - **Busca em profundidade** e da esquerda para direita das premissas das cláusulas,
        - **backtracking sistemático** e **linear** quando a **unificação falha**,
        - Sem occur-check na unificação.

> [!NOTE]
>
> - Estratégia eficiente mas incompleta.

### Verificação de Ocorrência
- Unificação de Prolog é sem **occur-check**, quando chamado com uma variável X e um literal l, <u>instancia X com l</u>, **sem verificar** antes se X ocorre em l.
- Junto com a **busca em profundidade**:
    - Faz com que Prolog possa entrar em **loop** com **regras recursivas**, 

```prolog
c(X) :- c(p(X)). % gera lista infinita de objetivos:
c(p(U)), c(p(p(U))), c(p(p(p(U)))), ...
```

> [!NOTE]
> 
> - Cabe ao programador não escrever tais regras,
> - Torna a **unificação linear** no lugar de quadrática no tamanho dos termos a unificar.

### Vantagens
- Ampla expressividade.
- Representação de associações empíricas (**heurísticas**) em domínios não estruturados.
- Codificação da experiência de especialistas na resolução de problemas.
- Possui sintaxe e semântica simples.
- **Aplicação:**
    - Sistemas especialistas, em especial, de diagnóstico.
- **Prototipação:**
    - Crescimento incremental da BC. 

### Desvantagens
- **Falta de estruturação da BC dificulta.**
    - Introduzir modificações na BC.
    - Localizar informações desejadas.
    - Representar estruturas <u>inerentes ao domínio</u> tais como:
        - Taxonomia de classes
        - Relações temporais
        - Relações estruturais
        - Herança de atributos
- Regras podem ser modularizadas de forma a se obter **subconjuntos independentes** e **complementares**, o que facilita o processo de resolução de conflitos.
- Não facilita a distinção semântica entre propriedades essenciais e propriedades <u>complementares</u> dos objetos.

## Sintaxe SWI-Prolog
Os dados representados em Prolog podem ser dos seguites tipos:

- **Variáveis:** Iniciadas com letras **maiúsculas** ou underscore (`_`) seguidos de qualquer <u>caractere alfanumérico</u>.
    - Somente `_` define uma **variável anônima**.
    - Ex: X, Y1, _Nome, ...

- **Átomos:** São **constantes** que devem ser iniciadas com letra **minúsculas** seguidas de qualquer <u>caractere alfanúmerico</u> ou qualquer sequência entre '' (aspas simples).
    - Ex: joao, 'Joao', '16', ...

- **Inteiros:** Qualquer **sequência numérica** que são contenha ponto (`.`).
    - Caracteres ASCII entre "" (aspas duplas) são tratados como listas de inteiros.
    - Ex: 1, 6, -3, "a", ...

- **Floats:** Números com um ponto (`.`) e pelo menos uma casa decimal.
    - Ex: 5.3, 7. (incorreto).

- **Listas:** Sequência ordenada de elementos entre [] e separados por vírgulas.
    - Ex: [a,b,c], [a | b,c] (incorreto)

### Exemplo
| Termo | Classificação |
| :---: | :-----------:  |
| vINCENT | Átomo |
| 23 | Inteiro |
| variable23 | Átomo |
| aulas de lógica | Erro |
| 'Joao' | Átomo |
| [1, [2,3], 4] | Lista |
| Footmassage | Variável |
| 65. | Erro |
| 23.0 | Float |
| _ | Variável Anônima |
| 'aulas de logica' | Átomo |
| "a" | Lista |
| [ ] | Lista |

Os comandos `write` e `read`, **escrevem** e **leem** sobre os arquivos padrão, monitor e teclado.

```prolog
% write(termo). 
?- write('Aula de Prolog').
Aula de Prolog
true.

?- write(Aula de Prolog).
ERROR: Syntax error: Operator expected
ERROR: write(Aula
ERROR: ** here **
ERROR:  de Prolog) . 

?- write(X).
_21288
true.

?- write(X).
_22934
true.

?- write(X).
_24572
true.

?- write(joao).
joao
true.

% read(Var)
read(X).
read(x). % Erro
read(Joao).
read(joao). % Erro
```

Alguns caracteres são **especias** para impressão, são eles:

- `nl`, `\n`, `\l`: Nova linha.
- `\r`: Retorna ao início da linha.
- `\t`: Tabulação.
- `\%`: Imprime o símbolo %.

Existem dois tipos de **comentários** em `Prolog`, são eles:

- `%`: Todo texto existente na mesma linha após o símbolo é considerado comentário. 
- `/* */`: Todo o texto entre os símbolos é considerado comentário.

## Usando o Prolog

Para usar o Prolog você precisa saber:
1. Invocar o Prolog.
2. Sair do Prolog: `^Z` 

```prolog
halt. % Retorna ao chamador
```

Usar um editor de arquivo texto para editar um programa.

Carregar um programa: 
```prolog
load ou load_files(arquivo).  % fonte ou objeto
consult(arquivo).  % fonte
consult(user).  % carrega via teclado. Fim ^Z
reconsult(arquivo).  % recarrega arquivo
```

Capacidade especial de algumas implementações:
```prolog
% Armazenar a BC atual em um arquivo
save(arquivo).  % salva a BC no arquivo, objeto
save_predicates(predicados, arquivo). % salva os predicados em arquivo, código

% Recuperar o arquivo salvo
restore(arquivo).  % recupera o código objeto
load ou load_files(arquivo).   % objeto
```

## Exemplos
```prolog
/*
* atom(): Verifica se o parâmetro é um átomo.
* var(): Verifica se o parâmetro é uma variável.
* number(): Verifica se o parâmetro é um número.
* is_list(): Verifica se o parâmetro é uma lista.
* Observação: Toda consulta em Prolog tem que terminar com ponto (.)
*/

?- atom(joao).
true.

?- atom(12).
false.

?- var(Joao).
true.

?- var(12).
false.

?- number(12).
true.

?- is_list([]).
true.

start() :- 
    write('Digite o valor de X:'),nl,
    read(X),
    write(X).
    
% Execução
?- start().
Digite o valor de X:
|: lucas.
lucas
true.

?- start().
Digite o valor de X:
|: 50.
50
true.

?- start().
Digite o valor de X:
|: 50.54.
50.54
true.
```
