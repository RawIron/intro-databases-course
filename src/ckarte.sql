/*
 *  karte.sql
	Skript erstellt Schema fuer Karten-Beispiel
	vergibt Zugriffsrechte fuer public
	Fuegt Daten in Relationen ein
 */


create table Stadt (
	StadtName	varchar2(25),
	StadtEinwohner	number
);

create table Staat (
	StaatName	varchar2(25),
	StaatEinwohner	number
);

create table Fluss (
	FlussName	varchar2(25),
	FlussLaenge	real
);

create table See (
	SeeName		varchar2(25),
	SeeFlaeche	real
);

create table Meer (
	MeerName	varchar2(25),
	MeerMaxTiefe	real
);


create table MuendetIn (
	Fluss	varchar2(25),
	FlussOderMeer	varchar2(25)
/*
	, constraint ck_muendetIn_01 check
		( NOT ( fluss == flussOderMeer and flussOderMeer in (
			select FlussName
			from fluss where flussName = FlussOderMeer)
		      )
		)
*/
);

create table FliesstDurch (
	Fluss	varchar2(25),
	SeeOderStaat	varchar2(25)
);

create table LiegtAn (
	Stadt	varchar2(25),
	SeeOderFlussOderMeer	varchar2(25)
);

create table LiegtIn (
	Stadt	varchar2(25),
	Staat	varchar2(25)
);



/*
 *  Histogramme fuer den Optimierer erzeugen
 */
analyze table Stadt compute statistics;
analyze table Staat compute statistics;
analyze table Fluss compute statistics;
analyze table See compute statistics;
analyze table Meer compute statistics;
analyze table MuendetIn compute statistics;
analyze table FliesstDurch compute statistics;
analyze table LiegtAn compute statistics;
analyze table LiegtIn compute statistics;


/*
 *  Leserecht fuer Alle vergeben
 */
grant select on nathe.stadt to public;
grant select on nathe.staat to public;
grant select on nathe.meer to public;
grant select on nathe.see to public;
grant select on nathe.fluss to public;
grant select on nathe.muendetIn to public;
grant select on nathe.liegtAn to public;
grant select on nathe.liegtIn to public;
grant select on nathe.fliesstDurch to public;


/*
    Lege Synonyme fuer Relationen an
    Dadurch koennen andere Benutzer Relationen als meer und nicht nathe.meer benutzen

create synonym meer for nathe.meer;
 */




/* Staedte einfuegen */
insert into Stadt values ('Berlin', 3000);
insert into Stadt values ('Budapest', 3000);
insert into Stadt values ('Bukarest', 3000);
insert into Stadt values ('Bruessel', 3000);
insert into Stadt values ('Dresden', 3000);
insert into Stadt values ('Frankfurt', 3000);
insert into Stadt values ('Genf', 3000);
insert into Stadt values ('Gibraltar', 3000);
insert into Stadt values ('Hamburg', 3000);
insert into Stadt values ('Koblenz', 3000);
insert into Stadt values ('London', 3000);
insert into Stadt values ('Konstanz', 3000);
insert into Stadt values ('Paris', 3000);
insert into Stadt values ('Mainz', 3000);
insert into Stadt values ('Prag', 3000);
insert into Stadt values ('Pilsen', 3000);
insert into Stadt values ('Wien', 3000);
insert into Stadt values ('Stockholm', 3000);


/* Staaten einfuegen */
insert into Staat values ('Belgien', 16000);
insert into Staat values ('Ungarn', 16000);
insert into Staat values ('Schweiz', 16000);
insert into Staat values ('Schweden', 16000);
insert into Staat values ('Bulgarien', 16000);
insert into Staat values ('Deutschland', 16000);
insert into Staat values ('Rumaenien', 16000);
insert into Staat values ('Grossbritannien', 16000);
insert into Staat values ('Niederlande', 16000);
insert into Staat values ('Oesterreich', 16000);
insert into Staat values ('Kanada', 16000);
insert into staat values ('Frankreich', 23000);

/* Fluesse einfuegen */
insert into fluss values ('Themse', 2450);
insert into fluss values ('Donau', 2450);
insert into fluss values ('Elbe', 2450);
insert into fluss values ('Maas', 2450);
insert into fluss values ('Main', 2450);
insert into fluss values ('Marne', 2450);
insert into fluss values ('Seine', 2450);
insert into fluss values ('Rhone', 2450);
insert into fluss values ('Rhein', 2450);
insert into fluss values ('Moldau', 2450);
insert into fluss values ('Mosel', 2450);

/* Meere einfuegen */
insert into meer values ('Atlantik', 5666);
insert into meer values ('Mittelmeer', 5666);
insert into meer values ('Nordsee', 5666);
insert into meer values ('Ostsee', 5666);
insert into meer values ('Schwarzes Meer', 5666);
insert into meer values ('Pazifik', 5666);

