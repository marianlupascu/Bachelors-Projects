SET SERVEROUTPUT ON;

-- 1
-- Men?ine?i într-o colec?ie codurile celor mai prost plãti?i 5 angaja?i care nu câ?tigã comision. Folosind aceastã colec?ie 
-- mãri?i cu 5% salariul acestor angaja?i. Afi?a?i valoarea veche a salariului, respectiv valoarea nouã a salariului.

CREATE TABLE emp_mlu
AS (SELECT * FROM employees);

DECLARE 
TYPE tablou_indexat IS TABLE OF emp_mlu.employee_id%TYPE INDEX BY PLS_INTEGER; 
t tablou_indexat;
aux emp_mlu.salary%TYPE;

BEGIN 
    SELECT id
    BULK COLLECT INTO t
    FROM (SELECT employee_id AS id
        FROM emp_mlu
        WHERE commission_pct IS NULL
        ORDER BY salary) 
    WHERE ROWNUM <= 5;
    
    DBMS_OUTPUT.PUT_LINE('Id'); 
    FOR i IN t.FIRST..t.LAST LOOP 
        IF t.EXISTS(i) THEN 
            DBMS_OUTPUT.PUT(t(i) || ' '); 
        END IF; 
    END LOOP; 
    DBMS_OUTPUT.NEW_LINE;
    
    DBMS_OUTPUT.PUT_LINE('Vechiul Salar'); 
    FOR i IN t.FIRST..t.LAST LOOP 
        IF t.EXISTS(i) THEN 
            SELECT salary
            INTO aux
            FROM emp_mlu
            WHERE employee_id = t(i);
            DBMS_OUTPUT.PUT(aux || ' '); 
        END IF; 
    END LOOP; 
    DBMS_OUTPUT.NEW_LINE;
    
    FOR i IN t.FIRST..t.LAST LOOP 
        IF t.EXISTS(i) THEN 
            UPDATE emp_mlu
            SET salary = salary * 1.05
            WHERE employee_id = t(i);
        END IF; 
    END LOOP; 
    
    DBMS_OUTPUT.PUT_LINE('Noul Salar'); 
    FOR i IN t.FIRST..t.LAST LOOP 
        IF t.EXISTS(i) THEN 
            SELECT salary
            INTO aux
            FROM emp_mlu
            WHERE employee_id = t(i);
            DBMS_OUTPUT.PUT(aux || ' '); 
        END IF; 
    END LOOP; 
    DBMS_OUTPUT.NEW_LINE;
END;
/

-- 2
-- Defini?i un tip colec?ie denumit tip_orase_***. Crea?i tabelul excursie_*** cu urmãtoarea structurã: 
-- cod_excursie NUMBER(4), denumire VARCHAR2(20), orase tip_orase_*** (ce va con?ine lista ora?elor care se 
-- viziteazã într-o excursie, într-o ordine stabilitã; de exemplu, primul ora? din listã va fi primul ora? vizitat), 
-- status (disponibilã sau anulatã).
-- a. Insera?i 5 înregistrãri în tabel.

CREATE OR REPLACE TYPE vec_orase_mlu IS VARRAY(100) OF VARCHAR2(60);
/
CREATE TABLE excursie_mlu (
    cod_ecursie NUMBER(4),
    denumire VARCHAR2(20),
    orase vec_orase_mlu,
    status VARCHAR2(20)
);
/

INSERT INTO excursie_mlu VALUES 
(1, 'Select', vec_orase_mlu('Paris', 'Grenoble', 'Geneva'), 'Disponibil');
/

INSERT INTO excursie_mlu VALUES 
(2, 'Africa', vec_orase_mlu('Casablanca', 'Tunis', 'Cairo'), 'Anulat');
/

INSERT INTO excursie_mlu VALUES 
(3, 'Japan', vec_orase_mlu('Osaka', 'Tokyo'), 'Disponibil');
/

INSERT INTO excursie_mlu VALUES 
(4, 'Comunism', vec_orase_mlu('Moscova', 'Sankt Petersburg', 'Kiev', 'Odesa'), 'Anulat');
/

INSERT INTO excursie_mlu VALUES 
(5, 'SUA', vec_orase_mlu('LA', 'San Francisco', 'Seattle', 'DC'), 'Disponibil');
/
SELECT * FROM excursie_mlu;

