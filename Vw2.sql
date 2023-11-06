Use VW;

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