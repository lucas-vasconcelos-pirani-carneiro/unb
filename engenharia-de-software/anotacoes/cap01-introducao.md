# Introdução

- Engenharia de software é essencial para o funcionamento da sociedade atualmente.
- Os sistemas de software são **abstratos** e **intangíveis**, não dependem de limites físicos, o que contribui para se tornarem bastante **complexos**.
  - Difíceis de entender
  - Caros de modificar

- Existem diferentes **tipos** de software:
  - Sistemas embarcados
  - Sistemas de alcance mundial

-  Não existem uma *"Bala de Prata"*, ou seja, não há **técnicas** ou **métodos** <u>universais</u> pois diferentes tipos de software exigem abordagens diferentes.
-  Projetos equivocados e *falhas de software*
  - *Complexidade crescente dos sistemas*: Novas técnicas de engenharia de software ajudam a construir sistemas maiores e complexos devido a rapidez com que sistemas são construidos e distribuídos. 
  - *Não utilização de métodos de engenharia de software*: Software se torna mais caro e menos confiável. 


## Desenvolvimento Profissional de Software 

- O software profissional se destina a ser utilizado por outras pessoas além de seu desenvolvedor.
- É desenvolvido normalmente por equipes, e não por indivíduos; ele é **mantido** e **alterado** ao longo de sua vida útil.
- Possui técnicas que apoiam a **especificação**, o **projeto** e a **evolução do software**, aspectos geralmente irrelevantes para o desenvolvimento de software pessoal. 

| Pergunta                                                     | Resposta                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| O que é software?                                            | Programas de computador e documentação associada. Os produtos de software podem ser desenvolvidos para um determinado cliente ou para um mercado genérico. |
| Quais são os atributos do bom software?                      | O bom software deve proporcionar a funcionalidade e o desempenho necessários e deve ser manutenível, usável e confiável (dependability). |
| O que é engenharia de software?                              | A engenharia de software é uma disciplina de engenharia que se preocupa com os aspectos da produção de software, desde sua concepção inicial até sua operação e manutenção. |
| Quais são as atividades fundamentais da engenharia de software? | Especificação, desenvolvimento, validação e evolução do software. |
| Qual é a diferença entre engenharia de software e ciência da computação? | A ciência da computação se concentra na teoria e nos fundamentos. A engenharia de software se preocupa com as questões práticas de desenvolver e entregar software útil. |
| Qual é a diferença entre engenharia de software e engenharia de sistemas? | A engenharia de sistemas se preocupa com todos os aspectos do desenvolvimento de sistemas computacionais, incluindo hardware, software e processos. A engenharia de software faz parte desse processo mais geral. |
| Quais são os principais desafios enfrentados pela engenharia de software? | Lidar com a crescente diversidade, com as demandas por menores prazos de entrega e desenvolver software confiável. |
| Quais são os custos da engenharia de software?               | Aproximadamente 60% dos custos de software são relativos ao desenvolvimento e 40% aos testes. Para software personalizado, os custos de evolução frequentemente ultrapassam os de desenvolvimento. |
| Quais são os melhores métodos e técnicas de engenharia de software? | Não existe um método único ideal. Técnicas diferentes são adequadas para diferentes tipos de sistemas. Jogos usam prototipação, enquanto sistemas críticos exigem especificações completas e analisáveis. |
| Quais diferenças a internet trouxe para a engenharia de software? | A internet possibilitou sistemas massivos e distribuídos baseados em serviços e criou a indústria de aplicativos móveis, mudando a economia de software. |

- Quando falamos sobre engenharia de software, não estamos
  falando apenas dos <u>programas em si</u>, mas também de toda a **documentação**, **bibliotecas**, **websites** de apoio e dados de configuração associados, elementos necessários para que esses programas sejam úteis. 
- Um **sistema de software** desenvolvido profis­sionalmente consiste em
  <u>diversos programas diferentes</u> e em <u>arquivos de configuração</u>, que são utilizados para parametrizar esses programas. 
- Também podem incluir:
  -   **Documentação de sistema**: Descreve sua estrutura; 
  - **Manual do usuário**: Explica como utilizar o sistema;
  - **Sites**: Utilizados por usuários para baixarem informações recentes sobre o produto.

- Engenheiros de Software sem preocupam em desenvolver **produtos de software**, produtos que possam ser vendidos para clientes
- Existem dois tipos de produtos de software:
  1. *Produtos genéricos*: São sistemas *"stand-alone"* produzidos por uma organização de desenvolvimento de software e vendidos no mercado para **qualquer cliente** que queira comprá-los.
     -  Editores de texto;
     - SGBD;
     -  Pacotes de desenho;
     - Ferramentas de gerenciamento de projetos. 
     - Esse tipo de software também inclui aplicações “verticais", projetadas para um **mercado específico**, como **sistemas de informação de bibliotecas**, **sistemas contábeis** ou sistemas para manter registros odontológicos.
  2. *Software personalizado (ou feito sob medida)*: São sistemas **encomendados** e **desenvolvidos** para um determinado cliente. 
     - Sistemas de controle para dispositivos eletrônicos; 
     - Sistemas escritos para apoiar processos de negócios específicos;
     -  Sistemas de controle de tráfego aéreo.

