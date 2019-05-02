SET SERVEROUTPUT ON;

CREATE TABLE INFO_MLU(
    UTILIZATOR VARCHAR2(50),
    DATA DATE,
    COMANDA VARCHAR2(500),
    NR_LINII NUMBER(5),
    EROARE VARCHAR2(250)
);
TRUNCATE TABLE INFO_MLU;

---------------------------------------------
--------------------- 3 ---------------------
---------------------------------------------
--Definiþi o funcþie stocatã care determinã numãrul de angajaþi care au avut cel puþin 2 joburi
--diferite ºi care în prezent lucreazã într-un oraº dat ca parametru. Trataþi cazul în care oraºul dat
--ca parametru nu existã, respectiv cazul în care în oraºul dat nu lucreazã niciun angajat. Inseraþi
--în tabelul info_*** informaþiile corespunzãtoare fiecãrui caz determinat de valoarea datã pentru
--parametru.

CREATE OR REPLACE FUNCTION ANGAJATI2JOBURIDIFERITE (v_oras locations.city%TYPE DEFAULT 'Seattle') 
RETURN NUMBER IS 
    nr_salariati NUMBER(4);
    
    nr_orase NUMBER(4);
    NU_EXISTA_ORAS EXCEPTION;
    PREA_MULTE_ORASE EXCEPTION;
    IN_ORAS_NU_LUCREAZA_ANGAJATI EXCEPTION;
BEGIN 
    SELECT COUNT(1)
    INTO nr_orase
    FROM locations
    WHERE city = v_oras;
    
    IF nr_orase = 0 THEN
        INSERT INTO info_mlu 
        VALUES (USER, SYSDATE, 'ANGAJATI2JOBURIDIFERITE(' || v_oras || ')', 0, 'Nu exista orasul dat');
        RAISE NU_EXISTA_ORAS;
    END IF;
    
    IF nr_orase > 1 THEN
        INSERT INTO info_mlu 
        VALUES (USER, SYSDATE, 'ANGAJATI2JOBURIDIFERITE(' || v_oras || ')', 0, 'Exista mai mult de 2 orase cu numle dat');
        RAISE PREA_MULTE_ORASE;
    END IF;
    
    SELECT COUNT(e.employee_id)
    INTO nr_salariati
    FROM employees e
    JOIN departments d ON (e.department_id = d.department_id)
    JOIN locations l ON (l.location_id = d.location_id)
    WHERE l.city = v_oras;
    
    IF nr_salariati = 0 THEN
        INSERT INTO info_mlu 
        VALUES (USER, SYSDATE, 'ANGAJATI2JOBURIDIFERITE(' || v_oras || ')', 0, 'In orasul dat nu lucreaza nimeni');
        RAISE IN_ORAS_NU_LUCREAZA_ANGAJATI;
    END IF;
    
    nr_salariati := 0;
    SELECT COUNT(1)
    INTO nr_salariati
    FROM employees e
    JOIN departments d ON (e.department_id = d.department_id)
    JOIN locations l ON (l.location_id = d.location_id)
    WHERE l.city = v_oras AND (SELECT COUNT(1)
                               FROM job_history hs 
                               WHERE hs.employee_id = e.employee_id AND
                               hs.job_id <> e.job_id) > 0;
    INSERT INTO info_mlu 
    VALUES (USER, SYSDATE, 'ANGAJATI2JOBURIDIFERITE(' || v_oras || ')', 0, 'Fara eroare');
    
    RETURN nr_salariati;
    
EXCEPTION 
    WHEN NU_EXISTA_ORAS THEN 
        nr_salariati := 0;
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista orasul ' || v_oras); 
    WHEN PREA_MULTE_ORASE THEN 
        nr_salariati := 0;
        RAISE_APPLICATION_ERROR(-20001, 'Exista mai mult de 2 orase cu numle dat (' || v_oras || ')');
    WHEN IN_ORAS_NU_LUCREAZA_ANGAJATI THEN 
        nr_salariati := 0;
        RAISE_APPLICATION_ERROR(-20002, 'In orasul ' || v_oras || ' nu lucreaza nimeni'); 
    WHEN OTHERS THEN
        nr_salariati := 0;
        RAISE_APPLICATION_ERROR(-20003,'Alta eroare!'); 
END ANGAJATI2JOBURIDIFERITE;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(ANGAJATI2JOBURIDIFERITE);
END;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE(ANGAJATI2JOBURIDIFERITE('Roma'));
END;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE(ANGAJATI2JOBURIDIFERITE('Geneva'));
END;
/
SELECT * 
FROM info_mlu; 

---------------------------------------------
--------------------- 4 ---------------------
---------------------------------------------
--Definiþi o procedurã stocatã care mãreºte cu 10% salariile tuturor angajaþilor conduºi direct sau
--indirect de cãtre un manager de al cãrui cod este dat ca parametru. Trataþi cazul în care nu
--existã niciun manager cu codul dat. Inseraþi în tabelul info_*** informaþiile corespunzãtoare
---fiecãrui caz determinat de valoarea datã pentru parametru.
CREATE OR REPLACE PROCEDURE MARIRESALARII (v_id DEPARTMENTS.manager_id%TYPE)
IS
    nr_manageri NUMBER(4);
    nr_linii NUMBER(4);
    NU_EXISTA_MANAGER EXCEPTION;
