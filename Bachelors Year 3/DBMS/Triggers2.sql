/*
a. Creați vizualizarea v_info_mlu care va conține informații complete despre studenti, secțiile de care aparțin, notele, 
numarul total de credite și numarul de prieteni ai acestora. 

b. Definiți un declanșator prin care actualizările ce au loc asupra vizualizării se propagă automat 
în tabelele de bază (declanșator INSTEAD OF). Se consideră că au loc următoarele actualizări asupra vizualizării:
- se adaugă un student într-o secție deja existent�?;
- se elimină un student;
- se elimin�? o prietenie;
- se modifică nota unui student;
- se modific�? o prietenie;
- se modifică secția unui student (codul secției).

c. Verificați dacă declanșatorul definit funcționează corect.

d. Modificați declanșatorul definit astfel încât să permită și următoarele operații:
- se adaugă un student și secția acestuia (secția este nou�?);
- se adaugă doar o secție;
- se adaug�? o prietenie.

e. Verificați dacă declanșatorul definit funcționează corect.

f. Modificați prin intermediul vizualizării numele unui student.

g. Modificați declanșatorul definit anterior astfel încât să permită propagarea în tabelele de bază 
a actualizărilor realizate asupra numelui și prenumelui studentului, respectiv asupra numelui de secție.

h. Verificați dacă declanșatorul definit funcționează corect.
*/

SELECT * FROM student_mlu ORDER BY 1;
SELECT * FROM prieteni_mlu ORDER BY 1, 2;
SELECT * FROM profesor_mlu;
SELECT * FROM curs_mlu;
SELECT * FROM note_mlu ORDER BY 1, 2, 3;
/* a. Creați vizualizarea v_info_mlu care va conține informații complete despre studenti, secțiile de care aparțin, notele, 
numarul total de credite și numarul de prieteni ai acestora. */

-- In continuare in loc de vizualizare voi folosi tabel, deoarece nu avem privilegiile necesare pentru  acreea vizualizari
DROP TABLE v_info_mlu;

CREATE TABLE v_info_mlu AS (
    SELECT s.cod_student, s.nume, s.prenume, s.sectie, c.denumire, n.nota, c.nr_credite,
    (
        SELECT SUM (cc.nr_credite) 
        FROM note_mlu nn 
        JOIN curs_mlu cc ON (cc.cod_curs = nn.cod_curs) 
        WHERE nn.cod_student = s.cod_student AND nn.nota >= 5
    ) "NUMAR_TOTAL_CREDITE",
    (
        SELECT COUNT (1)
        FROM prieteni_mlu p
        WHERE p.cod_student1 = s.cod_student OR p.cod_student2 = s.cod_student
    ) "NUMAR_PRIETENI"
    FROM student_mlu s
    LEFT OUTER JOIN note_mlu n ON (n.cod_student = s.cod_student)
    LEFT OUTER JOIN curs_mlu c ON (c.cod_curs = n.cod_curs)
    GROUP BY s.cod_student, s.nume, s.prenume, s.sectie, c.denumire, n.nota, c.nr_credite
    
);

SELECT * FROM v_info_mlu ORDER BY 1, 5, 6;

/* b. Definiți un declanșator prin care actualizările ce au loc asupra vizualizării se propagă automat 
în tabelele de bază (declanșator INSTEAD OF). Se consideră că au loc următoarele actualizări asupra vizualizării:
- se adaugă un student într-o secție deja existent�?;
- se elimină un student;
- se modifică nota unui student;
- se modifică secția unui student (codul secției).*/
        

CREATE OR REPLACE TRIGGER trig_tv_mlu
AFTER INSERT OR DELETE OR UPDATE ON v_info_mlu
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- se adaugă un student într-o secție deja existent�?;
        INSERT INTO student_mlu (cod_student, nume, prenume, sectie, data_nasterii, nr_matricol, grupa, an, cnp)
        VALUES (:NEW.cod_student, :NEW.nume, :NEW.prenume, :NEW.sectie, null, null, null, null, null);
        
    ELSIF DELETING THEN
        -- se elimină un student;
        DELETE FROM note_mlu
        WHERE cod_student = :OLD.cod_student;
        
        DELETE FROM prieteni_mlu
        WHERE cod_student1 = :OLD.cod_student OR cod_student2 = :OLD.cod_student;
        
        DELETE FROM student_mlu
        WHERE cod_student = :OLD.cod_student;
        
    ELSIF UPDATING ('nota') THEN
        -- se modifică nota unui student;
        UPDATE note_mlu
        SET nota = :NEW.nota
        WHERE cod_student = :OLD.cod_student AND cod_curs = (
            SELECT cod_curs
            FROM curs_mlu 
            WHERE denumire = :OLD.denumire
        );
        
    ELSIF UPDATING ('sectie') THEN
        -- se modifică sectia unui student;
        UPDATE student_mlu
        SET sectie = :NEW.sectie
        WHERE cod_student = :OLD.cod_student;

    END IF;
