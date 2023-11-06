use VW;

CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  id_vendedor INT
);

INSERT INTO clientes (nome, id_vendedor) VALUES
('Jucelino Oliveira', 1),
('Flávio Rocha', 2),
('Marcelo Nascimento', 1),
('Rodrigo dos Campos', 3);

CREATE TABLE vendedores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL
);

INSERT INTO vendedores (nome) VALUES
('Moacir Rodrigues'),
('Jurandi Ferreira'),
('Marcelo Campos');

CREATE VIEW vw_relacionamento_cliente_vendedor AS
SELECT c.nome AS cliente, v.nome AS vendedor
FROM clientes AS c
JOIN vendedores AS v ON c.id_vendedor = v.id;


select * from vw_relacionamento_cliente_vendedor;