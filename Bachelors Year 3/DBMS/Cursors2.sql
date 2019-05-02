SET SERVEROUTPUT ON;
------------------------------------------------------------------------------------------------------------------
-----------------------------------------
------------------- 2 -------------------
-----------------------------------------
--Modificaþi exerciþiul anterior astfel încât sã obþineþi ºi urmãtoarele informaþii:
--  - un numãr de ordine pentru fiecare angajat care va fi resetat pentru fiecare job
--  - pentru fiecare job
--      o numãrul de angajaþi
--      o valoarea lunarã a veniturilor angajaþilor
--      o valoarea medie a veniturilor angajaþilor
--  - indiferent job
--      o numãrul total de angajaþi
--      o valoarea totalã lunarã a veniturilor angajaþilor
--      o valoarea medie a veniturilor angajaþilor
DECLARE
    TYPE refcursor IS REF CURSOR;
    CURSOR c_jobs IS
        SELECT job_title, 
            CURSOR (SELECT e.first_name, e.last_name, e.salary
            FROM employees e
            WHERE e.job_id = j.job_id)
        FROM jobs j  
        ORDER BY 1;
    v_nume_job jobs.job_title%TYPE;
    v_cursor refcursor;
    v_nume_emp employees.last_name%TYPE;
    v_prenume_emp employees.first_name%TYPE;
    v_salari employees.salary%TYPE;
    n NUMBER(4);
    totaPerJob employees.salary%TYPE;
    nTotal NUMBER(4) := 0;
    totaSalarii employees.salary%TYPE := 0;
BEGIN
    OPEN c_jobs;
    LOOP
        FETCH c_jobs INTO v_nume_job, v_cursor;
        EXIT WHEN c_jobs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('JOBUL '|| v_nume_job);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        n := 0;
        totaPerJob := 0;
        LOOP
            FETCH v_cursor INTO v_prenume_emp, v_nume_emp, v_salari;
            EXIT WHEN v_cursor%NOTFOUND;
            n := n + 1;
            totaPerJob := totaPerJob + v_salari;
            DBMS_OUTPUT.PUT_LINE (n || '). ' || v_nume_emp || ' ' || v_prenume_emp || ' si are salariul = ' || v_salari);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE ('PENTRU JOBUL ' || v_nume_job || ' AVEM:');
        DBMS_OUTPUT.PUT_LINE ('NUMARUL TOTAL DE ANGAJATI    = ' || n);
        DBMS_OUTPUT.PUT_LINE ('VALOAREA TOTALA A SALARIILOR = ' || totaPerJob);
        DBMS_OUTPUT.PUT_LINE ('VALOAREA MEDIE A SALARIILOR  = ' || totaPerJob / n);
        nTotal := nTotal + n;
        totaSalarii := totaSalarii + totaPerJob;
    END LOOP; 
    DBMS_OUTPUT.PUT_LINE ('_________________________________________');
    DBMS_OUTPUT.PUT_LINE ('PER TOTAL AVEM:');
    DBMS_OUTPUT.PUT_LINE ('NUMARUL TOTAL DE ANGAJATI    = ' || nTotal);
    DBMS_OUTPUT.PUT_LINE ('VALOAREA TOTALA A SALARIILOR = ' || totaSalarii);
    DBMS_OUTPUT.PUT_LINE ('VALOAREA MEDIE A SALARIILOR  = ' || totaSalarii / nTotal);
    CLOSE c_jobs;
END;
/
------------------------------------------------------------------------------------------------------------------
-----------------------------------------
------------------- 3 -------------------
-----------------------------------------
--Modificaþi exerciþiul anterior astfel încât sã obþineþi suma totalã alocatã lunar pentru plata
--salariilor ºi a comisioanelor tuturor angajaþilor, iar pentru fiecare angajat cât la sutã din aceastã
--sumã câºtigã lunar.
DECLARE
    n NUMBER := 0;
    totalSalarii employees.salary%TYPE := 0;
    totalAngajati NUMBER(4) := 0;
    totalComision NUMBER(4) := 0;
BEGIN
    SELECT
        COUNT(employee_id)
    INTO
        totalAngajati
    FROM
        employees;
        
    SELECT
        SUM(salary)
    INTO
        totalSalarii
    FROM
        employees;
        
    SELECT
        SUM(commission_pct)
    INTO
        totalComision
    FROM
        employees;
        
    DBMS_OUTPUT.PUT_LINE('TOTAL ANGAJATI  = ' || totalAngajati);
    DBMS_OUTPUT.PUT_LINE('TOTAL SALARII   = ' || totalSalarii);
    DBMS_OUTPUT.PUT_LINE('TOTAL COMISION  = ' || totalComision);
    DBMS_OUTPUT.PUT_LINE('______________________________');

    FOR i in (select e.first_name vfname, e.last_name vlname, e.salary vsalary, e.commission_pct vcommission
    from employees e
    order by 1) LOOP
        IF i.vcommission IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE(n || i.vfname || ' ' || i.vlname || ' ' || i.vsalary || ' | COMISION = ' || i.vcommission);
            DBMS_OUTPUT.PUT_LINE('Comisionul reprezinta ' || TRUNC((i.vcommission * 100) / totalcomision, 2) || '% din total');
        ELSE
            DBMS_OUTPUT.PUT_LINE(n || i.vfname || ' ' || i.vlname || ' ' || i.vsalary);
        END IF;
        DBMS_OUTPUT.PUT_LINE('Salariul reprezinta ' || TRUNC((i.vsalary * 100) / totalsalarii, 2) || '% din total');
        n := n + 1;
    END LOOP;
