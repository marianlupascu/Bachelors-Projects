--P1
--Sã se determine, printr-o singurã cerere, codul ºi numele studenþilor coordonaþi de profesorul Brown, precum ºi codul 
--ºi numele cursurilor þinute de acesta. Etichetaþi coloanele „Cod” ºi „Student sau curs”.
SELECT * FROM STUDENT;
SELECT * FROM FACULTY;
SELECT * FROM COURSE;
SELECT * FROM COURSE_SECTION;
SELECT * FROM ENROLLMENT;
SELECT * FROM LOCATION;
SELECT * FROM T;
SELECT * FROM TERM;

SELECT S_ID, S_FIRST || ' ' || S_LAST "Nume"
FROM STUDENT
JOIN FACULTY USING (F_ID)
WHERE LOWER(F_LAST) = 'brown'
UNION
SELECT COURSE_NO, COURSE_NAME
FROM COURSE
JOIN COURSE_SECTION CS USING (COURSE_NO)
JOIN FACULTY USING (F_ID)
WHERE LOWER(F_LAST) = 'brown'
;

--P2
--Determinaþi studenþii (cod, nume) care au urmat un curs de Baze de date, dar nu ºi unul de Programare în C++.
SELECT S.S_ID, S.S_FIRST || ' ' || S.S_LAST "Nume"
FROM STUDENT S
JOIN ENROLLMENT E ON (E.S_ID = S.S_ID)
JOIN COURSE_SECTION CS ON (E.C_SEC_ID = CS.c_SEC_ID)
JOIN COURSE C ON (C.COURSE_NO = CS.COURSE_NO)
WHERE LOWER(C.COURSE_NAME) = 'database management'
MINUS
SELECT S.S_ID, S.S_FIRST || ' ' || S.S_LAST "Nume"
FROM STUDENT S
JOIN ENROLLMENT E ON (E.S_ID = S.S_ID)
JOIN COURSE_SECTION CS ON (E.C_SEC_ID = CS.c_SEC_ID)
JOIN COURSE C ON (C.COURSE_NO = CS.COURSE_NO)
WHERE LOWER(C.COURSE_NAME) = 'programming in c++'
;

--P3
--Determinaþi studenþii (cod, nume) care au obþinut nota C la cel puþin un examen sau care au cel puþin o notã necunoscutã.
SELECT DISTINCT S.S_ID, S.S_FIRST || ' ' || S.S_LAST "Nume"
FROM STUDENT S
JOIN ENROLLMENT E ON (E.S_ID = S.S_ID)
WHERE E.GRADE = 'C' OR E.GRADE IS NULL
;

--P4
--Afiºaþi locaþiile care au capacitate maximã (codul locaþiei, codul clãdirii, capacitatea).
SELECT LOC_ID, BLDG_CODE, CAPACITY
FROM LOCATION
WHERE CAPACITY IN (SELECT MAX(CAPACITY) FROM LOCATION)
;

--P5
--Executaþi comenzile urmãtoare:
CREATE TABLE t (id NUMBER PRIMARY KEY);
INSERT INTO t VALUES(1);
INSERT INTO t VALUES(2);
INSERT INTO t VALUES(4);
INSERT INTO t VALUES(6);
INSERT INTO t VALUES(8);
INSERT INTO t VALUES(9);

SELECT CASE (SELECT COUNT (1) FROM (
SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= (SELECT MAX(ID) FROM T)
MINUS
SELECT ID  FROM T)) 
WHEN 0 THEN (SELECT MAX(ID) + 1 FROM T) 
ELSE (
SELECT MIN (NUM) FROM (SELECT LEVEL "NUM" FROM DUAL CONNECT BY LEVEL <= (SELECT MAX(ID) FROM T)
MINUS
SELECT ID FROM T))
END "MINIM"
FROM DUAL
;

