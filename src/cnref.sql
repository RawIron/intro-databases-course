/*
 * cnref.sql
 *	verschachtelte De-refenrenzen anwenden
 *	zyklische Referenzen sind erlaubt
 */


/* 
 * root_t wird für Zeiger gebraucht, kann aber noch nicht
 * definiert werden.
 */
create type root_t;
/

create type leaf_t as object
(	name	number
	, inhalt	varchar2(30)
	, next	ref	root_t
);
/

create type branch_t as object
(	name number
	, inhalt	varchar2(30)
	, next	ref	leaf_t
);
/

create type root_t as object
(	name	number
	, inhalt	varchar2(30)
	, next ref	branch_t
);
/


create table leaf of leaf_t;
create table branch of branch_t;
create table root of root_t;


insert into leaf values (1, 'Wasser', NULL);
insert into leaf values (2, 'Feuer', NULL);

insert into branch values (1, 'branch Feuer',
	(select ref(l) from leaf l where l.name = 2));

insert into root values (1, 'root Feuer',
	(select ref(b) from branch b where b.name = 1));


update leaf
set next = (select ref(r) from root r where r.name = 1)
where name = 2;