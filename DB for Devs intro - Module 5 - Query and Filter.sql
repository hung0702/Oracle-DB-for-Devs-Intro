/*Already know how to select, from, and where*/

/*AND & OR: order matters
	'and' goes first*/

--e.g.

where A and B or C
--is the same as
where (A and B) or C

--e.g.

where A or B and C
--is the same as
where A or (B and C)

--e.g. use parenthesis if you want the following

where (A or B) and C

/*Query to find rows that have (1) toy_name Sir Stripypants or the color blue, and (2) a price equal to 6 (correct)*/

select	*
from	toys
where (toy_name = 'Sir Stripypants' or colour = 'blue') --British English of color
and price = 6;

/*Use IN to search for any column containing the values in parentheses*/

select *
from example_table
where example_column in (example1, example2, example3);

/*Return a range of values with inequalities*/
--e.g. Query for color = blue or red, price >= 6 but < 14.22

select	*
from	toys
where	colour in ('blue', 'red') 
and price >= 6 and price < 14.22;

/*"Wildcard, b*tches!"
	• Underscore _ to match one character
	• Percent % to match zero or more
	• use 'like' condition in select clause*/

select	*
from	example_table
where	exampl_attr like 'b%';		--e.g. find all starting with 'b'

select	*
from	example_table
where	exampl_attr like 'b__';		--e.g. find 3-letter results starting with 'b'

select	*
from	example_table
where	exampl_attr like '%bb%';	--e.g. find all results containing 'bb'

select	*
from	example_table
where	exampl_attr like '%_bo_%';	--e.g. find all results with 'bb' in the middle of a word

--e.g. Query for toy_name rows with 'B' (case sensitive)	(checked; correct)

select	toy_name
from	toys
where	toy_name like '%B%';

/*Misc
	• must use 'is null' vs '= null'
	• use 'not' for negation*/

--e.g. Query (1) color != green, (2) price != 6	(checked, correct)

select	toy_name
from	toys
where	colour 	!= 'green' 
and		price 	!= 6;