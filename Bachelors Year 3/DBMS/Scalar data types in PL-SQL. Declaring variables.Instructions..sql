
SET SERVEROUTPUT ON;

--6
VARIABLE rezultat VARCHAR2(35) 
BEGIN 
SELECT department_name 
INTO :rezultat
FROM employees e, departments d 
WHERE e.department_id=d.department_id 
GROUP BY department_name 
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM employees GROUP BY department_id); 
DBMS_OUTPUT.PUT_LINE('Departamentul '|| :rezultat); 
END;
/

DECLARE
numarAngajati NUMBER(3) := 0;
BEGIN 
SELECT count(1) 
INTO :numarAngajati
FROM employees e
WHERE e.department_id = (SELECT department_id FROM departments WHERE department_name = :rezultat); 
DBMS_OUTPUT.PUT_LINE('Numarul de angajati '|| :numarAngajati); 
END;
/




