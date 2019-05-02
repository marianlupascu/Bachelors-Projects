SET SERVEROUTPUT ON;

/*
Creati tabelul info_dept_*** cu urmatoarele coloane: 
- id (codul departamentului) – cheie primara; 
- nume_dept (numele departamentului); 
- plati (suma alocata pentru plata salariilor angajatilor care lucreaza în departamentul respectiv).
*/
CREATE TABLE info_dept_mlu
 (
 id NUMBER PRIMARY KEY,
 nume_dept VARCHAR2(50),
 plati NUMBER(10, 2)
 );
 
 -- a
/*
Crea?i tabelul info_emp_*** cu urmãtoarele coloane:
- id (codul angajatului) – cheie primarã;
- nume (numele angajatului);
- prenume (prenumele angajatului);
- salariu (salariul angajatului);
- id_dept (codul departamentului) – cheie externã care referã tabelul info_dept_***.
*/
CREATE TABLE info_emp_mlu
 (
 id NUMBER PRIMARY KEY,
 nume VARCHAR2(50),
 prenume VARCHAR2(50),
 salariu NUMBER(10, 2),
 id_dept NUMBER REFERENCES info_dept_mlu(id)
 );
 
 -- b. 
 -- Introduce?i date în tabelul creat anterior corespunzãtoare informa?iilor existente în schemã.
INSERT INTO info_dept_mlu
SELECT department_id, department_name, SUM(salary)
FROM departments
JOIN employees USING (department_id)
GROUP BY department_id, department_name;


INSERT INTO info_emp_mlu
SELECT employee_id, last_name, first_name, salary, department_id
FROM employees;

-- c
/*
Crea?i vizualizarea v_info_*** care va con?ine informa?ii complete despre angaja?i ?i
departamentele acestora. Folosi?i cele douã tabele create anterior, info_emp_***, respectiv
info_dept_***.
*/
CREATE OR REPLACE VIEW v_info_mlu AS
SELECT e.id Cod_ang, e.nume, e.prenume, e.salariu, d.id Cod_dep, d.nume_dept, d.plati
FROM info_emp_mlu e
JOIN info_dept_mlu d ON e.id_dept = d.id;

-- d
/*
Se pot realiza actualizãri asupra acestei vizualizãri? Care este tabelul protejat prin cheie?
Consulta?i vizualizarea user_updatable_columns.
*/
SELECT *
FROM user_updatable_columns
WHERE table_name LIKE '%MLU%';

-- 7
CREATE TABLE audit_mlu 
(
    utilizator VARCHAR2(30), 
    nume_bd VARCHAR2(50), 
    eveniment VARCHAR2(20), 
    nume_obiect VARCHAR2(30), 
    data DATE
); 

CREATE OR REPLACE TRIGGER trig7_mlu 
AFTER CREATE OR DROP OR ALTER ON SCHEMA 
BEGIN 
INSERT INTO audit_mlu 
VALUES (SYS.LOGIN_USER, SYS.DATABASE_NAME, SYS.SYSEVENT, 
SYS.DICTIONARY_OBJ_NAME, SYSDATE); 
END; 
/ 

CREATE INDEX ind_mlu ON info_emp_mlu(nume); 
DROP INDEX ind_mlu; 
SELECT * FROM audit_mlu; 

DROP TRIGGER trig7_mlu;

-- Ex1
/*
Defini?i un declan?ator care sã permitã ?tergerea informa?iilor din tabelul dept_*** decât dacã
utilizatorul este ********.
*/
CREATE TABLE dept_mlu
AS SELECT * FROM departments;

CREATE OR REPLACE TRIGGER ex1_mlu
BEFORE DELETE ON dept_mlu
BEGIN
    IF user LIKE '%GRUPA31%' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu ai drepturi de stergere');
    END IF;
END;
/

DELETE FROM dept_mlu;
DROP TRIGGER ex1_mlu;

