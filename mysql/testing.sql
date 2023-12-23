SELECT manager.first_name AS manager, COUNT(member.emp_id) AS member_count
FROM employee manager
JOIN employee member 
ON member.branch_id = manager.branch_id
AND manager.emp_id IN (
    SELECT branch.mgr_id
    FROM branch
    WHERE NOT ISNULL(branch.mgr_id)
)
AND member.emp_id <> manager.emp_id 
GROUP BY manager.first_name; 
