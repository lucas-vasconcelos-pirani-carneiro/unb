# Modelo Entidade Relacionamento

- É um modelo de dados **conceitual** de <u>alto nível</u>.
- Está centrado na **percepção dos usuários** sobre os dados, não
  importando a maneira na qual os dados serão **armazenados**.

## Entidade

- É um **elemento** do mundo real com uma existência própria.
- **Exemplo:** Pessoas, Carros, Casa, ...
- Cada entidade possui propriedades que a descrevem, chamadas de **atributos**.
- Exemplo: Funcionários da Empresa
```txt
Nome = João
Endereço = Rua A, Casa 123
Idade = 26
Fone = 222-2222
```

### Atributos
- **Simples:** Trata-se de um atributo que **não** é divisível.
  - Data de nascimento;
  - CPF;
  - Matrícula;
- **Composto:** Consiste em vários atributos básicos.
  - Endereço;
  - Logradouro;

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
  - Ex: Telefone Residencial

- **Atributo Chave:** Identifica cada entidade <u>unicamente</u>.
  - Matrícula, CPF, código, id, ...
  - É marcado com "um traço embaixo", sublinhado.

![atributo-chave](img/02-modelo-entidade-relacionamento/atributo-chave.png)

- **Domínio de um Atributo:**
  - Especifica os <u>possíveis valores</u> que podem estar associados a um atributo em cada entidade individual.
  - Ex: Domínio do atributo *Nome* seria um conjunto de <u>caracteres alfabéticos</u>.

## Relacionamento

- É um conjunto de **associações** entre entidades.
- Relacionamento **liga** as instâncias dos dados.
- **Grau** de um Tipo de Relacionamento:
  - **Binário:** Relaciona <u>duas</u> entidades. 
  - **Terciário:** Relaciona <u>três</u> entidades.
  - **Não existe** um limite para quantas entidades podem participar de um relacionamento.

![relacionamento-binario-terciario](img/02-modelo-entidade-relacionamento/relacionamento-binario-terciario.png)

![relacionamento-ternario](img/02-modelo-entidade-relacionamento/relacionamento-ternario.png)

- Relacionamento **Recursivo**: A entidade se relaciona com ela <u>mesma</u>.
  - Pré-requisito e uma disciplina;
  - Funcionário e supervisor;
  - É importante explicitar os papeis das entidades naquele relacionamento.

![relacionamento-recursivo](img/02-modelo-entidade-relacionamento/relacionamento-recursivo.png)

### Cardinalidade

- Quantidade que as **instâncias** da entidade podem se relacionar.
  - `1:1`; um para um.
  - `1:N`; um para muitos.
  - `N:1`; muitos para um.
  - `N:N`; muitos para muitos.

![exemplos-cardinalidade](img/02-modelo-entidade-relacionamento/exemplos-cardinalidade.png)

### Participação

- **Obrigatoriedade** que a entidade pode ter ao participar daquele relacionamento.
- **Total:** Obrigatório.
  - É representada por dois traços `==`.
  - **Todas** as instâncias da entidade precisam estar <u>relacionadas</u> com as instâncias da outra entidade.
- **Parcial:** Optativo.
  - É representado por apenas um traço `---`.
  - **Nem todas** as instâncias da entidade precisam estar relacionadas com as instâncias da outra entidade.

![restricao-participacao](img/02-modelo-entidade-relacionamento/restricao-participacao.png)

#### Cardinalidade (Mínima, Máxima)

- **Cardinalidade Mínima:** Substitui a participação, obrigatoriedade. 
  - 0: Parcial; 
  - 1: Total.
- **Cardinalidade Máxima:** Continua como antes.
  - 1 ou N.

![exemplo-cardinalidade-min-max](img/02-modelo-entidade-relacionamento/cardinalidade-min-max.png)
![cardinalidade-minima-maxima](img/02-modelo-entidade-relacionamento/cardinalidade-minima-maxima.png)

## Entidade Fraca

- **Não** tem um atributo que pode ser considerado **chave**, único.
  - Precisa de uma chave externa para se identificar unicamente. 
- Depende de uma outra entidade para existir.
- **Chave Composta:** Sua chave candidata + a chave da entidade forte.
  - (matriculaEmp , nomeDep)

![entidade-fraca](img/02-modelo-entidade-relacionamento/entidade-fraca.png)

- **Relacionamento de Identificação:** Indica que o dependente precisa da chave do funcionário para se identificar unicamente.

> [!IMPORTANT]
>
> - Toda entidade fraca tem **participação total** no **Relacionamento de Identificação** com a entidade forte.

