--Syntax

delete from example_table;

--e.g. Remove row for toy_name Purple ninja

delete toys where toy_name = 'Purple Ninja';

/*Truncate removes all rows in a table
	• Part of the Oracle db and automatically commits so you can't rollback
	• Faster than individual deletes*/

/*Soft delete adds a flag that that something is 'deleted'
	• Basically adds an attribute is_deleted with boolean
	• Requires you filter out 'deleted' values, for which there are 3 main Oracle db tools
	• Views, Virtual Private db (VPD), and In-db archiving*/

/*Views: create a view that excludes the deleted row, but requires all code to use the view*/

--Syntax

create or replace view active_example as
	select * from example_table
	where is_deleted = 'N'; --should probably use 'true' or 'false'

/*VPD: primarily a security feature that controls which users can see which rows*/

/*In-Database archiving was introduced in Oracle 12c
	• adds an invisible column ora_archive_state to each table*/

--Syntax to activate

alter table example_table row archival

--Syntax to set delete (any non-zero value)

update	example_table
set		ora_archive_state = '1'
where	col1 = 'example_value';

--Syntax to set all rows visible

alter session set row archival visibility = all;

--Syntax to automatically filter our deleted rows

alter session set row archival visibility = active;
