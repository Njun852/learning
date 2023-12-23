-- @block
SELECT first_name AS data
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client;

-- @block
SELECT client_name, branch_id
FROM client UNION
SELECT supplier_name, branch_id
FROM branch_supplier;

-- @block
SELECT salary AS spentearned
FROM employee UNION
SELECT total_sales
FROM works_with;
