-- @block
SELECT COUNT(emp_id)
FROM employee;

-- @block
SELECT COUNT(super_id)
FROM employee;

-- @block
SELECT COUNT (emp_id)
FROM employee
WHERE branch_id = 1;

-- @block
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND YEAR(birth_date) > '1970';

-- @block
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

-- @block
SELECT SUM(salary)
FROM employee;

-- @block
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

-- @block
SELECT AVG(salary), sex
FROM employee
GROUP BY sex;

-- @block
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;