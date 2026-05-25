-- Tabela Proprietario
CREATE TABLE Proprietario (
    cod_proprietario INT PRIMARY KEY,
    cpf CHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    data_nasc DATE,
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(50)
);

-- Tabela Telefone
CREATE TABLE telefone (
    telefone VARCHAR(20),
    cod_proprietario INT,
    PRIMARY KEY (telefone, cod_proprietario),
    FOREIGN KEY (cod_proprietario) REFERENCES Proprietario(cod_proprietario)
);

-- Tabela Modelo
CREATE TABLE Modelo (
    cod_modelo INT PRIMARY KEY,
    nome_modelo VARCHAR(100) NOT NULL
);

-- Tabela Categoria
CREATE TABLE Categoria (
    cod_categoria INT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    idVeiculo INT PRIMARY KEY,
    ano_fabricacao DATE,
    cor VARCHAR(50),
    placa VARCHAR(10) UNIQUE,
    chassi VARCHAR(50) UNIQUE,
    idProprietario INT,
    idModelo INT,
    idCategoria INT,
    FOREIGN KEY (idProprietario) REFERENCES Proprietario(cod_proprietario),
    FOREIGN KEY (idModelo) REFERENCES Modelo(cod_modelo),
    FOREIGN KEY (idCategoria) REFERENCES Categoria(cod_categoria)
);

-- Tabela Local
CREATE TABLE Local (
    cod_local INT PRIMARY KEY,
    vel_permitida INT,
    longitude FLOAT,
    latitude FLOAT
);

-- Tabela Agente de Trânsito
CREATE TABLE Agente_de_Transito (
    matricula INT PRIMARY KEY,
    nome VARCHAR(100),
    data_contratacao DATE,
    tempo_servico INT
);

-- Tabela Tipo_Infração
CREATE TABLE Tipo_Infrao (
    cod_tipo_infracao INT PRIMARY KEY,
    valor FLOAT
);

-- Tabela Infração
CREATE TABLE Infracao (
    idVeiculo INT,
    idLocal INT,
    idAgente_de_Transito INT,
    idTipo_Infracao INT,
    vel_aferida INT,
    data_hora DATETIME,
    PRIMARY KEY (idVeiculo, idLocal, idAgente_de_Transito, idTipo_Infracao, data_hora),
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (idLocal) REFERENCES Local(cod_local),
    FOREIGN KEY (idAgente_de_Transito) REFERENCES Agente_de_Transito(matricula),
    FOREIGN KEY (idTipo_Infracao) REFERENCES Tipo_Infrao(cod_tipo_infracao)
);
