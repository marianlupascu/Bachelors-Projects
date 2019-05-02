SET SERVEROUTPUT ON;
------------------------------------------------------------------------------------------------------------------
-----------------------------------------
------------------- 1 -------------------
-----------------------------------------
--Pentru fiecare job (titlu – care va fi afiºat o singurã datã) obþineþi lista angajaþilor (nume ºi
--salariu) care lucreazã în prezent pe jobul respectiv. Trataþi cazul în care nu existã angajaþi care
--sã lucreze în prezent pe un anumit job. Rezolvaþi problema folosind:
--a. cursoare clasice
select j.job_title, e.first_name, e.last_name, e.salary
from jobs j
left outer join employees e on (e.job_id = j.job_id)
order by 1;

--b. ciclu cursoare
DECLARE
    CURSOR c IS
    select j.job_title vjob, e.first_name vfname, e.last_name vlname, e.salary vsalary, COUNT(employee_id) nr
    from jobs j
    left outer join employees e on (e.job_id = j.job_id)
    group by j.job_title, e.first_name, e.last_name, e.salary
    order by 1;
    n NUMBER := 1;
BEGIN
    FOR i in c LOOP
        IF i.nr=0 THEN
            DBMS_OUTPUT.PUT_LINE(n || '| Pe jobul '|| i.vjob|| ' nu lucreaza angajati');
        ELSE       
            DBMS_OUTPUT.PUT_LINE(n || '|Pe jobul '|| i.vjob|| ' lucreaza angajatul '|| i.vfname || ' ' || i.vlname || ' ' || i.vsalary);
        END IF;
        n := n + 1;
    END LOOP;
END;
/
--c. ciclu cursoare cu subcereri
DECLARE
    n NUMBER := 1;
BEGIN
    FOR i in (select j.job_title vjob, e.first_name vfname, e.last_name vlname, e.salary vsalary, COUNT(employee_id) nr
    from jobs j
    left outer join employees e on (e.job_id = j.job_id)
    group by j.job_title, e.first_name, e.last_name, e.salary
    order by 1) LOOP
        IF i.nr=0 THEN
            DBMS_OUTPUT.PUT_LINE(n || '| Pe jobul '|| i.vjob|| ' nu lucreaza angajati');
        ELSE       
            DBMS_OUTPUT.PUT_LINE(n || '|Pe jobul '|| i.vjob|| ' lucreaza angajatul '|| i.vfname || ' ' || i.vlname || ' ' || i.vsalary);
        END IF;
        n := n + 1;
    END LOOP;
END;
/

--d. expresii cursor
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
BEGIN
    OPEN c_jobs;
    LOOP
        FETCH c_jobs INTO v_nume_job, v_cursor;
        EXIT WHEN c_jobs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('JOBUL '|| v_nume_job);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        LOOP
            FETCH v_cursor INTO v_prenume_emp, v_nume_emp, v_salari;
            EXIT WHEN v_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE (v_nume_emp || ' ' || v_prenume_emp || ' si are salariul = ' || v_salari);
        END LOOP;
    END LOOP; 
    CLOSE c_jobs;
END;
/