END;
/

-- c. Verificați dacă declanșatorul definit funcționează corect.

SELECT * FROM student_mlu ORDER BY 1;
SELECT * FROM v_info_mlu ORDER BY 1, 5, 6;

INSERT INTO v_info_mlu (cod_student, nume, prenume, sectie)
VALUES (9, 'Mere-Albe', 'Yohannah', 'mate');

---------------

SELECT * FROM student_mlu ORDER BY 1;
SELECT * FROM v_info_mlu ORDER BY 1, 5, 6;
DELETE FROM v_info_mlu WHERE cod_student = 1;

---------------

SELECT * FROM note_mlu ORDER BY 1, 2, 3;
SELECT * FROM v_info_mlu ORDER BY 1, 5, 6;
UPDATE v_info_mlu SET nota = 1 WHERE cod_student = 2 AND denumire = 'analiza matematica';

---------------

SELECT * FROM student_mlu ORDER BY 1;
SELECT * FROM v_info_mlu ORDER BY 1, 5, 6;
UPDATE v_info_mlu SET sectie = 'mate' WHERE cod_student = 4;

/* d. Modificați declanșatorul definit astfel încât să permită și următoarele operații:
- se adaugă un student și secția acestuia (secția este nou�?);
- se adaugă doar o secție; */

CREATE OR REPLACE TRIGGER trig_tv_mlu
AFTER INSERT OR DELETE OR UPDATE ON v_info_mlu
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- se adaugă un student
        INSERT INTO student_mlu (cod_student, nume, prenume, sectie, data_nasterii, nr_matricol, grupa, an, cnp)
        VALUES (:NEW.cod_student, :NEW.nume, :NEW.prenume, :NEW.sectie, null, null, null, null, null);
        
    ELSIF DELETING THEN
        -- se elimină un student;
        DELETE FROM note_mlu
        WHERE cod_student = :OLD.cod_student;
        
        DELETE FROM prieteni_mlu
        WHERE cod_student1 = :OLD.cod_student OR cod_student2 = :OLD.cod_student;
        
        DELETE FROM student_mlu
        WHERE cod_student = :OLD.cod_student;
        
    ELSIF UPDATING ('nota') THEN
        -- se modifică nota unui student;
        UPDATE note_mlu
        SET nota = :NEW.nota
        WHERE cod_student = :OLD.cod_student AND cod_curs = (
            SELECT cod_curs
            FROM curs_mlu 
            WHERE denumire = :OLD.denumire
        );
        
    ELSIF UPDATING ('sectie') THEN
        -- se modifică sectia unui student;
        UPDATE student_mlu
        SET sectie = :NEW.sectie
        WHERE cod_student = :OLD.cod_student;

    END IF;
END;
/

-- e. Verificați dacă declanșatorul definit funcționează corect.
SELECT * FROM student_mlu ORDER BY 1;
SELECT * FROM v_info_mlu ORDER BY 1, 5, 6;

INSERT INTO v_info_mlu (cod_student, nume, prenume, sectie)
VALUES (10, 'Mere-Albe', 'Roberto', 'cti');

-------------------

INSERT INTO v_info_mlu (cod_student, sectie)
VALUES (11, 'mate-amplicata');

