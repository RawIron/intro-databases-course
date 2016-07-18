/*
 * squaderOO.sql
 *	ausgewaehlte Anfragen gegen einen Quader
 */



/* Alle Flaechen des Quaders mit der Id=1 ausgeben */
select f.ptr_flaeche.fid
from table (
   select q.setof_flaeche
   from quader_o q
   where q.qid = 1
   ) f
/


/* Alle Kanten der Flaeche mit der Id=1 ausgeben */
select f.ptr_kante.kid
from table (
   select k.setof_kante
   from flaeche_o k
   where k.fid = 1
   ) f
/


/* Alle Punkte der Kante mit der Id=1 ausgeben */
select p.ptr_punkt.pid
from table (
   select k.setof_punkt
   from kante_o k
   where k.kid = 1
   ) p
/



/*
 *  die nachfolgende Anfrage laeuft nicht!
 */
select k.setof_kante
from (
	select deref(f.ptr_flaeche)
	from table (
  		select q.setof_flaeche
  		from quader_o q
   		where q.qid = 1
   		) f
	) k
/

/*
 * ... und das laeuft erst recht nicht!
 */
select x.ptr_kante.kid
from table (
	select k.setof_kante
	from (
		select deref(f.ptr_flaeche)
		from table (
  			select q.setof_flaeche
  			from quader_o q
   			where q.qid = 1
   		) f
	) k
) x
/


/*
 * ... dafuer tut es aber der Umweg
 */
create table tt_flaeche of flaeche_t
	nested table setof_kante store as tt_ntflaeche;

insert into tt_flaeche
	(select deref(f.ptr_flaeche)
	 from table (
  		select q.setof_flaeche
  		from quader_o q
   		where q.qid = 1
   		) f
	)
/

select x.ptr_kante.kid
from table (
	select k.setof_kante
	from tt_flaeche k
	where k.fid = 1
	) x
/

drop table tt_flaeche;
