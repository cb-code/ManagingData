###---------------------------------------------------------------------------------------###
			5400 MANAGING DATA | Project 1.1 CU DELI DATABASE | UNI: CHB2132
###---------------------------------------------------------------------------------------###


###---------------------------------------------------------------------------------------###
				# 1. CREATE TABLE for DEPARTMENT, DEPARTMENT, MANAGER:
###---------------------------------------------------------------------------------------###

CREATE TABLE DEPARTMENT(
ID bigserial PRIMARY KEY,
DEPT_NAME varchar NOT NULL);

CREATE TABLE EMPLOYEE(
ID bigserial PRIMARY KEY,
SSN char(11) UNIQUE,
EMPLOYEE_NAME varchar NOT NULL,
SALARY numeric NOT NULL,
DEPT_ID bigint NOT NULL,
HIRE_DATE date NOT NULL,
START_DATE date NOT NULL,
SUPER_ID bigint NOT NULL,
FOREIGN KEY (DEPT_ID)
REFERENCES DEPARTMENT(ID) ON DELETE
CASCADE,
	FOREIGN KEY (SUPER_ID) REFERENCES
	EMPLOYEE(ID) ON DELETE CASCADE);

CREATE TABLE MANAGER(
ID bigserial PRIMARY KEY,
DEPT_ID bigint UNIQUE,
EMPLOYEE_ID bigint NOT NULL,
START_DATE date NOT NULL,
FOREIGN KEY (DEPT_ID)
REFERENCES DEPARTMENT(ID) ON
DELETE CASCADE,
FOREIGN KEY (EMPLOYEE_ID)
REFERENCES EMPLOYEE(ID) ON
DELETE CASCADE);

###---------------------------------------------------------------------------------------###
							# 2. INSERT INTO table for DEPARTMENT:
###---------------------------------------------------------------------------------------###

INSERT INTO DEPARTMENT(ID, DEPT_NAME)
VALUES(1, 'HOT FOODS')

INSERT INTO DEPARTMENT(ID, DEPT_NAME)
VALUES(2, 'SANDWICHES')

INSERT INTO DEPARTMENT(ID, DEPT_NAME)
VALUES(3, 'SNACKS')

INSERT INTO DEPARTMENT(ID, DEPT_NAME)
VALUES(4, 'BEVERAGES')

###---------------------------------------------------------------------------------------###
							# 3. INSERT INTO table for EMPLOYEE:
###---------------------------------------------------------------------------------------###

###---------------------------------------------------------------------------------------###
# NOTE:
	# SUPER_ID -> 
	# RITA BITA = 1
	# HOLLY DEW = 2
	# PABLO ESCOBAR = 3
	# AL CAPONE = 4
###---------------------------------------------------------------------------------------###

INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(1,
							134568877,
							'JIM JONES',
							28000,
							1,
							'2015-01-26',
   							'2015-01-26',
							1)

INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(2,
							138568050,
							'RITA BITA',
							32000,
							4,
							'2017-02-15',
   							'2018-03-18',
							2)

INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(3,
						334558877,
						'HOLLY DEW',
						29000,
						2,
						'2016-01-15',
							'2016-01-15',
						3)

INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(4,
							666566666,
							'PABLO ESCOBAR',
							48000,
							3,
							'2014-01-26',
   							'2015-05-05',
							1)

INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(5,
							888918870,
							'AL CAPONE',
							40000,
							1,
							'2015-01-26',
   							'2016-01-01',
							3)


INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(6,
							111223333,
							'BONNIE CLYDE',
							42000,
							2,
							'2015-04-07',
   							'2016-01-01',
							4)

###---------------------------------------------------------------------------------------###
										ASSIGNMENT NOTES
###---------------------------------------------------------------------------------------###

deli organized into several depts (each dept. has unique name):
1. hot foods
2. sandwich
3. snacks
4. beverages

CONSTRAINTS TO ENFORCE:
each dept. must have exactly one employee as the CURRENT DEPT MGR (pkey)
each DEPT MGR must have exactly one hire date (pkey)
every employee must be assigned to one department (pkey ???)
as an employee, each DEPT MGR must have one assigned dept. (!= managing dept.)
as an employee, each DEPT MGR must have a supervisor
		supervisor is also an employee and must be assigned to a department
		supervisor is also an employee and has a supervisor
each dept. has exactly one employee as manager
	however, an employee can manage more than a single dept.

Notes:
No separate table for Deli (entire database represents CU DELI aka schema)
Create table for every major entity in specifications
relations between entities (ex. who works for which department) are their own tables
	choose primary keys (pkeys) per table to enforce constraints

NEW SCHEMA COLUMBIA DELI
CREATE TABLE DEPARTMENT
CREATE TABLE EMPLOYEE
CREATE TABLE MANAGER

Tables:

DEPTS
	DEPT NAME (pkey)
		hot foods INSERT_DATATYPE_HERE
		sandwich INSERT_DATATYPE_HERE
		snacks INSERT_DATATYPE_HERE
		beverages INSERT_DATATYPEc_HERE
	CURRENT MGR NAME (pkey)

	CURRENT MGR HIREDATE (pkey)
	
EMPLOYEES (pkeys: SSN INSERT_DATATYPE_HERE, WORKER NAME INSERT_DATATYPE_HERE, SALARY INSERT_DATATYPE_HERE, HIREDATE INSERT_DATATYPE_HERE)
	SSN 134-56-8877 INSERT_DATATYPE_HERE
	WORKER NAME Jim Jones INSERT_DATATYPE_HERE

	SALARY

	DEPT NAME
		hot foods
		sandwich
		snacks
		beverages
	HIREDATE
	STARTED
	SUPER NAME

SUPERVISORS
	SUPER NAME
		Rita Bita
		Holly Dew
		Pablo Escobar
		Al Capone
	SUB NAME
		Jim Jones
		Rita Bita
		Holly Dew
		Pablo Escobar
		Al Capone
		Bonnie Clyde

SSN 134568877
NAME 'Jim Jones'
SALARY 28000
DEPARTMENT 1
HIREDATE '2015-01-26'
STARTDATE ***MISSING***
SUPER 1

SSN 138568050
NAME Rita Bita
SALARY 32000
DEPARTMENT 4
HIREDATE 2017-02-15
STARTDATE 2018-03-18
SUPER Holly Dew

SSN 334558877
NAME Holly Dew
SALARY 29000
DEPARTMENT 2
HIREDATE 2016-01-15
STARTDATE ***MISSING***
SUPER Pablo Escobar

SSN 666566666
NAME Pablo Escobar
SALARY 48000
DEPARTMENT 3
HIREDATE 2014-01-26
STARTDATE 2015-05-05
SUPER Rita Bita

SSN 888918870
NAME Al Capone
SALARY 40000
DEPARTMENT 1
HIREDATE 2015-01-26
STARTDATE 2016-01-01
SUPER Pablo Escobar

SSN 111223333
NAME Bonnie Clyde
SALARY 42000
DEPARTMENT 2
HIREDATE 2015-04-07
STARTDATE 2016-01-01
SUPER Al Capone

###---EOF---###
