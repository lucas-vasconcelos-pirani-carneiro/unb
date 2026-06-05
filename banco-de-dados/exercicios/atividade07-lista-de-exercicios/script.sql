CREATE TABLE departamento(
    cod_dep VARCHAR(2) PRIMARY KEY,
    nome_dep VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE funcionario(
    cod_funcional INT PRIMARY KEY,
    nome_func VARCHAR(60) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    salario DECIMAL(10,2),
    idade INT CHECK (idade >= 0),

    cod_supervisor INT,
    depto VARCHAR(2) NOT NULL,

    FOREIGN KEY (cod_supervisor)
        REFERENCES funcionario(cod_funcional),

    FOREIGN KEY (depto)
        REFERENCES departamento(cod_dep)
);

CREATE TABLE projeto(
    numero SERIAL PRIMARY KEY,
    nome_proj VARCHAR(50) NOT NULL,
    depto VARCHAR(2) NOT NULL,

    FOREIGN KEY (depto)
        REFERENCES departamento(cod_dep)
);

INSERT INTO departamento (cod_dep, nome_dep)
VALUES 
    ('MK', 'Marketing'),
    ('IN', 'Informática');


INSERT INTO funcionario
(cod_funcional, nome_func, cpf, salario, idade, cod_supervisor, depto)
VALUES
    (51, 'Carina Montemor', '35425496702', 2879.52, 30, NULL, 'MK'),
    (10, 'Fernando Martini', '12385796898', 1000.58, 48, 51, 'IN'),
    (79, 'Sérgio Vilardi', '15789674125', 5081.21, 20, 51, 'IN');


INSERT INTO projeto (nome_proj, depto)
VALUES 
    ('Divulgação de evento', 'MK'),
    ('Projeto de softwares', 'IN'),
    ('Projeto da Rede de Dados', 'IN');

SELECT nome_func, nome_dep, nome_proj
FROM funcionario AS f
INNER JOIN departamento AS d
	ON d.cod_dep = f.depto  
INNER JOIN projeto AS p
	ON p.depto = d.cod_dep
WHERE p.nome_proj = 'Divulgação de evento';

SELECT f1.nome_func AS Supervisor, f2.nome_func
FROM funcionario f1
INNER JOIN funcionario f2
ON f2.cod_funcional = f1.cod_supervisor;

CREATE TABLE aluno (
    matricula INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    endereco VARCHAR(60),
    sexo VARCHAR(20)
        CHECK (sexo IN ('Masculino', 'Feminino', 'Outro')),
    data_nasc DATE,
    nome_conj VARCHAR(30),
    qtde_dep INT
        CHECK (qtde_dep >= 0),
    cpf VARCHAR(11) UNIQUE NOT NULL
);

CREATE TABLE curso (
    cod_curso INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    qtde_hora INT
        CHECK (qtde_hora > 0)
);

CREATE TABLE livro (
    isbn VARCHAR(13) PRIMARY KEY,
    titulo VARCHAR(40) NOT NULL,
    editora VARCHAR(20) NOT NULL,
    autor VARCHAR(60) NOT NULL,
    data_publicacao DATE
);

CREATE TABLE curso_livro (
    cod_curso INT REFERENCES curso(cod_curso),
    isbn VARCHAR(13) REFERENCES livro(isbn),
    PRIMARY KEY (cod_curso, isbn)
);

CREATE TABLE hist (
    matricula INT REFERENCES aluno(matricula),
    cod_curso INT REFERENCES curso(cod_curso),
    semestre INT
        CHECK (semestre IN (1,2)),
    ano INT,
    media DECIMAL(4,2)
        CHECK (media BETWEEN 0 AND 10),
    perc_freq DECIMAL(5,2)
        CHECK (perc_freq BETWEEN 0 AND 100),
    PRIMARY KEY (matricula, cod_curso, semestre, ano)
);

CREATE TABLE prereq (
    cod_curso INT REFERENCES curso(cod_curso),
    cod_curso_pre INT REFERENCES curso(cod_curso),
    PRIMARY KEY (cod_curso, cod_curso_pre)
);

INSERT INTO aluno
(matricula, nome, endereco, sexo, data_nasc, nome_conj, qtde_dep, cpf)
VALUES
(1001, 'Lucas Almeida', 'Rua A', 'Masculino', '2002-05-10', NULL, 0, '12345678901'),
(1002, 'Marina Souza', 'Rua B', 'Feminino', '2001-08-21', 'Carlos Souza', 1, '23456789012'),
(1003, 'Pedro Lima', 'Rua C', 'Masculino', '2000-11-30', NULL, 0, '34567890123'),
(1004, 'Ana Costa', 'Rua D', 'Feminino', '2003-02-15', NULL, 2, '45678901234');

INSERT INTO curso
(cod_curso, descricao, qtde_hora)
VALUES
(10, 'Banco de Dados', 80),
(20, 'Estrutura de Dados', 60),
(30, 'Programação em C', 100),
(40, 'Redes de Computadores', 70);

INSERT INTO livro
(isbn, titulo, editora, autor, data_publicacao)
VALUES
('9781111111111', 'SQL Básico', 'Novatec', 'Carlos Silva', '2020-01-10'),
('9782222222222', 'Algoritmos em C', 'Pearson', 'João Pereira', '2019-06-20'),
('9783333333333', 'Redes Modernas', 'Atlas', 'Marina Lopes', '2021-03-15'),
('9784444444444', 'Estruturas de Dados', 'Campus', 'Fernanda Rocha', '2018-09-05');

INSERT INTO curso_livro
(cod_curso, isbn)
VALUES
(10, '9781111111111'),
(20, '9784444444444'),
(30, '9782222222222'),
(40, '9783333333333'),
(30, '9784444444444');

INSERT INTO hist
(matricula, cod_curso, semestre, ano, media, perc_freq)
VALUES
(1001, 10, 1, 2024, 8.50, 92.00),
(1001, 20, 2, 2024, 7.80, 88.00),
(1002, 10, 1, 2024, 9.10, 95.00),
(1002, 30, 2, 2024, 6.50, 75.00),
(1003, 20, 1, 2023, 5.90, 70.00),
(1004, 40, 2, 2024, 8.00, 90.00);

INSERT INTO prereq
(cod_curso, cod_curso_pre)
VALUES
(20, 30),
(40, 20),
(10, 30);

SELECT l.titulo, c.descricao
FROM livro AS l
INNER JOIN curso_livro AS cl
	ON cl. isbn = l.isbn
INNER JOIN curso AS c
	ON c.cod_curso = cl.cod_curso;

SELECT 
	c1.descricao AS curso, 
	c2.descricao AS pre_requisito
FROM prereq AS p
INNER JOIN curso AS c1
	ON p.cod_curso = c1.cod_curso
INNER JOIN curso AS c2
	ON p.cod_curso_pre = c2.cod_curso;