SELECT CASE (SELECT COUNT (1) FROM (
SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= (SELECT MAX(ID) FROM T)
MINUS
SELECT ID  FROM T)) 
WHEN 0 THEN (SELECT MAX(ID) + 2 FROM T) --DACA CARDINALUL VIEW-ULUI ESTE 0 MIN VA FI MAX + 1 SI MAX VA FI MAX + 2 DIN VIEW
WHEN 1 THEN (SELECT MAX(ID) + 1 FROM T) --DACA CARDINALUL VIEW-ULUI ESTE 0 MIN VA FI MINIMUL DIN VIEW SI MAX VA FI MAX + 1
ELSE (
SELECT MAX (NUM) FROM (SELECT LEVEL "NUM" FROM DUAL CONNECT BY LEVEL <= (SELECT MAX(ID) FROM T)
MINUS
SELECT ID FROM T))
END "MAXIM"
FROM DUAL
;

--P6
--Sã se obþinã un rezultat de forma: cod profesor, nume profesor, student, curs. Pentru fiecare profesor, coloanele student 
--ºi curs vor afiºa „Da” dacã existã vreun student coordonat, respectiv vreun curs prezentat de acel profesor, ºi „Nu” altfel. 
--În cazul afirmativ, se va specifica între paranteze numãrul de studenþi coordonaþi, respectiv numãrul de cursuri þinute.
SELECT F.F_ID, F.F_LAST || ' ' || F.F_FIRST "Nume", CASE(SELECT COUNT(1) FROM STUDENT S WHERE S.F_ID = F.F_ID) 
WHEN 0 THEN 'NU'
ELSE 'DA (' || (SELECT COUNT(1) FROM STUDENT S WHERE S.F_ID = F.F_ID) || ')' END "STUDENT",
CASE(SELECT COUNT(1) FROM COURSE_SECTION CS WHERE CS.F_ID = F.F_ID) 
WHEN 0 THEN 'NU'
ELSE 'DA (' || (SELECT COUNT(1) FROM COURSE_SECTION CS WHERE CS.F_ID = F.F_ID) || ')' END "CURS"
FROM FACULTY F
GROUP BY F.F_ID, F.F_LAST || ' ' || F.F_FIRST
;

--P7
--Determinaþi perechile posibile de semestre a cãror descriere (term_desc) diferã doar pe ultimul caracter.
SELECT T1.TERM_ID, T1.TERM_DESC, T2.TERM_ID, T2.TERM_DESC 
FROM  TERM T1, TERM T2
WHERE SUBSTR(T1.TERM_DESC, -1) <> SUBSTR(T2.TERM_DESC, -1);

--P8
--Determinaþi studenþii care au urmat cel puþin douã cursuri al cãror cod (course_no) diferã pe al cincilea caracter.
SELECT S.S_ID, S.S_LAST, S.S_FIRST
FROM STUDENT S
WHERE EXISTS (
SELECT 1
FROM COURSE C1
JOIN COURSE_SECTION CS1 ON (C1.COURSE_NO = CS1.COURSE_NO)
JOIN ENROLLMENT E1 ON (CS1.C_SEC_ID = E1.C_SEC_ID)
JOIN STUDENT S1 ON (S1.S_ID = E1.S_ID)
JOIN COURSE C2 ON (C1.COURSE_NO <> C2.COURSE_NO)
JOIN COURSE_SECTION CS2 ON (C2.COURSE_NO = CS2.COURSE_NO)
JOIN ENROLLMENT E2 ON (CS2.C_SEC_ID = E2.C_SEC_ID)
JOIN STUDENT S2 ON (S2.S_ID = E2.S_ID)
WHERE LOWER(SUBSTR(C1.COURSE_NAME, 5, 1)) <> LOWER(SUBSTR(C2.COURSE_NAME, 5, 1))
)
;