-- f. Modificați prin intermediul vizualizării numele unui student.
-- g. Modificați declanșatorul definit anterior astfel încât să permită propagarea în tabelele de bază 
-- a actualizărilor realizate asupra numelui și prenumelui studentului, respectiv asupra numelui de secție.
CREATE OR REPLACE TRIGGER trig_tv_mlu
AFTER INSERT OR DELETE OR UPDATE ON v_info_mlu
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- se adaugă un student într-o secție deja existent�?;
        INSERT INTO student_mlu (cod_student, nume, prenume, sectie, data_nasterii, nr_matricol, grupa, an, cnp)
        VALUES (:NEW.cod_student, :NEW.nume, :NEW.prenume, :NEW.sectie, null, null, null, null, null);
        
    ELSIF DELETING THEN
        -- se elimină un student;
        DELETE FROM note_mlu
        WHERE cod_student = :OLD.cod_student;
        
        DELETE FROM prieteni_mlu
        WHERE cod_student1 = :OLD.cod_student OR cod_student2 = :OLD.cod_student;
        
        DELETE FROM student_mlu
        WHERE cod_student = :OLD.cod_student;
        
    ELSIF UPDATING ('nota') THEN
        -- se modifică nota unui student;
        UPDATE note_mlu
        SET nota = :NEW.nota
        WHERE cod_student = :OLD.cod_student AND cod_curs = (
            SELECT cod_curs
            FROM curs_mlu 
            WHERE denumire = :OLD.denumire
        );
        
    ELSIF UPDATING ('sectie') THEN
        -- se modifică sectia unui student;
        UPDATE student_mlu
        SET sectie = :NEW.sectie
        WHERE cod_student = :OLD.cod_student;
        
    ELSIF UPDATING ('nume') THEN
        IF :NEW.prenume IS NULL THEN
            UPDATE student_mlu
            SET nume = :NEW.nume
            WHERE cod_student = :OLD.cod_student;
        ELSE
            UPDATE student_mlu
            SET nume = :NEW.nume, prenume = :NEW.prenume
            WHERE cod_student = :OLD.cod_student;
        END IF;

    END IF;
END;
/

-- h. Verificați dacă declanșatorul definit funcționează corect.

SELECT * FROM student_mlu ORDER BY 1;
SELECT * FROM v_info_mlu ORDER BY 1, 5, 6;
UPDATE v_info_mlu SET nume = 'Mere-Rosii', prenume = 'Fernando' WHERE cod_student = 10;

--------------------------------------------------------------------------------------------------------------------------------
drop table note_mlu cascade constraints;
drop table curs_mlu cascade constraints;
drop table student_mlu cascade constraints;
drop table profesor_mlu cascade constraints;
drop table prieteni_mlu cascade constraints;

create table student_mlu(cod_student number(4) primary key,
                    	nume varchar2(20),
					    prenume varchar2(20),
					    data_nasterii date,
					    nr_matricol varchar2(20),
					    grupa varchar2(3),
					    an number,
	                    CNP varchar2(13),
		      			sectie varchar2(20));

create table profesor_mlu(cod_profesor number(4) primary key,
					    nume varchar2(20),
					    prenume varchar2(20),
	                    data_nasterii date,
	                    data_angajarii date,
	                    titlu varchar2(20),
					    salariu number(10));

create table curs_mlu (cod_curs number(4) primary key, 
	                    denumire varchar2(20), 
					    nr_credite number(4), 
					    cod_profesor number(4) references profesor_mlu(cod_profesor));  			 	
create table note_mlu(cod_student number(4) references student_mlu(cod_student), 
                		cod_curs number(4) references curs_mlu(cod_curs), 
						nota number(4),
						data_examinare date,
						PRIMARY KEY(cod_student,cod_curs,data_examinare));

CREATE TABLE prieteni_mlu (cod_student1 NUMBER(20) NOT NULL,
                           cod_student2 NUMBER(20) NOT NULL,
                           data DATE NOT NULL,
                           CONSTRAINT fk_prieten_cod_student11 FOREIGN KEY (cod_student1) REFERENCES student_mlu(cod_student),
                           CONSTRAINT fk_prieten_cod_student22 FOREIGN KEY (cod_student2) REFERENCES student_mlu(cod_student),
                           CONSTRAINT fara_duplicatee UNIQUE (cod_student1, cod_student2));

insert into student_mlu
values(1,'Barbu','Lavinia',TO_DATE('01-02-1983','dd-mm-yyyy'),'156',421,4,'2830201893510','mate-info');


insert into student_mlu
values(8,'Sandulescu','Xenia',TO_DATE('01-02-1983','dd-mm-yyyy'),'156',421,4,'2830201893510','mate-info');

insert into student_mlu
values(2,'Anton','Maria',TO_DATE('03-03-1981','dd-mm-yyyy'),'6589',211,2,'2810303907818','mate');

insert into student_mlu
values(3,'Anton','Catalin',TO_DATE('04-05-1981','dd-mm-yyyy'),'136',221,2,'2810504568564','mate-info');

insert into student_mlu
values(4,'Busuioc','Gigi',TO_DATE('15-12-1980','dd-mm-yyyy'),'248',221,2,'2801215873510','info');

insert into student_mlu
values(5,'Antonescu','Teodor',TO_DATE('01-02-1983','dd-mm-yyyy'),'156',211,2,'2830201893510','mate-info');