-- b. Actualiza?i coloana orase pentru o excursie specificatã:
-- - adãuga?i un ora? nou în listã, ce va fi ultimul vizitat în excursia respectivã;
-- - adãuga?i un ora? nou în listã, ce va fi al doilea ora? vizitat în excursia respectivã;
-- - inversa?i ordinea de vizitare a douã dintre ora?e al cãror nume este specificat;
-- - elimina?i din listã un ora? al cãrui nume este specificat.
-- c. Pentru o excursie al cãrui cod este dat, afi?a?i numãrul de ora?e vizitate, respectiv numele ora?elor.
-- d. Pentru fiecare excursie afi?a?i lista ora?elor vizitate.
-- e. Anula?i excursiile cu cele mai pu?ine ora?e vizitate.

-- - adãuga?i un ora? nou în listã, ce va fi ultimul vizitat în excursia respectivã;
DECLARE
    v_req_id NUMBER(3) := &p_req;
    v_orase EXCURSIE_MLU.ORASE%TYPE;
    
BEGIN
    SELECT orase
    INTO v_orase
    FROM excursie_mlu
    WHERE cod_ecursie = v_req_id;
    
    v_orase.EXTEND;
    v_orase(v_orase.LAST) := 'Berlin';
    
    UPDATE excursie_mlu
    SET orase = v_orase
    WHERE cod_ecursie = v_req_id;
    
END;
/
SELECT * FROM excursie_mlu;

-- - adãuga?i un ora? nou în listã, ce va fi al doilea ora? vizitat în excursia respectivã;
DECLARE
    v_req_id NUMBER(3) := &p_req;
    v_orase EXCURSIE_MLU.ORASE%TYPE;
    
BEGIN
    SELECT orase
    INTO v_orase
    FROM excursie_mlu
    WHERE cod_ecursie = v_req_id;
    
    
    v_orase.EXTEND;
    FOR i IN REVERSE 3..v_orase.COUNT LOOP 
        v_orase(i) := v_orase(i-1);
    END LOOP; 
    v_orase(2) := 'Berlin';
    
    UPDATE excursie_mlu
    SET orase = v_orase
    WHERE cod_ecursie = v_req_id;
    
END;
/
SELECT * FROM excursie_mlu;

-- - inversa?i ordinea de vizitare a douã dintre ora?e al cãror nume este specificat;
DECLARE
    v_req_id NUMBER(3) := &p_req;
    nume1 VARCHAR2(60) := &nume1;
    nume2 VARCHAR2(60) := &nume2;
    v_orase EXCURSIE_MLU.ORASE%TYPE;
    aux VARCHAR(60) := '';
    indice1 INT := 0;
    indice2 INT := 0;
    