- A principal diferença entre esses tipos de software é que nos **produtos genéricos** a organização que desenvolve o software controla a sua especificação, enquanto nos **produtos personalizados**, a especificação
  é desenvolvida e controlada pela organização que está comprando o software.
- No entanto, a distinção entre esses tipos de produto está ficando cada vez mais **confusa**.
- Sistemas estão sendo criados tendo como <u>base</u> um **produto genérico** que
  depois é **adaptado** para atender às necessidades de um determinado diente. 
  - Sistemas **ERP** (Enterprise Resource Planning),
  - SAP e da Oracle.

- **Qualidade de software:** Inclui o comportamento do software enquanto ele está em execução, a <u>estrutura</u> e a <u>organização</u> dos programas do sistema e a <u>documentação</u> associada.
- **Atributos da qualidade** ou **não funcionais**: 
  - Tempo de resposta do software para uma consulta do usuário
  -  Inteligibilidade do código do programa.
- Conjunto de atributos essenciais:

| Característica do Produto                            | Descrição                                                    |
| ---------------------------------------------------- | ------------------------------------------------------------ |
| Aceitabilidade                                       | O software deve ser aceitável para o tipo de usuário para o qual é projetado. Isso significa que ele deve ser inteligível, útil e compatível com os outros sistemas utilizados pelos usuários. |
| Dependabilidade e segurança da informação (security) | A dependabilidade do software inclui uma gama de características, como confiabilidade, segurança da informação (security) e segurança (safety). O software não deve causar danos físicos ou econômicos em caso de falha e deve ser protegido contra acessos maliciosos. |
| Eficiência                                           | O software não deve desperdiçar recursos do sistema, como memória e ciclos de processador. Inclui responsividade, tempo de processamento e uso adequado de recursos. |
| Manutenibilidade                                     | O software deve ser escrito de forma que possa evoluir e se adaptar às necessidades mutáveis dos clientes. Esse é um atributo crítico, pois mudanças são inevitáveis em ambientes empresariais. |

### Engenharia de Software

- É uma aplicação **sistemática**, científica e tecnológica utilizando conhecimento, métodos e experiência para "design", implementação, teste, documentação e projeto de software.
- **Importância** da engenharia de software:
  - Cada vez mais os indivíduos e a sociedade dependem de sistemas de software avançados. 
  - É preciso produzir sistemas confiáveis de maneira **econômica** e **rápida**. 
  - Não utilizar um **método de engenharia de software** leva a custos mais altos de teste e econômicos, garantia de qualidade e manutenção de longo prazo.
- **Processo de Software:** Uma sequência de atividades que leva à produção
  de um software.
- Atividades fundamentais no processo de software:
  1. **Especificação do software**: Clientes e engenheiros definem o
     software que deve ser produzido e as <u>restrições</u> impostas à sua operação.
  2. **Desenvolvimento de software**: O software é <u>projetado</u> e <u>programado</u>.
  3. **Validação de software**: O programa é analisado para garantir que
    seja aquilo de que o cliente precisa.
  4. **Evolução do software**: Modificação para refletir a mudança de requisitos tanto do cliente quanto do mercado.

- Não existem **métodos** ou **técnicas** <u>universais</u> de engenharia de software que possam ser utilizados.
- Questões que afetam diversos tipos de software:
  1. "*Heterogeneidade*": Sistemas que atuem de forma distribuída em redes e que incluam diferentes **tipos de computadores** e **dis­positivos móveis**. 
     - O software precisar ser executado em telefones celulares e tablets;
     - Desenvolver técnicas para criar software com **dependabilidade**, ser flexível; 
  2. "*Mudanças nos negócios e na sociedade*": As empresas e a sociedade estão mudando rapidamente o que exige mudança em seu software existente e de desenvolver rapidamente um novo. 
  3. "*Segurança da informação (security) e confiança (trust)*" : Como o software está presente em nosso cotidiano é essencial que possamos confiar nele.
     -  Usuários maliciosos não podem conseguir atacar com sucesso o nosso software e que a as informações estejam protegidas.
  4. *"Escala"*:  O software tem de ser desenvolvido considerando diferentes escalas, desde pequenos sistemas embarcados em dispositivos móveis ou dispositivos vestíveis até sistemas baseados na nuvem e distribuídos pela internet que atendam a uma <u>comunidade global</u>.

### Diversidade da Engenharia de Software

- A engenharia de software é uma abordagem **sistemática** para a produção de software que leva em conta o **custo prático**, o **cronograma** e questões de **dependa­bilidade**, bem como as necessidades de clientes e produtores de software. 

- **Métodos**, **ferramentas** e **técnicas** específicas dependem da organização que está desenvol­vendo o software, do **tipo de software** e das pessoas envolvidas no processo de desenvolvimento. 

  - Não há **métodos universais** de engenharia de software que sejam
    adequados para **todos** os sistemas e empresas. 

