SET SERVEROUTPUT ON;

DROP TABLE emp_mlu;
CREATE TABLE emp_mlu AS (SELECT * FROM employees);
-------------------------------------------------------------------
--1. Definiþi un pachet care sã permitã gestiunea angajaþilor companiei. Pachetul va conþine:
--a. o procedurã care determinã adãugarea unui angajat, dându-se informaþii complete despre acesta:
-- - codul angajatului va fi generat automat utilizându-se o secvenþã;
-- - informaþiile personale vor fi date ca parametrii (nume, prenume, telefon, email);
-- - data angajãrii va fi data curentã;
-- - salariul va fi cel mai mic salariu din departamentul respectiv, pentru jobul respectiv (se
--   vor obþine cu ajutorul unei funcþii stocate în pachet);
-- - nu va avea comision;
-- - codul managerului se va obþine cu ajutorul unei funcþii stocate în pachet care va avea ca
--   parametrii numele ºi prenumele managerului);
-- - codul departamentului va fi obþinut cu ajutorul unei funcþii stocate în pachet, dându-se
--   ca parametru numele acestuia;
--   - codul jobului va fi obþinut cu ajutorul unei funcþii stocate în pachet, dându-se ca parametru numele acesteia.
--   Observaþie: Trataþi toate excepþiile.
----------------------------------------------
--b. o procedurã care determinã mutarea în alt departament a unui angajat (se dau ca parametrii
--numele ºi prenumele angajatului, respectiv numele departamentului, numele jobului ºi
--numele ºi prenumele managerului acestuia):
-- - se vor actualiza informaþiile angajatului:
-- - codul de departament (se va obþine cu ajutorul funcþiei corespunzãtoare definitã la
--   punctul a);
--  - codul jobului (se va obþine cu ajutorul funcþiei corespunzãtoare definitã la punctul a);
--  - codul managerului (se va obþine cu ajutorul funcþiei corespunzãtoare definitã la punctul a);
--  - salariul va fi cel mai mic salariu din noul departament, pentru noul job dacã acesta
--    este mai mare decât salariul curent; altfel se va pãstra salariul curent;
--  - comisionul va fi cel mai mic comision din acel departament, pentru acel job;
--  - data angajãrii va fi data curentã;
--  - se vor înregistra informaþii corespunzãtoare în istoricul joburilor.
--Observaþie: Trataþi toate excepþiile.
----------------------------------------------
--c. o funcþie care întoarce numãrul de subalterni direcþi sau indirecþi ai unui angajat al cãrui
--nume ºi prenume sunt date ca parametrii;
--Observaþie: Trataþi toate excepþiile.
----------------------------------------------
--d. o procedurã care determinã promovarea unui angajat pe o treaptã imediat superioarã în
--departamentul sãu; propuneþi o variantã de restructurare a arborelui care implementeazã
--ierarhia subaltern – ºef din companie;
--Observaþie: Trataþi toate excepþiile.
----------------------------------------------
--e. o procedurã prin care se actualizeazã cu o valoare datã ca parametru salariul unui angajat al
--cãrui nume este dat ca parametru:
-- - se va verifica dacã valoarea datã pentru salariu respectã limitele impuse pentru acel job;
-- - dacã sunt mai mulþi angajaþi care au acelaºi nume, atunci se va afiºa un mesaj
--corespunzãtor ºi de asemenea se va afiºa lista acestora;
-- - dacã nu existã angajaþi cu numele dat, atunci se va afiºa un mesaj corespunzãtor;
----------------------------------------------
--f. un cursor ca obþine lista angajaþilor care lucreazã pe un job al cãrui cod este dat ca
--parametru;
----------------------------------------------
--g. un cursor care obþine lista tuturor joburilor din companie;
----------------------------------------------
--h. o procedurã care utilizeazã cele douã cursoare definite anterior ºi obþine pentru fiecare job
--numele acestuia ºi lista angajaþilor care lucreazã în prezent pe acel job; în plus, pentru
--fiecare angajat sã se specifice dacã în trecut a mai avut sau nu jobul respectiv.

