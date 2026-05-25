SELECT * FROM Proprietario;
SELECT * FROM telefone;
SELECT * FROM Modelo;
SELECT * FROM Categoria;
SELECT * FROM Veiculo;
SELECT * FROM Local;
SELECT * FROM Agente_de_Transito;
SELECT * FROM Tipo_Infrao;
SELECT * FROM Infracao;

INSERT INTO Proprietario (cod_proprietario, cpf, nome, data_nasc, bairro, cidade, estado)
	VALUES 
		(1, '11111111111', 'João da Costa', '1999/10/20', NULL, 'Brasília', 'DF'),
		(2, '12111111111', 'Bruno da Costa', '1999/09/30', 'Morumbi', 'São Paulo', 'SP');

INSERT INTO telefone (telefone, cod_proprietario)
VALUES 
    ('(61) 99999-9999', 1), 
    ('(11) 11111-1111', 2);

INSERT INTO Categoria (cod_categoria, nome_categoria) 
VALUES 
    (1, 'SUV'),
    (2, 'Sefan');

INSERT INTO Modelo (cod_modelo, nome_modelo) 
VALUES 
    (1, 'Pulse'),
    (2, 'Logan');

INSERT INTO Veiculo 
(idVeiculo, ano_fabricacao, cor, placa, chassi, idProprietario, idModelo, idCategoria)
VALUES
    (1, '2020-01-01', 'Prata', 'ABC1D23', 'CHASSI001', 1, 1, 1),
    (2, '2019-01-01', 'Branco', 'XYZ9K87', 'CHASSI002', 2, 2, 2),
    (3, '2022-01-01', 'Preto', 'JKL5M44', 'CHASSI003', 1, 2, 1);

INSERT INTO Local
(cod_local, vel_permitida, longitude, latitude)
VALUES
    (1, 60, -47.8825, -15.7942),
    (2, 80, -47.9000, -15.7801),
    (3, 40, -47.9105, -15.8123);

INSERT INTO Agente_de_Transito
(matricula, nome, data_contratacao, tempo_servico)
VALUES
    (1001, 'Carlos Henrique', '2018-03-10', 7),
    (1002, 'Mariana Souza', '2020-08-15', 5),
    (1003, 'Felipe Almeida', '2022-01-20', 3);

INSERT INTO Tipo_Infrao
(cod_tipo_infracao, valor)
VALUES
    (1, 130.16),
    (2, 195.23),
    (3, 880.41);

INSERT INTO Infracao
(idVeiculo, idLocal, idAgente_de_Transito, idTipo_Infracao, vel_aferida, data_hora)
VALUES
    (1, 1, 1001, 1, 75, '2025-05-20 14:30:00'),
    (2, 2, 1002, 2, 105, '2025-05-21 09:15:00'),
    (3, 3, 1003, 3, 70, '2025-05-22 18:45:00');

-- Update
UPDATE Categoria 
SET nome_categoria = 'Sedan'
WHERE cod_categoria = 2;

UPDATE Veiculo
SET cor = 'Azul'
WHERE idVeiculo = 1;

UPDATE Proprietario
SET nome = 'João Pedro da Costa'
WHERE cod_proprietario = 1;

UPDATE Tipo_Infrao
SET valor = 250.00
WHERE cod_tipo_infracao = 2;

UPDATE Local
SET vel_permitida = 50
WHERE cod_local = 3;

-- Delete
DELETE FROM Infracao
WHERE idVeiculo = 3;

DELETE FROM Infracao
WHERE idAgente_de_Transito = 1003;

DELETE FROM Veiculo 
WHERE idVeiculo = 3;

DELETE FROM Agente_de_Transito
WHERE matricula = 1003;

DELETE FROM telefone
WHERE cod_proprietario = 2;