-- Ex2
/*
Crea?i un declan?ator prin care sã nu se permitã mãrirea comisionului astfel încât sã depã?eascã
50% din valoarea salariului.
*/
CREATE OR REPLACE TRIGGER ex2_mlu
BEFORE UPDATE OF commission_pct ON emp_mlu
FOR EACH ROW -- !!
BEGIN
    IF :NEW.commission_pct > 0.5 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Comision peste 50%');
    END IF;
END;
/

UPDATE emp_mlu
SET commission_pct = 0.6;

DROP TRIGGER ex2_mlu;

-- Ex3
/*
a. Introduce?i în tabelul info_dept_*** coloana numar care va reprezenta pentru fiecare
departament numãrul de angaja?i care lucreazã în departamentul respectiv. Popula?i cu date
aceastã coloanã pe baza informa?iilor din schemã.
b. Defini?i un declan?ator care va actualiza automat aceastã coloanã în func?ie de actualizãrile
realizate asupra tabelului info_emp_***.
*/
--a
ALTER TABLE info_dept_mlu
ADD numar NUMBER;

UPDATE info_dept_mlu i
SET i.numar = (SELECT COUNT(employee_id)
               FROM employees
               WHERE department_id = i.id);
               
--b
CREATE OR REPLACE PROCEDURE p3_mlu (cod info_dept_mlu.id%TYPE,
                                    nr info_dept_mlu.numar%TYPE)
IS
BEGIN
    UPDATE info_dept_mlu
    SET numar = numar + nr
    WHERE id = cod;
END;
/

CREATE OR REPLACE TRIGGER ex3_mlu
BEFORE UPDATE OR DELETE OR INSERT ON info_emp_mlu
FOR EACH ROW -- !!
BEGIN
    IF INSERTING THEN
        p3_mlu(:NEW.id_dept, 1);
    ELSIF UPDATING THEN
        p3_mlu(:OLD.id_dept, -1);
        p3_mlu(:NEW.id_dept, 1);
    ELSIF DELETING THEN
        p3_mlu(:OLD.id_dept, -1);
    END IF;
END;
/

SELECT *
FROM info_emp_mlu;

UPDATE info_emp_mlu
SET id_dept = 50
WHERE id = 101;

SELECT *
FROM info_dept_mlu;

DELETE FROM info_emp_mlu
WHERE id = 101;

INSERT INTO info_emp_mlu
VALUES (1000, null, null, null, 90);

DROP TRIGGER ex3_mlu;

-- Ex4
/*
Defini?i un declan?ator cu ajutorul cãruia sã se implementeze restric?ia conform cãreia într-un
departament nu pot lucra mai mult de 45 persoane (se vor utiliza doar tabelele emp_*** ?i
dept_*** fãrã a modifica structura acestora).
*/
SELECT * FROM emp_mlu ORDER BY department_id;
SELECT * FROM dept_mlu;
SELECT d.department_id, d.department_name, COUNT(e.employee_id) 
FROM dept_mlu d 
JOIN emp_mlu e ON (d.department_id = e.department_id) 
GROUP BY d.department_id, d.department_name
ORDER BY 2 DESC;

CREATE OR REPLACE TRIGGER ex4_mlu
BEFORE INSERT OR UPDATE ON emp_mlu 
FOR EACH ROW
DECLARE
    v_Max_emp CONSTANT NUMBER := 45;
    v_emp_curent NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_emp_curent
    FROM emp_mlu
    WHERE department_id = :NEW.department_id;
    
    IF v_emp_curent + 1 > v_Max_emp THEN
        RAISE_APPLICATION_ERROR(-20000,'Prea multi angajati in departamentul avand codul ' || :NEW.department_id);
    END IF;
END ex4_mlu;
/

UPDATE emp_mlu
SET department_id = 50
WHERE employee_id = 202;

DROP TRIGGER ex4_mlu;

