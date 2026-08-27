-- Schema
CREATE TABLE Assinante (
  cd_assinante INT PRIMARY KEY,
  nm_assinante VARCHAR(100)
);

CREATE TABLE Endereco (
  cd_endereco INT PRIMARY KEY,
  cd_assinante INT,
  ds_endereco VARCHAR(150),
  FOREIGN KEY (cd_assinante) REFERENCES Assinante(cd_assinante)
);

CREATE TABLE Telefone (
  cd_fone INT PRIMARY KEY,
  cd_endereco INT,
  n_fone VARCHAR(20),
  FOREIGN KEY (cd_endereco) REFERENCES Endereco(cd_endereco)
);

INSERT INTO Assinante VALUES (1,'Ana Souza'),(2,'Bruno Lima'),(3,'Carla Dias');
INSERT INTO Endereco VALUES (10,1,'Rua A, 100'),(20,2,'Av. B, 200');
INSERT INTO Telefone VALUES (100,10,'84999990001'),(101,10,'8433330002'),(102,20,'84988880003');

-- Consulta
SELECT a.nm_assinante, e.ds_endereco, t.n_fone 
FROM Assinante a 
INNER JOIN Endereco e ON a.cd_assinante = e.cd_assinante 
INNER JOIN Telefone t ON e.cd_endereco = t.cd_endereco;

CREATE TABLE Ramo_Atividade (
  cd_ramo INT PRIMARY KEY,
  ds_ramo VARCHAR(80)
);

CREATE TABLE Assinante (
  cd_assinante INT PRIMARY KEY,
  nm_assinante VARCHAR(100),
  cd_ramo INT NULL,
  FOREIGN KEY (cd_ramo) REFERENCES Ramo_Atividade(cd_ramo)
);

INSERT INTO Ramo_Atividade VALUES (1,'Comércio'),(2,'Indústria'),(3,'Serviços');
INSERT INTO Assinante VALUES 
  (1,'Ana Souza',1),
  (2,'Bruno Lima',NULL),
  (3,'Carla Dias',3),
  (4,'Diego Melo',NULL);

SELECT a.nm_assinante, r.ds_ramo 
FROM Assinante a 
LEFT JOIN Ramo_Atividade r ON a.cd_ramo = r.cd_ramo 
ORDER BY r.ds_ramo, a.nm_assinante;

CREATE TABLE Tipo_Assinante (
  cd_tipo INT PRIMARY KEY,
  ds_tipo VARCHAR(50)
);

CREATE TABLE Municipio (
  cd_municipio INT PRIMARY KEY,
  ds_municipio VARCHAR(80)
);

CREATE TABLE Assinante (
  cd_assinante INT PRIMARY KEY,
  nm_assinante VARCHAR(100),
  cd_tipo INT,
  FOREIGN KEY (cd_tipo) REFERENCES Tipo_Assinante(cd_tipo)
);

CREATE TABLE Endereco (
  cd_endereco INT PRIMARY KEY,
  cd_assinante INT,
  cd_municipio INT,
  ds_endereco VARCHAR(150),
  FOREIGN KEY (cd_assinante) REFERENCES Assinante(cd_assinante),
  FOREIGN KEY (cd_municipio) REFERENCES Municipio(cd_municipio)
);

INSERT INTO Tipo_Assinante VALUES (1,'Residencial'),(2,'Comercial');
INSERT INTO Municipio VALUES (1,'Pelotas'),(2,'Natal'),(3,'João Câmara');
INSERT INTO Assinante VALUES (1,'Ana Souza',1),(2,'Bruno Lima',2),(3,'Carla Dias',1),(4,'Diego Melo',1);
INSERT INTO Endereco VALUES 
  (10,1,1,'Rua A, 100'),
  (20,2,1,'Av. B, 200'),
  (30,3,2,'Rua C, 300'),
  (40,4,1,'Av. D, 400');

SELECT a.nm_assinante 
FROM Assinante a 
INNER JOIN Tipo_Assinante ta ON a.cd_tipo = ta.cd_tipo 
INNER JOIN Endereco e ON a.cd_assinante = e.cd_assinante 
INNER JOIN Municipio m ON e.cd_municipio = m.cd_municipio 
WHERE m.ds_municipio = 'Pelotas' AND ta.ds_tipo = 'Residencial';

CREATE TABLE Assinante (
  cd_assinante INT PRIMARY KEY,
  nm_assinante VARCHAR(100)
);

CREATE TABLE Endereco (
  cd_endereco INT PRIMARY KEY,
  cd_assinante INT,
  ds_endereco VARCHAR(150),
  FOREIGN KEY (cd_assinante) REFERENCES Assinante(cd_assinante)
);

CREATE TABLE Telefone (
  cd_fone INT PRIMARY KEY,
  cd_endereco INT,
  n_fone VARCHAR(20),
  FOREIGN KEY (cd_endereco) REFERENCES Endereco(cd_endereco)
);

INSERT INTO Assinante VALUES (1,'Ana Souza'),(2,'Bruno Lima'),(3,'Carla Dias');
INSERT INTO Endereco VALUES (10,1,'Rua A'),(20,2,'Av. B'),(30,3,'Rua C');
INSERT INTO Telefone VALUES 
  (100,10,'84999990001'),
  (101,10,'8433330002'),
  (102,10,'84988880003'),
  (103,20,'84977770004'),
  (104,30,'84966660005'),
  (105,30,'84955550006');

SELECT nm_assinante 
FROM Assinante 
WHERE cd_assinante IN (
  SELECT e.cd_assinante 
  FROM Endereco e 
  JOIN Telefone t ON e.cd_endereco = t.cd_endereco 
  GROUP BY e.cd_assinante 
  HAVING COUNT(t.cd_fone) > 1
);