CREATE OR REPLACE PACKAGE pachet_mlu AS 
    PROCEDURE p1 ( --emp_insert
                    prenume employees.first_name%TYPE,
                    nume employees.last_name%TYPE,
                    telefon employees.phone_number%TYPE,
                    email employees.email%TYPE,
                    prenume_manager employees.first_name%TYPE,
                    nume_manager employees.last_name%TYPE,
                    nume_dep departments.department_name%TYPE,
                    nume_job jobs.job_title%TYPE
                    );
                    
    PROCEDURE p2 ( --emp_update
                    prenume employees.first_name%TYPE,
                    nume employees.last_name%TYPE,
                    prenume_manager employees.first_name%TYPE,
                    nume_manager employees.last_name%TYPE,
                    nume_dep departments.department_name%TYPE,
                    nume_job jobs.job_title%TYPE
                    );
    
    FUNCTION get_job (nume_job jobs.job_title%TYPE) 
    RETURN jobs.job_id%TYPE;
    
    FUNCTION get_dep (nume_dep departments.department_name%TYPE)
    RETURN departments.department_id%TYPE;
    
    FUNCTION get_manager (prenume_manager employees.first_name%TYPE,
                          nume_manager employees.last_name%TYPE)
    RETURN employees.employee_id%TYPE;
    
    FUNCTION get_sal (job_id jobs.job_id%TYPE,
                      dep_id departments.department_id%TYPE)
    RETURN employees.salary%TYPE;
    
    FUNCTION get_comm (job_id jobs.job_id%TYPE,
                       dep_id departments.department_id%TYPE)
    RETURN employees.commission_pct%TYPE;
    
    FUNCTION get_numar_subalterni (prenume employees.first_name%TYPE,
                                   nume employees.last_name%TYPE)
    RETURN NUMBER;
    
    PROCEDURE promoveaza (prenume employees.first_name%TYPE,
                          nume employees.last_name%TYPE);
                          
    PROCEDURE set_salary (nume employees.last_name%TYPE,
                          amount employees.salary%TYPE);
                          
    --CURSOR c_emp_job(cod_job employees.job_id%TYPE) RETURN employees%ROWTYPE;
    --CURSOR c_jobs RETURN jobs%ROWTYPE;
    
    PROCEDURE p3;
    
END pachet_mlu;
/

CREATE SEQUENCE seq_mlu MINVALUE 1000 MAXVALUE 10000 START WITH 1000 INCREMENT BY 1;