insert into student_mlu
values(6,'Dragan','Dan',TO_DATE('22-05-1989','dd-mm-yyyy'),'0890',111,1,'2890522893510','mate');

insert into student_mlu
values(7,'Roman','Daniel',TO_DATE('07-06-1985','dd-mm-yyyy'),'1786',421,4,'2850706893510','mate-info');

insert into profesor_mlu
values(11,'Todorache','Petre',TO_DATE('21-03-1950','dd-mm-yyyy'),TO_DATE('01-08-1973','dd-mm-yyyy'),'profesor',3000);

insert into profesor_mlu
values(12,'Dumitrescu','Dorin',TO_DATE('24-05-1980','dd-mm-yyyy'),TO_DATE('01-08-2004','dd-mm-yyyy'),'asistent',1300);

insert into profesor_mlu
values(13,'Gheorghe','Stefan',TO_DATE('20-02-1975','dd-mm-yyyy'),TO_DATE('24-09-2000','dd-mm-yyyy'),'lector',2100);

insert into profesor_mlu
values(14,'Mares','Madalina',TO_DATE('24-06-1975','dd-mm-yyyy'),NULL,'conferentiar',4000);

insert into curs_mlu
values (31,'ecuatii',6,11);

insert into curs_mlu
values (32,'ecuatii der par',7,11);

insert into curs_mlu
values (33, 'analiza matematica',4,12);

insert into curs_mlu
values (34, 'analiza functionala', 6,12);

insert into curs_mlu
values(35,'baze de date',7, 13);

insert into curs_mlu
values(36,'retele',7,13);

insert into curs_mlu
values(37,'interfete',5,NULL);

insert into curs_mlu
values(38,'poo',15,NULL);

insert into curs_mlu
values(39,'algebra',NULL,NULL);

insert into note_mlu
values(2,32,7,TO_DATE('01-06-2007','dd-mm-yyyy'));

insert into note_mlu
values(4,33,8,TO_DATE('25-05-2006','dd-mm-yyyy'));

insert into note_mlu
values(4,34,9,TO_DATE('20-05-2007','dd-mm-yyyy'));

insert into note_mlu
values(4,35,10,TO_DATE('21-05-2007','dd-mm-yyyy'));

insert into note_mlu
values(4,36,9,TO_DATE('22-05-2007','dd-mm-yyyy'));

insert into note_mlu
values(2,33,6,TO_DATE('03-05-2007','dd-mm-yyyy'));

insert into note_mlu
values(1,35,4,TO_DATE('03-05-2005','dd-mm-yyyy'));

insert into note_mlu
values(1,35,5,TO_DATE('03-10-2005','dd-mm-yyyy'));

insert into note_mlu
values(1,36,4,TO_DATE('03-01-2004','dd-mm-yyyy'));

insert into note_mlu
values(1,36,4,TO_DATE('01-02-2004','dd-mm-yyyy'));

insert into note_mlu
values(1,36,6,TO_DATE('03-07-2004','dd-mm-yyyy'));

insert into note_mlu
values(7,35,10,TO_DATE('03-05-2005','dd-mm-yyyy'));

insert into note_mlu
values(8,35,4,TO_DATE('03-05-2005','dd-mm-yyyy'));

insert into note_mlu
values(8,37,4,TO_DATE('03-05-2005','dd-mm-yyyy'));

insert into note_mlu
values(8,37,5,TO_DATE('04-05-2005','dd-mm-yyyy'));

insert into note_mlu
values(8,36,3,TO_DATE('05-05-2006','dd-mm-yyyy'));

INSERT INTO prieteni_mlu (cod_student1, cod_student2, data) VALUES
(2, 4, '04-02-2017');

INSERT INTO prieteni_mlu (cod_student1, cod_student2, data) VALUES
(2, 5, '04-02-2017');

INSERT INTO prieteni_mlu (cod_student1, cod_student2, data) VALUES
(3, 6, '04-02-2017');

INSERT INTO prieteni_mlu (cod_student1, cod_student2, data) VALUES
(4, 5, '04-02-2017');

INSERT INTO prieteni_mlu (cod_student1, cod_student2, data) VALUES
(4, 8, '04-02-2017');

INSERT INTO prieteni_mlu (cod_student1, cod_student2, data) VALUES
(5, 6, '04-02-2017');

INSERT INTO prieteni_mlu (cod_student1, cod_student2, data) VALUES
(7, 3, '04-02-2017');

INSERT INTO prieteni_mlu (cod_student1, cod_student2, data) VALUES
(7, 8, '04-02-2017');

commit;