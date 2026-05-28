# Álgebra Relacional

Consiste em um **conjunto de operações** utilizadas para manipular relações (**tabelas**).

## Operações

### Operação de Seleção
Seleciona um **subconjunto de tuplas** de uma relação (linhas de uma tabela), a paritr da condição de seleção.

$$\sigma_{\text{condição}}(\text{Relação})$$

#### Exemplo: Seleção de funcionários do sexo masculino

EMPREGADO
| Matricula | Nome | Sexo | Salario |
| :-------: | :--: | :--: | :-----: |
|    111    | PEDRO | M | 1000.00 |
|    222    | MARIA | F | 2000.00 |
|    333    | JOÃO | M | 120.00 |
|    444    | ANA | F | 120.00 |
|    321    | CARLOS | M | 150.00 |
|    123    | CLAUDIA| F | 359.00 |
|    001    | MARCOS | M | 120.00 |

$\sigma_{\text{Sexo} = M}(\text{EMPREGADO})$

| Matricula | Nome | Sexo | Salario |
| :-------: | :--: | :--: | :-----: |
|    111    | PEDRO | M | 1000.00 |
|    333    | JOÃO | M | 120.00 |
|    321    | CARLOS | M | 150.00 |
|    001    | MARCOS | M | 120.00 |

#### Exemplo: Seleção de funcionários do sexo masculino com o salário maior que 120.00

$\sigma_{(\text{Sexo} = M) \text{ AND } (\text{ Salario} > 120.00)}(\text{EMPREGADO})$

| Matricula | Nome | Sexo | Salario |
| :-------: | :--: | :--: | :-----: |
|    111    | PEDRO | M | 1000.00 |
|    321    | CARLOS | M | 150.00 |

### Operação de Projeção
Proketa os atributos que devem retornar de uma relação (**colunas da tabela**).

$$\pi_{<\text{lista de atributos}>}(\text{Relação})$$

#### Exemplo: Selecionar o nome e o salário dos empregados

$\pi_{\text{Nome, Salario}}(\text{EMPREGADO})$

| Nome | Salario |
| :--: | :-----: |
| PEDRO | 1000.00 |
| MARIA | 2000.00 |
| JOÃO | 120.00 |
| ANA | 120.00 |
| CARLOS | 150.00 |
| CLAUDIA| 359.00 |
| MARCOS | 120.00 |

A operação de projeção **remove implicitamente as tuplas duplicadas** presentes na relações resultante.

$\pi_{\text{Sexo}}(\text{EMPREGADO})$

| Sexo |
| :--: |
|  M   |
|  F   |

Como o resultado as operações também são tabelas podemos **combinar os operadores**.

#### Exemplo: Selecione o nome de todos os funcionários do sexo masculino com salário maior que 120.00

$\pi_{\text{Nome}}(\sigma_{(\text{Sexo} = M) \text{ AND } (\text{ Salario} > 120.00)}(\text{EMPREGADO}))$

| Nome |
| :--: |
| PEDRO |
| CARLOS |

### Operadores de Conjuntos

**União:** $R \cup S$
- A união entre $R$ e $S$ é o conjunto de elementos estão em R ou em S ou em ambos, **excluindo as linhas duplicadas**.

**Intesecção:** $R \cap S$
- A intersecção entre $R$ e $S$ é o conjunto dos elementos que tanto em $R$ quanto em $S$. 

**Diferença:** $R - S$
- A diferença entre $R$ e $S$ é o conjunto de elementos que estão em $R$, porém não estão em $S$.

> [!IMPORTANT]
>
> Essa operações só são possíveis quando duas ou mais tabelas:
> - Compartilham o mesmo número de colunas;
> - Quando as colunas correspondentes compartilham os **mesmos domínios** ou **domínios compatíveis**.
> 
> Diz-se que elas são **compatíveis com a união (*union-compatible*)**.

#### Exemplo 01

R
| name     | address          | gender | birthdate |
|----------|------------------|--------|------------|
| Princess | Bryan            | F      | 9/9/99     |
| Luke     | College Station  | M      | 8/8/88     |

S
| name     | address | gender | birthdate |
|----------|----------|--------|------------|
| Princess | Bryan    | F      | 9/9/99     |
| Harry    | Houston  | M      | 7/7/77     |

$R \cup S$
| name     | address          | gender | birthdate |
|----------|------------------|--------|------------|
| Princess | Bryan            | F      | 9/9/99     |
| Luke     | College Station  | M      | 8/8/88     |
| Harry    | Houston          | M      | 7/7/77     |

