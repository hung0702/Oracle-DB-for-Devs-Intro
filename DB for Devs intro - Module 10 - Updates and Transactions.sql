/*Update statement changes values in columns specified
*/

--Syntax

update 	table
set 	attribute = 60;

--e.g. Update the unit_weight of all bricks to 21 (checked, works)

update	bricks
set		unit_weight = 21;

/*Filtering updates is performed by adding a where clause*/

--e.g. Update the cube unit_weight to 5 (checked, works)


update  bricks
set     unit_weight = 5
where   shape = 'cube';

/*Transactions: any number of inserts, updates, or deletes between a commit/rollback and another commit/rollback*/

/*Deadlocks occur when multiple users attempt to change the same row
	• Due to the target row being locked because there was a transaction without a commit/rollback*/

/*Select for update requires a 'for update' clause to lock rows before you start updating to prevent your session from being locked by the other session*/

/*Lost updates occur when one session's changes overwrite another's*/

/*Optimistic locking vs pessimitic locking
	• Optimistic locking only checks the values are the updated
	• Pessimistic locking locks the rows when the user first queries them (less common than optimistic)*/