## Exemplo 01 - RH
Uma Empresa é organizada em **departamentos**. Cada departamento tem um <u>nome</u>, um <u>número</u> e um <u>empregado que gerencia o departamento</u>. Deve-se saber a <u>data</u> em que um empregado iniciou como gerente de um **departamento**. Um **departamento** pode ter <u>diversas localizações</u>.

Um **departamento** controla um número de **projetos**, cada qual com um <u>nome</u>, um <u>número</u> e uma <u>única localização</u>.

São armazenados o <u>nome</u> do **empregado**, <u>matrícula</u>, <u>endereço</u>, <u>salário</u>, <u>sexo</u> e <u>data de nascimento</u>. Um **empregado** está associado a um **departamento**, mas pode trabalhar em **diversos projetos**, não necessariamente controlados pelo mesmo departamento. Deve-se saber o número de <u>horas semanais</u> que um empregado trabalha em cada projeto, bem como o **supervisor direto de cada empregado**.

Cada **empregado** pode possuir vários **dependentes**, devendo-se saber, para cada dependente, o <u>nome</u>, o <u>sexo</u>, a <u>data de nascimento</u> e a sua <u>ligação com o empregado</u>.

- Na Entidade fica aquilo que exclusivo dela, ou seja, não depende de outras entidades.
- Como descobrir a **Cardinalidade e a Paricipação**?
  - 1 empregado pode trabalhar em quantos departamentos ? **1**, a resposta vai para o outro lado.
  - 1 departamento pode ter quantos empregados ? **vários**, a resposta vai para o outro lado.
  - Todos os empregados trabalham em algum departamento ? **Não** necessariamente, neste caso.
  - Todo departamento tem um empregado ? **Não** necessariamente, neste caso.
  - 1 empregado gerencia quantos departamentos ? **1**, a resposta vai para o outro lado.
  - 1 Departamento é gerenciado por quantos empregados ? **1**, a resposta vai para o outro lado.
  - Todo empregado gerencia um departamento ? **Não**, parcial.
  - Todo Departamento é gerenciado por um empregado ? **Sim**, total.
  - 1 empregado supervisionado pode ser supervisionado por quantos supervisores ? **1**, resposta vai para o outro lado.
  - 1 supervidor pode ter quantos empregados supervisionados ? **Vários**, resposta vai para o outro lado.
  - Todo empregado é supervisionado por alguém ? **Não**. Parcial
  - Todo empregado é supervisor ? **Não**. Parcial
  - 1 empregado pode ter quantos dependentes ? **Vários**, reposta vai para o outro lado.
  - 1 Dependente depende de quantos empregados ? **1**, resposta vai para o outro lado. 
  - Todo dependente é dependente de algum empregado ? **Sim**. Total
  - Todo empregado tem dependente ? **Não**. Parcial
  - ...

```plaintext
@startchen

'/ Entidades e Atributos /'
entity Departamento {
    nome_departamento
    cod_departamento <<key>>
    local <<multi>>
}

entity Empregado {
    nome_empregado
    matricula <<key>>
    endereco
    salario
    sexo
    data_de_nasc
}

entity Projeto {
    nome_projeto
    cod_projeto <<key>>
    local
}

entity Dependente <<weak>> {
    nome_dependente <<key>>
    sexo
    data_nasc
    parentesco
}

'/ Relacionamentos /'
relationship Gerencia {
    data_inicio
}

relationship Supervisao {
    
}

relationship Trabalha_em {
    horas
}

relationship Trabalha_para {
    
}

relationship Controla {
    
}

relationship Depende_de <<identifying>> {
    
}

Empregado -N- Trabalha_para
Trabalha_para -1- Departamento

Empregado -1- Gerencia
Gerencia =1= Departamento

Empregado -NSupervisionado- Supervisao 
Supervisao -1Supervisor- Empregado

Empregado -N- Trabalha_em
Trabalha_em -N- Projeto

Empregado -1- Depende_de
Depende_de =N= Dependente

Departamento -1- Controla
Controla =N= Projeto

@endchen
```

![exemplo-rh](img/02-modelo-entidade-relacionamento/exemplo-rh.png)

## Exemplo 02 - Detran
- A especificação encontra-se me `/exercicios/lista-detran.pdf`
- Se tiver código será uma entidade.
- Identificada $\rightarrow$ Chave
- **Relacionamento de Identificação:** Está relacionado com a chave da entidade fraca.

