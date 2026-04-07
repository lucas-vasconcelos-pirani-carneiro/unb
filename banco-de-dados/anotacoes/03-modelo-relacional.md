# Modelo Relacional

- Criado por *Edgar Frank Codd* na década de 70.

### Tabela - Relação

FUNCIONARIO
| matricula | nome | data_nasc | salario |
| :-------: | :--: | :--------:| :-----: |
| 111 | Joana | 25/06/1991 | 12.000 |
| 222 | Pedro | 14/08/1995 | 8.000 |
| 333 | Bia | 03/11/1994 | 9.000 |
| 444 | Erick | 17/10/1997 | 6.000 |

DEPARTAMENTO
| CodDep | NomeDep |
| :--: | :-----: |
|  VE  | Vendas |
|  MK  | Marketing |
|  TI  | Tecnologia |

- Nela estão contidos os dados dos nossos funcionários.
- **Coluna:** Atributo ou a propriedade da tabela.
    - **Nome do Campo:** "Nome" do atributo.
        - Ex: matricula, nome, salario.
    - **Valor do Abritubo:** Valor de um determinado campo. 
        - Ex: 111, Joana, 12.000.

- **Linha** ou **Tuplas:** São os registros da tabela.
- **Grau:** Número de atributos/colunas que uma tabela possue.
    - Ex: Possui grau 4.

- **Chave Primária (*Primary Key - PK*):** Identifica unicamente uma tupla detre o conjunto de todas as tuplas.
    - Ex: matricula, CodDe.

- **Chave Estrangeira:** É utilizado para fazer <u>relacionamento</u> entre tabelas.
    - Incluí-se uma coluna nova na tabela e o valor dessa coluna está ligado com a outra tabela que está sendo relacionada.
    - Ex: `CodDep` é a chave **estrangeira (*Foreign Key - FK*)**.

| matricula | nome | data_nasc | salario | CodDep |
| :-------: | :--: | :--------:| :-----: | :---: |
| 111 | Joana | 25/06/1991 | 12.000 | MK |
| 222 | Pedro | 14/08/1995 | 8.000 | TI |
| 333 | Bia | 03/11/1994 | 9.000 | VE |
| 444 | Erick | 17/10/1997 | 6.000 | VE |

### Restrições de Integridade - *Constraints*

- São as **regras** que o SGBD <u>vai ou não permitir</u> dentro do bando de dados.

#### Restrição de Integridade de Domínio
- **Domínio:** Conjunto de valores que um determinado atributo pode ter. 
- O SGBD vai garantir essa restrição de valores, ou seja, não haverá dados fora do domínio especificado.
    - Ex: Nome = 23435.

#### Restrição de Integridade de Valores NULL
- Pode definir se aquela coluna é **obrigatória**, `NOT NULL`, não pode ter valores nulos.
- Ex: A coluna nome pode ser colocada como `NOT NULL`, assim, quando o for tentar inserir no banco de dados alguma instância sem nome o SGBD irá retornar um erro. 

#### Restrição de Integridade de Entidade
- Está relacionada com a chave primária.
- Uma chave primária **não** pode ser **repetida** e ser **nula**.

#### Restrição de Integridade Referencial
- Está associada ao conceito de chave estrangeira.
- O valor de uma **chave estrangeira** tem que ser **igual** ao valor de uma **chave primária**.
    - Isso tem que ocorrer para fazer a ligação com a outra tabela. 

- O SGBD não permite colocar um valor de chave estrangeira que **não exista** como chave primária da tabela que faz referência a essa chave estrangeira.

> [!WARNING]
>
> Uma chave estrangeira também pode ser nula, ela pode ser um campo que não estaja preenchido se a chave estrangeira for `NOT NULL`.

## Mapeamento MER $\rightarrow$ MR

- O objetivo é transformar o projeto conceitual feito pelo MER para o modelo lógico usando MR.

![processo-de-mapeamento](img/03-modelo-relacional/processo-de-mapeamento.png)

### Entidade

- Cada **entidade** vira uma **tabela** no banco de dados.
- Cada dessa entidade **atributo** gera uma da mesma **coluna**.

#### Atributo Composto

- Somente as **partes** desse atributo composto é mapeada.
- Funcionario (<u>matricula</u>, nome, rua, cidade)

