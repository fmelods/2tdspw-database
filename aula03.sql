-- EXERC�CIO 1
DECLARE
    sexo VARCHAR(2) := &DIGITE;
BEGIN
    IF upper(sexo) = 'M' THEN
        dbms_output.put_line ('G�nero informado � Masculino');
    ELSIF upper(sexo) = 'F' THEN
        dbms_output.put_line('G�nero informado � Feminino');
    ELSE
        dbms_output.put_line('G�nero informado � outro');
    END IF;
END;

-- EXERC�CIO 2
-- Crie um bloco an�nimo, que voc� insira um n�mero e seu c�digo devolva se o n�mero informado � par ou �mpar
DECLARE
    numero VARCHAR(2) := &DIGITE;
BEGIN
    IF mod(numero,2) = 0 THEN
        dbms_output.put_line('O n�mero informado � par');
    ELSE
        dbms_output.put_line('O n�mero informado � �mpar');
    END IF;
END;

-- EXERC�CIO 3
-- Criar um bloco an�nimo para calcular a m�dia dos alunos
-- nota maior que 8 : conceito A
-- nota entre 6 e 8 : conceito B
-- nota menor que 6 : reprovado
DECLARE
    nota NUMBER := &DIGITE;
BEGIN
    IF nota > 8 THEN
        dbms_output.put_line('Sua nota � acima da m�dia');
    ELSIF nota BETWEEN 6.1 AND 7 THEN
        dbms_output.put_line('Sua nota est� na m�dia');
    ELSIF nota <= 6 THEN
        dbms_output.put_line('Voc� est� abaixo da m�dia');
    END IF;
END;

-- DQL
-- CRIA��O
CREATE TABLE ALUNO (RA CHAR(9),
NOME VARCHAR2(50),
CONSTRAINT ALUNO_PK PRIMARY KEY(RA));

-- INSER��ES
INSERT INTO ALUNO VALUES('111222333','Antonio Alves');
INSERT INTO ALUNO VALUES('222333444','Beatriz Bernardes');
INSERT INTO ALUNO VALUES('333444555','Cl�udio Cardoso');

SELECT * FROM ALUNO;

-- INSTRU��O DE SELECT
DECLARE
    V_RA CHAR(9) := '333444555';
    V_NOME VARCHAR2(50);
BEGIN
    SELECT NOME INTO V_NOME FROM ALUNO WHERE RA = V_RA;
    DBMS_OUTPUT.PUT_LINE('O noe do aluno �:'||V_NOME);
END;

-- INSTRU��O DE INSERT
DECLARE
    V_RA CHAR(9) := '444555666';
    V_NOME VARCHAR2(50) := 'Daniela Dorneles';
BEGIN
    INSERT INTO ALUNO (RA,NOME) VALUES (V_RA,V_NOME);
END;

-- INSTRU��O DE UPDATE
DECLARE 
    V_RA CHAR(9) := '111222333';
    V_NOME VARCHAR2(50) := 'Antonio Rodrigues';
BEGIN
    UPDATE ALUNO SET NOME = V_NOME WHERE RA = V_RA;
END;

-- INSTRU��O DE DELETE
DECLARE
    V_RA CHAR(9) := '444555666';
BEGIN
DELETE FROM ALUNO WHERE RA = V_RA;
END;

-- IMPORTA��O DA TABELA DE VENDAS
SELECT * FROM VENDAS

-- EXERC�CIO 1
-- Crie um bloco an�nimo que calcule a quantidade de pedidos por pa�s
-- Utilize where para limitar o retorno de uma �nica linha
DECLARE
QTD_PEDIDOS NUMBER;
BEGIN
SELECT COUNT(1)INTO QTD_PEDIDOS FROM VENDAS WHERE COUNTRY = 'France';
DBMS_OUTPUT.PUT_LINE ('A QUANTIDADE DE PEDIDO DO PA�S INFORMADO �: '||QTD_PEDIDOS);
END;
V