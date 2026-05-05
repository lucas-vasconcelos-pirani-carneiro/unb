# SQL - *Structured Query Language*

- Foi criado por ***Donald D. Chamberlim*** e por ***Raymond F. Boyce*** no laboratório da IBM.
- Virou padrão pela primeira vez em 1986 pela `ANSI` e `ISO`.
- Hoje em dia existe diversas outras versões: `SQLServer`, `MySQL`, `PostgreSQL`.  
- Basicamente, o mesmo SQL que é usado no `MySQL` pode ser usado no `PostgreSQL`, por exemplo.
    - Existe algumas **pequenas diferenças** entre eles, embora o contexto geral do `SQL` é sempre mantido.

## Linguagem SQL
- Na lingaugem `SQL` existem diversas **sublinguagens**: 
    - **DDL (*Data Definition Language*):** Linguagem de <u>definição</u> de dados, **estrutura** do banco de dados.
    - **DML (*Data Manipularion Language*):** Linguagem para <u>manipulção</u> dos dados.

### Comandos DDL
- `CREATE`: Cria objetos no meu banco de dados.
    - Banco de Dados;
    - Tabelas.

```sql
CREATE database nome_banco;
(
    coluna tipo [constraint coluna],
    ...
    ...
    ...
    [constraint tabela]
);
-- [ ]: Siginifica que essa parte é opcional
```

> [!NOTE]
>
> - Podemos colocar a constraint direto na coluna ou criar todas as colunas e depois criar as regras no final da tabela.

- Cada SGBD possui um **conjunto de dados específicos**, o exemplo a seguir e usando o `MySQL`.

| Tipo | Descrição |
| :--: | :-------: |
| `VARCHAR (size)` | Valores de caractere variável |
| `CHAR (size)` | Valores de caracteres fixos |
| `INTEGER` | Valores Numéricos |
| `DECIMAL (p,s)` | Valores Numérios, `p`: Número de dígitos totais, `s`: Quantidade de dígitos após a vírgula |
| `DATE` | Valores data |
| `BLOB` | Valores de caracteres de comprimento variável para dados binários até 2GB, usado para colocar foto, pdf |
| `LOGBLOB` | valores de caracteres de comprimento variável para dados binários |

> [!WARNING]
>
> - Prestar atenção em como a estrutura da data está no Banco de Dados.

#### Constraints
- `NOT NULL`: A coluna é obrigatória, ela não pode estar nula no Banco de Dados.  
- `UNIQUE`: A coluna é única, nessa coluna não pode ter outra instância de valor igual. 
    - CPF, matrícula, ...
- `PRIMARY KEY`: Chave Primária.
- `FOREIGN KEY`: Chave Estrangeira.
- `CHECK`: Verificação para domínios, lista de valores possíveis que um atributo pode ter (**lista de domínios**). 
    - Ex: O Estado Civil de uma pessoa é solteiro, casado ou viúvo.

##### Sintaxe

```sql
-- Nível de Coluna
coluna [CONSTRAINT nome_constraint] tipo_constraint,

-- Nível de Tabela
coluna, ...
[CONSTRAINT nome_constraint tipo_constraint (coluna, ...)], 
```

- `ALTER TABLE`: Altera **estrutura** e ***constraints*** de uma tabela.  
    - Adiciona e altera colunas;
    - Inclui ou remove constraints;
    - Habilita e desabilita constraints, ocorre quando estamos fazendo **migração** ou **manutenção** do Banco de dados.

```sql
ALTER TABLE nome_tabela
ADD [CONSTRAINT nome_constraint] tipo_constraint (nome_coluna)
-- 
ALTER TABLE <nome_tabela>
DROP PRIMARY KEY | UNIQUE tipo_constraint (nome_coluna) | 
CONSTRAINT nome_constraint [CASCADE];
-- Cascade: Apaga em cascata as constraint relacionadas àquela coluna.
ALTER TABLE nome_tabela
DROP PRIMARY KEY | UNIQUE tipo_constraint (nome_coluna) | 
CONSTRAINT <nome_constraint> [CASCADE]; 
```

- `DROP`: Elimina uma tabela ou um objeto do banco de dados.
    - **Todos** os <u>dados</u> e estrutura da tabela são excluídos;
    - **Todas** as **transações** pendentes serão efetivadas (***commit***);
    - **Todos** os **índices** serão eliminados.

```sql
DROP TABLE <nome_tabela>
    [CASCADE CONSTRAINTS];
```

## Exemplos

### Exemplo Simples
```sql
create table pessoa (
    codigo integer primary key,
    nome varchar(50) not null,
    data_nasc date
)

create table projeto (
    codigo integer primary key,
    nome varchar(100) not null
)

create table pessoa_projeto (
    cod_pes integer references pessoa (codigo),
    cod_proj integer references projeto (codigo),
    primary key (cod_pes, cod_proj)
)
```

### Exemplo - Dentran
```sql

```



