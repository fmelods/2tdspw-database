CREATE OR REPLACE FUNCTION fnc_percentual_desconto(p_cod_pedido NUMBER)
RETURN NUMBER
IS
    v_val_total_pedido pedido.VAL_TOTAL_PEDIDO%TYPE;
    v_val_desconto pedido.VAL_DESCONTO%TYPE;
    v_percentual NUMBER(5,2);
BEGIN
    SELECT p.VAL_TOTAL_PEDIDO, p.VAL_DESCONTO
    INTO v_val_total_pedido, v_val_desconto
    FROM pedido p
    JOIN item_pedido ip ON p.COD_PEDIDO = ip.COD_PEDIDO
    WHERE p.COD_PEDIDO = p_cod_pedido
    AND ROWNUM = 1;
 
    IF v_val_total_pedido = 0 THEN
        RETURN 0;
    END IF;
 
    v_percentual := ROUND((v_val_desconto / v_val_total_pedido) * 100, 2);
 
    RETURN v_percentual;
 
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN ZERO_DIVIDE THEN
        RETURN 0; 
    WHEN OTHERS THEN
        RETURN NULL; 
END;
 
 
 
CREATE OR REPLACE FUNCTION fnc_media_itens_por_pedido
RETURN NUMBER
IS
    v_media NUMBER(10,2);
BEGIN
    SELECT ROUND(AVG(qtd_itens), 2)
    INTO v_media
    FROM (
        SELECT COUNT(*) AS qtd_itens
        FROM item_pedido ip
        JOIN historico_pedido hp ON ip.COD_PEDIDO = hp.COD_PEDIDO
        GROUP BY ip.COD_PEDIDO
    );
 
    RETURN v_media;
 
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN NULL;
END;
 
 
 
 
CREATE OR REPLACE PROCEDURE prc_relatorio_estoque_produto(p_cod_produto NUMBER)
IS
    v_total_movimentado NUMBER := 0;
    v_data_ultima_movimentacao DATE;
BEGIN
    SELECT NVL(SUM(me.QTD_MOVIMENTACAO_ESTOQUE), 0),
           MAX(me.DAT_MOVIMENTO_ESTOQUE)
    INTO v_total_movimentado, v_data_ultima_movimentacao
    FROM produto p
    LEFT JOIN produto_composto pc ON p.COD_PRODUTO = pc.COD_PRODUTO
    LEFT JOIN movimento_estoque me ON p.COD_PRODUTO = me.COD_PRODUTO
    WHERE p.COD_PRODUTO = p_cod_produto;
 
    IF v_data_ultima_movimentacao IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Produto sem movimentações.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total movimentado: ' || v_total_movimentado);
        DBMS_OUTPUT.PUT_LINE('Última movimentação: ' || TO_CHAR(v_data_ultima_movimentacao, 'DD/MM/YYYY'));
    END IF;
 
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao gerar relatório de estoque.');
END;
 
 
 
CREATE OR REPLACE PROCEDURE prc_relatorio_composicao_ativa(p_cod_produto NUMBER)
IS
BEGIN
    FOR comp IN (
        SELECT pc.COD_PRODUTO_RELACIONADO,
               pr.NOM_PRODUTO
        FROM produto_composto pc
        JOIN produto pr ON pc.COD_PRODUTO_RELACIONADO = pr.COD_PRODUTO
        JOIN movimento_estoque me ON me.COD_PRODUTO = pc.COD_PRODUTO_RELACIONADO
        WHERE pc.COD_PRODUTO = p_cod_produto
          AND pc.STA_ATIVO = 'S'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Componente: ' || comp.NOM_PRODUTO || ' (Código: ' || comp.COD_PRODUTO_RELACIONADO || ')');
    END LOOP;
 
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao gerar relatório de composição ativa.');
END;
 
 
 
CREATE OR REPLACE PROCEDURE prc_relatorio_pedido(p_cod_pedido NUMBER)
IS
    v_val_total pedido.VAL_TOTAL_PEDIDO%TYPE;
    v_val_desconto pedido.VAL_DESCONTO%TYPE;
    v_data_entrega pedido.DAT_ENTREGA%TYPE;
BEGIN
    SELECT p.VAL_TOTAL_PEDIDO, p.VAL_DESCONTO, p.DAT_ENTREGA
    INTO v_val_total, v_val_desconto, v_data_entrega
    FROM pedido p
    JOIN item_pedido ip ON p.COD_PEDIDO = ip.COD_PEDIDO
    WHERE p.COD_PEDIDO = p_cod_pedido
    AND ROWNUM = 1;
 
    DBMS_OUTPUT.PUT_LINE('Valor Total do Pedido: R$ ' || TO_CHAR(v_val_total, 'FM9999990.00'));
    DBMS_OUTPUT.PUT_LINE('Desconto Aplicado: R$ ' || TO_CHAR(v_val_desconto, 'FM9999990.00'));
 
    IF v_data_entrega IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Status: ENTREGUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Status: PENDENTE');
    END IF;
 
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Pedido não encontrado ou não possui itens.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao gerar relatório do pedido.');
END;