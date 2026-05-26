DROP TABLE IF EXISTS FILME_ATOR;
DROP TABLE IF EXISTS ATOR;
DROP TABLE IF EXISTS LOC_FITA;
DROP TABLE IF EXISTS FITA;
DROP TABLE IF EXISTS FILME;
DROP TABLE IF EXISTS CATEGORIA;
DROP TABLE IF EXISTS LOCACAO;
DROP TABLE IF EXISTS CLIENTE;

CREATE TABLE CLIENTE (
    codCli      SERIAL PRIMARY KEY,
    nome        VARCHAR(65) NOT NULL,
    endereco    VARCHAR(150) NOT NULL,
    fone        VARCHAR(20)
);

CREATE TABLE LOCACAO (
    codLoc      SERIAL PRIMARY KEY,
    codCli      INTEGER REFERENCES CLIENTE(codCli),
    dtInicio    DATE,
    dtFim       DATE
);

CREATE TABLE CATEGORIA (
    codCat      SERIAL PRIMARY KEY,
    descricao   VARCHAR(30) NOT NULL
);

CREATE TABLE FILME (
    codFilme    SERIAL PRIMARY KEY,
    titulo      VARCHAR(65) NOT NULL,
    codCat      INTEGER,
    FOREIGN KEY (codCat) REFERENCES CATEGORIA(codCat)
);

CREATE TABLE FITA (
    codFita     SERIAL PRIMARY KEY,
    codFilme    INTEGER REFERENCES FILME(codFilme),
    parte       CHAR(1)
);

CREATE TABLE LOC_FITA (
    codFita     INTEGER REFERENCES FITA(codFita),
    codLoc      INTEGER REFERENCES LOCACAO(codLoc),
    PRIMARY KEY (codFita, codLoc)
);

CREATE TABLE ATOR (
    codAtor     SERIAL PRIMARY KEY,
    nreal       VARCHAR(65) NOT NULL,
    nFan        VARCHAR(65) NOT NULL,
    dtNasc      DATE
);

CREATE TABLE FILME_ATOR (
    codFilme    INTEGER REFERENCES FILME(codFilme),
    codAtor     INTEGER REFERENCES ATOR(codAtor),
    PRIMARY KEY (codFilme, codAtor)
);

-- CLIENTE
INSERT INTO CLIENTE(codCli, nome, endereco, fone)
VALUES
(1, 'Maria da Silva', 'BSB', '12341234'),
(2, 'Jose Geraldo', 'São Paulo', '13243647'),
(3, 'Marcos da Silva', 'Rio de Janeiro', '34678923'),
(4, 'Marcelo Oliveira', 'Belém', '13579323'),
(5, 'Marcos Antonio', 'Pará', '73839581');

-- CATEGORIA
INSERT INTO CATEGORIA(codCat, descricao)
VALUES
(1, 'Acao'),
(2, 'Comedia'),
(3, 'Desenho'),
(4, 'Terror'),
(5, 'Romance');

-- FILME
INSERT INTO FILME(codFilme, titulo, codCat)
VALUES
(1, 'Titanic', 5),
(2, 'Se eu fosse voce', 3),
(3, 'Poderoso Chefão', 1),
(4, 'Os Vagabundos Trapalhões', 2),
(5, 'Massaropi', 2);

-- LOCACAO
INSERT INTO LOCACAO(codLoc, codCli, dtInicio, dtFim)
VALUES
(1, 1, '2009-02-02', '2009-02-05'),
(2, 1, '2009-02-02', '2009-02-05'),
(3, 2, '2009-05-02', '2009-05-05'),
(4, 3, '2009-02-10', '2009-02-12'),
(5, 3, '2009-02-15', '2009-02-17');

-- FITA
INSERT INTO FITA(codFita, codFilme, parte)
VALUES
(1, 1, '1'),
(2, 1, '1'),
(3, 2, '1'),
(4, 2, '2'),
(5, 3, '1');

-- LOC_FITA
INSERT INTO LOC_FITA(codLoc, codFita)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- ATOR
INSERT INTO ATOR(codAtor, nreal, nFan, dtNasc)
VALUES
(1, 'Leonardo DiCaprio', 'Leonardo DiCaprio', '1980-03-19'),
(2, 'Kate Winslet', 'Kate Winslet', '1983-12-19'),
(3, 'Antônio de Carvalho Barbosa', 'Toni Ramos', '1956-03-01'),
(4, 'Antonio Rentao Aragao', 'Didi', '1980-05-20'),
(5, 'Gloria Pires', 'Gloria Pires', '1980-07-19');

-- FILME_ATOR
INSERT INTO FILME_ATOR(codFilme, codAtor)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 5),
(4, 4);
