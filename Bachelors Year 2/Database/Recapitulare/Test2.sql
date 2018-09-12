--1. Pentru fiecare produs, sã se afiºeze denumirea sa ºi preul maxim la care este
--vândut.
SELECT * FROM PRODUSE_MLU;

SELECT P.NUME, MAX(O.PRET)
FROM PRODUSE_MLU P
LEFT OUTER JOIN OFERTE_MLU O ON (O.ID_MAGAZIN = P.ID)
GROUP BY P.NUME
;

--2. Sã se insereze un client nou în tabelul CLIENTI, având codul egal cu maximul
--codurilor existente + 1 ºi salariul egal cu media salariilor celorlali clieni.
DESC CLIENTI_MLU;
SELECT * FROM CLIENTI_MLU;
INSERT INTO CLIENTI_MLU
SELECT MAX(C.ID) + 1, 'POP', 'POPESCU', 'ONESTI', 'MARASESTI', AVG(C.SALARIU), NULL
FROM CLIENTI_MLU C
;

SELECT * FROM CLIENTI_MLU;
SELECT * FROM ACHIZITII_MLU;
SELECT ORAS FROM CLIENTI_MLU GROUP BY ORAS;

SELECT DISTINCT ID_CLIENT
FROM CLIENTI_MLU JOIN ACHIZITII_MLU ON (ID = ID_CLIENT);

--3. Sã se creeze tabelul CLIENTI_TOP, ce va avea coloanele id_client, nume, produse,
--oras ºi va conine, pentru fiecare oraº, clienii care au fãcut cele mai multe achiziii.
CREATE TABLE CLIENTI_TOP AS (
    SELECT DISTINCT C.ORAS, C.ID, C.NUME, (SELECT COUNT(1) FROM ACHIZITII_MLU WHERE ACHIZITII_MLU.ID_CLIENT = C.ID) "NUMAR PRODUSE"
    FROM CLIENTI_MLU C
    JOIN ACHIZITII_MLU A ON (A.ID_CLIENT = C.ID)
    WHERE (SELECT COUNT(1) FROM ACHIZITII_MLU WHERE ACHIZITII_MLU.ID_CLIENT = C.ID) = (
        SELECT MAX(COUNT(1)) FROM ACHIZITII_MLU A1 JOIN CLIENTI_MLU C1 ON (C1.ID = A1.ID_CLIENT) WHERE C.ORAS = C1.ORAS GROUP BY A1.ID_CLIENT)
);
DROP TABLE CLIENTI_TOP;
SELECT * FROM CLIENTI_TOP;

--4. Care sunt magazinele care pot asigura loc de parcare tuturor potenialilor clieni,
--presupunând cã aceºtia sunt cei care posedã permis de conducere ºi nu locuiesc pe
-- stradã ºi IN oraº cu magazinul respectiv?
SELECT * FROM MAGAZINE_MLU;
SELECT DISTINCT M.ID, M.NUME, M.ORAS, M.STRADA
FROM MAGAZINE_MLU M
WHERE NVL(M.CAPACITATE_PARCARE, 0) >= (SELECT COUNT(1) FROM CLIENTI_MLU C WHERE C.PERMIS_AUTO = 1 AND C.STRADA <> M.STRADA AND C.ORAS = M.ORAS)
;