--P9
--Determinaþi perechile de coduri de cursuri care s-au þinut pe acelaºi semestru. Perechile se vor considera neordonate 
--(dacã se determinã (x,y), nu se va include în rezultat ºi (y, x)). Codul mai mare va fi pe prima coloanã.
SELECT DISTINCT CS1.COURSE_NO, CS2.COURSE_NO
FROM COURSE_SECTION CS1, COURSE_SECTION CS2
WHERE CS1.TERM_ID = CS2.TERM_ID AND CS1.COURSE_NO > CS2.COURSE_NO
ORDER BY 1 DESC, 2
;

--P10
--Sã se determine codul, numele cursului, denumirea semestrului ºi numãrul de locuri (max_enrl) pentru cursurile al cãror
--numãr de locuri este mai mic decât numãrul de locuri corespunzãtor oricãrui curs þinut în locaþia 1.

SELECT DISTINCT C.COURSE_NO, C.COURSE_NAME, T.TERM_DESC, CS.MAX_ENRL
FROM COURSE C
JOIN COURSE_SECTION CS ON (CS.COURSE_NO = C.COURSE_NO)
JOIN TERM T ON (T.TERM_ID = CS.TERM_ID)
WHERE CS.MAX_ENRL < ALL(SELECT COURSE_SECTION.MAX_ENRL
FROM COURSE_SECTION 
WHERE COURSE_SECTION.LOC_ID = 1)
;

--P11
--Determinaþi cursurile cu numãr minim de locuri. Se vor afiºa numele cursului ºi numãrul de locuri.
SELECT DISTINCT C.COURSE_NAME, CS.MAX_ENRL
FROM COURSE C
JOIN COURSE_SECTION CS USING (COURSE_NO)
WHERE CS.MAX_ENRL = (SELECT MIN(MAX_ENRL) FROM COURSE_SECTION)
;

--P12
--Pentru fiecare profesor, sã se afiºeze numele acestuia ºi numãrul mediu de locuri corespunzãtoare cursurilor sale.
SELECT F.F_FIRST, F.F_LAST, TRUNC((SELECT AVG(CS.MAX_ENRL) FROM COURSE_SECTION CS WHERE CS.F_ID = F.F_ID), 3) "NUMAR LOCURI"
FROM FACULTY F
;

--P13
--Determinaþi profesorii care coordoneazã cel puþin 3 studenþi. Afiºaþi numele profesorului ºi numãrul de studenþi coordonaþi.
SELECT F.F_LAST, F.F_FIRST, (SELECT COUNT(1) FROM STUDENT S WHERE S.F_ID = F.F_ID) "NUMAR STUDENTI"
FROM FACULTY F
WHERE (SELECT COUNT(1) FROM STUDENT S WHERE S.F_ID = F.F_ID) > 2
;

--P14
--Determinaþi, pentru fiecare curs, capacitatea maximã a locaþiilor în care s-a desfãºurat. Se vor afiºa numele cursului, 
--capacitatea maximã ºi codul locaþiei corespunzãtoare.
SELECT DISTINCT C.COURSE_NAME, L.CAPACITY, L.LOC_ID
FROM COURSE C
JOIN COURSE_SECTION CS ON (CS.COURSE_NO = C.COURSE_NO)
JOIN LOCATION L ON (L.LOC_ID = CS.LOC_ID)
WHERE L.CAPACITY = (SELECT MAX(CAPACITY) 
FROM LOCATION LOC 
JOIN COURSE_SECTION CSEC ON (LOC.LOC_ID = CSEC.LOC_ID) 
WHERE CSEC.COURSE_NO = CS.COURSE_NO)
;

--P15
--Pentru fiecare semestru din 2007, sã se afle valoarea medie a numãrului de locuri la cursurile din semestrul respectiv.
SELECT T.TERM_DESC, TRUNC(AVG(CS.MAX_ENRL), 3)
FROM COURSE_SECTION CS
JOIN TERM T ON (T.TERM_ID = CS.TERM_ID)
WHERE INSTR(T.TERM_DESC, '2007') <> 0
GROUP BY ROLLUP(T.TERM_DESC)
;