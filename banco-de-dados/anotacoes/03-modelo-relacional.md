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

> ![WARNING]
>
> Uma chave estrangeira também pode ser nula, ela pode ser um campo que não estaja preenchido se a chave estrangeira for `NOT NULL`.

## Mapeamento MER --> MR

## Exemplo 
