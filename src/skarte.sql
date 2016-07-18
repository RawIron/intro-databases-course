/*
 * Loesungen zu ausgewaehlten Aufgaben
 */



/*
 * Welche Flusse fliessen durch genau einen Staat
 */
select fluss
from fliesstDurch fd, staat s
where fd.SeeOderStaat = s.StaatName
group by fd.fluss
having count(*) = 1;


/*
 * Welcher Fluss muendet in sich selbst
 */
select mi.fluss
from muendetIn mi, fluss f
where mi.flussOderMeer = f.flussName
and mi.fluss = mi.flussOderMeer;


/*
 * Welcher Fluss muendet in welchen anderen Fluss
 */
select mi.fluss || ' muendet in ' ||  mi.flussOderMeer
"Muendungen"
from muendetIn mi, fluss f
where mi.flussOderMeer = f.flussName
and mi.fluss != mi.flussOderMeer;


/*
 * Welcher Fluss muendet direkt oder indirekt in 
 * die Nordsee
 */
select mi.fluss
from muendetIn mi
where mi.FlussOderMeer = 'Nordsee'

union all

select mi.fluss
from muendetIn mi, muendetIn mf, fluss f
where mi.flussOderMeer = f.flussName
and mi.fluss != mi.flussOderMeer
and mi.flussOderMeer = mf.fluss
and mf.flussOderMeer = 'Nordsee';