CREATE OR REPLACE PACKAGE BODY pachet_mlu AS 
    PROCEDURE p1 (
                    prenume employees.first_name%TYPE,
                    nume employees.last_name%TYPE,
                    telefon employees.phone_number%TYPE,
                    email employees.email%TYPE,
                    prenume_manager employees.first_name%TYPE,
                    nume_manager employees.last_name%TYPE,
                    nume_dep departments.department_name%TYPE,
                    nume_job jobs.job_title%TYPE
                    ) IS
    v_job employees.job_id%TYPE;
    v_dep employees.department_id%TYPE;
    v_manager employees.employee_id%TYPE;
    v_sal employees.salary%TYPE;
    BEGIN
        v_job := get_job(nume_job);
        v_dep := get_dep(nume_dep);
        v_manager := get_manager(prenume_manager, nume_manager);
        v_sal := get_sal(v_job, v_dep);
        
        INSERT INTO emp_mlu 
        VALUES ( seq_mlu.NEXTVAL, prenume, nume, email, telefon, SYSDATE, v_job, v_sal, NULL, v_manager, v_dep );
        
        COMMIT;
    END p1;
    
    PROCEDURE p2 (
                    prenume employees.first_name%TYPE,
                    nume employees.last_name%TYPE,
                    prenume_manager employees.first_name%TYPE,
                    nume_manager employees.last_name%TYPE,
                    nume_dep departments.department_name%TYPE,
                    nume_job jobs.job_title%TYPE
                ) IS
    v_job employees.job_id%TYPE;
    v_dep employees.department_id%TYPE;
    v_manager employees.employee_id%TYPE;
    v_sal employees.salary%TYPE;
    v_sal_actual employees.salary%TYPE;
    v_comm employees.commission_pct%TYPE;
    BEGIN
        v_job := get_job(nume_job);
        v_dep := get_dep(nume_dep);
        v_manager := get_manager(prenume_manager, nume_manager);
        v_sal := get_sal(v_job, v_dep);
        v_comm := get_comm(v_job, v_dep);
        
        SELECT salary
        INTO v_sal_actual
        FROM emp_mlu
        WHERE first_name = prenume AND last_name = nume;
        
        IF v_sal < v_sal_actual THEN
            v_sal := v_sal_actual;
        END IF;
        
        UPDATE emp_mlu
        SET 
            department_id = v_dep,
            job_id = v_job,
            manager_id = v_manager,
            salary = v_sal,
            commission_pct = v_comm,
            hire_date = SYSDATE
        WHERE first_name = prenume AND last_name = nume;
        
        COMMIT;
    END;
    
    FUNCTION get_job (nume_job jobs.job_title%TYPE) 
    RETURN jobs.job_id%TYPE 
    IS
    v_id jobs.job_id%TYPE;
    BEGIN
        SELECT job_id
        INTO v_id
        FROM jobs
        WHERE job_title = nume_job;
        
        RETURN v_id;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001, 'Nu exista un job cu nume dat.');
        WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20002, 'Prea multe job-uri cu acest nume.');
    END get_job;
    
    FUNCTION get_dep (nume_dep departments.department_name%TYPE)
    RETURN departments.department_id%TYPE
    IS
    v_id departments.department_id%TYPE;
    BEGIN
        SELECT department_id
        INTO v_id
        FROM departments
        WHERE department_name = nume_dep;
        
        RETURN v_id;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001, 'Nu exista un dep cu nume dat.');
        WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20002, 'Prea multe dep-uri cu acest nume.');
    END;
    
    FUNCTION get_manager (prenume_manager employees.first_name%TYPE,
                          nume_manager employees.last_name%TYPE)
    RETURN employees.employee_id%TYPE
    IS
    v_id employees.employee_id%TYPE;
    BEGIN
        SELECT employee_id
        INTO v_id
        FROM employees
        WHERE first_name = prenume_manager AND last_name = nume_manager;
        
        FOR min_id IN (SELECT manager_id FROM employees) LOOP
        
            --DBMS_OUTPUT.PUT_LINE(min_id.manager_id);
        
            IF NVL(min_id.manager_id, 0) = v_id THEN 
                RETURN v_id;
            END IF;
        
        END LOOP;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001, 'Nu exista un manager cu nume dat.');
        WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20002, 'Prea multi manageri cu acest nume.');
    END;
    
    FUNCTION get_sal (job_id jobs.job_id%TYPE,
                        dep_id departments.department_id%TYPE)
    RETURN employees.salary%TYPE
    IS
    v_sal employees.salary%TYPE;
    BEGIN
    
        SELECT MIN(e.salary) 
        INTO v_sal
        FROM employees e
        WHERE e.job_id = job_id AND e.department_id = dep_id;
    
        RETURN v_sal; 
    END;
    
    FUNCTION get_comm (job_id jobs.job_id%TYPE,
                        dep_id departments.department_id%TYPE)
    RETURN employees.commission_pct%TYPE
    IS
    v_comm employees.commission_pct%TYPE;
    BEGIN
        SELECT MIN(commission_pct)
        INTO v_comm
        FROM employees e
        WHERE e.department_id = dep_id AND e.job_id = job_id;
        
        RETURN v_comm;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001, 'Nu exista un comision pentru datele introduse.');
        WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20002, 'Prea multe comisioane pentru datele introduse.');
    END;
    
    FUNCTION get_numar_subalterni (prenume employees.first_name%TYPE,
                                   nume employees.last_name%TYPE)
    RETURN NUMBER
    IS
        nr_subalerni NUMBER := 0;
        emp_id employees.employee_id%TYPE;
    BEGIN
        SELECT employee_id
        INTO emp_id
        FROM employees
        WHERE first_name = prenume AND last_name = nume;
        
        SELECT COUNT(1)
        INTO nr_subalerni
        FROM (SELECT employee_id, last_name, hire_date, salary, manager_id
              FROM emp_mlu
              START WITH employee_id=emp_id
              CONNECT BY manager_id = PRIOR employee_id);
        
        RETURN nr_subalerni;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001, 'Nu exista un angajat pentru datele introduse.');
        WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20002, 'Prea multi angajati pentru datele introduse.');
    END;
    
    PROCEDURE promoveaza (prenume employees.first_name%TYPE,
                          nume employees.last_name%TYPE)
    IS 
        emp_id employees.employee_id%TYPE;
        v_manager_id employees.manager_id%TYPE;
        v_manager_manager_id employees.manager_id%TYPE;
    BEGIN 
        SELECT employee_id
        INTO emp_id
        FROM emp_mlu
        WHERE first_name = prenume AND last_name = nume;
        
        SELECT manager_id
        INTO v_manager_id
        FROM emp_mlu
        WHERE employee_id = emp_id;
        
        IF v_manager_id IS NULL THEN
            NULL;
        ELSE
            SELECT manager_id
            INTO v_manager_manager_id
            FROM emp_mlu
            WHERE employee_id = v_manager_id;
            
            IF v_manager_manager_id IS NULL THEN
                UPDATE emp_mlu
                SET manager_id = NULL
                WHERE employee_id = emp_id;
            ELSE
                UPDATE emp_mlu
                SET manager_id = v_manager_manager_id
                WHERE employee_id = emp_id;
            END IF;
        END IF;
        
        COMMIT;
        
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajati cu numele dat'); 
        WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat'); 
        WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
    END;
    
    PROCEDURE set_salary (nume employees.last_name%TYPE,
                          amount employees.salary%TYPE)
    IS 
        emp_id employees.employee_id%TYPE;
        nr_angajati NUMBER := 0;
        min_sal jobs.min_salary%TYPE;
        max_sal jobs.max_salary%TYPE;
        v_job_id jobs.job_id%TYPE;
    BEGIN 
    
        SELECT COUNT(1)
        INTO nr_angajati
        FROM emp_mlu
        WHERE UPPER(last_name) = UPPER(nume);
        
        DBMS_OUTPUT.PUT_LINE(nr_angajati);
        
        IF nr_angajati > 1 THEN
            DBMS_OUTPUT.PUT_LINE('Exista prea multi angajati cu numele dat. Acestia sunt:');
            FOR i IN (SELECT first_name, last_name FROM emp_mlu WHERE UPPER(last_name) = UPPER(nume)) LOOP
                DBMS_OUTPUT.PUT_LINE(i.last_name || '  ' || i.first_name);
            END LOOP;
        END IF;
        
        IF nr_angajati = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat.');
        END IF;
        
        SELECT employee_id
        INTO emp_id
        FROM emp_mlu
        WHERE UPPER(last_name) = UPPER(nume);
        
        SELECT job_id
        INTO v_job_id
        FROM emp_mlu
        WHERE employee_id = emp_id;
        
        SELECT min_salary
        INTO min_sal
        FROM jobs
        WHERE job_id = v_job_id;
        
        SELECT max_salary
        INTO max_sal
        FROM jobs
        WHERE job_id = v_job_id;
        
        IF amount < min_sal OR amount > max_sal THEN
            DBMS_OUTPUT.PUT_LINE('Suma nu este eligibila pentru jobul angajatului.');
            DBMS_OUTPUT.PUT_LINE('Aceasta trebuie sa fie intre ' || min_sal || ' si ' || max_sal);
        ELSE
            UPDATE emp_mlu
            SET salary = amount
            WHERE employee_id = emp_id;
            COMMIT;
        END IF;
        
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajati cu numele dat'); 
        WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat'); 
        WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
    END;
    
    --CURSOR c_emp_job (cod_job employees.job_id%TYPE) RETURN employees%ROWTYPE
    --    IS
    --    SELECT *
    --    FROM emp_mlu
    --    WHERE job_id = cod_job;
        
    --CURSOR c_jobs RETURN jobs%ROWTYPE
    --    IS
    --    SELECT *
    --    FROM jobs;
    
    PROCEDURE p3
    IS
        CURSOR c_emp_job(cod_job employees.job_id%TYPE)
            IS
            SELECT *
            FROM emp_mlu
            WHERE job_id = cod_job;
        
        CURSOR c_jobs
            IS
            SELECT *
            FROM jobs;
        
        nr NUMBER;
    BEGIN
        FOR i IN c_jobs LOOP
            DBMS_OUTPUT.PUT_LINE('Pentru jobul ' || i.job_title || ' avem angajatii:');
            FOR j IN c_emp_job(i.job_id) LOOP
                
                SELECT COUNT(1)
                INTO nr
                FROM job_history
                WHERE employee_id = j.employee_id AND job_id = i.job_id;
                
                IF nr > 1 THEN
                    DBMS_OUTPUT.PUT_LINE('-' || j.first_name || '  ' || j.last_name || ' a mai avut in trecut jobul actual');
                ELSE
                    DBMS_OUTPUT.PUT_LINE('-' || j.first_name || '  ' || j.last_name || ' NU a mai avut in trecut jobul actual');
                END IF;
            END LOOP;
        END LOOP;
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20000, 'Nu exista angajati cu numele dat'); 
        WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi angajati cu numele dat'); 
        WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
    END;
    
