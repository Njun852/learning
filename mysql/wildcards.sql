-- @block
SELECT *
FROM client
WHERE client_name LIKE '%LCC';

-- @block
SELECT *
FROM client
WHERE client_name NOT LIKE '% %';

-- @block
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '% label';

-- @block
SELECT *
FROM employee
WHERE birth_date LIKE '____-10-__';

-- @block
SELECT *
FROM client
WHERE client_name LIKE '% %school%';