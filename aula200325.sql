SELECT * FROM PAIS

INSERT INTO PAIS VALUES (77,'JAMAICA');

SET SERVEROUTPUT ON;

DECLARE
    v_id NUMBER := &VALOR;
    v_nome VARCHAR2(30) := '&NOME';
BEGIN
    INSERT INTO pais VALUES (
    v_id,
    v_nome
    );
    
    COMMIT;
END;



CREATE OR REPLACE PROCEDURE insert_pais (
    v_id    NUMBER,
    v_nome  VARCHAR2
) AS
BEGIN
    INSERT INTO PAIS VALUES (
        v_id,
        v_nome
    );
 
    COMMIT;
END;



EXEC insert_pais(231,'AFRICA DO SUL');

EXECUTE insert_pais(323,'AFRICA DO SUL');

CALL insert_pais(545,'AFRICA DO SUL');

BEGIN
insert_pais();
END;



CREATE OR REPLACE PROCEDURE update_pais (
    p_cod NUMBER,
    p_nome VARCHAR2
) AS
BEGIN
    UPDATE pais
    SET
        nom_pais = p_nome
    WHERE
        cod_pais =  p_cod;
        
    COMMIT;
END update_pais;



CREATE OR REPLACE PROCEDURE delete_pais (
    p_cod NUMBER
) AS
BEGIN
    DELETE FROM pais
    WHERE
        cod_pais =  p_cod;
        
    COMMIT;
END delete_pais;



SELECT * FROM CLIENTE
SELECT * FROM PEDIDO

SELECT
    a.cod_pedido,
    b.cod_cliente,
    b.nom_cliente,
    a.dat_pedido,
    d.nom_produto
FROM
        pedido a
    INNER JOIN cliente b ON ( a.cod_cliente = b.cod_cliente )
    inner join item_pedido c on (a.cod_pedido=c.cod_pedido)
    inner join produto d on (c.cod_produto=d.cod_produto)
WHERE
    a.cod_cliente = 74
    and a.cod_pedido = 130501;
    



create or replace procedure rel_pedidos (p_cod_ped number) as
Begin FOR X IN (
    SELECT
        ped.cod_pedido,
        cli.cod_cliente,
        cli.nom_cliente,
        MAX(ped.dat_pedido),
        prod.nom_produto
    FROM 
        pedido ped
        INNER JOIN cliente cli ON (ped.cod_cliente = cli.cod_cliente)
        INNER JOIN item_pedido item ON (ped.cod_pedido = item.cod_pedido)
        INNER JOIN produto prod ON (item.cod_produto = prod.cod_produto)
    WHERE 
        ped.cod_cliente = 74
        AND ped.cod_pedido = 130501
    GROUP BY
        ped.cod_pedido,
        cli.cod_cliente,
        cli.nom_cliente,
        prod.nom_produto
) LOOP
    DBMS_OUTPUT.PUT_LINE(X.COD_CLIENTE || ' ' || X.NOM_CLIENTE);
END LOOP;
END;

