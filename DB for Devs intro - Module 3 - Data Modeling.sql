/*Designing a database in 4-steps: (1) Capture requirements, (2) build  conceptual model, (3) Design logical model, (4) Create physical model

(1) Capture requirements
	• Interview people who will use the system
	• What kind of data will be stored?
	• What purpose will the system serve?
	• How should the application work?
	• Functional (all the above) vs non-functional requirements (i.e. performance)

(2) Conceptual model
	• High-level overview of db
	• Defines key entities (real-world details) 

(3) Design logical model
	• Fleshes out conceptual model
	• Document aspects of entities to be stored as attributes/columns
	• Entity-Relationship Diagram

(3a) Normalization
	• Remove redundancies
	• Notation: xNF, where x is a number 1 to 5
		• e.g. 1NF is the first normal form, 4NF is the fourth normal form
		• Boyce-Codd normal form: 3.5NF
	• Must meed requirements of those forms lower than given form
		• e.g. 3NF must meet requirements of 1NF & 2NF
	• "A Simple Guide to Five Normal Forms in Relational Database Theory"
		http://www.bkent.net/Doc/simple5.htm 

(4) Create physical model
	• Output should create table statements that build the db
	• Consider non-functional requirements (i.e. performance)
	• Organization? Partition vs IOT performance*/

/*Supertypes and subtypes
	• Can be used to disambiguate is situations where tables & attributes could be misleading/erroneous
	• Supertypes are generalizations and subtypes are specializations
	• e.g. If someone has two roles, avoid recording a different name for that person by combining all folks into one relation
		• Then, assign an attribute to define that person's role(s)
	• General guidelines
		• >=2 tables have the same columns storring the same info, think supertype. Consider merging into a single table
		• 1 table has columns applicable only if the row is of a certain type, consider splitting  into subtypes
*/

/*Relational vs Document storage
	• Supertyping/subtyping can be time-consuming
	• Can store requirements as documents as a tuple/row in each relation
		• JSON/XML support
		• Drawbacks: 
			• Must refer to document to know attributes, making querying difficult
			• Duplicates details
	• Sometimes you can store everything in a single document
	• Other times, relational modeling will be better in the long-term*/