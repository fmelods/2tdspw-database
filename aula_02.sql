set SERVEROUTPUT on;

DECLARE
    variavel01 NUMBER;
    nome       VARCHAR2(30) := 'Vergs';
    nome2 nome%type;
BEGIN
    variavel01 := 10;
    dbms_output.put_line('O valor digital �: '|| variavel01);
    dbms_output.put_line('O nome digito �: ' || nome);
END;

-- EXERC�CIO 1
set SERVEROUTPUT on;

DECLARE
    salariominimo NUMBER := 1518;
    aumento       NUMBER;
BEGIN
    aumento := salariominimo + (salariominimo *0.25);
    dbms_output.put_line
    ('O valor do novo sal�rio minimo com 25% � : '|| aumento);
END;

-- EXERC�CIO 2
set SERVEROUTPUT on;

DECLARE
    reais NUMBER := &valor;
    dolar NUMBER := 5.70;
BEGIN
dbms_output.put_line('O valor de '
                    || reais
                    || ' O dolares em reais � R$:'
                    || reais * dolar);
END;

-- EXERC�CIO 3
DECLARE
    v_valor_compra NUMBER := &valor_compra;
    v_juros NUMBER := 0.03;
    v_valor_total_com_juros NUMBER;
    v_valor_parcela NUMBER;
BEGIN
    v_valor_total_com_juros := v_valor_compra * (1 + v_juros);

    v_valor_parcela := v_valor_total_com_juros / 10;

    DBMS_OUTPUT.PUT_LINE('Valor de cada parcela: ' || TO_CHAR(v_valor_parcela, 'FM9999990.00'));
END;

-- EXERC�CIO 4
set SERVEROUTPUT on;

DECLARE
    valorCarro number := &DigiteValorCarro;
BEGIN
    dbms_output.put_line('O valor do Carro a vista �: R$' || ValorCarro);
    dbms_output.put_line('O valor de cada parcela dividido em 10X, Cada parcela � : R$'
                        ||(ValorCarro*1.03)/10);
    dbms_output.put_line('Valor do carro financiado �: R$'|| ValorCarro*1.03);
END;

-- EXERC�CIO 5
DECLARE
    v_sexo CHAR(1) := '&sexo';
    v_resultado VARCHAR2(10);
BEGIN
    IF UPPER(v_sexo) = 'M' THEN
        v_resultado := 'Masculino';
    ELSIF UPPER(v_sexo) = 'F' THEN
        v_resultado := 'Feminino';
    ELSE
        v_resultado := 'Outros';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Sexo informado: ' || v_resultado);
END;