/* Seen einfuegen */
insert into see values ('Bodensee', 3412);
insert into see values ('Genfer See', 3412);
insert into see values ('Maelarsee', 3412);


/* Muendungen einfuegen */
insert into muendetin values ('Donau', 'Schwarzes Meer');
insert into muendetin values ('Elbe', 'Nordsee');
insert into muendetin values ('Maas', 'Nordsee');
insert into muendetin values ('Main', 'Rhein');
insert into muendetin values ('Marne', 'Seine');
insert into muendetin values ('Moldau', 'Elbe');
insert into muendetin values ('Mosel', 'Rhein');
insert into muendetin values ('Rhein', 'Nordsee');
insert into muendetin values ('Rhone', 'Mittelmeer');
insert into muendetin values ('Seine', 'Atlantik');
insert into muendetin values ('Themse', 'Nordsee');

/* FliesstDurch einfuegen */
insert into fliesstdurch values ('Donau', 'Bulgarien');
insert into fliesstdurch values ('Donau', 'Deutschland');
insert into fliesstdurch values ('Donau', 'Oesterreich');
insert into fliesstdurch values ('Donau', 'Rumaenien');
insert into fliesstdurch values ('Donau', 'Ungarn');
insert into fliesstdurch values ('Elbe', 'Deutschland');
insert into fliesstdurch values ('Elbe', 'Tschechien');
insert into fliesstdurch values ('Maas', 'Belgien');
insert into fliesstdurch values ('Maas', 'Frankreich');
insert into fliesstdurch values ('Maas', 'Niederlande');
insert into fliesstdurch values ('Main', 'Deutschland');
insert into fliesstdurch values ('Marne', 'Frankreich');
insert into fliesstdurch values ('Moldau', 'Tschechien');
insert into fliesstdurch values ('Mosel', 'Deutschland');
insert into fliesstdurch values ('Mosel', 'Frankreich');
insert into fliesstdurch values ('Rhein', 'Bodensee');
insert into fliesstdurch values ('Rhein', 'Deutschland');
insert into fliesstdurch values ('Rhein', 'Frankreich');
insert into fliesstdurch values ('Rhein', 'Niederlande');
insert into fliesstdurch values ('Rhein', 'Schweiz');
insert into fliesstdurch values ('Rhone', 'Frankreich');
insert into fliesstdurch values ('Rhone', 'Genfer See');
insert into fliesstdurch values ('Rhone', 'Schweiz');
insert into fliesstdurch values ('Seine', 'Frankreich');
insert into fliesstdurch values ('Themse', 'Grossbritannien');


/* LiegtAn einfuegen */
insert into LiegtAn values ('Budapest', 'Donau');
insert into LiegtAn values ('Dresden', 'Elbe');
insert into LiegtAn values ('Frankfurt', 'Main');
insert into LiegtAn values ('Genf', 'Genfer See');
insert into LiegtAn values ('Genf', 'Rhone');
insert into LiegtAn values ('Gibraltar', 'Atlantik');
insert into LiegtAn values ('Gibraltar', 'Mittelmeer');
insert into LiegtAn values ('Hamburg', 'Elbe');
insert into LiegtAn values ('Koblenz', 'Mosel');
insert into LiegtAn values ('Koblenz', 'Rhein');
insert into LiegtAn values ('London', 'Themse');
insert into LiegtAn values ('Konstanz', 'Bodensee');
insert into LiegtAn values ('Paris', 'Seine');
insert into LiegtAn values ('Mainz', 'Rhein');
insert into LiegtAn values ('Prag', 'Moldau');
insert into LiegtAn values ('Rotterdam', 'Rhein');
insert into LiegtAn values ('Wien', 'Donau');
insert into LiegtAn values ('Stockholm', 'Ostsee');


/* LiegtIn einfuegen */
insert into LiegtIn values ('Berlin', 'Deutschland');
insert into LiegtIn values ('Budapest', 'Ungarn');
insert into LiegtIn values ('Bukarest', 'Rumaenien');
insert into LiegtIn values ('Bruessel', 'Belgien');
insert into LiegtIn values ('Dresden', 'Deutschland');
insert into LiegtIn values ('Frankfurt', 'Deutschland');
insert into LiegtIn values ('Genf', 'Schweiz');
insert into LiegtIn values ('Gibraltar', 'Grossbritannien');
insert into LiegtIn values ('Hamburg', 'Deutschland');
insert into LiegtIn values ('Koblenz', 'Deutschland');
insert into LiegtIn values ('London', 'Grossbritannien');
insert into LiegtIn values ('Konstanz', 'Deutschland');
insert into LiegtIn values ('Paris', 'Frankreich');
insert into LiegtIn values ('Mainz', 'Deutschland');
insert into LiegtIn values ('Prag', 'Tschechien');
insert into LiegtIn values ('Pilsen', 'Tschechien');
insert into LiegtIn values ('Wien', 'Oesterreich');
insert into LiegtIn values ('Stockholm', 'Schweden');