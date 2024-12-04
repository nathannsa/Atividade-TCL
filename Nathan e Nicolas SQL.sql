-- Criar as tabelas necessárias para o exemplo
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Iniciar transação
START TRANSACTION;

-- Inserir cliente
INSERT INTO cliente (id_cliente, nome) VALUES (1, 'João Silva');

-- Definir ponto de salvamento
SAVEPOINT cliente_inserted;

-- Inserir pedido relacionado
INSERT INTO pedido (id_pedido, id_cliente, data_pedido) VALUES (101, 1, NOW());

-- Confirmar transação
COMMIT;

-- Exemplos adicionais de uso de ROLLBACK

-- Exemplo 1: Rollback completo
START TRANSACTION;
INSERT INTO cliente (id_cliente, nome) VALUES (2, 'Maria Souza');
ROLLBACK;  -- Desfaz a inserção de Maria Souza

-- Exemplo 2: Uso de SAVEPOINT
START TRANSACTION;
INSERT INTO cliente (id_cliente, nome) VALUES (3, 'Pedro Santos');
SAVEPOINT antes_do_pedido;
INSERT INTO pedido (id_pedido, id_cliente, data_pedido) VALUES (102, 3, NOW());
ROLLBACK TO SAVEPOINT antes_do_pedido;  -- Volta ao estado antes da inserção do pedido
COMMIT;