# Modelo Entidade Relacionamento

- É um modelo de dados **conceitual** de <u>alto nível</u>.
- Está centrado na **percepção dos usuários** sobre os dados, não
  importando a maneira na qual os dados serão **armazenados**.

![exemplo-mer](img/02-modelo-entidade-relacionamento/exemplo-mer.png)

![exemplo-modelagem](img/02-modelo-entidade-relacionamento/exemplo-modelagem.png)

## Entidade
- É um **elemento** do mundo real com uma existência própria.

- Cada entidade possui propriedades que a descrevem, chamadas de **atributos**.

Exemplo: Funcionários de uma empresa

```
Nome = João
Endereço = Rua A, Casa 123
Idade = 26
Telefone = 11 91111-1111
```

### Atributos

- **Simples:** Trata-se de um atributo que **não** é divisível.
  - Data de nascimento;
  - CPF;
  - Matrícula;
- **Composto:** Consiste em vários atributos básicos.
  - Endereço;
  - Logradouro;

![atributo-composto](img/02-modelo-entidade-relacionamento/atributo-composto.png)

![atributo-simples-composto](img/02-modelo-entidade-relacionamento/atributo-simples-composto.png)

- **Atributo Monovalorado:** Possui um <u>único</u> valor para uma entidade particular.
  - Ex: <u>Nome</u> na entidade funcionário

- **Atributo Multivalorado:** Pode ter um <u>conjunto de valores</u> para uma mesma entidade
  - Ex: Email na entidade funcionário, Área de pesquisa

![atributo-multivalorado](img/02-modelo-entidade-relacionamento/atributo-multivalorado.png)

- **Atributo Derivado ou Virtual:** É aquele que <u>pode ser obtido</u> a partir de outros atributos.
  - Ex: <u>Idade</u> calculada a partir da **data de nascimento**, <u>número total de funcionários</u> - derivado da **soma** dos empregados.
  - **Não** é armazenado no SGBD.

- **Valores NULL:** Valor vazio para um atributo.
  - Ex: Telefone
- Entidade na forma de instâncias, elementos de um conjunto:

![elementos-conjunto](img/02-modelo-entidade-relacionamento/elementos-conjunto.png)

- **Atributo Chave:** Identifica cada entidade unicamente.
  - Matrícula, CPF, código, id, ...
  - É marcado com "um traço embaixo", sublinhado

![atributo-chave](img/02-modelo-entidade-relacionamento/atributo-chave.png)

- **Domínio de um Atributo:**
  - Especifica os <u>possíveis valores</u> que podem estar associados a um atributo em cada entidade individual.
  - Ex: Domínio do atributo *Nome* seria um conjunto de <u>caracteres alfabéticos</u>.

## Relacionamento

- É um conjunto de **associações** entre entidades.
- Relacionamento **liga** as instâncias dos dados

![relacionamento-conjuntos](img/02-modelo-entidade-relacionamento/relacionamento-conjuntos.png)

- **Grau** de um Tipo de Relacionamento:
  - **Binário:** Relaciona <u>dois</u> entidades. 
  - **Terciário:** Relaciona <u>três</u> entidades.
  - **Não existe** um limite para quantas entidades podem participar de um relacionamento.

![relacionamento-binario-terciario](img/02-modelo-entidade-relacionamento/relacionamento-binario-terciario.png)

- Relacionamento **Recursivo**: A entidade se relaciona com ela <u>mesma</u>.
  - Pré-requisito e uma disciplina;
  - Funcionário e supervisor;

![relacionamento-recursivo](img/02-modelo-entidade-relacionamento/relacionamento-recursivo.png)

- É importante explicitar os papeis do relacionamento.
- Exemplo de como fica na modelagem:

![relacionamento-recursivo2](img/02-modelo-entidade-relacionamento/relacionamento-recursivo2.png)

### Cardinalidade

- Quantidade que as **instâncias** da entidade podem se relacionar.
- `1:1` um para um

![cardinalidade_1-1](img/02-modelo-entidade-relacionamento/cardinalidade_1-1.png)

- `1:N`um para muitos
- `N:1` muitos para um

![cardinalidade_1-n](img/02-modelo-entidade-relacionamento/cardinalidade_1-n.png)

- `N:N` muitos para muitos

![cardinalidade_n-n](img/02-modelo-entidade-relacionamento/cardinalidade_n-n.png)

### Participação

- **Obrigatoriedade** que a entidade pode ter ao participar daquele relacionamento.
- **Total:** Obrigatório.
  - É representada por dois traços `===`.
  - **Todas** as instâncias da entidade precisam estar <u>relacionadas</u> com as instâncias da outra entidade.
- **Parcial:** Optativo.
  - É representado por apenas um traço `---`.
  - **Nem todas** as instâncias da entidade precisam estar relacionadas com as instâncias da outra entidade.

![restricao-participacao](img/02-modelo-entidade-relacionamento/restricao-participacao.png)