$R \cap S$
| name     | address          | gender | birthdate |
|----------|------------------|--------|------------|
| Princess | Bryan            | F      | 9/9/99     |

$R - S$
| name     | address          | gender | birthdate |
|----------|------------------|--------|------------|
| Luke     | College Station  | M      | 8/8/88     |

#### Exemplo 02
(a) Relações Originais

ALUNO
| PN      | UN      |
| ------- | ------- |
| Susan   | Yao     |
| Ramesh  | Shah    |
| Johnny  | Kohler  |
| Barbara | Jones   |
| Amy     | Ford    |
| Jimmy   | Wang    |
| Ernest  | Gilbert |

INSTRUTOR
| PNOME   | UNOME   |
| ------- | ------- |
| John    | Smith   |
| Ricardo | Browne  |
| Susan   | Yao     |
| Francis | Johnson |
| Ramesh  | Shah    |

(b) ALUNO $\cup$ INSTRUTOR
| PN      | UN      |
| ------- | ------- |
| Susan   | Yao     |
| Ramesh  | Shah    |
| Johnny  | Kohler  |
| Barbara | Jones   |
| Amy     | Ford    |
| Jimmy   | Wang    |
| Ernest  | Gilbert |
| John    | Smith   |
| Ricardo | Browne  |
| Francis | Johnson |

(c) ALUNO $\cap$ INSTRUTOR
| PN     | UN   |
| ------ | ---- |
| Susan  | Yao  |
| Ramesh | Shah |

(d) ALUNO − INSTRUTOR
| PN      | UN      |
| ------- | ------- |
| Johnny  | Kohler  |
| Barbara | Jones   |
| Amy     | Ford    |
| Jimmy   | Wang    |
| Ernest  | Gilbert |

(e) INSTRUTOR − ALUNO
| PNOME   | UNOME   |
| ------- | ------- |
| John    | Smith   |
| Ricardo | Browne  |
| Francis | Johnson |

### Produto Cartesiano
A <u>operação de produto cartesiano</u> é uma operação binária que **combina as tuplas** de ambas as relações envolvidadas. 

Considere duas relações $R (A_1, A_2, \ldots, A_n) \text{ e } S (B_1, B_2, \ldots, B_m)$; o resultado do produto cartesiano consiste em uma relação $Q$ com $n + m$ **atributos**: $Q (A_1, A_2, \ldots, A_n, B_1, B_2, \ldots, B_m)$, **nesta ordem**. 

A relação resultante $Q$ possui uma **tupla** para cada possível combinação de tuplas $R$ e $S$.

EMPREGADO
| Matric | Nome | Sexo | Salario | Dep |
| :----: | :--: | :--: | :-----: | :-: |
|   111  | PEDRO | M | 1000.00 | VE |
|   222  | MARIA | F | 2000.00 | EN |
|   123  | CLAUDIA| F | 359.00 | VE |
|   001  | MARCOS | M | 120.00 | EN |

DEPTO
| CodDep | NomeDep |
| :----: | :-----: | 
|   VE   | Vendas |
|   EN   | Engenharia |

(EMPREGADO x DEPTO)
| Matric |   Nome  | Sexo | Salario | Dep | CodDep | NomeDep    |
| :----: | :-----: | :--: | :-----: | :-: | :----: | :--------- |
|   111  |  PEDRO  |   M  | 1000.00 |  VE |   VE   | Vendas     |
|   111  |  PEDRO  |   M  | 1000.00 |  VE |   EN   | Engenharia |
|   222  |  MARIA  |   F  | 2000.00 |  EN |   VE   | Vendas     |
|   222  |  MARIA  |   F  | 2000.00 |  EN |   EN   | Engenharia |
|   123  | CLAUDIA |   F  |  359.00 |  VE |   VE   | Vendas     |
|   123  | CLAUDIA |   F  |  359.00 |  VE |   EN   | Engenharia |
|   001  |  MARCOS |   M  |  120.00 |  EN |   VE   | Vendas     |
|   001  |  MARCOS |   M  |  120.00 |  EN |   EN   | Engenharia |

A tabela resultante além de **confusa** é **inconsistente** pois temos, por exemplo, que Pedro trabalha em dois departamentos.

Para arrumar usamos o operação de seleção junto com o produto cartesiano:

$\sigma_{\text{Dep } = \text{ CodDep}}(\text{EMPREGADO} \times \text{DEPTO})$

