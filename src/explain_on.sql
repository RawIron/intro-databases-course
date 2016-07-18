/*
 * 
 */



create table plan_table (
	statement_id	varchar2(30)
	, timestamp	date
	, remarks	varchar2(80)
	, operation	varchar2(30)
	, options	varchar2(30)
	, object_node	varchar2(128)
	, object_owner	varchar2(30)
	, object_name	varchar2(30)
	, object_instance	numeric
	, object_type	varchar2(30)
	, optimizer	varchar2(255)
	, search_columns	numeric
	, id		numeric
	, parent_id	numeric
	, position	numeric
	, cost		numeric
	, cardinality	numeric
	, bytes		numeric
	, other_flag	varchar2(255)
	, other		long
);

explain plan
set statement_id = 'Aufgabe 4a'
for
select mi.Fluss
from MuendetIn mi, Fluss f
where mi.FlussOderMeer = f.FlussName;

explain plan
set statement_id = 'Aufgabe 4b'
for
select mi.Fluss
from MuendetIn mi, Fluss f
where mi.FlussOderMeer = f.FlussName;

select lpad(' ', 2*level) || operation || ' ' || object_name query_plan
from plan_table
where statement_id like 'Aufgabe 4_'
connect by prior id=parent_id
start with id=0;