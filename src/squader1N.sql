/*
 * Loesungen zu einigen ausgewaehlten Anfragen
 */


/* gibt die Kanten (ohne Redundanz) zum Punkt 1 aus */
select distinct glch_kid
from kante k, punkt p
where k.kid = p.kid
and p.glch_pid = 1;

/* gibt zu allen Punkten ihre Kanten (ohne Redundanz) aus */
select distinct p.glch_pid, glch_kid
from kante k, punkt p
where k.kid = p.kid