| Matric |   Nome  | Sexo | Salario | Dep | CodDep | NomeDep    |
| :----: | :-----: | :--: | :-----: | :-: | :----: | :--------- |
|   111  |  PEDRO  |   M  | 1000.00 |  VE |   VE   | Vendas     |
|   222  |  MARIA  |   F  | 2000.00 |  EN |   EN   | Engenharia |
|   123  | CLAUDIA |   F  |  359.00 |  VE |   VE   | Vendas     |
|   001  |  MARCOS |   M  |  120.00 |  EN |   EN   | Engenharia |

Outra forma de fazer a mesma consulta, é mais utilizada com ambas tem o mesmo nome de atributo:

$\sigma_{\text{EMEPREGADO.Dep } = \text{ DEPTO.CodDep}}(\text{EMPREGADO} \times \text{DEPTO})$

#### Exemplo: Selecione o nome do empregado e o nome do departamento em que ele trabalha.

$\pi_{\text{Nome, NomeDep}}(\sigma_{\text{Dep } = \text{ CodDep}}(\text{EMPREGADO} \times \text{DEPTO}))$

|  Nome   | NomeDep |
| :-----: | :-----: |
|  PEDRO  | Vendas  |
|  MARIA  | Engenharia |
| CLAUDIA | Vendas     |
|  MARCOS | Engenharia |

### Operação de Renomeação
Para efetuar uma operação binária que envolva duas **tabelas iguais**, utiliza-se o operador de renomeação para eliminar possíveis **ambiguidades**.

$$\rho_{<\text{Novo nome da relação}>}(\text{Relação})$$

**Exemplo:** $\rho_{e}(\text{EMPREGADO})$

### Operação de Junção
Junção (**JOIN**) entre tabelas.

$$R \bowtie_{ <\text{condição}> } S$$

O resultado desta operação é construído da seguinte forma:
- Tome o produto de R e S
- Selecione do produto apenas as tuplas que **satisfazem a condição C**.

Essa operação é semelhante a fazer $\sigma_{\text{codição}}(R \times S)$.

#### Exemplo
$\text{DEPT\_GET} \leftarrow \text{DEPARTAMENTO} \bowtie_{\text{ GERSSN } = \text{ SSN}} \text{EMPREGADO}$

| DEPT_GER | DNOME | DNUMERO | GERSSN | ... | PNOME | MINICIAL | UNOME | SSN | ... |
| :------: | :---: | :-----: | :----: | :-: | :---: | :------: | :---: | :-: | :-: |
|  | Research | 5 | 333445555 | ... | Franklin | T | Wong | 3333445555 | ... |
|  | Administration | 4 | 987654321 | ... | Jennifer | S | Wallace | 987654321 | ... |
|  | Headquarters | 1 | 888665555 | ... | James | E | Borg | 888665555 | ... |

> [!NOTE]
>
> É comum utilizar **setas** para fazer atribuição de tabelas.

### Operação de Junção Natural
Operação de Junção natural utilizada para fazer relacionamento entre relações, **eliminando a repetição** dos atributos de ligação entre as tabelas.
- Só conseguimos utilzá-la se tiver uma ligação direta entre as tabelas.

$$R * S$$

#### Exemplos
a) $\text{DEPT\_PROJ} \leftarrow \text{PROJETO} * \text{DEPT}$

| PNAME            | PNUMBER | PLOCALIZACAO | DNUM | DNOME          | GERSSN   | GERDATAINICIO |
|------------------|----------|---------------|------|----------------|-----------|----------------|
| ProdutoX         | 1        | Bellaire      | 5    | Research       | 333445555 | 1988-05-22     |
| ProdutoY         | 2        | Sugarland     | 5    | Research       | 333445555 | 1988-05-22     |
| ProdutoZ         | 3        | Houston       | 5    | Research       | 333445555 | 1988-05-22     |
| Automacao        | 10       | Stafford      | 4    | Administration | 987654321 | 1995-01-01     |
| Reorganizacao    | 20       | Houston       | 1    | Headquarters   | 888665555 | 1981-06-19     |
| Novosbeneficios  | 30       | Stafford      | 4    | Administration | 987654321 | 1995-01-01     |

b) $\text{DEPT\_LOCS} \leftarrow \text{DEPARTAMENTO} * \text{DEPT\_LOCALIZACOES}$

