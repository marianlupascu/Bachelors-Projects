--Create tables

drop table ACHIZITII
cascade constraints;
drop table CLIENTI
cascade constraints;
drop table OFERTE
cascade constraints;
drop table PRODUSE
cascade constraints;
drop table MAGAZINE
cascade constraints;

create table MAGAZINE(
  id number(3) constraint magazine_pk primary key,
  nume varchar2(20) constraint magazine_nume_nn not null,
  oras varchar2(20) constraint magazine_oras_nn not null,
  strada varchar2(40) constraint magazine_strada_nn not null,
  ora_deschidere number(4) constraint magazine_ora_desch_nn not null,
  ora_inchidere number(4) constraint magazine_ora_inch_nn not null,
  capacitate_parcare number(5),
  plata_card number(1),
  alimentatie_publica number(1),
  transport_public number(1),
  constraint magazine_nume_oras_str_unq unique(nume, oras, strada));

create table PRODUSE(
  id number(5) constraint produse_pk primary key,
  nume varchar2(30) constraint produse_nume_nn not null,
  producator varchar2(30) constraint produse_producator_nn not null,
  tip varchar2(20) constraint produse_tip_nn not null,
  constraint produse_nume_prod_tip_unq unique(nume, producator, tip));

create table OFERTE(
  id number(8) constraint oferte_pk primary key,
  id_magazin number(3) constraint oferte_id_mag_fk references MAGAZINE (id),
  id_produs number(5) constraint oferte_id_prod_fk references PRODUSE (id),
  pret number(7,2) constraint oferte_pret_nn not null,
  promotie number(1),
  in_stoc number(1),
  constraint oferte_id_mag_prod_unq unique (id_magazin, id_produs));

create table CLIENTI(
  id number(8) constraint clienti_pk primary key,
  nume varchar2(20) constraint clienti_nume_nn not null,
  prenume varchar2(20) constraint clienti_prenume_nn not null,
  oras varchar2(20) constraint clienti_oras_nn not null,
  strada varchar2(40) constraint clienti_strada_nn not null,
  salariu number(7,2),
  permis_auto number(1),
  constraint clienti_nume_pren_str_unq unique (nume, prenume, strada));

create table ACHIZITII(
  id_client number(8) constraint achizitii_id_client_fk references CLIENTI (id),
  id_oferta number(8) constraint achizitii_id_oferta_fk references OFERTE (id),
  data date constraint achizitii_data_nn not null,
  cantitate number(5),
  constraint achizitii_id_cli_ofer_data_pk primary key (id_client, id_oferta, data));

--Populate tables

drop sequence SECVENTA_CLIENTI;
drop sequence SECVENTA_OFERTE;
drop sequence SECVENTA_PRODUSE;
drop sequence SECVENTA_MAGAZINE;

create sequence SECVENTA_MAGAZINE
start with 1
increment by 1;
create sequence SECVENTA_PRODUSE
start with 1
increment by 1;
create sequence SECVENTA_OFERTE
start with 1
increment by 1;
create sequence SECVENTA_CLIENTI
start with 1
increment by 1;

insert into MAGAZINE
values (SECVENTA_MAGAZINE.nextval, 'Carrefour', 'Bucuresti', 'Semanatorii', '0800', '2100', 230, 1, 1, null);
insert into MAGAZINE
values (SECVENTA_MAGAZINE.nextval, 'Carrefour', 'Galati', 'Florilor', '0800', '2130', 105, 0, null, 0);
insert into MAGAZINE
values (SECVENTA_MAGAZINE.nextval, 'Selgros', 'Bucuresti', 'Aviatorilor', '0900', '2100', 80, 1, 0, 0);
insert into MAGAZINE
values (SECVENTA_MAGAZINE.nextval, 'Selgros', 'Craiova', 'Pescarilor', '0930', '2100', 95, 1, 0, 1);
insert into MAGAZINE
values (SECVENTA_MAGAZINE.nextval, 'Mega Image', 'Iasi', 'Copou', '0800', '2200', null, 0, 0, 0);
insert into MAGAZINE
values (SECVENTA_MAGAZINE.nextval, 'Mega Image', 'Bucuresti', 'Patrascu Voda', '0930', '2130', 10, 1, 0, 1);
insert into MAGAZINE
values (SECVENTA_MAGAZINE.nextval, 'Metro', 'Craiova', 'Magheru', '1000', '2200', 160, 1, 0, 0);
insert into MAGAZINE
values (SECVENTA_MAGAZINE.nextval, 'Praktiker', 'Bucuresti', 'Tudor Vianu', '0900', '2130', 130, 1, null, null);
insert into MAGAZINE
values (SECVENTA_MAGAZINE.nextval, 'Auchan', 'Brasov', 'Aleea Dunarii', '0930', '2300', 95, 1, 1, 1);

insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Camasa de bumbac', 'CA', 'IMBRACAMINTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Camasa de in', 'HM', 'IMBRACAMINTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Iie', 'HM', 'IMBRACAMINTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Pantaloni scurti', 'Kenvelo', 'IMBRACAMINTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Tricou', 'Kenvelo', 'IMBRACAMINTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Cereale integrale', 'Dr Oetker', 'ALIMENTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Cereale integrale', 'Natura', 'ALIMENTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Pateu vegetal', 'Inedit', 'ALIMENTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Salata', 'Agricola', 'ALIMENTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Orez', 'Agricola', 'ALIMENTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Ciocolata cu lapte', 'Suchard', 'DULCIURI');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Prajitura Magura', 'Dobrogea', 'DULCIURI');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Biscuiti Eugenia', 'Dobrogea', 'DULCIURI');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Biscuiti cu cacao', 'Ulpio', 'DULCIURI');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Cereale de grau integral', 'Dr Oetker', 'ALIMENTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Fulgi de porumb', 'Dobrogea', 'ALIMENTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Minge de fotbal', 'NB', 'SPORT');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Manusi de fotbal', 'Nike', 'SPORT');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Manusi de box', 'Best', 'SPORT');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Adidasi', 'NB', 'INCALTAMINTE');
insert into PRODUSE
values (SECVENTA_PRODUSE.nextval, 'Pantofi negri', 'Marco', 'INCALTAMINTE');