END;
/
------------------------------------------------------------------------------------------------------------------
-----------------------------------------
------------------- 4 -------------------
-----------------------------------------
--Modificaþi exerciþiul anterior astfel încât sã obþineþi pentru fiecare job primii 5 angajaþi care
--câºtigã cel mai mare salariu lunar. Specificaþi dacã pentru un job sunt mai puþin de 5 angajaþi.
DECLARE
    TYPE refcursor IS REF CURSOR;
    CURSOR c_jobs IS
        SELECT job_title, 
            CURSOR (SELECT e.first_name, e.last_name, e.salary
            FROM employees e
            WHERE e.job_id = j.job_id
            ORDER BY e.salary DESC)
        FROM jobs j  
        ORDER BY 1;
    v_nume_job jobs.job_title%TYPE;
    v_cursor refcursor;
    v_nume_emp employees.last_name%TYPE;
    v_prenume_emp employees.first_name%TYPE;
    v_salari employees.salary%TYPE;
    n NUMBER(4);
    total NUMBER(4);
BEGIN
    OPEN c_jobs;
    LOOP
        FETCH c_jobs INTO v_nume_job, v_cursor;
        EXIT WHEN c_jobs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('JOBUL '|| v_nume_job);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        n := 0;
        LOOP
            FETCH v_cursor INTO v_prenume_emp, v_nume_emp, v_salari;
            EXIT WHEN v_cursor%NOTFOUND;
            EXIT WHEN n = 5;
            n := n + 1;
            DBMS_OUTPUT.PUT_LINE (n || '). ' || v_nume_emp || ' ' || v_prenume_emp || ' si are salariul = ' || v_salari);
        END LOOP;
            
        SELECT count(employee_id)
        INTO total
        FROM employees e
        JOIN jobs j ON (e.job_id = j.job_id)
        WHERE j.job_title = v_nume_job;
        
        IF total > 5 THEN
            DBMS_OUTPUT.PUT_LINE ('PENTRU JOBUL CURENT EXISTA MAI MULT DE 5 ANGAJATI');
        END IF;
            
    END LOOP; 
    CLOSE c_jobs;
END;
/
------------------------------------------------------------------------------------------------------------------
-----------------------------------------
------------------- 5 -------------------
-----------------------------------------
--Modificaþi exerciþiul anterior astfel încât sã obþineþi pentru fiecare job top 5 angajaþi. Dacã
--existã mai mulþi angajaþi care respectã criteriul de selecþie care au acelaºi salariu, atunci aceºtia
--vor ocupa aceeaºi poziþie în top 5.
DECLARE
    TYPE refcursor IS REF CURSOR;
    CURSOR c_jobs IS
        SELECT job_title, 
            CURSOR (SELECT e.first_name, e.last_name, e.salary
            FROM employees e
            WHERE e.job_id = j.job_id
            ORDER BY e.salary DESC)
        FROM jobs j  
        ORDER BY 1;
    v_nume_job jobs.job_title%TYPE;
    v_cursor refcursor;
    v_nume_emp employees.last_name%TYPE;
    v_prenume_emp employees.first_name%TYPE;
    v_salari employees.salary%TYPE;
    n NUMBER(4);
    ind NUMBER(4);
    prevSalariu employees.salary%TYPE;
    total NUMBER(4);
BEGIN
    OPEN c_jobs;
    LOOP
        FETCH c_jobs INTO v_nume_job, v_cursor;
        EXIT WHEN c_jobs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('JOBUL '|| v_nume_job);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        n := 0;
        ind := 0;
        LOOP
            FETCH v_cursor INTO v_prenume_emp, v_nume_emp, v_salari;
            EXIT WHEN v_cursor%NOTFOUND;
            EXIT WHEN n = 5;
            IF n > 0 THEN
                IF prevSalariu = v_salari THEN
                    ind := ind - 1;
                END IF;
            END IF;
            n := n + 1;
            ind:= ind + 1;
            DBMS_OUTPUT.PUT_LINE (ind || '). ' || v_nume_emp || ' ' || v_prenume_emp || ' si are salariul = ' || v_salari);
            prevSalariu := v_salari;
        END LOOP;
            
        SELECT count(employee_id)
        INTO total
        FROM employees e
        JOIN jobs j ON (e.job_id = j.job_id)
        WHERE j.job_title = v_nume_job;
        
        IF total > 5 THEN
            DBMS_OUTPUT.PUT_LINE ('PENTRU JOBUL CURENT EXISTA MAI MULT DE 5 ANGAJATI');
        END IF;
            
    END LOOP; 
    CLOSE c_jobs;
END;
/