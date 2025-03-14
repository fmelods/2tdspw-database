-- CP 1 DE DATABASE
-- NOME: FELIPE MELO DE SOUSA
-- RM: 556099
-- DATA: 13/03/2025
-- OBS: OS PRINTS ESTÃO NO FINAL DO WORD

-- EXERCÍCIO 1
SET SERVEROUTPUT ON;

DECLARE
    v_ano NUMBER;
BEGIN
    v_ano := &ano;

    IF (v_ano MOD 400 = 0) OR (v_ano MOD 4 = 0 AND v_ano MOD 100 != 0) THEN
        DBMS_OUTPUT.PUT_LINE(v_ano || ' é um ano bissexto.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_ano || ' não é um ano bissexto.');
    END IF;
END;

-- EXERCÍCIO 2
DECLARE
    v_num1 NUMBER;
    v_num2 NUMBER;
    v_maior NUMBER;
    v_menor NUMBER;
    v_resultado NUMBER;
BEGIN
    v_num1 := &num1;
    v_num2 := &num2;

    IF v_num1 > v_num2 THEN
        v_maior := v_num1;
        v_menor := v_num2;
    ELSE
        v_maior := v_num2;
        v_menor := v_num1;
    END IF;

    v_resultado := v_maior / v_menor;
    
    DBMS_OUTPUT.PUT_LINE('Resultado da divisão de ' || v_maior || ' por ' || v_menor || ' é: ' || v_resultado);
END;
    
-- EXERCÍCIO 3
DECLARE
    v_salario NUMBER := NVL(&salario, 0);
    v_bonus NUMBER := NVL(&bonus, 0);
    v_salario_total NUMBER;
BEGIN
    v_salario_total := v_salario + v_bonus;
    
    DBMS_OUTPUT.PUT_LINE('O salário anual com bônus é: ' || v_salario_total);
END;

-- BANCO DE DADOS PARA O EXERCÍCIO 4 E 5
/*criar Tabela*/
CREATE TABLE PRODUTOCP (
CODIGO NUMBER(4),
CATEGORIA CHAR(1),
VALOR NUMBER(4,2));

/*inserir dados na tabela*/
INSERT INTO PRODUTOCP VALUES (1001,'A',7.55);
INSERT INTO PRODUTOCP VALUES (1002,'B',5.95);
INSERT INTO PRODUTOCP VALUES (1003,'C',3.45);

SELECT * FROM PRODUTOCP

-- EXERCÍCIO 4
BEGIN
    FOR r IN (SELECT * FROM PRODUTOCP) LOOP
        IF r.CATEGORIA = 'A' THEN
            UPDATE PRODUTOCP SET VALOR = VALOR * 1.05 WHERE CODIGO = r.CODIGO;
        ELSIF r.CATEGORIA = 'B' THEN
            UPDATE PRODUTOCP SET VALOR = VALOR * 1.10 WHERE CODIGO = r.CODIGO;
        ELSIF r.CATEGORIA = 'C' THEN
            UPDATE PRODUTOCP SET VALOR = VALOR * 1.15 WHERE CODIGO = r.CODIGO;
        END IF;
    END LOOP;
    
    COMMIT;
END;

-- EXERCÍCIO 5
BEGIN
    INSERT INTO PRODUTOCP (CODIGO, CATEGORIA, VALOR) VALUES (&codigo1, &categoria1, &valor1);
    INSERT INTO PRODUTOCP (CODIGO, CATEGORIA, VALOR) VALUES (&codigo2, &categoria2, &valor2);
    INSERT INTO PRODUTOCP (CODIGO, CATEGORIA, VALOR) VALUES (&codigo3, &categoria3, &valor3);
    INSERT INTO PRODUTOCP (CODIGO, CATEGORIA, VALOR) VALUES (&codigo4, &categoria4, &valor4);
    
    COMMIT;
END;

-- EXERCÍCIO 6
SELECT table_name AS tabela, 
  TO_NUMBER(EXTRACTVALUE(XMLTYPE(DBMS_XMLGEN.GETXML(
    'SELECT COUNT(*) AS c FROM ' || owner || '.' || table_name)),
    'ROWSET/ROW/C')) AS qtd_linhas
FROM all_tables
WHERE owner = 'RM556099'
ORDER BY qtd_linhas DESC

-- EXERCÍCIO 7
DECLARE
    v_cliente_id NUMBER;
    v_pedido_id NUMBER;
    v_data_pedido DATE;
BEGIN
    v_cliente_id := &cliente_id;
    
    SELECT cod_pedido, dat_pedido
    INTO v_pedido_id, v_data_pedido
    FROM pedido
    WHERE cod_cliente = v_cliente_id
    ORDER BY dat_pedido DESC
    FETCH FIRST 1 ROWS ONLY;

    DBMS_OUTPUT.PUT_LINE('Último pedido do cliente ' || v_cliente_id || ': Pedido ID ' || v_pedido_id || ' na data ' || v_data_pedido);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum pedido encontrado para o cliente ' || v_cliente_id);
END;