![mapeamento-atributo-composto](img/03-modelo-relacional/mapeamento-atributo-composto.png)

FUNCIOANRIO
| matricula (PK) | nome | rua | cidade |
| : -----------: | :--: | :-: | :----: |

#### Atributo Multivalorado

- É preciso **criar** uma **nova tabela** para esse atributo.
- Ex: Funcionario e Telefone
    - A chave da tabela TELEFONE é composta pela **chave do funcionário** + o próprio **atributo telefone**.
    - É uma **chave composta**.
- Funcionario (<u>matricula</u>, nome, rua, cidade)
- Telefone (matFunc, fone), onde `MatFunc` referencia Funcionario (matricula)

FUNCIOANRIO
| matricula (PK) | nome | rua | cidade |
| :-----------: | :--: | :-: | :----:  |

TELEFONE
| matFunc (PK e FK) | fone (PK) |
| :--------------: | :--------: |

![mapeamento-atributo-multivalorado](img/03-modelo-relacional/mapeamento-atributo-multivalorado.png)

#### Entidade Fraca

- É uma entidade que precisa da **chave** de uma **outra entidade** para se identificar unicamente.
- Ex: Funcionario e Dependete
    - A chave da tabela DEPENDENTE é composta pela **chave do funcionário** + o nome do dependente.
    - É uma **chave composta**.
- Funcionario (<u>matricula</u>, nome, rua, cidade)
- Telefone (matFunc, nome, data_nasc, parentesco), onde `MatFunc` referencia Funcionario (matricula)

FUNCIOANRIO
| matricula (PK) | nome | rua | cidade |
| :-----------: | :--: | :-: | :----:  |

TELEFONE
| matFunc (PK e FK) | nome (PK) | data_nasc | parentesco |
| :--------------: | :--------: | :-------: | :--------: | 

![mapeamento-entidade-fraca](image.png)

### Relacionamento

- Pode gerar uma **tabela** ou ser uma **coluna/conjunto de colunas**, como na coluna FK, no banco de dados. 
- O relacionamento no modelo relacional é implementado por meio de **chaves estrangeiras**.
    - Ou seja, são responsáveis pelo relacionamento entre as tabelas.

![chave-estrangeira](img/03-modelo-relacional/chave-estrangeira.png)

#### Relacionamento 1:1
- **Parcipação total** dos dois lados: Gera uma **única** tabela no banco de dados. 

![tipo1-card1-1](img/03-modelo-relacional/tipo1-card1-1.png)  
![tipo1-card1-1_tabela](img/03-modelo-relacional/tipo1-card1-1_tabela.png)

- **Parcipação parcial** dos dois lados: Cria-se uma coluna de **chave estrangeira** em uma das tabelas para fazer a ligação.
    - Não faz diferença em qual tabela ($E_1$, $E_2$) colocar a chave estrangeira.

![tipo2-card1-1](img/03-modelo-relacional/tipo2-card1-1.png)  
![tipo2-card1-1_tabela](img/03-modelo-relacional/tipo2-card1-1_tabela.png)
![tipo2-card1-1_tabela_1](img/03-modelo-relacional/tipo2-card1-1_tabela_1.png)

- **Parcipação total** de um lado e **Participação parcial** de outro: Cria-se uma coluna de **chave estrangeira** na tabela com **partcipação total**.

![tipo3-card1-1](img/03-modelo-relacional/tipo3-card1-1.png)  
![tipo3-card1-1_tabela](img/03-modelo-relacional/tipo3-card1-1_tabela.png)

#### Relacionamento 1:N / N:1
- Cria-se uma coluna de **chave estrangeira** na tabela que se relaciona uma **única** vez com a outra tabela, ou seja, do `lado N` na **modelagem MER**.

![card1-N](img/03-modelo-relacional/card1-N.png)  
![card1-N_tabela](img/03-modelo-relacional/card1-N_tabela.png)

#### Relacionamento N:N
- Cria-se uma **nova tabela** que é composta por **chaves estrangeiras** das outras tabelas. 

![cardN-N](img/03-modelo-relacional/cardN-N.png)  
![cardN-N_tabela](img/03-modelo-relacional/cardN-N_tabela.png)

## Exemplo 