BEGIN 
    SELECT COUNT(1)
    INTO nr_manageri
    FROM departments
    WHERE manager_id = v_id;
    
    IF nr_manageri = 0 THEN
        INSERT INTO info_mlu 
        VALUES (USER, SYSDATE, 'MARIRESALARII(' || v_id || ')', 0, 'Nu exista manager cu id-ul dat');
        RAISE NU_EXISTA_MANAGER;
    END IF;
    
    SELECT COUNT(1)
    INTO nr_linii
    FROM employees
    WHERE manager_id = v_id;
    
    UPDATE employees
    SET salary = salary * 1.1 
    WHERE manager_id = v_id;
    
    INSERT INTO info_mlu 
    VALUES (USER, SYSDATE, 'MARIRESALARII(' || v_id || ')', nr_linii, 'Fara eroare');
    
    DBMS_OUTPUT.PUT_LINE('Am modificat salariile'); 
    
EXCEPTION 
    WHEN NU_EXISTA_MANAGER THEN 
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista manager cu id-ul dat'); 
    WHEN OTHERS THEN 
        RAISE_APPLICATION_ERROR(-20002,'Alta eroare!'); 
END MARIRESALARII;
/

BEGIN
    MARIRESALARII(103); 
END;
/
SELECT * 
FROM info_mlu; 

---------------------------------------------
--------------------- 5 ---------------------
---------------------------------------------
--Definiþi un subprogram care obþine pentru fiecare nume de departament ziua din sãptãmânã în
--care au fost angajate cele mai multe persoane, lista cu numele acestora, vechimea ºi venitul lor
--lunar. Afiºaþi mesaje corespunzãtoare urmãtoarelor cazuri:
--  - într-un departament nu lucreazã niciun angajat;
--  - într-o zi din sãptãmânã nu a fost nimeni angajat.
--Observaþii:
--a. Numele departamentului ºi ziua apar o singurã datã în rezultat.
--b. Rezolvaþi problema în douã variante, dupã cum se þine cont sau nu de istoricul joburilor angajaþilor.

CREATE OR REPLACE FUNCTION WeekDayInt (DayOfWeekName job_history.start_date%TYPE) RETURN INT 
IS
    DayWeekNumber INT;
BEGIN
DBMS_OUTPUT.PUT_LINE(LOWER(TO_CHAR(DayOfWeekName, 'DAY')));
    CASE (LOWER(TO_CHAR(DayOfWeekName, 'DAY')))
        WHEN 'luni'     THEN DayWeekNumber := 1;
        WHEN 'marti'    THEN DayWeekNumber := 2;
        WHEN 'miercuri' THEN DayWeekNumber := 3;
        WHEN 'joi'      THEN DayWeekNumber := 4;
        WHEN 'vineri'   THEN DayWeekNumber := 5;
        WHEN 'sâmbata'  THEN DayWeekNumber := 6;
        WHEN 'duminica' THEN DayWeekNumber := 7;
    END CASE;
    RETURN DayWeekNumber;
END WeekDayInt;
/

CREATE OR REPLACE FUNCTION WeekDayString (DayOfWeek INT) RETURN VARCHAR2 
IS
    DayWeekSTRING VARCHAR2(10);
BEGIN
    CASE DayOfWeek
        WHEN 1 THEN DayWeekSTRING := 'luni';
        WHEN 2 THEN DayWeekSTRING := 'marti';
        WHEN 3 THEN DayWeekSTRING := 'miercuri';
        WHEN 4 THEN DayWeekSTRING := 'joi';
        WHEN 5 THEN DayWeekSTRING := 'vineri';
        WHEN 6 THEN DayWeekSTRING := 'sâmbata';
        WHEN 7 THEN DayWeekSTRING := 'duminica';
    END CASE;
    RETURN DayWeekSTRING;
END WeekDayString;
/

CREATE OR REPLACE PROCEDURE ZIMAXIMANGAJARI
IS
    TYPE zilearray IS VARRAY(7) OF INT; 
    NU_EXISTA_ANGAJATI EXCEPTION;
    CURSOR c IS
        SELECT d.department_id id_dep, d.department_name nume
        FROM departments d;
    zile zilearray := zilearray(0,0,0,0,0,0,0);
    zi INT;
    maxim INT;
    nr_angajati NUMBER(4);
    NU_LUCREAZA_NIMENI EXCEPTION;
    