BEGIN
DBMS_OUTPUT.PUT_LINE(nume1);

    SELECT orase
    INTO v_orase
    FROM excursie_mlu
    WHERE cod_ecursie = v_req_id;
    
    FOR i IN 1..v_orase.COUNT LOOP
        DBMS_OUTPUT.PUT(v_orase(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    
    FOR i IN 1..v_orase.COUNT LOOP 
        IF v_orase(i) = nume1 OR v_orase(i) = nume2 THEN
            indice1 := i;
            EXIT;
        END IF;
    END LOOP; 
    
    FOR i IN indice1 + 1..v_orase.COUNT LOOP 
        IF v_orase(i) = nume1 OR v_orase(i) = nume2 THEN
            indice2 := i;
            EXIT;
        END IF;
    END LOOP; 
    
    aux := v_orase(indice1);
    v_orase(indice1) := v_orase(indice2);
    v_orase(indice2) := aux;
    
    UPDATE excursie_mlu
    SET orase = v_orase
    WHERE cod_ecursie = v_req_id;
    
END;
/
SELECT * FROM excursie_mlu;

-- - elimina?i din listã un ora? al cãrui nume este specificat.
DECLARE
    v_req_id NUMBER(3) := &p_req;
    nume VARCHAR2(60) := &nume;
    v_orase EXCURSIE_MLU.ORASE%TYPE;
    indice INT := 0;
    
BEGIN

    SELECT orase
    INTO v_orase
    FROM excursie_mlu
    WHERE cod_ecursie = v_req_id;
    
    FOR i IN 1..v_orase.COUNT LOOP
        DBMS_OUTPUT.PUT(v_orase(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    
    FOR i IN 1..v_orase.COUNT LOOP 
        IF v_orase(i) = nume THEN
            indice := i;
            EXIT;
        END IF;
    END LOOP; 
    
    FOR i IN indice..v_orase.COUNT - 1 LOOP
        v_orase(i) := v_orase(i+1);
    END LOOP; 
    
    v_orase.TRIM;
    
    UPDATE excursie_mlu
    SET orase = v_orase
    WHERE cod_ecursie = v_req_id;
    
END;
/

SELECT * FROM excursie_mlu;

-- c. Pentru o excursie al cãrui cod este dat, afi?a?i numãrul de ora?e vizitate, respectiv numele ora?elor.
DECLARE
    v_req_id NUMBER(3) := &p_req;
    v_orase EXCURSIE_MLU.ORASE%TYPE;
    
BEGIN
    SELECT orase
    INTO v_orase
    FROM excursie_mlu
    WHERE cod_ecursie = v_req_id;
    
    DBMS_OUTPUT.PUT_LINE('Numar orase = ' || v_orase.COUNT);
    FOR i IN 1..v_orase.COUNT LOOP
        DBMS_OUTPUT.PUT(v_orase(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
END;
/

-- d. Pentru fiecare excursie afi?a?i lista ora?elor vizitate.
DECLARE
    v_orase EXCURSIE_MLU.ORASE%TYPE;
    TYPE tablou_indexat_cod_excursii IS TABLE OF excursie_mlu.cod_ecursie%TYPE INDEX BY PLS_INTEGER; 
    t tablou_indexat_cod_excursii;
    TYPE tablou_indexat_nume_excursii IS TABLE OF excursie_mlu.denumire%TYPE INDEX BY PLS_INTEGER; 
    d tablou_indexat_nume_excursii;
BEGIN

    SELECT cod_ecursie
    BULK COLLECT INTO t
    FROM excursie_mlu;
    
    SELECT denumire
    BULK COLLECT INTO d
    FROM excursie_mlu;

    FOR j IN 1..t.COUNT LOOP
        SELECT orase
        INTO v_orase
        FROM excursie_mlu
        WHERE cod_ecursie = t(j);
        
        DBMS_OUTPUT.PUT_LINE('Nume excursie = ' || d(j));
        DBMS_OUTPUT.PUT_LINE('Numar orase = ' || v_orase.COUNT);
        FOR i IN 1..v_orase.COUNT LOOP
            DBMS_OUTPUT.PUT(v_orase(i) || ' ');
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
END;
/

-- e. Anula?i excursiile cu cele mai pu?ine ora?e vizitate.
DECLARE
    v_orase EXCURSIE_MLU.ORASE%TYPE;
    TYPE tablou_indexat_cod_excursii IS TABLE OF excursie_mlu.cod_ecursie%TYPE INDEX BY PLS_INTEGER; 
    t tablou_indexat_cod_excursii;
    minim INT := 0;
    poz INT := 0;
BEGIN

    SELECT cod_ecursie
    BULK COLLECT INTO t
    FROM excursie_mlu;
    
    SELECT orase
    INTO v_orase
    FROM excursie_mlu
    WHERE cod_ecursie = t(1);
    minim := v_orase.COUNT;
    poz := 1;

    FOR j IN 2..t.COUNT LOOP
        SELECT orase
        INTO v_orase
        FROM excursie_mlu
        WHERE cod_ecursie = t(j);

        IF minim > v_orase.COUNT THEN
            minim := v_orase.COUNT;
            poz := j;
        END IF;
    END LOOP;
    
    UPDATE excursie_mlu
    SET status = 'Anulat'
    WHERE cod_ecursie = t(poz);
END;
/
SELECT * FROM excursie_mlu;

----------------------------------------------------------------------------------------
-- 3. 
-- Rezolva?i problema anterioarã folosind un alt tip de colec?ie studiat.
------------------------------------
-- Defini?i un tip colec?ie denumit tip_orase_***. Crea?i tabelul excursie_*** cu urmãtoarea structurã: 
-- cod_excursie NUMBER(4), denumire VARCHAR2(20), orase tip_orase_*** (ce va con?ine lista ora?elor care se 
-- viziteazã într-o excursie, într-o ordine stabilitã; de exemplu, primul ora? din listã va fi primul ora? vizitat), 
-- status (disponibilã sau anulatã).
-- a. Insera?i 5 înregistrãri în tabel.

CREATE OR REPLACE TYPE tab_imbricat_orase_mlu IS TABLE OF VARCHAR2(60);
/
CREATE TABLE excursie_mlu_tab_imbri (
    cod_ecursie NUMBER(4),
    denumire VARCHAR2(20),
    orase tab_imbricat_orase_mlu,
    status VARCHAR2(20)
)nested table orase store as nested_tab return as value;
/

INSERT INTO excursie_mlu_tab_imbri VALUES 
(1, 'Select', tab_imbricat_orase_mlu('Paris', 'Grenoble', 'Geneva'), 'Disponibil');
/

INSERT INTO excursie_mlu_tab_imbri VALUES 
(2, 'Africa', tab_imbricat_orase_mlu('Casablanca', 'Tunis', 'Cairo'), 'Anulat');
/

INSERT INTO excursie_mlu_tab_imbri VALUES 
(3, 'Japan', tab_imbricat_orase_mlu('Osaka', 'Tokyo'), 'Disponibil');
/

INSERT INTO excursie_mlu_tab_imbri VALUES 
(4, 'Comunism', tab_imbricat_orase_mlu('Moscova', 'Sankt Petersburg', 'Kiev', 'Odesa'), 'Anulat');
/

INSERT INTO excursie_mlu_tab_imbri VALUES 
(5, 'SUA', tab_imbricat_orase_mlu('LA', 'San Francisco', 'Seattle', 'DC'), 'Disponibil');
/
SELECT * FROM excursie_mlu_tab_imbri;

-- b. Actualiza?i coloana orase pentru o excursie specificatã:
-- - adãuga?i un ora? nou în listã, ce va fi ultimul vizitat în excursia respectivã;
-- - adãuga?i un ora? nou în listã, ce va fi al doilea ora? vizitat în excursia respectivã;
-- - inversa?i ordinea de vizitare a douã dintre ora?e al cãror nume este specificat;
-- - elimina?i din listã un ora? al cãrui nume este specificat.
-- c. Pentru o excursie al cãrui cod este dat, afi?a?i numãrul de ora?e vizitate, respectiv numele ora?elor.
-- d. Pentru fiecare excursie afi?a?i lista ora?elor vizitate.
-- e. Anula?i excursiile cu cele mai pu?ine ora?e vizitate.

-- - adãuga?i un ora? nou în listã, ce va fi ultimul vizitat în excursia respectivã;
DECLARE
    v_req_id NUMBER(3) := &p_req;
    v_orase excursie_mlu_tab_imbri.ORASE%TYPE;
    
BEGIN
    SELECT orase
    INTO v_orase
    FROM excursie_mlu_tab_imbri
    WHERE cod_ecursie = v_req_id;
    
    v_orase.EXTEND;
    v_orase(v_orase.LAST) := 'Berlin';
    
    UPDATE excursie_mlu_tab_imbri
    SET orase = v_orase
    WHERE cod_ecursie = v_req_id;
    
END;
/
SELECT * FROM excursie_mlu_tab_imbri;

-- - adãuga?i un ora? nou în listã, ce va fi al doilea ora? vizitat în excursia respectivã;
DECLARE
    v_req_id NUMBER(3) := &p_req;
    v_orase excursie_mlu_tab_imbri.ORASE%TYPE;
    
BEGIN
    SELECT orase
    INTO v_orase
    FROM excursie_mlu_tab_imbri
    WHERE cod_ecursie = v_req_id;
    
    
    v_orase.EXTEND;
    FOR i IN REVERSE 3..v_orase.COUNT LOOP 
        v_orase(i) := v_orase(i-1);
    END LOOP; 
    v_orase(2) := 'Berlin';
    
    UPDATE excursie_mlu_tab_imbri
    SET orase = v_orase
    WHERE cod_ecursie = v_req_id;
    
END;
/
SELECT * FROM excursie_mlu_tab_imbri;

-- - inversa?i ordinea de vizitare a douã dintre ora?e al cãror nume este specificat;
DECLARE
    v_req_id NUMBER(3) := &p_req;
    nume1 VARCHAR2(60) := &nume1;
    nume2 VARCHAR2(60) := &nume2;
    v_orase excursie_mlu_tab_imbri.ORASE%TYPE;
    aux VARCHAR(60) := '';
    indice1 INT := 0;
    indice2 INT := 0;
    
BEGIN
DBMS_OUTPUT.PUT_LINE(nume1);

    SELECT orase
    INTO v_orase
    FROM excursie_mlu_tab_imbri
    WHERE cod_ecursie = v_req_id;
    
    FOR i IN 1..v_orase.COUNT LOOP
        DBMS_OUTPUT.PUT(v_orase(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    
    FOR i IN 1..v_orase.COUNT LOOP 
        IF v_orase(i) = nume1 OR v_orase(i) = nume2 THEN
            indice1 := i;
            EXIT;
        END IF;
    END LOOP; 
    
    FOR i IN indice1 + 1..v_orase.COUNT LOOP 
        IF v_orase(i) = nume1 OR v_orase(i) = nume2 THEN
            indice2 := i;
            EXIT;
        END IF;
    END LOOP; 
    
    aux := v_orase(indice1);
    v_orase(indice1) := v_orase(indice2);
    v_orase(indice2) := aux;
    
    UPDATE excursie_mlu_tab_imbri
    SET orase = v_orase
    WHERE cod_ecursie = v_req_id;
    
END;
/
SELECT * FROM excursie_mlu_tab_imbri;

-- - elimina?i din listã un ora? al cãrui nume este specificat.
DECLARE
    v_req_id NUMBER(3) := &p_req;
    nume VARCHAR2(60) := &nume;
    v_orase excursie_mlu_tab_imbri.ORASE%TYPE;
    indice INT := 0;
    
BEGIN

    SELECT orase
    INTO v_orase
    FROM excursie_mlu_tab_imbri
    WHERE cod_ecursie = v_req_id;
    
    FOR i IN 1..v_orase.COUNT LOOP
        DBMS_OUTPUT.PUT(v_orase(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    
    FOR i IN 1..v_orase.COUNT LOOP 
        IF v_orase(i) = nume THEN
            indice := i;
            EXIT;
        END IF;
    END LOOP; 
    
    FOR i IN indice..v_orase.COUNT - 1 LOOP
        v_orase(i) := v_orase(i+1);
    END LOOP; 
    
    v_orase.TRIM;
    
    UPDATE excursie_mlu_tab_imbri
    SET orase = v_orase
    WHERE cod_ecursie = v_req_id;
    
END;
/

SELECT * FROM excursie_mlu_tab_imbri;

-- c. Pentru o excursie al cãrui cod este dat, afi?a?i numãrul de ora?e vizitate, respectiv numele ora?elor.
DECLARE
    v_req_id NUMBER(3) := &p_req;
    v_orase excursie_mlu_tab_imbri.ORASE%TYPE;
    
BEGIN
    SELECT orase
    INTO v_orase
    FROM excursie_mlu_tab_imbri
    WHERE cod_ecursie = v_req_id;
    
    DBMS_OUTPUT.PUT_LINE('Numar orase = ' || v_orase.COUNT);
    FOR i IN 1..v_orase.COUNT LOOP
        DBMS_OUTPUT.PUT(v_orase(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
END;
/

-- d. Pentru fiecare excursie afi?a?i lista ora?elor vizitate.
DECLARE
    v_orase excursie_mlu_tab_imbri.ORASE%TYPE;
    TYPE tablou_indexat_cod_excursii IS TABLE OF excursie_mlu_tab_imbri.cod_ecursie%TYPE INDEX BY PLS_INTEGER; 
    t tablou_indexat_cod_excursii;
    TYPE tablou_indexat_nume_excursii IS TABLE OF excursie_mlu_tab_imbri.denumire%TYPE INDEX BY PLS_INTEGER; 
    d tablou_indexat_nume_excursii;
BEGIN

    SELECT cod_ecursie
    BULK COLLECT INTO t
    FROM excursie_mlu_tab_imbri;
    
    SELECT denumire
    BULK COLLECT INTO d
    FROM excursie_mlu_tab_imbri;

    FOR j IN 1..t.COUNT LOOP
        SELECT orase
        INTO v_orase
        FROM excursie_mlu_tab_imbri
        WHERE cod_ecursie = t(j);
        
        DBMS_OUTPUT.PUT_LINE('Nume excursie = ' || d(j));
        DBMS_OUTPUT.PUT_LINE('Numar orase = ' || v_orase.COUNT);
        FOR i IN 1..v_orase.COUNT LOOP
            DBMS_OUTPUT.PUT(v_orase(i) || ' ');
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
END;
/

-- e. Anula?i excursiile cu cele mai pu?ine ora?e vizitate.
DECLARE
    v_orase excursie_mlu_tab_imbri.ORASE%TYPE;
    TYPE tablou_indexat_cod_excursii IS TABLE OF excursie_mlu_tab_imbri.cod_ecursie%TYPE INDEX BY PLS_INTEGER; 
    t tablou_indexat_cod_excursii;
    minim INT := 0;
    poz INT := 0;
BEGIN

    SELECT cod_ecursie
    BULK COLLECT INTO t
    FROM excursie_mlu_tab_imbri;
    
    SELECT orase
    INTO v_orase
    FROM excursie_mlu_tab_imbri
    WHERE cod_ecursie = t(1);
    minim := v_orase.COUNT;
    poz := 1;

    FOR j IN 2..t.COUNT LOOP
        SELECT orase
        INTO v_orase
        FROM excursie_mlu_tab_imbri
        WHERE cod_ecursie = t(j);

        IF minim > v_orase.COUNT THEN
            minim := v_orase.COUNT;
            poz := j;
        END IF;
    END LOOP;
    
    UPDATE excursie_mlu_tab_imbri
    SET status = 'Anulat'
    WHERE cod_ecursie = t(poz);
END;
/
SELECT * FROM excursie_mlu_tab_imbri;
