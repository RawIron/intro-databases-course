/*
 * Musterlösungen zu 2.Übung in SQL-2
 */


/*
 *  QUADER
 */
select *
from quader q, flaeche f, kante k, punkt p
where q.qid = f.qid	/* die Flaechen zu den Quadern zuordnen */
and f.fid = k.fid	/* die Kanten zu den Flaechen zuordnen */
and k.kid = p.kid	/* die Punkte zu den Kanten zuordnen */
and q.name = 'ERSTER';	/* Quader auswaehlen */

select p.x, p.y, p.z
from quader q, flaeche f, kante k, punkt p
where q.qid = f.qid
and f.fid = k.fid
and k.kid = p.kid
and q.name = 'ERSTER';

select q.name, p.x, p.y, p.z
from quader q, flaeche f, kante k, punkt p
where q.qid = f.qid
and f.fid = k.fid
and k.kid = p.kid
and q.name = 'ERSTER';

select q.name
from quader q, flaeche f, kante k, punkt p
where q.qid = f.qid
and f.fid = k.fid
and k.kid = p.kid
and p.x = 0 and p.y = 0 and p.z = 0;

select q.name, k.kid
from quader q, flaeche f, kante k
where q.qid = f.qid
and f.fid = k.fid;




/*
 *  KARTE
 */

/* 1. */
select s.StaatName
from FliesstDurch fd, Staat s
where fd.SeeOderStaat = s.StaatName	/* Staaten herausfiltern */
and Fluss = 'Donau';


/* 2. */
select fd.Fluss
from FliesstDurch fd, MuendetIn mi
where fd.Fluss = mi.Fluss		/*  der Fluss der durch Deutschland fliesst
					 *  soll derselbe Fluss sein, der in die
					 *  Nordsee muendet
					 */
and fd.SeeOderStaat = 'Deutschland'
and mi.FlussOderMeer = 'Nordsee';


/* 3. */
select la.Stadt
from LiegtAn la, Meer m
where la.SeeOderFlussOderMeer = m.MeerName	/* auf Meere einschraenken */
;

/* 4. */
select mi.Fluss
from MuendetIn mi, Fluss f
where mi.FlussOderMeer = f.FlussName	/*  Als Muendungsgewaesser kommen nur
					 *  Fluesse in Frage
					 */
;

/* 5. */
select la.Stadt
from LiegtAn la, Fluss f, FliesstDurch fd, See s, MuendetIn mi, Meer m
where la.SeeOderFlussOderMeer = f.FlussName	/* auf Fluesse einschraenken */
and fd.Fluss = la.SeeOderFlussOderMeer		/*  der Fluss an dem die Stadt liegt
						 *  ist der Fluss, der durch den See fliesst
						 */
and fd.SeeOderStaat = s.SeeName
and fd.Fluss = mi.Fluss				/*  Fluss, der durch den See fliesst
						 *  ist der Fluss, der in das Meer muendet
						 */
and mi.FlussOderMeer = m.MeerName;