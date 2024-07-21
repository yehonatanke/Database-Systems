-- (Q-8) Among the projects that do not have any employees with a classification higher than 3, 
-- find the projects that have the highest number of employees working on them. 
-- Present to each project that meets the condition the name of the project and the budget of the project.

-- This query selects projects with the highest number of employees,
-- excluding projects that have employees with classification > 3
SELECT pname, budget
FROM project NATURAL JOIN onproject
WHERE pid NOT IN (
    -- Subquery to exclude projects with high-classification employees
    SELECT pid 
    FROM onproject NATURAL JOIN employee 
    WHERE classification > 3
)
GROUP BY pname, budget, pid 
HAVING COUNT(eid) >= ALL (
    -- Subquery to find the maximum number of employees on any eligible project
    SELECT COUNT(eid)
    FROM onproject
    WHERE pid NOT IN (
        -- Nested subquery to again exclude projects with high-classification employees
        SELECT pid 
        FROM onproject NATURAL JOIN employee 
        WHERE classification > 3
    )        
    GROUP BY pid
);
