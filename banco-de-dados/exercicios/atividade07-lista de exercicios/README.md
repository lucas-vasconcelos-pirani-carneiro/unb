# Lista de Exercícios - SELECT

### Questão 1) Baseando-se nas relações especificadas a seguir, apresente a correta sintaxe das expressões em SQL para os itens a e b, além das relações resultantes da aplicação destas consultas.

Departamento

| Código | Nome_depto |
|--------|-------------|
| MK     | Marketing   |
| IN     | Informática |

Projeto

| Número | Nome_proj              | Deptos |
|---------|------------------------|---------|
| 1       | Divulgação de evento   | MK      |
| 2       | Projeto de softwares   | IN      |
| 3       | Projeto da Rede de Dados | IN    |

Funcionário

| Nome              | CPF        | Salário | Cód_funcional |
|-------------------|------------|----------|----------------|
| Fernando Martini  | 12385796898 | 1000,58 | 10 |
| Carina Montemor   | 35425496702 | 2879,52 | 51 |
| Sérgio Vilardi    | 15789674125 | 5081,21 | 79 |

a) Os nomes dos funcionários e o nome do departamento do projeto "Divulgação de eventos".

```sql
SELECT nome_func, nome_dep, nome_proj
FROM funcionario AS f
INNER JOIN departamento AS d
	ON d.cod_dep = f.depto  
INNER JOIN projeto AS p
	ON p.depto = d.cod_dep
WHERE p.nome_proj = 'Divulgação de evento';
```

b) Informe o nome dos funcionários e o nome dos seus supervisores.

```sql
SELECT f1.nome_func AS Supervisor, f2.nome_func
FROM funcionario f1
INNER JOIN funcionario f2
ON f2.cod_funcional = f1.cod_supervisor;
```

### Questão 2) Com o esquema relacional abaixo responda em Álgebra Relacional e em SQL:

    ALUNO (<u>Matr</u>, Nome, Ender, Sexo, DataNasc, NomeConj, QtdeDep, CPF)
    
    CURSO (<u>CodCurso</u>, Descr, QtdeHora)
    
    LIVRO (<u>ISBN</u>, Titulo, Editora, Autor, DataPub)

    HIST (<u>Matr, CodCurso, Semestre, Ano</u>, Media, PercFreq)
    HIST (Matr) REFERENCIA ALUNO (Matr)
    HIST (CodCurso) REFERENCIA CURSO (CodCurso)

    CURSO_LIVRO (<u>CodCurso, ISBN</u>)
    CURSO_LIVRO (CodCurso) REFERENCIA CURSO (CodCurso)
    CURSO_LIVRO (ISBN) REFERENCIA LIVRO (ISBN)

    PREREQ (<u>CodCurso, CodCursoPre</u>)
    PREREQ (CodCurso) REFERENCIA CURSO (CodCurso)
    PREREQ (CodCursoPre) REFERENCIA CURSO (CodCurso)


a) Liste o nome dos livros e o nome dos cursos que eles estão relacionados.

```sql
SELECT l.titulo, c.descricao
FROM livro AS l
INNER JOIN curso_livro AS cl
	ON cl. isbn = l.isbn
INNER JOIN curso AS c
	ON c.cod_curso = cl.cod_curso;
```

b) Para toda ocorrência de pré-requisito de cursos apresente, código e descrição de curso, como também código e descrição de curso pré-requisito.

```sql
SELECT 
	c1.descricao AS curso, 
	c2.descricao AS pre_requisito
FROM prereq AS p
INNER JOIN curso AS c1
	ON p.cod_curso = c1.cod_curso
INNER JOIN curso AS c2
	ON p.cod_curso_pre = c2.cod_curso;
```
