/*Syntax for single row insert*/

insert into table_name (col1, col2, coletc)
	values ('val1', 'val2', 'valetc')

/*don't need column list after table_name, but then would need would value for every visible column*/

--e.g. Insert toy_id 3 and color red into toys table (checked, worked)

insert into toys (toy_id, colour) values ( 3, 'red' );


/*Syntax for multi-row insert (typically much faster than single row)*/

insert into example_table (example_column)
	select example_column2
	from example_table2;

/*Note: must have same number of columns and same data type*/

--e.g. insert rows for toy_id and colour for toys 4 & 5 into brick_id (checked, worked; don't forget 'into')

insert into bricks (brick_id, colour)
	select toy_id, colour
	from   toys
 	where  toy_id in ( 4, 5 );

/*Commit changes with a 'commit;' command
	• Rollback  to the most recent commit with 'rollback;' command
		• rolling back immediately after a commit does nothing
	• Can also use a savepoint which does not push changes to all_tables*/

--Syntax examples (note that LiveSQL requires 'exec' prefix to savepoint)

commit;

rollback;

savepoint example_save;
rollback to savepoint example_save;

--e.g. Commit the insert of toy_id 8, add rows for toy_id 9 & 10, then remove row 10, and undo insert for toy_id 9 (checked; worked)

insert into toys ( toy_id, toy_name, colour ) 
	values ( 8, 'Red Rabbit', 'red' );

commit;

insert into toys ( toy_id, toy_name, colour ) 
	values ( 9, 'Purple Ninja', 'purple' );

exec savepoint save_1;

insert into toys ( toy_id, toy_name, colour ) 
	values ( 10, 'Blue Dinosaur', 'blue' );

exec savepoint save_2;

rollback to savepoint save_1;

select * from toys
where  toy_id in ( 8, 9, 10 );

rollback;

select * from toys
where  toy_id in ( 8, 9, 10 );

/*Multi-table inserts place rows in many tables with one statement
	•  Can insert to the same table multiple times

Note that the query or table can be replaced by 'dual'
	• Dual is a special Oracle db table that has only one-row (~placeholder) and stores values/functions not present in a real table*/

--Syntax

insert 	all
	into tab1 	(col1, col2, coletc) values ('val1', 'val2', 'valetc')
	into tab2 	(col1, col2, coletc) values ('val1', 'val2', 'valetc')
	into tabetc	(col1, col2, coletc) values ('val1', 'val2', 'valetc')
select * from example_query_or_table



/*Conditional multi-table inserts have two forms: all or first
	• all: insert wherever applicable
	• first: inserts only once, from top to bottom*/

--Syntax

insert [ all | first ]
	when example1 then
		into ex1 (col1, coletc) values ('val1', 'valetc')
	when example2 then
		into ex2 (col1, coletc) values ('val1', 'valetc')
		into ex3 (col1, coletc) values ('val1', 'valetc')
	else 
		into ex4 (col1, coletc) values ('val1', 'valetc')
select * from example_query_or_table