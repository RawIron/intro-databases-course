/*
   iquader1N.sql
	Implementierung der folgenden Integritaetsbedingungen:
	Quader hat nicht mehr als 6 Flaechen
	Flaeche hat nicht mehr als 4 Kanten
	Kante hat nicht mehr als 2 Punkte
*/


create table quader_check (
	qid	number constraint fk_iquader_01 references quader (qid)
	, fcnt	number constraint ck_iquader_01
		check (fcnt between 0 and 6)
	, kcnt	number constraint ck_iquader_02
		check (kcnt between 0 and 24)
	, pcnt	number constraint ck_iquader_03
		check (pcnt between 0 and 48)
);


create trigger new_quader
	after insert or update of qid on quader
	for each row
	begin
		if INSERTING
		then
			insert into quader_check values (:new.qid, 0, 0, 0);
		elsif UPDATING
			update quader_check
			set qid = :new.qid
			where qid = :old.qid;
		end if;
	end;
/


/*
   PRE
	zu jeder qid in flaeche ex. eine qid in quader
	damit kann qid nur auf eine bereits ex. quader.qid gesetzt werden
	damit ist aber stets ein Eintrag in quader_check bereits enthalten
*/
create trigger cnt_check
	before insert or update of qid on flaeche
	for each row
	begin
		if INSERTING
		then
			update quader_check
			set fcnt = fcnt + 1
			where qid = :new.qid;
		elsif UPDATING
		then
			update quader_check
			set fcnt = fcnt - 1
			where qid = :old.qid;

			update quader_check
			set fcnt = fcnt + 1
			where qid = :new.qid;
		end if;
	end;
/