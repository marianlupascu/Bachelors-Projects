--I
--P1 raspuns 1
SELECT LAST_NAME||','||FIRST_NAME||','||SALARY "Adress"
FROM EMPLOYEES;

--P2 raspuns A si C

--P3 raspuns C

--P4 raspuns C (semnul - (minus) nu _(underscore))

--P5 raspuns 9-mar-2009
SELECT to_char(NEXT_DAY(to_date('2-MAR-2009', 'DD-MON-YYYY'), 'MONDAY'), 'DD-MON-YY')
FROM dual;

--P6 raspuns 3 conditii in clauza WHERE

--P7 raspuns toate mai putin ceil
SELECT CEIL(to_date('2-MAR-2009', 'DD-MON-YYYY')) "Date"
FROM dual;

--II
--P1 -> 13 linii
SELECT CUST_ID, CUST_NAME
FROM CUSTOMER_TBL
WHERE CUST_STATE IN ('IN', 'OH', 'MI', 'IL') AND
(lower(CUST_NAME) LIKE '%a%' OR lower(CUST_NAME) LIKE 'b%')
ORDER BY 2;

--P2 a).
SELECT PROD_ID, PROD_DESC, COST
FROM PRODUCTS_TBL
WHERE COST BETWEEN 1 AND 12.5;

--P2 b). -> 2 linii
SELECT PROD_ID, PROD_DESC, COST
FROM PRODUCTS_TBL
WHERE COST NOT BETWEEN 1 AND 12.5;

--P3
SELECT lower(FIRST_NAME) || '.' || lower(LAST_NAME) || '@ittech.com'
FROM EMPLOYEE_TBL;

--P4
SELECT upper(first_name) || ', ' || upper(last_name) NAME, 
substr(EMP_ID, 1, 3) || '-' || substr(EMP_ID, 4, 2) || '-' || substr(EMP_ID, 6) EMP_ID, 
'(' || substr(PHONE, 1, 3) || ')' || substr(PHONE, 4, 3) || '-' || substr(PHONE, 7) PHONE
FROM EMPLOYEE_TBL;

--P5
SELECT e.EMP_ID, f.DATE_HIRE
FROM EMPLOYEE_TBL e, EMPLOYEE_PAY_TBL f
WHERE e.EMP_ID = f.EMP_ID;

--P6
SELECT e.EMP_ID, e.LAST_NAME, e.FIRST_NAME, f.SALARY, f.BONUS
FROM EMPLOYEE_TBL e, EMPLOYEE_PAY_TBL f
WHERE e.EMP_ID = f.EMP_ID;

--P7
SELECT c.CUST_NAME, o.CUST_ID, o.ORD_DATE
FROM CUSTOMER_TBL c, ORDERS_TBL o
WHERE c.CUST_ID = o.CUST_ID AND
lower(c.CUST_STATE) LIKE 'i%' ;

--P8
SELECT o.ORD_NUM, o.QTY, e.LAST_NAME, e.FIRST_NAME, e.CITY
FROM ORDERS_TBL o, EMPLOYEE_TBL e
WHERE o.SALES_REP = e.EMP_ID;

--P9
SELECT o.ORD_NUM, o.QTY, e.LAST_NAME, e.FIRST_NAME, e.CITY
FROM ORDERS_TBL o, EMPLOYEE_TBL e
WHERE o.SALES_REP = e.EMP_ID
UNION
SELECT o.ORD_NUM, o.QTY, e.LAST_NAME, e.FIRST_NAME, e.CITY
FROM ORDERS_TBL o, EMPLOYEE_TBL e
WHERE e.EMP_ID NOT IN (SELECT DISTINCT nvl(SALES_REP, 0) FROM ORDERS_TBL);

--P10
SELECT LAST_NAME, FIRST_NAME, MIDDLE_NAME
FROM EMPLOYEE_TBL
WHERE MIDDLE_NAME IS NULL;

--P11
SELECT LAST_NAME, FIRST_NAME, case (nvl(f.SALARY, 0) + nvl(f.BONUS, 0)) 
when 0 then null
else nvl(f.SALARY, 0) + nvl(f.BONUS, 0) end Salariu
FROM EMPLOYEE_TBL e, EMPLOYEE_PAY_TBL f
WHERE e.EMP_ID = f.EMP_ID;

--P12
--v1
SELECT LAST_NAME, f.SALARY, f.POSITION, 
case lower(f.POSITION) when 'marketing' then f.SALARY *1.1
                       when 'salesman' then f.SALARY *1.15
                       else f.SALARY end "Salariu modificat"
FROM EMPLOYEE_TBL e, EMPLOYEE_PAY_TBL f
WHERE e.EMP_ID = f.EMP_ID;

--v2
SELECT LAST_NAME, f.SALARY, f.POSITION, 
DECODE(lower(f.POSITION), 'marketing', f.SALARY *1.1,
                          'salesman', f.SALARY *1.15,
                          f.SALARY) "Salariu modificat"
FROM EMPLOYEE_TBL e, EMPLOYEE_PAY_TBL f
WHERE e.EMP_ID = f.EMP_ID;
