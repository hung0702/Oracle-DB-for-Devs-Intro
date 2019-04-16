/*For full data type documentation, refer to 
https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Data-Types.html#GUID-A3C0D836-BADB-44E5-A5D4-265BA5968483*/

/*6 data types with varying precision
decimal
integer
number
float
binary integer
binary float*/

number ( 'precision', 'scale' ); --omitting precision/scale will default to max available

/*float is a subtype of number for floating-point numbers (unfixed number of digits pre-/post-decimal) 
	binary_float or binary_double recommended instead
	binary_float is 32-but single-precision, and binary_double is 64-bit double-precision
		both allow you to store infinity and NaN (Not a Number)*/

/*ANSI number types: supported by Oracle db, e.g. integer or real map to number or float*/

create table numeric_data (
	number_3_sf_2_dp  number(3, 2),
	number_3_sf_2     number(3, -2),
	number_5_sf_0_dp  number(5, 0),
	integer_col       integer,
	float_col         float(10),
	real_col          real,
	binary_float_col  binary_float,
	binary_double_col binary_double
);

/*strings hold general text and unstructured data
Primary data type is varchar2(data_length)	(<= 4KB in Oracle 11.2, <= ~32KB in 12.1)
Use char for fixed length	(pads shorter text, <= 2KB)
Use clob for wall of text	(4GB - 1)*(db block size), up to 32TB in Oracle*/

create table character_data (
	varchar_10_col   varchar2(10),
	varchar_4000_col varchar2(4000),
	char_10_col      char(10),
	clob_col         clob
);

/*date data type don't store timezone info; instead use timestamp for that
	types: (1) date, (2) timestamp, (3) timestamp with time zone, (4) timestamp with local time zone
		(1) dates are granular to the second and must include a time (no calendar date-only type in Oracle), and have no time zone
			e.g. date'2019-04-16' is the date for April 16, 2019 at midnight
			e.g. to_date ( '2019-04-16 02:17 PM', 'YYYY-MM-DD HH:MI AM' ) is for when you need to specify time, remember the format mask!
		(2) timestamps provide greater precision than dates, up to 9 digits of fractional seconds
			e.g. to_timestamp ( '2019-04-16 02:17:00.123 PM', 'YYYY-MM-DD HH:MI:SS:FF PM' )
		(3/4) timezones are stored in a column and handled by the db, such that quering returns the time value stored converted to the session time zone
	Time intervals are durations of two types: years-to-month and day-to-second
		Can add/subtract intervals from dates, timestamps, or same-type intervals*/

create table datetime_data (
  date_col                      date,
  timestamp_with_3_frac_sec_col timestamp(3),
  timestamp_with_tz             timestamp with time zone,
  timestamp_with_local_tz       timestamp with local time zone,
  year_to_month_col             interval year to month,
  day_to_second_col             interval day to second
);

/*Binary data types store data in the original format (e.g. graphics, sound, Word docs); raw and blob are the two key primary types
	Raw: for smaller items, up to 2KB on 11.2 and ~32KB on 12.1
	Blob: Binary Large OBject; max of (4GB - 1)*(db block size)*/

create table binary_data (
	raw_col  raw(1000),
	blob_col blob
);

/*Oracle tables have up to 1,000 columns, each with its own data type
Query with terms like table_name, column_name, data_type, data_length, data_precision, data_scale*/

create table example_table_with_three_columns (
	character_column 	varchar2(100),
	number_column		number,
	date_column			date
);

/*Create example table with example column (worked, but where statement needed all caps in Oracle's SQL worksheet*/

create table example_table (
	example_column 	varchar2(10)
);

/*Create table with (1) brick_id of type number (20, 0), (2) color of type varchar2(10), (3) price of type number(10, 2),
	(4) purchased_date of type date 	(tried, worked)*/

create table bricks (
	brick_id		number(20, 0),
	color			varchar2(10),
	price			number (20, 0),
	purchased_date	date
);

/*add/drop columns to existing tables with 'alter' and 'add'/'drop' (up to 1,000 final total)*/

alter table example_table_with_three_columns add (
	timestamp_example	timestamp
	blob_example		blob
);

alter table example_table_with_three_columns drop (
	timestamp_example,	--don't need type, just column name
	blob_example
);

/*Alter this table to add weight as a number(8, 1) and remove cuddliness factor*/

create table toys (
  toy_id            integer,
  toy_name          varchar2(100),
  cuddliness_factor integer
);

--Answers (able to input both into Worksheet simultaneously)

alter table toys add (
	weight 	number(8, 1)
);

alter table toys drop (
	cuddliness_factor
);