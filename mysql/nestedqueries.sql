-- @block
SELECT employee.first_name, employee.last_name
FROM employee
WHERE emp_id IN (
    SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);
-- @block
SELECT client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
    LIMIT 1
);

-- @block
SELECT employee.first_name, employee.branch_id
FROM employee
WHERE employee.emp_id IN(
    SELECT branch.mgr_id
    FROM branch
    WHERE NOT ISNULL(branch.mgr_id)
);

-- @block
SELECT employee.emp_id, COUNT(employee.emp_id)
FROM employee
WHERE employee.emp_id NOT IN (
    SELECT branch.mgr_id
    FROM branch
    WHERE NOT ISNULL(branch_id)
);

-- @block
SELECT employee.branch_id, COUNT(employee.emp_id)
FROM employee
WHERE employee.emp_id NOT IN (
    SELECT branch.mgr_id
    FROM branch
    WHERE NOT ISNULL(branch.mgr_id)
)
GROUP BY employee.branch_id;
