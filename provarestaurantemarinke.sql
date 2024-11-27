USE restaurante;
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Vendas;
DROP TABLE IF EXISTS Produtos;
DROP TABLE IF EXISTS Mesas;
DROP TABLE IF EXISTS Funcionarios;

-- Tabela de Funcionarios
CREATE TABLE Funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela de Mesas
CREATE TABLE Mesas (
    id_mesa INT AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL,
    status ENUM('Livre', 'Ocupada', 'Sobremesa', 'Ocupada-Ociosa') NOT NULL
);

-- Tabela de Produtos
CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    estoque_minimo INT NOT NULL,
    marca VARCHAR(50) NOT NULL
);

-- Tabela de Vendas
CREATE TABLE Vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    id_mesa INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario),
    FOREIGN KEY (id_mesa) REFERENCES Mesas(id_mesa)
);

-- Tabela de Pedidos
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES Vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

SELECT
    f.nome AS Nome_Do_Funcionario,
    m.numero AS Mesa,
    SUM(v.valor_total) AS Total_Gasto
FROM
    Funcionarios f
JOIN
    Vendas v ON f.id_funcionario = v.id_funcionario
JOIN
    Mesas m ON v.id_mesa = m.id_mesa
GROUP BY
    f.nome, m.numero;
    
    SELECT
    f.nome AS Nome_Do_Funcionario,
    m.numero AS Mesa,
    SUM(v.valor_total) AS Total_Gasto
FROM
    Funcionarios f
JOIN
    Vendas v ON f.id_funcionario = v.id_funcionario
JOIN
    Mesas m ON v.id_mesa = m.id_mesa
GROUP BY
    f.nome, m.numero;
    
   SELECT 
    p.nome AS Produto,
    pd.quantidade AS Quantidade,
    pd.quantidade * p.preco_unitario AS Total_Produto
FROM
    Pedidos pd
        JOIN
    Vendas v ON pd.id_venda = v.id_venda
        JOIN
    Produtos p ON pd.id_produto = p.id_produto
WHERE
    v.id_mesa = 1;
    
    DELIMITER $$

CREATE PROCEDURE ResetarStatusMesa(Livre INT)
BEGIN
    UPDATE Mesas
    SET status = 'Livre'
    WHERE id_mesa = Livre;
END $$

DELIMITER ;