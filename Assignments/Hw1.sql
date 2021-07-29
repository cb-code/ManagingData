###--------------------------------------------BOF--------------------------------------------###
Hw1 | C.Blanchard (chb2132)
Managing Data | APAN 5400
###-------------------------------------------------------------------------------------------###


###-------------------------------------------------------------------------------------------###
Consider the following schema:
	Suppliers(sid, sname, address)
	Parts(pid, pname, color)
	Catalog(sid, pid, cost)

Assumptions:
	Each part has only one color.
	The cost field is a real number with two decimal places (e.g., 100.25, 93.00).
	The sid field in Suppliers and the sid field in Catalog refer to the same field.
	The pid field in Parts and the pid field in Catalog refer to the same field.

Notes:
	Parts AS P:
		P.pid
		P.pname
		P.color

	Suppliers AS S:
		S.sid
		S.sname
		S.address

	Catalog AS C
		C.sid
		C.pid
		C.cost
###-------------------------------------------------------------------------------------------###


###-------------------------------------------------------------------------------------------###
1. Find the names of all suppliers who supply a green part.

	SELECT sname
	FROM Parts AS P, Catalog AS C, Suppliers AS S
	WHERE P.color = "green" AND
	P.pid = C.pid AND
	C.sid = S.sid
###-------------------------------------------------------------------------------------------###


###-------------------------------------------------------------------------------------------###
2. Find the names of all suppliers who are from Illinois.

	SELECT sname
	FROM Suppliers AS S
	WHERE S.address like '%Illinois%'
###-------------------------------------------------------------------------------------------###


###-------------------------------------------------------------------------------------------###
3. Find the names of all suppliers who sell a red part costing less than $100.

	SELECT sname
	FROM Parts AS P, Catalog AS C, Suppliers AS S
	WHERE P.color = "red" AND
	P.pid = C.pid AND
	C.cost < 100.00 AND
	C.sid = S.sid
###-------------------------------------------------------------------------------------------###



###-------------------------------------------------------------------------------------------###
4. Find the names and colors of all parts that are green or red.

	SELECT pname, color
	FROM Parts AS P
	WHERE P.color = "green" OR 
	P.color = "red"
###-----------------------------------------EOF-----------------------------------------------###