--Treggerul de deasupra nu merge ARUNCA EROAREA: tabela GRUPA31.EMP_MLU este schimbatoare, triggerul/functia nu o poate vedea

CREATE OR REPLACE PACKAGE PdepDate_mlu AS
TYPE t_cod IS TABLE OF dept_mlu.department_id%TYPE INDEX BY BINARY_INTEGER;
v_cod_dep t_cod;
v_NrIntrari BINARY_INTEGER := 0;
END PdepDate_mlu;
/

CREATE OR REPLACE TRIGGER TrLLimitaDep_mlu
BEFORE INSERT OR UPDATE ON emp_mlu
FOR EACH ROW
BEGIN
    PDepDate_mlu.v_NrIntrari := PDepDate_mlu.v_NrIntrari + 1;
    PdepDate_mlu.v_cod_dep (PdepDate_mlu.v_NrIntrari) := :NEW.department_id;
END TrLLimitaDep_mlu;
/

CREATE OR REPLACE TRIGGER TrILimitaDep_mlu
BEFORE INSERT OR UPDATE ON emp_mlu
DECLARE
    v_Max_emp CONSTANT NUMBER := 45;
    v_emp_curent NUMBER;
    v_cod_dept dept_mlu.department_id%TYPE;
BEGIN
    /* Parcurge fiecare departament inserat sau actualizat si
    verifica daca se incadreaza in limita stabilita */
    FOR v_LoopIndex IN 1..PdepDate_mlu.v_NrIntrari LOOP
    
        v_cod_dept := PdepDate_mlu.v_cod_dep(v_LoopIndex);
        
        SELECT COUNT(*)
        INTO v_emp_curent
        FROM emp_mlu
        WHERE department_id = v_cod_dept;
        
        IF v_emp_curent >= v_Max_emp THEN
            RAISE_APPLICATION_ERROR(-20000, 'Prea multi angajati in departamentul avand codul: ' || v_cod_dept);
        END IF;
    END LOOP;
    /* Reseteaza contorul deoarece urmatoarea executie
    va folosi date noi */
    PdepDate_mlu.v_NrIntrari := 0;
    
END TrILimitaDep_mlu;
/

SELECT d.department_id, d.department_name, COUNT(e.employee_id) 
FROM dept_mlu d 
JOIN emp_mlu e ON (d.department_id = e.department_id) 
GROUP BY d.department_id, d.department_name
ORDER BY 2 DESC;

UPDATE emp_mlu
SET department_id = 50
WHERE employee_id = 202;

DROP TRIGGER TrLLimitaDep_mlu;
DROP TRIGGER TrILimitaDep_mlu;

-- Ex5
/*
a. Pe baza informa?iilor din schemã crea?i ?i popula?i cu date urmãtoarele douã tabele:
- emp_test_*** (employee_id – cheie primarã, last_name, first_name, department_id);
- dept_test_*** (department_id – cheie primarã, department_name).
b. Defini?i un declan?ator care va determina ?tergeri ?i modificãri în cascadã:
- ?tergerea angaja?ilor din tabelul emp_test_*** dacã este eliminat departamentul acestora
din tabelul dept_test_***;
- modificarea codului de departament al angaja?ilor din tabelul emp_test_*** dacã
departamentul respectiv este modificat în tabelul dept_test_***.

Testa?i ?i rezolva?i problema în urmãtoarele situa?ii:
- nu este definitã constrângere de cheie externã între cele douã tabele;
- este definitã constrângerea de cheie externã între cele douã tabele;
- este definitã constrângerea de cheie externã între cele douã tabele cu op?iunea ON
DELETE CASCADE;
- este definitã constrângerea de cheie externã între cele douã tabele cu op?iunea ON
DELETE SET NULL.
Comenta?i fiecare caz în parte.
*/
-- a
CREATE TABLE emp_test_mlu
 (
    employee_id NUMBER PRIMARY KEY,
    last_name VARCHAR2(50),
    first_name VARCHAR2(50),
    department_id NUMBER
);
    
