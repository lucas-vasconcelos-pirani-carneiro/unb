# Paradigma Funcional - Linguagem Prolog

## O que é Prolog ?
- **Linguagem Declarativa**
    - Não tem instruções.
- Primeira e mais usada linguagem do paradigma programação em lógica.
    - Proposta em 1970 como **provador de teoremas** especializado.
    - Alain Colmerauer e Phillipe Roussel (Universidade de Aix-Marseille). 
    - Robert Kowalski (Universidade de Edinburgh).
    - Outras pessoas importantes... **Helder Coelho**, Universidade de Lisboa. 
- **Não** usada extensivamente na prática de **engenharia de software**.
    - Seriamente avaliada nos 80s como **linguagem de propósito geral**.
        - linguagem do Projeto V Geração do Japão.
    - Hoje é usada em contextos específicos.
        - Maioria relacionados a **IA**.
        - Mais utilizada na Europa.
        - EUA: A linguagem `LISP` é mais utilizada em IA.  
- O desenvolvimento `SWI PROLOG` inicio em 1987.

### Metáfora da Programação em Lógica
- **Teoria Lógica (TL)** = Programa = Banco de Dados dedutivo = BC.
- **Programar** é declarar **axiomas** e **regras**.
- Axiomas da **TL**
    - Fatos da BC 
    - Parte <u>extensional</u> do BD dedutivo
    - Dados <u>explícitos</u> de um BD tradicional
- Regras da **TL** (e da **BC**):
    - parte <u>intencional</u> do BD dedutivo
- Teoremas da **TL** 
    - **Deduzidos** a partir dos **axiomas** e das **regras**.
    - Dados <u>implícitos</u> do BD dedutivo.

### O que é PROLOG ?
- **Uma linguagem de programação para computação simbólica não numérica**.
    - **Interpretador**.
    - Base de conhecimentos, Memória de trabalho e Máquina de inferência.
- Com o que se parece programar em Prolog?
    - Definir relações e formular perguntas sobre as relações.
- O que é o `SWI-PROLOG` ?
    - Um **Interpretador**.

```prolog
?- prompt principal
| - prompt secundario
```

- O prolog precisa ter uma base.
- O que não estiver na **base de conhecimento**, nesse caso um mundo fechado, é falsa.
    - Hipotése de mundo fechado é para gerar decidibilidade.
- Usa **casamento padrão** assim como no `hugs`.
- Percorre a base de conhecimento de forma **linear** usando **ponteiros**.

### Exemplo

![exemplo-programa-prolog](img/03-prolog/exemplo-programa-prolog.png)

```prolog
?- parent(bob,pat).
true.
?- parent(liz,pat).
fail. 
?- parent(X,liz). % Pergunta quem é o pai/mãe da liz.
X = tom 
?- parent(bob, X). % Quer saber quem são os filhos de bob.
X = ann;
X = pat
```

> [!NOTE] 
>
> Ao digitar `;` após uma resposta, o `PROLOG` procura procura por outra resposta!  
> `;` == `OU`.

- O interpretador verifica se a `query` é uma **consequência lógica** dos fatos. 

```prolog
Quem é pai ou mãe de quem?
?- parent(X,Y).
X = pam;
Y = bob;
X = tom;
Y = bob;
X = tom;
Y = liz
```

#### Conectivo AND
- Usa-se a vŕigula (`,`) para expressar o conectivo `AND`.
- Quem é um **pai** ou **mãe** X de Ann? Também o é de Pat?

```prolog
?- parent(X,ann),parent(X,pat).
X = bob
```

### Exemplo - PROLOG com Regras



## Regras de Produção
