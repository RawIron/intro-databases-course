/*
 * snref.sql
 *	Anfragen gegen geschachtelte Referenzen
 *	Zyklus ist erlaubt
 */


/* von der root zum branch */
select r.next.name, r.next.inhalt
from root r
where r.name = 1;

/* von der root über den branch zur leaf */
select r.next.next.name, r.next.next.inhalt
from root r
where r.name = 1;

/* von der root über den Zyklus auf die root */
select r.next.next.next.name, r.next.next.next.inhalt
from root r
where r.name = 1;