insert into OFERTE
values (SECVENTA_OFERTE.nextval, 1, 2, 14, 0, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 1, 3, 15, null, 0);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 1, 6, 11, 0, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 2, 2, 19, 0, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 3, 4, 14, 1, 0);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 3, 7, 16, 1, 0);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 3, 8, 18, 0, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 3, 18, 18, 1, null);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 3, 20, 21, 1, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 3, 21, 23, null, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 4, 13, 15, 0, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 4, 17, 12, 0, 0);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 5, 16, 15, 1, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 5, 19, 18, 0, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 5, 21, 19, 1, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 6, 2, 13, 0, 0);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 6, 7, 13, 0, 0);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 6, 8, 15, 1, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 6, 13, 17, 1, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 7, 7, 18, 1, 0);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 9, 6, 24, 0, 0);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 9, 12, 26, 1, 0);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 9, 18, 25, 0, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 9, 19, 18, null, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 4, 4, 15, 1, 1);
insert into OFERTE
values (SECVENTA_OFERTE.nextval, 5, 7, 16, 1, 0);

insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Vasiliu', 'Marian', 'Bucuresti', 'Aviatorilor', null, 0);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Popescu', 'Marius', 'Bucuresti', 'Aleea Zavideni', 1000, 0);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Dobre', 'Andreea', 'Satu Mare', 'Academiei', null, 1);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Dobre', 'Gheorghe', 'Craiova', 'Azuga', 1250, 1);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Ionescu', 'Gheorghe', 'Iasi', 'Pietroasei', 1400, 0);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Vasilescu', 'Florin', 'Iasi', 'Vatra Luminoasa', 900, 1);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Voinea', 'Tiberiu', 'Bucuresti', 'Regina Maria', 1600, 1);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Gherghiceanu', 'George', 'Galati', 'Dobroiesti', null, 0);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Dinu', 'Daniel', 'Constanta', 'Gurghiului', 1350, 1);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Ene', 'Costin', 'Constanta', 'Foisorului', null, 0);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Ene', 'Florica', 'Bucuresti', 'Aviatorilor', null, 0);
insert into CLIENTI
values (SECVENTA_CLIENTI.nextval, 'Stamate', 'Alina', 'Brasov', 'Catargiu', 1100, 1);

insert into ACHIZITII
values (1, 1, to_date('15/03/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (1, 1, to_date('22/03/2000', 'DD/MM/YYYY'), 3);
insert into ACHIZITII
values (1, 2, to_date('18/05/2000', 'DD/MM/YYYY'), 6);
insert into ACHIZITII
values (1, 2, to_date('19/05/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (1, 3, to_date('10/02/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (1, 3, to_date('10/09/2000', 'DD/MM/YYYY'), 8);
insert into ACHIZITII
values (1, 5, to_date('12/07/2010', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (1, 8, to_date('15/12/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (2, 8, to_date('18/09/2009', 'DD/MM/YYYY'), 11);
insert into ACHIZITII
values (2, 8, to_date('14/10/2011', 'DD/MM/YYYY'), 2);
insert into ACHIZITII
values (3, 11, to_date('16/09/2010', 'DD/MM/YYYY'), 5);
insert into ACHIZITII
values (3, 13, to_date('12/02/2012', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (3, 15, to_date('10/07/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (3, 17, to_date('10/12/2001', 'DD/MM/YYYY'), 6);
insert into ACHIZITII
values (5, 2, to_date('04/07/2009', 'DD/MM/YYYY'), 6);
insert into ACHIZITII
values (5, 3, to_date('11/07/2011', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (5, 8, to_date('10/07/2000', 'DD/MM/YYYY'), 9);
insert into ACHIZITII
values (7, 3, to_date('10/07/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (7, 7, to_date('14/07/2011', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (7, 9, to_date('10/07/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (7, 12, to_date('15/09/2010', 'DD/MM/YYYY'), 13);
insert into ACHIZITII
values (9, 18, to_date('11/08/2010', 'DD/MM/YYYY'), 4);
insert into ACHIZITII
values (10, 22, to_date('10/11/2011', 'DD/MM/YYYY'), 12);
insert into ACHIZITII
values (10, 23, to_date('07/07/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (11, 3, to_date('08/12/2011', 'DD/MM/YYYY'), 7);
insert into ACHIZITII
values (11, 5, to_date('10/07/2000', 'DD/MM/YYYY'), 9);
insert into ACHIZITII
values (11, 7, to_date('10/07/2000', 'DD/MM/YYYY'), 1);
insert into ACHIZITII
values (12, 9, to_date('11/08/2000', 'DD/MM/YYYY'), 1);
insert into ACHIZITII
values (12, 11, to_date('10/02/2000', 'DD/MM/YYYY'), 5);
insert into ACHIZITII
values (12, 13, to_date('12/03/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (12, 19, to_date('10/07/2000', 'DD/MM/YYYY'), null);
insert into ACHIZITII
values (12, 20, to_date('09/08/2000', 'DD/MM/YYYY'), 14);
insert into ACHIZITII
values (12, 24, to_date('16/07/2000', 'DD/MM/YYYY'), 6);

commit;