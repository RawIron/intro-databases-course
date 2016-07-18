/*
 * Musterloesungen zu 3.Uebung zu SQL-2
 */


drop table Artikel;
drop table Artikelart;


/*
 * Zuerst ArtikelArt anlegen
 */
create table ArtikelArt (
	rtklrt_id	number
		constraint pk_ArtikelArt primary key
	, rtklrt_name	varchar2(25)
		constraint nn_ArtikelArt_01 not null
	, rtklrt_ware	char(5)
		constraint nn_ArtikelArt_02 not null
		constraint ck_ArtikelArt_01
			check (rtklrt_ware in ('REGAL', 'KUEHL'))
	, rtklrt_verderblich	char(1)
		constraint nn_ArtikelArt_03 not null
		constraint ck_ArtikelArt_02
			check (rtklrt_verderblich in ('T', 'F'))
	, rtklrt_zerbrechlich	char(1)
		constraint ck_ArtikelArt_03
			check (rtklrt_zerbrechlich in ('T', 'F'))
	, rtklrt_zustand	char(8)
		constraint ck_ArtikelArt_04 
			check (rtklrt_zustand in ('FEST', 'FLUESSIG'))
);


/*
 * jetzt kann Artikel den Fremdschluessel aus ArtikelArt definieren
 */
create table Artikel (
	rtkl_id		number
		constraint pk_Artikel primary key
	, rtkl_art	number
		constraint fk_Artikel_01 references ArtikelArt (rtklrt_id)
	, rtkl_name	varchar2(25)
		constraint nn_Artikel_01 not null
	, rtkl_gewicht		number(8,3)
		constraint nn_Artikel_02 not null
		constraint ck_Artikel_01 check (rtkl_gewicht > 0)
	, rtkl_hersteller	varchar2(25)
		constraint nn_Artikel_03 not null
		/*
		constraint ck_Artikel_02
		check (
			rtkl_hersteller in ('Procter', 'Lever', 'Boss', 'Cerruti',
				'Danone', 'Fresenius')
		 OR
		 (	rtkl_hersteller='Westmilch' and rtkl_art = (
				select rtklrt_id
				from ArtikelArt
				where rtklrt_name = 'Molkereiprodukte'
		 )		)
		)
		*/
);




/*
 * Tabellen füllen
 * Auch hier: erst ArtikelArt füllen, damit Artikel.rtkl_art belegt werden kann
 */
insert into ArtikelArt values (1, 'Reinigungsmittel', 'REGAL', 'F', 'F', 'FEST');
insert into ArtikelArt values (2, 'Bekleidung', 'REGAL', 'F', 'F', 'FEST');
insert into ArtikelArt values (3, 'Molkereiprodukte', 'KUEHL', 'T', 'T', 'FEST');
insert into ArtikelArt values (4, 'Getraenke', 'REGAL', 'T', 'T', 'FLUESSIG');

insert into Artikel values (1, 1, 'Waschpulver', 2.5, 'Procter');
insert into Artikel values (2, 1, 'Seife', 0.01, 'Procter');
insert into Artikel values (3, 1, 'Allzweckreiniger', 1.0, 'Lever');
insert into Artikel values (4, 2, 'Hemd', 0.01, 'Boss');
insert into Artikel values (5, 2, 'Wollmantel', 1.0, 'Cerruti');
insert into Artikel values (6, 3, 'Joghurt', 0.02, 'Danone');
insert into Artikel values (7, 3, 'Quark', 0.025, 'Westmilch');
insert into Artikel values (8, 1, 'Orangensaft', 1.0, 'Fresenius');


/*
 *  Statistiken fuer den Optimierer
 */
analyze table Artikelart compute statistics;
analyze table Artikel compute statistics;



/*
 * Abfragen
 * 
 */
select sum(rtkl_gewicht)
from Artikel
where rtkl_hersteller = 'Procter';

select rtkl_name, rtkl_hersteller
from Artikel
order by rtkl_hersteller;

select max(rtkl_gewicht)
from Artikel, ArtikelArt
where rtkl_art = rtklrt_id
and rtklrt_name = 'Reinigungsmittel';

select rtkl_name
from Artikel
where rtkl_art not in (
	select rtklrt_id
	from ArtikelArt
	);



/*
 * Änderungsoperationen
 * 
 */

/* PRE */
select rtkl_name, rtkl_gewicht
from Artikel
where rtkl_id = 8;

update Artikel
set rtkl_gewicht = 1.5
where rtkl_id = 8;

/* POST */
select rtkl_name, rtkl_gewicht
from Artikel
where rtkl_id = 8;


/* PRE */
select rtkl_name, rtkl_hersteller
from Artikel
where rtkl_name = 'Waschpulver';

update Artikel
set rtkl_hersteller = 'Henkel'
where rtkl_name = 'Waschpulver';

/* POST */
select rtkl_name, rtkl_hersteller
from Artikel
where rtkl_name = 'Waschpulver';


/* PRE */
select rtklrt_zustand
from Artikelart
where rtklrt_name = 'Reinigungsmittel';

update ArtikelArt
set rtklrt_zustand = 'FLUESSIG'
where rtklrt_name = 'Reinigungsmittel';

/* POST */
select rtklrt_zustand
from Artikelart
where rtklrt_name = 'Reinigungsmittel';


/* PRE */
select rtkl_name from Artikel;

delete from Artikel
where rtkl_name = 'Joghurt';

/* POST */
select rtkl_name from Artikel;


/* PRE */
select rtkl_hersteller, rtklrt_name
from Artikel, ArtikelArt
where rtkl_art = rtklrt_id
and rtklrt_name = 'Bekleidung';

update Artikel
set rtkl_hersteller = 'CundA'
where rtkl_art in (
	select rtklrt_id
	from ArtikelArt
	where rtklrt_name = 'Bekleidung'
	);

/* POST */
select rtkl_hersteller, rtklrt_name
from Artikel, ArtikelArt
where rtkl_art = rtklrt_id
and rtklrt_name = 'Bekleidung';


/* PRE */
select rtkl_name, rtklrt_name
from Artikel, ArtikelArt
where rtkl_art = rtklrt_id
and rtklrt_name = 'Reinigungsmittel';

delete from Artikel
where rtkl_art in (
	select rtklrt_id
	from ArtikelArt
	where rtklrt_name = 'Reinigungsmittel'
	);

/* POST */
select rtkl_name, rtklrt_name
from Artikel, ArtikelArt
where rtkl_art = rtklrt_id
and rtklrt_name = 'Reinigungsmittel';



alter table Artikel add (rtkl_gwchtnht	char(2));
/* POST */
describe Artikel;