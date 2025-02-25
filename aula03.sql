-- EXERCÍCIO 1
DECLARE
    sexo VARCHAR(2) := &DIGITE;
BEGIN
    IF upper(sexo) = 'M' THEN
        dbms_output.put_line ('Gênero informado é Masculino');
    ELSIF upper(sexo) = 'F' THEN
        dbms_output.put_line('Gênero informado é Feminino');
    ELSE
        dbms_output.put_line('Gênero informado é outro');
    END IF;
END;

-- EXERCÍCIO 2
-- Crie um bloco anônimo, que você insira um número e seu código devolva se o número informado é par ou ímpar
DECLARE
    numero VARCHAR(2) := &DIGITE;
BEGIN
    IF mod(numero,2) = 0 THEN
        dbms_output.put_line('O número informado é par');
    ELSE
        dbms_output.put_line('O número informado é ímpar');
    END IF;
END;

-- EXERCÍCIO 3
-- Criar um bloco anônimo para calcular a média dos alunos
-- nota maior que 8 : conceito A
-- nota entre 6 e 8 : conceito B
-- nota menor que 6 : reprovado
DECLARE
    nota NUMBER := &DIGITE;
BEGIN
    IF nota > 8 THEN
        dbms_output.put_line('Sua nota é acima da média');
    ELSIF nota BETWEEN 6.1 AND 7 THEN
        dbms_output.put_line('Sua nota está na média');
    ELSIF nota <= 6 THEN
        dbms_output.put_line('Você está abaixo da média');
    END IF;
END;

-- DQL
-- CRIAÇÃO
CREATE TABLE ALUNO (RA CHAR(9),
NOME VARCHAR2(50),
CONSTRAINT ALUNO_PK PRIMARY KEY(RA));

-- INSERÇÕES
INSERT INTO ALUNO VALUES('111222333','Antonio Alves');
INSERT INTO ALUNO VALUES('222333444','Beatriz Bernardes');
INSERT INTO ALUNO VALUES('333444555','Cláudio Cardoso');

SELECT * FROM ALUNO;

-- INSTRUÇÃO DE SELECT
DECLARE
    V_RA CHAR(9) := '333444555';
    V_NOME VARCHAR2(50);
BEGIN
    SELECT NOME INTO V_NOME FROM ALUNO WHERE RA = V_RA;
    DBMS_OUTPUT.PUT_LINE('O noe do aluno é:'||V_NOME);
END;

-- INSTRUÇÃO DE INSERT
DECLARE
    V_RA CHAR(9) := '444555666';
    V_NOME VARCHAR2(50) := 'Daniela Dorneles';
BEGIN
    INSERT INTO ALUNO (RA,NOME) VALUES (V_RA,V_NOME);
END;

-- INSTRUÇÃO DE UPDATE
DECLARE 
    V_RA CHAR(9) := '111222333';
    V_NOME VARCHAR2(50) := 'Antonio Rodrigues';
BEGIN
    UPDATE ALUNO SET NOME = V_NOME WHERE RA = V_RA;
END;

-- INSTRUÇÃO DE DELETE
DECLARE
    V_RA CHAR(9) := '444555666';
BEGIN
DELETE FROM ALUNO WHERE RA = V_RA;
END;

-- IMPORTAÇÃO DA TABELA DE VENDAS
SELECT * FROM VENDAS

-- EXERCÍCIO 1
-- Crie um bloco anônimo que calcule a quantidade de pedidos por país
-- Utilize where para limitar o retorno de uma única linha
DECLARE
QTD_PEDIDOS NUMBER;
BEGIN
SELECT COUNT(1)INTO QTD_PEDIDOS FROM VENDAS WHERE COUNTRY = 'France';
DBMS_OUTPUT.PUT_LINE ('A QUANTIDADE DE PEDIDO DO PAÍS INFORMADO É: '||QTD_PEDIDOS);
END;
V