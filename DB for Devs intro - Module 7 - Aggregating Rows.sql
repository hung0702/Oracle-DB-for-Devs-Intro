/*Count can count the total number of tuples or the number of tuples with non-null attribute
	• Put distinct in the parenthesis and before the input to return the number of unique value*/

--e.g. total

select 	count (*) from bricks; --returns total number of tuples in bricks table

select 	count (color) from bricks; --returns the total number of values for the color attribute that are not null

--e.g. other aggregate functions

sum();
min();
max();
avg();
stddev(); --how come this one isn't colored?
median(); --this one either?
variance(); --maybe some of the functions aren't recognized in sublime (follow-up: yeah it's just Sublime)
stats_mode; --the statistical mode

--Return the number of different shapes and the standard deviation of unique weights

select	count (distinct shape) number_of_shapes,
		stddev (distinct weight) distinct_weight_stddev
from	bricks;

--Return the total weight for each shape stored in the bricks table (checked, worked)

select 	shape, sum (weight) shape_weight
from 	bricks
group	by shape;

/*Can filter the pre-aggregated values with a where clause (before group by clause)
	• You can't use an aggregate function in the where clause
	• To filter post-aggregated values, use a having clause before or after the group by clause*/

--Return the shapes with a sum weight < 4

select 	shape, sum (weight)
from   	bricks
group	by shape
having sum (weight) < 4;

/*Rollup is a subclause of the group by clause
	• Number of groups = Length of list + 1
	• Kind of like reverse factorials, removing the right most element until you get to zero
	• The last set is the grand total
	• Intended use: produces a bunch of grouping sets so you can query different hierarchies simultaneously

--e.g. rollup (a, b, c)	

produces the 4 following sets

(a, b, c) 	union
(a, b)		union
(a)			union
()*/

select	colour, shape, count (*)
from	bricks
group	by rollup (colour, shape);

/*Cube is a subclause of the group by clause
	• Number of groups = 2^N, where N = the number of columns
	• Like rollup, except produces all possible combinations of columns
	• Also produces a grand total
	• Intended use: produces all possible groupings so you can query hierarchies, even if the sub-elements aren't naturally grouped
	• Rollup/Cube are for generating subtotals*/