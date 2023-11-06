create database Trigge;
use Trigge;

CREATE TABLE trigge.produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome_produto VARCHAR(255) NOT NULL,
  data_validade DATE NOT NULL,
  preco DECIMAL(10, 2) NOT NULL,
  quantidade_estoque INT NOT NULL
);

DELIMITER //
CREATE TRIGGER tg_validar_data_validade
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
    IF NEW.data_validade < CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de validade vencida';
    END IF;
END //
DELIMITER ;

INSERT INTO produtos (nome_produto, data_validade, preco, quantidade_estoque)
VALUES ('Hamburguer', '1400-12-31', 50.00, 100);

CREATE TABLE vendas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_produto INT NOT NULL,
  data_venda DATE NOT NULL,
  valor DECIMAL(10, 2) NOT NULL
);

DELIMITER //
CREATE TRIGGER tg_aumentar_preco_produto
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    SET NEW.preco = NEW.preco * 1.10;
END //
DELIMITER ;


INSERT INTO produtos (nome_produto, data_validade, preco, quantidade_estoque)
VALUES ('Café', '2023-12-31', 60.00, 100);

SELECT * FROM produtos WHERE nome_produto = 'Café';

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

INSERT INTO vendas (id_produto, data_venda, valor)
VALUES (1, '2023-11-06', 50.00);

SELECT * FROM produtos WHERE id = 1;

CREATE TABLE tb_funcionarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255),
  email VARCHAR(255),
  data_nascimento DATE
);

CREATE TABLE tb_funcionarios_demitidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255),
  email VARCHAR(255),
  data_nascimento DATE
);

DELIMITER //
CREATE TRIGGER tg_registrar_demitidos
AFTER DELETE ON tb_funcionarios
FOR EACH ROW
BEGIN
    INSERT INTO tb_funcionarios_demitidos (id, nome, email, data_nascimento)
    VALUES (OLD.id, OLD.nome, OLD.email, OLD.data_nascimento);
END //
DELIMITER ;


INSERT INTO tb_funcionarios (nome, email, data_nascimento)
VALUES ('João', 'joao@email.com', '1990-01-15');

DELETE FROM tb_funcionarios WHERE id = '1';

SELECT * FROM tb_funcionarios_demitidos;

CREATE TABLE tb_funcionarios2 (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255),
  email VARCHAR(255),
  data_nascimento DATE
);

CREATE TABLE tb_dependentes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_funcionario INT,
  nome VARCHAR(255),
  data_nascimento DATE
);

DELIMITER //
CREATE TRIGGER tg_excluir_dependentes
AFTER DELETE ON tb_funcionarios
FOR EACH ROW
BEGIN
    DELETE FROM tb_dependentes
    WHERE id_funcionario = OLD.id;
END //
DELIMITER ;

INSERT INTO tb_funcionarios2 (nome, email, data_nascimento)
VALUES ('João Nascimento', 'joao@email.com', '1990-01-15');

INSERT INTO tb_dependentes (id_funcionario, nome, data_nascimento)
VALUES (1, 'Cristian Nascimento', '2010-02-20');

DELETE FROM tb_funcionarios2 WHERE id = 1;

SELECT * FROM tb_dependentes;

drop table tb_dependentes;