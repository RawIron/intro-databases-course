/*
   cquader1N.sql
	Quader modelliert über Hierarchie (1:N)
	Jede Flaeche genau einem Quader
	Jede Kante genau einer Flaeche
	Jeder Punkt genau einer Kante

	redundante Speicherung von Werten
*/



create table quader (
	qid	number constraint pk_quader primary key
	, name	varchar2(20) constraint nn_quader_01	not null
);

create table flaeche (
	fid	number constraint pk_flaeche primary key
	, qid	number constraint fk_flaeche_01 references quader (qid)
);

create table kante (
	kid	number constraint pk_kante primary key
	, fid	number	constraint fk_kante_01 references flaeche (fid)
	, glch_kid	number
);

create table punkt (
	pid	number	constraint pk_punkt  primary key
	, kid	number constraint fk_punkt_01 references kante (kid)
	, glch_pid	number
	, x	float constraint nn_punkt_01 not null
	, y	float constraint nn_punkt_02 not null
	, z	float constraint nn_punkt_03 not null
);


/* Lese-Rechte vergeben */
grant select on quader to public;
grant select on flaeche to public;
grant select on kante to public;
grant select on punkt to public;


/* Beispiel-Tupel einfuegen */
/* ERSTER QUADER */
insert into quader values (1, 'ERSTER');

/* 6 Flaechen */
insert into flaeche values (1, 1);
insert into flaeche values (2, 1);
insert into flaeche values (3, 1);
insert into flaeche values (4, 1);
insert into flaeche values (5, 1);
insert into flaeche values (6, 1);

/* 24 Kanten */
insert into kante values (1, 1, 1);
insert into kante values (2, 1, 2);
insert into kante values (3, 1, 3);
insert into kante values (4, 1, 4);

insert into kante values (5, 2, 9);
insert into kante values (6, 2, 10);
insert into kante values (7, 2, 11);
insert into kante values (8, 2, 12);

insert into kante values (9, 3, 2);
insert into kante values (10, 3, 7);
insert into kante values (11, 3, 10);
insert into kante values (12, 3, 6);

insert into kante values (13, 4, 3);
insert into kante values (14, 4, 7);
insert into kante values (15, 4, 11);
insert into kante values (16, 4, 8);

insert into kante values (17, 5, 4);
insert into kante values (18, 5, 8);
insert into kante values (19, 5, 12);
insert into kante values (20, 5, 5);

insert into kante values (21, 6, 1);
insert into kante values (22, 6, 6);
insert into kante values (23, 6, 9);
insert into kante values (24, 6, 5);

/* 48 Punkte */
insert into punkt values (1, 1, 1, 2.0, 3.0, 4.0);
insert into punkt values (2, 1, 2, 2.0, 3.0, 4.0);

insert into punkt values (3, 2, 2, 2.0, 3.0, 4.0);
insert into punkt values (4, 2, 3, 2.0, 3.0, 4.0);

insert into punkt values (5, 3, 3, 2.0, 3.0, 4.0);
insert into punkt values (6, 3, 4, 2.0, 3.0, 4.0);

insert into punkt values (7, 4, 4, 2.0, 3.0, 4.0);
insert into punkt values (8, 4, 1, 2.0, 3.0, 4.0);

insert into punkt values (9, 5, 5, 2.0, 3.0, 4.0);
insert into punkt values (10, 5, 6, 0.0, 0.0, 0.0);

insert into punkt values (11, 6, 6, 0.0, 0.0, 0.0);
insert into punkt values (12, 6, 7, 2.0, 3.0, 4.0);

insert into punkt values (13, 7, 7, 2.0, 3.0, 4.0);
insert into punkt values (14, 7, 8, 2.0, 3.0, 4.0);

insert into punkt values (15, 8, 8, 2.0, 3.0, 4.0);
insert into punkt values (16, 8, 5, 2.0, 3.0, 4.0);

insert into punkt values (17, 9, 2, 2.0, 3.0, 4.0);
insert into punkt values (18, 9, 3, 2.0, 3.0, 4.0);

insert into punkt values (19, 10, 3, 2.0, 3.0, 4.0);
insert into punkt values (20, 10, 7, 2.0, 3.0, 4.0);

insert into punkt values (21, 11, 7, 2.0, 3.0, 4.0);
insert into punkt values (22, 11, 6, 0.0, 0.0, 0.0);

insert into punkt values (23, 12, 6, 0.0, 0.0, 0.0);
insert into punkt values (24, 12, 2, 2.0, 3.0, 4.0);

insert into punkt values (25, 13, 3, 2.0, 3.0, 4.0);
insert into punkt values (26, 13, 4, 2.0, 3.0, 4.0);

insert into punkt values (27, 14, 3, 2.0, 3.0, 4.0);
insert into punkt values (28, 14, 7, 2.0, 3.0, 4.0);

insert into punkt values (29, 15, 7, 2.0, 3.0, 4.0);
insert into punkt values (30, 15, 8, 2.0, 3.0, 4.0);

insert into punkt values (31, 16, 4, 2.0, 3.0, 4.0);
insert into punkt values (32, 16, 8, 2.0, 3.0, 4.0);

insert into punkt values (33, 17, 4, 2.0, 3.0, 4.0);
insert into punkt values (34, 17, 1, 2.0, 3.0, 4.0);

insert into punkt values (35, 18, 4, 2.0, 3.0, 4.0);
insert into punkt values (36, 18, 8, 2.0, 3.0, 4.0);

insert into punkt values (37, 19, 8, 2.0, 3.0, 4.0);
insert into punkt values (38, 19, 5, 2.0, 3.0, 4.0);

insert into punkt values (39, 20, 1, 2.0, 3.0, 4.0);
insert into punkt values (40, 20, 5, 2.0, 3.0, 4.0);

insert into punkt values (41, 21, 1, 2.0, 3.0, 4.0);
insert into punkt values (42, 21, 2, 2.0, 3.0, 4.0);

insert into punkt values (43, 22, 2, 2.0, 3.0, 4.0);
insert into punkt values (44, 22, 6, 0.0, 0.0, 0.0);

insert into punkt values (45, 23, 5, 2.0, 3.0, 4.0);
insert into punkt values (46, 23, 6, 0.0, 0.0, 0.0);

insert into punkt values (47, 24, 1, 2.0, 3.0, 4.0);
insert into punkt values (48, 24, 5, 2.0, 3.0, 4.0);
