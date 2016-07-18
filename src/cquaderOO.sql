/*
 *  cquaderOO.sql
 *	Objekttabellen zur redundanzfreien Speicherung eines Quaders
 *	set of referenzen
 */



create type punkt_t as object
(	pid	number
	, x	real
	, y	real
	, z	real
)
/
create table punkt_o of punkt_t
/
create type ptr_punkt_t as object
(	ptr_punkt	ref	punkt_t
)
/
create type setof_punkt_t as table of ptr_punkt_t
/



create type kante_t as object
(	kid	number
	, setof_punkt	setof_punkt_t
)
/
create table kante_o of kante_t
	nested table setof_punkt store as setof_punkt_str
/
create type ptr_kante_t as object
(	ptr_kante	ref	kante_t
)
/
create type setof_kante_t as table of ptr_kante_t
/



create type flaeche_t as object
(	fid	number
	, farbe	char(5)
	/*, kante	ptr_kante_t */
	, setof_kante	setof_kante_t
)
/
create table flaeche_o of flaeche_t
	nested table setof_kante store as setof_kante_str
/

create type ptr_flaeche_t as object
(	ptr_flaeche	ref	flaeche_t
)
/
create type setof_flaeche_t as table of ptr_flaeche_t
/



create type quader_t as object
(	qid	number
	, name	varchar2(20)
	, setof_flaeche	setof_flaeche_t
)
/

create table quader_o of quader_t
	nested table setof_flaeche store as setof_flaeche_str
/




/*
 * Objekttabellen fuellen
 */
insert into punkt_o values (1, 1.0, 2.0, 3.0);
insert into punkt_o values (2, 1.0, 2.0, 3.0);
insert into punkt_o values (3, 1.0, 2.0, 3.0);
insert into punkt_o values (4, 1.0, 2.0, 3.0);
insert into punkt_o values (5, 1.0, 2.0, 3.0);
insert into punkt_o values (6, 0.0, 0.0, 0.0);
insert into punkt_o values (7, 1.0, 2.0, 3.0);
insert into punkt_o values (8, 1.0, 2.0, 3.0);

insert into kante_o values (1, setof_punkt_t());
insert into kante_o values (2, setof_punkt_t());
insert into kante_o values (3, setof_punkt_t());
insert into kante_o values (4, setof_punkt_t());
insert into kante_o values (5, setof_punkt_t());
insert into kante_o values (6, setof_punkt_t());
insert into kante_o values (7, setof_punkt_t());
insert into kante_o values (8, setof_punkt_t());
insert into kante_o values (9, setof_punkt_t());
insert into kante_o values (10, setof_punkt_t());
insert into kante_o values (11, setof_punkt_t());
insert into kante_o values (12, setof_punkt_t());

insert into flaeche_o values (1, 'ROT', setof_kante_t());
insert into flaeche_o values (2, 'ROT', setof_kante_t());
insert into flaeche_o values (3, 'GRUEN', setof_kante_t());
insert into flaeche_o values (4, 'BLAU', setof_kante_t());
insert into flaeche_o values (5, 'GRUEN', setof_kante_t());
insert into flaeche_o values (6, 'BLAU', setof_kante_t());

insert into quader_o values (1, 'ERSTER', setof_flaeche_t());


/*
 * SET OF Referenzen fuellen
 */

/*
 * Quader seine 6 Flaechen
 */
insert into table (
	select q.setof_flaeche
	from quader_o q
	where q.qid = 1
	)
	select ref(f)
	from flaeche_o f
	where f.fid between 1 and 6;


/*
 *  6 Flaechen ihre 4 Kanten
 */
insert into table (
	select f.setof_kante
	from flaeche_o f
	where f.fid = 1
	)
	select ref(k)
	from kante_o k
	where k.kid in (1, 2, 3, 4);

insert into table (
	select f.setof_kante
	from flaeche_o f
	where f.fid = 2
	)
	select ref(k)
	from kante_o k
	where k.kid in (9, 10, 11, 12);

insert into table (
	select f.setof_kante
	from flaeche_o f
	where f.fid = 3
	)
	select ref(k)
	from kante_o k
	where k.kid in (2, 7, 10, 6);

insert into table (
	select f.setof_kante
	from flaeche_o f
	where f.fid = 4
	)
	select ref(k)
	from kante_o k
	where k.kid in (3, 7, 11, 8);

insert into table (
	select f.setof_kante
	from flaeche_o f
	where f.fid = 5
	)
	select ref(k)
	from kante_o k
	where k.kid in (4, 8, 12, 5);

insert into table (
	select f.setof_kante
	from flaeche_o f
	where f.fid = 6
	)
	select ref(k)
	from kante_o k
	where k.kid in (1, 6, 9, 5);


/*
 *   12 Kanten ihre 2 Punkte
 */
insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 1
	)
	select ref(p)
	from punkt_o p
	where p.pid in (1, 2);

insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 2
	)
	select ref(p)
	from punkt_o p
	where p.pid in (2, 3);

insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 3
	)
	select ref(p)
	from punkt_o p
	where p.pid in (3, 4);

insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 4
	)
	select ref(p)
	from punkt_o p
	where p.pid in (4, 1);


insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 5
	)
	select ref(p)
	from punkt_o p
	where p.pid in (1, 5);


insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 6
	)
	select ref(p)
	from punkt_o p
	where p.pid in (2, 6);


insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 7
	)
	select ref(p)
	from punkt_o p
	where p.pid in (3, 7);


insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 8
	)
	select ref(p)
	from punkt_o p
	where p.pid in (6, 8);


insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 9
	)
	select ref(p)
	from punkt_o p
	where p.pid in (5, 6);


insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 10
	)
	select ref(p)
	from punkt_o p
	where p.pid in (6, 7);


insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 11
	)
	select ref(p)
	from punkt_o p
	where p.pid in (7, 8);


insert into table (
	select k.setof_punkt
	from kante_o k
	where k.kid = 12
	)
	select ref(p)
	from punkt_o p
	where p.pid in (5, 8);