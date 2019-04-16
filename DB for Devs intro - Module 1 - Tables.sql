--Tables have (1) names, (2) columns, and (3) data types for each column

--e.g.

create table tabl_name (
	column1_name data_type,
	column2_name data_type,
	etc ad_finem,
);

/*Databases have three tables: 
	(1) user_tables: owned by current user
	(2) all_tables: accessible by db user
	(3) dba_tables: all (only if dba priv = true)*/

--e.g.

select table_name
from user_tables;

--create a table to store the following details about bricks: color, shape; use data type varchar2(10)

create table bricks (
	color varchar2(10)
	shape varchar2(10)
);

/*Create tables in Oracle has three options for organization: (1) Heap, (2) Index, (3) External
	(1) Heap: store where space available 
		Default table organization in Oracle
		No physical order ("where space available")*/

--e.g. (note placement after closing parenthesis)

create table heap_example (
	example_column varchar2(100)
) organization heap;

/*(2) Index: (IOT = Index-Organized Table) rows are soroted by primary key
			Needs: primary key, index clause
			Imposes physical order*/

--e.g. note primary key placement adjacent data type

create table index_IOT (
	index_example integer primary key,
	index_name varchar2(100)
) organization index;

--find IOT in data dictionary by selecting attribute IOT_TYPE; returns IOT if organization is index

select table_name, iot_type
from user_tables
where table_name = 'index_IOT';

--e.g. (from tutorial)

create table bricks_iot (
	bricks_id integer primary key
	) organization index;

--e.g. (check if it works; it did)

select table_name, iot_type
from   user_tables
where  table_name = 'BRICKS_IOT';

/*(3) External: for non-db files, such as CSVs
	Needs: directory pointing to file location, external clause, directory/file name
	Note: not supported in LiveSQL
	Note: db must be able to access the file; cannot use external tables for local files*/

CHECK BACK HERE --e.g. check back to see if you need apostrophes for file path

create or replace directory ext_dir as '/path/to/file';

--e.g. note the directory info after organization clause

create table ext_ex (
  tabl_name varchar2(100)
) organization external (
  default directory tmp
  location ('example.csv')
);

/*Temporary tables store session-specific data to store working data as global or private
	Global: accessible by all db users but only your session can view inserted rows*/

--e.g. (note placement in creation clause)

create global temporary table temp_tabl (
	temp_examp varchar2(100)
);

/*	Private: req 18c; visible only in your session
		Need private clause and table prefix ora$ptt_
		Rows disappear at end of transaction, but can change to session end with "on commit" clause*/

--e.g. (note clause placement and prefix)

create private temporary table ora$ptt_priv (
	priv_examp varchar2(100)
);

--e.g. View temporary tables

select temp_table, temporary
from user_tables
where temp_table in ( 'example_table', 'ORA$PTT_priv')

/*Partioning tables logically split a table in smaller tables, with three partitioning types available
	(1) Range
	(2) List
	(3) Hash
	Need to: choose partition method, state partition columns, define initial partitions*/

--e.g. note placement after table name/type, and p# for partition labeling

create table examp_range (
	tabl_name varchar2(100)
)	partition by range ( tabl_name ) (
	partition p0 values less than ('b'),
	partition p1 values less than ('c')
);

create table examp_list (
  tabl_name varchar2(100)
) partition by list ( tabl_name ) (
  partition p0 values ('exempli gratis'),
  partition p1 values ('lorem ipsum')
);

create table examp_hash (
  tabl_name varchar2(100)
) partition by hash ( tabl_name ) partitions 4;

--e.g. defaults to heap organization, but can do others (IOT below)

create table examp_part_iot (
  tabl_id   integer primary key,
  tabl_name varchar2(100)
) organization index 
  partition by hash ( tabl_id ) partitions 4;

--e.g. returns YES if querying 'partitioned', but this is not available in all SQL

select table_name, partitioned --returns table_name, YES

--Create hash-partitioned table on brick_id with 8 parts, then query for table_name, partitioned (checked, works)

create table bricks_hash (
  brick_id integer
) partition by hash ( bricks_id ) partitions 8;

/*Table clusters store rows from many table in the same physical location
	Need to create cluster, place tables in cluster clause*/

create cluster example_cluster (
	tabl_name varchar2(100)
);

--e.g. place tables in cluster clause

create table examp_cluster_tabl (
	tabl_name varchar2(100)
) cluster example_cluster ( tabl_name );

create table examp_owners_cluster_tabl (
  owner    varchar2(20),
  tabl_name varchar2(100)
) cluster example_cluster ( tabl_name );

--e.g. query cluster details via below

select cluster_name from user_tables;

/*Drop tables*/

drop table exampl_heap