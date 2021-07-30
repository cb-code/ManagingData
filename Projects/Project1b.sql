###---------------------------------------------------------------------------------------###
			5400 MANAGING DATA | Project 1.2 CU DELI DATABASE | UNI: CHB2132
###---------------------------------------------------------------------------------------###


###---------------------------------------------------------------------------------------###
							# 1. DROP TABLE (IF IT EXISTS):						
###---------------------------------------------------------------------------------------###

DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS MANAGER;
DROP TABLE IF EXISTS DEPARTMENT;
DROP TABLE IF EXISTS SUPERVISOR;
DROP TABLE IF EXISTS DISCOUNT;

###---------------------------------------------------------------------------------------###
			# 2. CREATE TABLE FOR DEPARTMENT, EMPLOYEE_STATUS, MANAGER, EMPLOYEE:
###---------------------------------------------------------------------------------------###

CREATE TABLE DEPARTMENT(
	ID bigserial PRIMARY KEY,
	DEPT_NAME varchar NOT NULL);

CREATE TABLE EMPLOYEE_STATUS(
	ID bigserial PRIMARY KEY,
	EMPLOYEE_NAME varchar NOT NULL,
	DISCOUNT numeric NOT NULL);

CREATE TABLE MANAGER(
	ID bigserial PRIMARY KEY,
	DEPT_ID bigint UNIQUE,
	EMPLOYEE_ID bigint NOT NULL,
	START_DATE date NOT NULL,
	DEPT_NAME varchar NOT NULL PRIMARY KEY,
	MANAGER_SSN varchar(12),
	FOREIGN KEY (MANAGER_SSN) REFERENCES EMPLOYEE(SSN)
	FOREIGN KEY (DEPT_ID)
	REFERENCES DEPARTMENT(ID) ON
	DELETE CASCADE,
	FOREIGN KEY (EMPLOYEE_ID)
	REFERENCES EMPLOYEE(ID) ON
	DELETE CASCADE);

CREATE TABLE EMPLOYEE(
	ID bigserial PRIMARY KEY,
	SSN char(11) UNIQUE,
	EMPLOYEE_NAME varchar NOT NULL,
	DEPT_ID bigint NOT NULL,
	EMPLOYEE_STATUS_ID bigint NOT NULL,
	SUPER_ID bigint NOT NULL,
	HIRE_DATE date NOT NULL,
	SALARY numeric NOT NULL,
	FOREIGN KEY (EMPLOYEE_STATUS_ID)
	REFERENCES EMPLOYEE_STATUS(ID) ON DELETE CASCADE,
	FOREIGN KEY (DEPT_ID) REFERENCES
	DEPARTMENT(ID) ON DELETE CASCADE,
	FOREIGN KEY (SUPER_ID) REFERENCES EMPLOYEE(ID) 
	ON DELETE CASCADE);

###---------------------------------------------------------------------------------------###
							# 3. INSERT INTO table for DEPARTMENT:
###---------------------------------------------------------------------------------------###

INSERT INTO DEPARTMENT(ID, DEPT_NAME)
VALUES(1, 'HOT FOODS');

INSERT INTO DEPARTMENT(ID, DEPT_NAME)
VALUES(2, 'SANDWICHES');

INSERT INTO DEPARTMENT(ID, DEPT_NAME)
VALUES(3, 'SNACKS');

INSERT INTO DEPARTMENT(ID, DEPT_NAME)
VALUES(4, 'BEVERAGES');

###---------------------------------------------------------------------------------------###
							# 4. INSERT INTO table for EMPLOYEE:
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
							1);

INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(2,
							138568050,
							'RITA BITA',
							32000,
							4,
							'2017-02-15',
   							'2018-03-18',
							2);

INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
	VALUES(3,
							334558877,
							'HOLLY DEW',
							29000,
							2,
							'2016-01-15',
								'2016-01-15',
							3);

INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(4,
							666566666,
							'PABLO ESCOBAR',
							48000,
							3,
							'2014-01-26',
   							'2015-05-05',
							1);

INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(5,
							888918870,
							'AL CAPONE',
							40000,
							1,
							'2015-01-26',
   							'2016-01-01',
							3);


INSERT INTO EMPLOYEE(ID, SSN, EMPLOYEE_NAME, SALARY, DEPT_ID, HIRE_DATE, START_DATE, SUPER_ID)
VALUES(6,
							111223333,
							'BONNIE CLYDE',
							42000,
							2,
							'2015-04-07',
   							'2016-01-01',
							4);

###---------------------------------------------------------------------------------------###

###---------------------------------------------------------------------------------------###
					# 5. INSERT INTO table for EMPLOYEE_STATUS:
###---------------------------------------------------------------------------------------###

INSERT INTO EMPLOYEE_STATUS(ID, EMPLOYEE_NAME, DISCOUNT)
VALUES(1,
							'JIM JONES',
							0.15);

INSERT INTO EMPLOYEE_STATUS(ID, EMPLOYEE_NAME, DISCOUNT)
VALUES(1,
							'RITA BITA',
							0.20);

INSERT INTO EMPLOYEE_STATUS(ID, EMPLOYEE_NAME, DISCOUNT)
VALUES(1,
							'HOLLY DEW',
							0.20);

INSERT INTO EMPLOYEE_STATUS(ID, EMPLOYEE_NAME, DISCOUNT)
VALUES(1,
							'PABLO ESCOBAR',
							0.20);

INSERT INTO EMPLOYEE_STATUS(ID, EMPLOYEE_NAME, DISCOUNT)
VALUES(1,
							'AL CAPONE',
							0.20);

INSERT INTO EMPLOYEE_STATUS(ID, EMPLOYEE_NAME, DISCOUNT)
VALUES(1,
							'BONNIE CLYDE',
							0.20);

###---------------------------------------------------------------------------------------###

###---------------------------------------------------------------------------------------###
"EMP_DISCOUNT" VIEW TO SHOW EACH EMPLOYEE NAME, DEPARTMENT, SUPERVISOR, DISCOUNT LEVEL [ONLY]
###---------------------------------------------------------------------------------------###

CREATE VIEW EMPLOYEE_DISCOUNT AS 
	SELECT E.EMPLOYEE_NAME, D.DEPT_NAME, 
	E.SUPER_ID, ES.DISCOUNT FROM EMPLOYEE E 
	JOIN EMPLOYEE_STATUS ES ON E.EMPLOYEE_STATUS_ID = ES.ID 
	JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.ID;

###---------------------------------------------------------------------------------------###
###-----------------------------------END-OF-FILE-----------------------------------------###
