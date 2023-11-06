Use Trigge;

CREATE TABLE trigge.produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome_produto VARCHAR(255) NOT NULL,
  data_validade DATE NOT NULL,
  preco DECIMAL(10, 2) NOT NULL,
  quantidade_estoque INT NOT NULL
)

DELIMITER //
CREATE TRIGGER tg_atualizar_estoque_venda
AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET quantidade_estoque = quantidade_estoque - 1
    WHERE id = NEW.id_produto;
END //
DELIMITER ;

INSERT INTO produtos (nome_produto, data_validade, preco, quantidade_estoque)
VALUES ('Hamburguer', '2025-12-31', 50.00, 100);

INSERT INTO vendas (id_produto, data_venda, valor)
VALUES (1, '2023-11-06', 50.00);

SELECT * FROM produtos WHERE id = 1;