CREATE TABLE dept_test_mlu
(
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(50)
);

INSERT INTO dept_test_mlu
SELECT department_id, department_name
FROM departments;

INSERT INTO emp_test_mlu
SELECT employee_id, last_name, first_name, department_id
FROM employees;

-- b
CREATE OR REPLACE TRIGGER ex5_mlu
BEFORE UPDATE OR DELETE ON dept_test_mlu
FOR EACH ROW
BEGIN
    IF DELETING THEN
        DELETE FROM emp_test_mlu
        WHERE department_id = :OLD.department_id;
    ELSIF UPDATING('department_id') THEN
        UPDATE emp_test_mlu
        SET department_id = :NEW.department_id
        WHERE department_id = :OLD.department_id;
    END IF;
END;
/

SELECT * FROM dept_test_mlu;

DELETE FROM dept_test_mlu
WHERE department_id = 50;

SELECT *
FROM emp_test_mlu
WHERE department_id = 1000;

UPDATE dept_test_mlu
SET department_id = 1000
WHERE department_id = 50;


ALTER TABLE emp_test_mlu
ADD CONSTRAINT fk_emp_dep_test_mlu 
    FOREIGN KEY (department_id) REFERENCES dept_test_mlu(department_id)
    ON DELETE CASCADE;

DROP TRIGGER ex5_mlu;

CREATE OR REPLACE TRIGGER ex5_mlu_del_cas
BEFORE UPDATE OR DELETE ON dept_test_mlu
FOR EACH ROW
BEGIN
    IF UPDATING('department_id') THEN
        UPDATE emp_test_mlu
        SET department_id = :NEW.department_id
        WHERE department_id = :OLD.department_id;
    END IF;
END;
/

DELETE FROM dept_test_mlu
WHERE department_id = 1000;

SELECT *
FROM emp_test_mlu
WHERE department_id = 1000;
-- Pentru cazurile ON DELETE CASCADE si ON DELETE SET NULL nu este necesar un trigger care sa faca asta deoarece sistemul 
-- face asta prin definitiile de constrancere, si nu are sens sa scriem un trigger care sa faca o functionalitate pe care o 
-- face sisemul. Chiar da ca am face un trigger care sa faca asta in conditiile in care avem o constrangere de tipul 
-- ON DELETE CASCADE sau ON DELETE SET NULL voum avea problema mutating table, care trebuie rezolvata in modul specific.

-- Ex6
/*
a. Crea?i un tabel cu urmãtoarele coloane:
- user_id (SYS.LOGIN_USER);
- nume_bd (SYS.DATABASE_NAME);
- erori (DBMS_UTILITY.FORMAT_ERROR_STACK);
- data.
b. Defini?i un declan?ator sistem (la nivel de bazã de date) care sã introducã date în acest tabel
referitoare la erorile apãrute.
*/
-- a
DROP TABLE erori_mlu;
CREATE TABLE erori_mlu
 (
    id_eroare NUMBER PRIMARY KEY,
    user_id VARCHAR2(500),
    nume_bd VARCHAR2(500),
    erori VARCHAR2(2000),
    data_info DATE
);

-- b
CREATE SEQUENCE sequence_1
start with 1
increment by 1
minvalue 0
maxvalue 100
cycle;

CREATE OR REPLACE TRIGGER ex6_mlu
AFTER SERVERERROR
ON SCHEMA
BEGIN

    INSERT INTO erori_mlu VALUES (
        sequence_1.nextval,
        SYS.LOGIN_USER,
        SYS.DATABASE_NAME,
        DBMS_UTILITY.FORMAT_ERROR_STACK,
        SYSDATE
    );

END ex6_mlu;
/

SELECT * FROM erori_mlu;

DROP TRIGGER ex6_mlu;