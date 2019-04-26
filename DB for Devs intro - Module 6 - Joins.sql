/*Oracle vs ANSI joins
	Oracle joins in where clause, ANSI has a join clause that uses the on clause for filtering*/

/*Cross join: returns Cartesian product (i.e. X rows * Y rows = X*Y result rows)*/

/*Inner join: matches rows based on shared value or condition
	Oracle: specify in where clause
	ANSI inner join: specify in on clause*/

--e.g. ANSI inner join

select 	* 
from   	toys
join 	bricks
on 		toy_id > brick_id;

--e.g. Oracle inner join

select  * 
from    toys, bricks
where   toy_id > brick_id;

/*Outer join: returns all the rows from one table with matching rows from other/optional table (returning null for no matches in other table)
	Oracle: add (+) to the optional table in the where clause
	ANSI: prefix left outer join*/

--e.g. ANSI outer join

select 	*
from 	toys
left	outer join ks
on 		toy_id = brick_id;

--e.g. Oracle outer join

select	*
from	toys, bricks
where	toy_id = brick_id (+);

/*Can use on and where clause in combination for further filtering on a specific inner join, but have to be careful with outer joins
	Oracle: use (+) normally, but also use it in the filtering condition 
	ANSI: omit the where clause and place the filter criteria in the on clause*/

--e.g. ANSI outer join with filter

select * 
from   toys
left   join bricks
on     toy_id = brick_id
and    brick_colour = 'green';

--e.g. Oracle outer join with filter

select * 
from   toys, bricks
where  toy_id = brick_id (+)
and    brick_colour (+) = 'green';

/*Return all rows from bricks, any rows with toy_id = brick_id, and toy_colour = 'blue'*/

--e.g. ANSI (checked, worked)

select   *
from    bricks
left    join toys
on		toy_id = brick_id
and		toy_colour = 'blue';

--e.g. Oracle (checked, worked)

select	*
from	bricks, toys
where	brick_id = toy_id (+)
and		toy_colour (+) = 'blue';

/*Full outer join makes neither table optional and return all tuples, with non-matches coupled with a null attribute*/

/*Syntax notes
	join: alone always means inner join, and with Oracle must use on statement if no singular attribute with shared name among tables
	left join: implies outer join
	cross join: must explicitly state cross, or use Oracle syntax with commas*/