END pachet_mlu;
/

--a
EXECUTE pachet_mlu.p1('prenume', 'nume', '12345678', 'mail', 'Steven', 'King', 'IT', 'Programmer');
SELECT * FROM emp_mlu;

--b
EXECUTE pachet_mlu.p2('prenume', 'nume', 'Lex', 'De Haan', 'Executive', 'Administration Vice President');
SELECT * FROM emp_mlu;

--c
BEGIN
DBMS_OUTPUT.PUT_LINE('Numar subalterini = ' || pachet_mlu.get_numar_subalterni('Steven', 'King'));
END;
/

--d
EXECUTE pachet_mlu.promoveaza('Shelli', 'Baida');
SELECT * FROM emp_mlu ORDER BY department_id;

--e
EXECUTE pachet_mlu.set_salary('Smith', 1000);
EXECUTE pachet_mlu.set_salary('Abel', 1000000);
EXECUTE pachet_mlu.set_salary('Abel', 7000);
SELECT * FROM emp_mlu ORDER BY last_name;

--f
BEGIN
    FOR i IN pachet_mlu.c_emp_job('SA_REP') LOOP
        DBMS_OUTPUT.PUT_LINE(i.last_name||' '|| i.first_name);
    END LOOP;
END;
/ -- daca vreti sa va uitati putin pe cursoare, nu stiu de ne nu merg. Trebuie sa decomentai mai intai in packet

--g
BEGIN
    FOR i IN pachet_mlu.c_jobs LOOP
        DBMS_OUTPUT.PUT_LINE(i.job_title);
    END LOOP;
END;
/ -- daca vreti sa va uitati putin pe cursoare, nu stiu de ne nu merg. Trebuie sa decomentai mai intai in packet

--h
EXECUTE pachet_mlu.p3;