```plantuml
@startchen

'Entidade e Atributos'
entity Veiculo {
    placa <<key>>
    chassi
    cor
    ano_fabricacao
}

entity Modelo {
    nome_modelo
    cod_modelo <<key>>
}

entity Categoria {
    nome_cateforia
    cod_categoria <<key>>
}

entity Proprietario {
    cpf <<key>>
    nome
    endereco {
        bairro
        cidade
        estado
    }
    telefone <<multi>>
    data_nasc
    idade <<derived>>
}

entity Infracao <<weak>> {
    data_hora <<key>>
    vel_aferida
}

entity Local {
    cod_local <<key>>
    pos_geografica
    vel_permitida
}

entity Tipo_Infracao {
    cod_tipo_infracao <<key>>
    valor
}

entity Agente_de_Transito {
    matricula <<key>>
    nome
    data_contratacao
    tempo_servico <<dereived>>
}

'Relacionamentos'
relationship Possui {
}

Veiculo -(0,N)- Possui
Possui -(1,1)- Modelo

relationship Pertence {
}

Veiculo -(0,N)- Pertence
Pertence -(1,1)- Categoria

relationship Tem {

}

Proprietario -(1,1)- Tem
Tem -(0,N)- Veiculo

relationship Detem <<identifying>> {
}

Veiculo -(1,1)- Detem
Detem -(0,N)- Infracao

relationship TEM <<identifying>> {
}

Infracao -(1,N)- TEM
TEM -(0,1)- Tipo_Infracao

relationship Ocorre {
}

Infracao -(0,N)- Ocorre
Ocorre -(1,1)- Local

relationship Aplica {
}

Infracao -(0,N)- Aplica
Aplica -(1,1)- Agente_de_Transito

@endchen
```

![exemplo-detran](img/02-modelo-entidade-relacionamento/exemplo-detran.png)

## Especificação e Generalização

![especificacao-generalizacao-total](img/02-modelo-entidade-relacionamento/especificacao-generalizacao-total.png)

![especificacao-generalizacao-parcial](img/02-modelo-entidade-relacionamento/especificacao-generalizacao-parcial.png)

## Observações

### Entidade Associativa
- É representada com um retangulo com Losango dentro.
- Utiliza-se em um caso especial quando for preciso fazer **um relacionamento de um relacionamento**.

![entidade-associativa](img/02-modelo-entidade-relacionamento/entidade-associativa.png)

### Atributo x Entidade

- **Atributo:** Informação adicional .
  - Ex: Cor em Dentran
- **Entidade:** A informação seria utilizada de forma mais aprofundada, fazer uma busca estatistica, gerar um relatório, fazer pesquisa.
  - Ex: Cor em Concessionário

![atributo_entidade](img/02-modelo-entidade-relacionamento/atributo_entidade.png)

### Atributo x Especialização

- A especialização ajuda a organizar melhor os dados, enquanto atributos não deixa muito claro o escopo do dado que estamos usando.

![atributo_especializacao](img/02-modelo-entidade-relacionamento/atributo_especializacao.png)

### Atributo Multivalorado x Entidade Fraca

- São modelos equivalentes, contudo o uso da entidade fraca também organiza melhor os dados.

![atributo_multivalorado-entidade_fraca](img/02-modelo-entidade-relacionamento/atributo_multivalorado-entidade_fraca.png)

### Erros Comuns
- **Compartilhar atributos**, atributos exclusivos da entidade alvo !!

![compartilhar-atributos](img/02-modelo-entidade-relacionamento/compartilhar-atributos.png)

- **Temporal/Histórico:** Guardar alguma informação ao ao longo do tempo. 
  - `Data` se torna a nossa **chave**.

![temporal](img/02-modelo-entidade-relacionamento/temporal.png)

- No esquema da esquerda o semestre se refere ao momento, o agora. Enquanto, o modelo da direita guardar um **aspecto temporal**, por isso semestre vira chave.
- No modelo da esquerda é possível armazenar quantas vezes uma pessoas vez a mesma disciplinas, caso haja reprovação nelas. 

![exemplo-temporal](img/02-modelo-entidade-relacionamento/exemplo-temporal.png)

## Notação

### UML
![exemplo-uml](img/02-modelo-entidade-relacionamento/exemplo-uml.png)

### *Crow’s Foot Notation* - Notação Pé de Galinha
![notacao-pe-de-galinha](img/02-modelo-entidade-relacionamento/notacao-pe-de-galinha.png)

> [!NOTE]
>
> A notação usada até agora foi a de ***Peter Chen***.