- Tipos diferentes de aplicação:

  1. **Aplicações "stand alone"**:  São sistemas de aplicação executados em um <u>compu­tador pessoal</u> ou aplicativos que rodam em dispositivos móveis. 

     - Aplicações de escritório em um computador pessoal;

     - Programas de CAD;

     - Software de manipulação de imagens;

     - Aplicativos de viagem;

     - Aplicativos de produtividade;

  2. **Aplicações interativas baseadas em transações**: São aplicações executadas em um <u>computador remoto</u> e que são acessadas por usuários a partir de seus próprios computadores, smartphones ou tablets. 

     - Comércio eletrônico, por exemplo.

     - Essa classe de aplicação também inclui sistemas de negócio, nos quais uma empresa concede acesso a seus sistemas por meio de um <u>navegador</u>, de um programa cliente de uso específico ou de um serviço baseado na nuvem, como <u>e-mail</u> e <u>compartilhamento de imagens</u>. 
     - As aplicações interativas incorporam frequentemente um grande <u>armazenamento de dados</u> que é acessado e atualizado em cada transação.

  3. **Sistemas de controle embarcados**: São sistemas de controle de software que <u>controlam</u> e <u>gerenciam</u> dispositivos de hardware. 
     - Telefone celular;
     - O software que controla o freio ABS em um carro 
     - O software em um forno de micro-ondas para controlar o processo de cozimento.
  4. **Sistemas deprocessamento em lotes (*batch*)**: São sistemas de negócio concebidos para <u>processar dados em grandes lotes</u>. 
     - Eles processam números enormes de entradas individuais para  criar as saídas correspondentes. 
     - São utilizados frequentemente em conjunto
       com os sistemas de <u>transações baseados na web</u>.
     - Ex: Faturamento periódico, como as contas de telefone, e
       os sistemas de folha de pagamento.
  5. **Sistemas de entretenimento**: São destinados para <u>uso pessoal</u>, para <u>entreter</u> o usuário. 
      - Jogos de gêneros variados;
      - A **qualidade da interação** com o usuário é a característica.
      diferenciadora mais importante dos **sistemas de entretenimento**.
  6. **Sistemas para modelagem e simulação**: São desenvolvidos por cientistas e enge­nheiros para <u>modelar processos físicos</u> ou situações que incluem muitos <u>objetos diferentes</u> e que <u>interagem</u>. 
      - Costumam ter <u>alto custo computacional</u> e demandam <u>sistemas paralelos</u> de alto desempenho para a sua execução.
  7. **Sistemas de coleta de dados e análise**: São aqueles que fazem a sua <u>coleta</u> no ambiente e <u>enviam esses dados</u> para outros sistemas, para processamento.
      - A análise de *"Big Data"* (grandes volumes de dados) pode envolver sistemas baseados na <u>nuvem</u> executando análises estatísticas e procurando <u>relações</u> entre os dados coletados.
  8. **Sistemas de sistemas**: São utilizados em empresas e outras grandes organizações e são <u>compostos</u> de uma <u>série de outros sistemas de software</u>. 

- Um software pode pertencer a mais de um tipo diferente.

- Cada tipo de sistema exige técnicas especializadas de engenharia de software, pois cada um tem características diferentes.

- Fundamentos que se aplicam a todos os tipos de sistemas de software:
  1. Devem ser desenvolvidos com o uso de um processo **gerenciado** e **com­preendido**. 
    - A organização que está desenvolvendo o software deve **planejar** o processo de desenvolvimento. 
  2. **Dependabilidade** e **desempenho** são importantes para todos os tipos de sis­tema. 
    - O software deve não apresentar falhas, funcionando conforme o planejado, ter uma operação segura e ter proteção contra ataques externos. 
    - O sistema deve ter um desempenho eficiente e não desperdiçar recursos.
  3. É importante compreender e controlar a **especificação** e os **requisitos do software** (o que o software deve fazer). 
  4. Os recursos existentes devem ser usados de modo eficaz.
    - Deve-se reusar software que já tenha sido desenvolvido, em vez de escrever um novo.

### Engenharia de software para Internet

- Com o crescimento da internet e a possibilidade de desenvolver produto de software para serem implementados em navegadores mudou a maneira como o software corporativo é organizado.

  - Barateou a modificação e a atualização de software, já que não havia necessidade de instalá-lo em cada computador.

- Software cada vez mais executado em nuvens.

  - e-mail
  - armazenamento de vídeo

> [!NOTE]
>
> Uma **nuvem** de computação é uma quantidade enorme de
> sistemas computacionais <u>interligados</u> que é <u>compartilhada</u> por muitos usuários.

- Mudanças que ocorrem:
  - O **reúso de software** se tornou a abordagem dominante para construir sistemas web.
  - Esses sistemas são montados a partir de componentes e de **sistemas de software** preexistentes, , *frameworks*.
  - Os sistemas web sempre são desenvolvidos e entregues de **modo incremental**, é impraticável levantar todos os requisitos desses sistemas.

## Estudos de Caso