| DNOME              | DNUMERO | GERSSN   | GERDATAINICIO | LOCALIZACAO |
|--------------------|----------|-----------|----------------|-------------|
| Sede Administrativa| 1        | 888665555 | 1981-06-19     | Houston     |
| Administracao      | 4        | 987654321 | 1995-01-01     | Stafford    |
| Pesquisa           | 5        | 333445555 | 1988-05-22     | Bellaire    |
| Pesquisa           | 5        | 333445555 | 1988-05-22     | Sugarland   |
| Pesquisa           | 5        | 333445555 | 1988-05-22     | Houston     |

### Inner and Outer Join

$U$
| A | B | C |
| - | - | - |
| 1 | 2 | 3 |
| 4 | 5 | 6 |
| 7 | 8 | 9 |

$V$
| B | C | D  |
| - | - | -- |
| 2 | 3 | 10 |
| 2 | 3 | 11 |
| 6 | 7 | 12 |

$U \bowtie V$
| A | B | C | D  |
| - | - | - | -- |
| 1 | 2 | 3 | 10 |
| 1 | 2 | 3 | 11 |

Left Outer Join - $U \ \overset{\scriptstyle\circ}{\bowtie}_L \ V$
| A | B | C | D  |
| - | - | - | -- |
| 1 | 2 | 3 | 10 |
| 1 | 2 | 3 | 11 |
| 4 | 5 | 6 |    |
| 7 | 8 | 9 |    |

Full Outer Join - $U \ \overset{\scriptstyle\circ}{\bowtie} \ V$
| A | B | C | D  |
| - | - | - | -- |
| 1 | 2 | 3 | 10 |
| 1 | 2 | 3 | 11 |
| 4 | 5 | 6 |    |
| 7 | 8 | 9 |    |
|   | 6 | 7 | 12 |

Right Outer Join - $U \ \overset{\scriptstyle\circ}{\bowtie}_R \ V$
| A | B | C | D  |
| - | - | - | -- |
| 1 | 2 | 3 | 10 |
| 1 | 2 | 3 | 11 |
|   | 6 | 7 | 12 |

### Agregação
A agregação é usada para **resumir ou agregar** os valores em uma coluna de uma relação.

Alguns tipos de operações de agregação são:
- SUM
- AVR
- MIN
- MAX
- COUNT

#### Exemplo
| A | B |
| - | - |
| 1 | 2 |
| 3 | 4 |
| 1 | 2 |
| 1 | 2 |

1. SUM (B) = 2 + 4 + 2 + 2 = 10
2. AVR (A) = (1 + 3 + 1 + 1)/4 = 1.5
3. MIN (A) = 1
4. MAX (B) = 4
5. COUNT (A) = 4

### Agrupamento
Considere as linhas de uma tabela em grupos, correspondentes ao **valor de uma ou mais outras colunas**, e agregamos apenas dentro de cada grupo.

$$\gamma_L(\text{Relação})$$

#### Exemplo
$\gamma_{\text{startName, MIN(year)}}(\text{StarsIn})$

StarsIn
| title               | year | starName              |
| :-----------------: | :--: | :-------------------: |
| Catch Me If You Can | 2002 | Leonardo DiCaprio     |
| The Aviator         | 2004 | Leonardo DiCaprio     |
| Dallas Buyers Club  | 2013 | Mathew McConaughey    |
| Cast Away           | 2000 | Tom Hanks             |
| Catch Me If You Can | 2002 | Tom Hanks             |
| The Terminal        | 2004 | Tom Hanks             |

### Árvore
Quais são os títulos e os anos do filmes feitos pela Fox que tem menos de 100 minutos de duração ?

```text
                 π title,year
                       |
                       ∩
                    /     \
      σ length ≥ 100     σ studioName = 'Fox'
              |                     |
            Movies                Movies
```

## Exercício
Qual o nome do outro ator que fez o mesmo filme que o Tom Hanks?

StarsIn
| title               | year | starName              |
| :-----------------: | :--: | :-------------------: |
| Catch Me If You Can | 2002 | Leonardo DiCaprio     |
| The Aviator         | 2004 | Leonardo DiCaprio     |
| Dallas Buyers Club  | 2013 | Mathew McConaughey    |
| Cast Away           | 2000 | Tom Hanks             |
| Catch Me If You Can | 2002 | Tom Hanks             |
| The Terminal        | 2004 | Tom Hanks             |

$\pi_{outros.starName}( \sigma_{\text{th.starName = 'Tom Hanks' AND th.title = outros.title AND outros.starName <> 'Tom Hanks'}}(\rho_{\text{th}}(\text{StarsIn}) \times \rho_{\text{outros}} ( \text{StarsIn} ) ) )$
