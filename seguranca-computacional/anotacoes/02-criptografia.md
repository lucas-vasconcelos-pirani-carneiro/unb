# Criptografia - Parte 02

## Criptografia Moderna

- Baseia-se em **três princípios** que sustentam a maior parte do trabalho em criptografia atualmente.

### Definições
- **Criptografia** refere-se à ciência e arte de **projetar/desenhar cifras**.
- **Criptoanálise** refere-se à ciência e arte de **quebrar as cifras**. 

- **Criptologia**, frequentemente abreviada como apenas cripto, é o **estudo de ambas**.
- A **entrada** de um processo de criptografia é comumente chamada de **texto original** (*plaintext* ou *cleartext*), e a **saída** é chamada de **texto cifrado** (*ciphertext*).

### Princípios Fundamentais

#### Princípio 1: Definições Formais

- Definições formais fornecem esse entendimento ao descrever claramente:
  - Quais ameaças estão em escopo.
  - Quais garantias de segurança são desejadas.

- É necessário **formalizar os requisitos antes de iniciar o projeto**.
- Definições permitem uma **comparação significativa entre esquemas**:
  - Um esquema que satisfaz uma definição mais fraca pode ser mais eficiente; Outro pode satisfazer uma definição mais forte.
  - Com definições precisas, podemos avaliar corretamente os **trade-offs** entre eles.

- Em geral, uma definição de segurança possui dois componentes:
  - **Garantia de segurança:**  Define o que o esquema pretende <u>impedir</u> que o atacante faça.
  - **Modelo de ataque:** Descreve o poder do adversário, ou seja, quais ações ele é <u>capaz de realizar</u>.

#### **Princípio 2: Suposições Precisas**

- A maioria das construções criptográficas modernas **não pode ser provada segura de forma incondicional**.
- Provas completas exigiriam resolver problemas da **teoria da complexidade computacional** que ainda estão em aberto.
- A criptografia moderna exige que todas as suposições sejam **explícitas** e **matematicamente precisas**.
  - É possível atribuir uma ordem de grandeza.


#### **Princípio 3: Provas de Segurança**

- Os dois princípios anteriores permitem alcançar o objetivo de fornecer uma **prova rigorosa** de que uma construção satisfaz uma definição, sob certas suposições.
- Provas são especialmente importantes porque existe um atacante tentando <u>ativamente</u> **quebrar o sistema**.
- Provas de segurança fornecem uma <u>garantia sólida</u> — **relativa às definições e suposições adotadas** — de que nenhum atacante terá sucesso.
- Nunca se deve adotar uma abordagem **não fundamentada ou puramente heurística**.
- <u>Sem uma prova</u> de que nenhum adversário com certos recursos pode quebrar o sistema, restamos apenas com **intuição**.
  - Confiar apenas na intuição em criptografia e segurança computacional pode ser **desastroso**.
