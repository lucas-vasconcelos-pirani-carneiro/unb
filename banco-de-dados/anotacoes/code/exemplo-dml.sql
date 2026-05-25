-- DML
SELECT * 
FROM categoria 

INSERT INTO categoria (cod_categoria, nome_categoria)
VALUES (3, 'Bicicleta Elétrica');

INSERT INTO categoria
VALUES (4, 'Bicicleta');

DELETE FROM categoria
WHERE cod_categoria = 4;

UPDATE categoria 
SET nome_categoria = 'Bicicleta'
WHERE cod_categoria = 3;

SELECT * FROM infracao

DELETE FROM local
WHERE cod_local = 1;

-- SELECT
SELECT * FROM veiculo;
SELECT * FROM proprietario;

SELECT cpf, nome 
FROM proprietario;

SELECT * 
FROM proprietario, veiculo; 

SELECT nome, placa 
FROM proprietario AS p, veiculo AS v
WHERE p.cod_proprietario = v.idproprietario;

SELECT * 
FROM proprietario AS p 
INNER JOIN veiculo AS v
	ON p.cod_proprietario = v.idproprietario;

SELECT * 
FROM proprietario AS p 
LEFT OUTER JOIN veiculo AS v
	ON p.cod_proprietario = v.idproprietario;

SELECT COUNT(*)
FROM veiculo; 

SELECT cor, COUNT(*)
FROM veiculo
GROUP BY cor
HAVING COUNT(*) > 1;

SELECT nome 
FROM proprietario
ORDER BY nome;
