create database VW;
use VW;

CREATE TABLE funcionarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  cargo VARCHAR(255) NOT NULL,
  departamento VARCHAR(255) NOT NULL
);

INSERT INTO funcionarios (nome, cargo, departamento) VALUES
('Joaquim Ferreira', 'Administrador', 'Administrativo'),
('José da Paz', 'Adminstrador de Cargas', 'Administrativo'),
('Rodrigo Muniz', 'Gerente', 'Bradesco'),
('Pedro Parente', 'CEO', 'Petrobras');

CREATE VIEW vw_funcionarios_departamento AS
SELECT nome, cargo
FROM funcionarios
WHERE departamento = 'Administrativo';

select * from vw_funcionarios_departamento;

CREATE TABLE produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome_produto VARCHAR(255) NOT NULL,
  quantidade_estoque INT NOT NULL,
  preco DECIMAL(10, 2) NOT NULL
);

INSERT INTO produtos (nome_produto, quantidade_estoque, preco) VALUES
('Memória RAM 4GB', 3, 120.00),
('Mouse', 8, 90.00),
('Processador I3', 2, 150.00),
('Processador I5', 7, 250.00),
('Processador I7', 4, 400.00);

CREATE VIEW vw_estoque_insuficiente AS
SELECT nome_produto, quantidade_estoque
FROM produtos
WHERE quantidade_estoque < 5;

select * from vw_estoque_insuficiente;

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

CREATE TABLE pedidos (
  numero_pedido INT AUTO_INCREMENT PRIMARY KEY,
  data_pedido DATE NOT NULL,
  status VARCHAR(255) NOT NULL
);

INSERT INTO pedidos (data_pedido, status) VALUES
('2023-12-03', 'Pendente'),
('2023-01-02', 'Entregue'),
('2023-11-15', 'Pendente'),
('2023-05-08', 'Entrege');

CREATE VIEW vw_produtos_caros AS
SELECT nome_produto, preco
FROM produtos
WHERE preco > 100;

CREATE VIEW vw_pedidos_pendentes AS
SELECT numero_pedido, data_pedido, status
FROM pedidos
WHERE status = 'Pendente';

select * from vw_produtos_caros;
select * from vw_pedidos_pendentes;