BEGIN 

    FOR i IN c LOOP 
    
        DBMS_OUTPUT.PUT_LINE('----------- ' || i.nume || ' -----------');
    
        SELECT COUNT(1)
        INTO nr_angajati
        FROM employees
        WHERE department_id = i.id_dep;
        
        IF nr_angajati = 0 THEN
            DBMS_OUTPUT.PUT_LINE('NU LUCREAZA NIMENI');
        ELSE 
            zile := zilearray(0,0,0,0,0,0,0);
            FOR j IN (SELECT e.employee_id id_emp, hs.start_date data_angajare
                      FROM employees e 
                      JOIN job_history hs ON (hs.employee_id = e.employee_id)
                      WHERE e.department_id = i.id_dep) LOOP
                DBMS_OUTPUT.PUT_LINE(WeekDayInt(j.data_angajare));
                
                zi := WeekDayInt(j.data_angajare);
                zile(zi) := zile(zi) + 1;
            END LOOP;
            
            maxim := zile(1);
            zi := 1;
            FOR j IN 2..7 LOOP
                IF zile(j) > maxim THEN
                    maxim := zile(j);
                    zi := j;
                END IF;
            END LOOP;
            
            DBMS_OUTPUT.PUT_LINE('Ziua in care s-au angajat cele mai multe persoane este: ' || WeekDayString(zi));
            DBMS_OUTPUT.PUT_LINE('-----------' || 'informatii angajati' || '-----------');
            
            FOR j IN (SELECT e.employee_id id_emp, hs.start_date data_angajare, e.salary salariu, e.last_name nume
                      FROM employees e 
                      JOIN job_history hs ON (hs.employee_id = e.employee_id)
                      WHERE e.department_id = i.id_dep AND
                      WeekDayInt(hs.start_date) = zi) LOOP
                DBMS_OUTPUT.PUT_LINE(j.nume || ' ' || j.salariu || ' ' || TRUNC(MONTHS_BETWEEN(SYSDATE, j.data_angajare))/12);
            END LOOP;
        END IF;
    
    END LOOP;
    
EXCEPTION 
    WHEN OTHERS THEN 
        RAISE_APPLICATION_ERROR(-20002,'Alta eroare!'); 
END ZIMAXIMANGAJARI;
/

BEGIN
    ZIMAXIMANGAJARI; 
END;
/

SELECT LOWER(TO_CHAR(TO_DATE('8-10-2007', 'DD-MM-YYYY'), 'DAY')) FROM DUAL;
SELECT WeekDayInt(TO_DATE('8-10-2007', 'DD-MM-YYYY')) FROM DUAL;

---------------------------------------------
--------------------- 6 ---------------------
---------------------------------------------
--Modificaþi exerciþiul anterior astfel încât lista cu numele angajaþilor sã aparã într-un clasament creat
--în funcþie de vechimea acestora în departament. Specificaþi numãrul poziþiei din clasament ºi apoi 
--lista angajaþilor care ocupã acel loc. Dacã doi angajaþi au aceeaºi vechime, atunci aceºtia ocupã 
--aceeaºi poziþie în clasament.

CREATE OR REPLACE PROCEDURE ZIMAXIMANGAJARICLASAMENT
IS
    CURSOR c IS
        SELECT d.department_id id_dep, d.department_name nume
        FROM departments d;
    nr_angajati NUMBER(4);
    zi DATE;
    ind NUMBER(4);
    
BEGIN 

    FOR i IN c LOOP 
    
        DBMS_OUTPUT.PUT_LINE('----------- ' || i.nume || ' -----------');
    
        SELECT COUNT(1)
        INTO nr_angajati
        FROM employees
        WHERE department_id = i.id_dep;
        
        IF nr_angajati = 0 THEN
            DBMS_OUTPUT.PUT_LINE('NU LUCREAZA NIMENI');
        ELSE 
        
            SELECT ZI
            INTO zi
            FROM 
                (SELECT e.hire_date "ZI"
                FROM employees e
                WHERE e.department_id = i.id_dep AND
                    (select count(1) from employees emp where e.hire_date = emp.hire_date AND emp.department_id = i.id_dep) >= ALL 
                    (select count(1) from employees where department_id = i.id_dep group by hire_date))
            WHERE ROWNUM <= 1;
            
            DBMS_OUTPUT.PUT_LINE('Ziua in care s-au angajat cele mai multe persoane este: ' || zi);
            DBMS_OUTPUT.PUT_LINE('-----------' || 'informatii angajati' || '-----------');
            ind := 1;
            FOR j IN (SELECT e.employee_id id_emp, e.hire_date data_angajare, e.salary salariu, e.last_name nume
                      FROM employees e 
                      WHERE e.department_id = i.id_dep AND
                      e.hire_date = zi) LOOP
                DBMS_OUTPUT.PUT_LINE(ind || '). ' || j.nume || ' ' || j.salariu || ' ' || TRUNC(MONTHS_BETWEEN(SYSDATE, j.data_angajare))/12);
                ind := ind + 1;
            END LOOP;
        END IF;
    
    END LOOP;
    
EXCEPTION 
    WHEN OTHERS THEN 
        RAISE_APPLICATION_ERROR(-20002,'Alta eroare!'); 
END ZIMAXIMANGAJARICLASAMENT;
/

BEGIN
    ZIMAXIMANGAJARICLASAMENT; 
END;
/
