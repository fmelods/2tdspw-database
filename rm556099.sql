-- EXERCÍCIO 1
create or replace procedure consulta_pedido (
    p_cliente NUMBER
) AS
BEGIN
    FOR x IN (
        SELECT
            cod_cliente,
            dat_pedido,
            val_total_pedido
        FROM
            pedido
        WHERE
            cod_cliente = p_cliente
    ) LOOP
        dbms_output.put_line(x.cod_cliente || x.dat_pedido);
    END LOOP;
END;
 
-- EXERCÍCIO 2
CREATE OR REPLACE PROCEDURE consulta_itens_pedido(
    p_pedido NUMBER
) AS
BEGIN
    FOR x IN (
        SELECT 
            cod_item_pedido,
            cod_produto,
            qtd_item
        FROM
            item_pedido
        WHERE
            cod_pedido = p_pedido
    ) LOOP
        dbms_output.put_line(x.cod_item_pedido || ' ' || x.cod_produto || ' ' || x.qtd_item);
    END LOOP;
END;
 
-- EXERCÍCIO 3
CREATE OR REPLACE PROCEDURE consulta_movimento_estoque(
    p_produto NUMBER
) AS
BEGIN
    FOR x IN (
        SELECT 
            dat_movimento_estoque,
            cod_tipo_movimento_estoque
        FROM
            movimento_estoque
        WHERE
            cod_produto = p_produto
    ) LOOP
        dbms_output.put_line(x.dat_movimento_estoque || ' ' || x.cod_tipo_movimento_estoque);
    END LOOP;
END;
 
-- EXERCÍCIO 4
CREATE OR REPLACE PROCEDURE prc_insere_produto(
    p_cod_produto NUMBER,
    p_nom_produto VARCHAR2,
    p_cod_barra VARCHAR2,
    p_sta_ativo VARCHAR2,
    p_dat_cadastro DATE,
    p_dat_cancelamento DATE
) AS
BEGIN
    IF LENGTH(p_nom_produto) > 3 AND REGEXP_LIKE(p_nom_produto, '^[A-Za-z ]+$') THEN
        INSERT INTO produto (cod_produto, nom_produto, cod_barra, sta_ativo, dat_cadastro, dat_cancelamento)
        VALUES (p_cod_produto, p_nom_produto, p_cod_barra, p_sta_ativo, p_dat_cadastro, p_dat_cancelamento);
        dbms_output.put_line('Produto inserido com sucesso.');
    ELSE
        dbms_output.put_line('Erro: Nome do produto inválido.');
    END IF;
END;

-- EXERCÍCIO 5
CREATE OR REPLACE PROCEDURE prc_insere_cliente(
    p_cod_cliente NUMBER,
    p_nom_cliente VARCHAR2,
    p_des_razao_social VARCHAR2,
    p_tip_pessoa CHAR,
    p_num_cpf_cnpj NUMBER,
    p_dat_cadastro DATE,
    p_dat_cancelamento DATE,
    p_sta_ativo CHAR
) AS
BEGIN
    IF LENGTH(p_nom_cliente) > 3 AND REGEXP_LIKE(p_nom_cliente, '^[A-Za-z ]+$') THEN
        INSERT INTO cliente (cod_cliente, nom_cliente, des_razao_social, tip_pessoa, num_cpf_cnpj, dat_cadastro, dat_cancelamento, sta_ativo)
        VALUES (p_cod_cliente, p_nom_cliente, p_des_razao_social, p_tip_pessoa, p_num_cpf_cnpj, p_dat_cadastro, p_dat_cancelamento, p_sta_ativo);
        dbms_output.put_line('Cliente inserido com sucesso.');
    ELSE
        dbms_output.put_line('Erro: Nome do cliente inválido.');
    END IF;
END;