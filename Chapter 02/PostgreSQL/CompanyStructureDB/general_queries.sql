-- (Q.10) 

-- This query summarizes the total budget for ongoing projects by department
SELECT 
    did,        -- Department ID
    dname,      -- Department Name
    SUM(budget) -- Total budget for ongoing projects
FROM 
    department NATURAL JOIN project
WHERE 
    duedate >= CURRENT_DATE -- Only include projects that are not yet due
GROUP BY 
    did, dname;


-- This query summarizes the total budget for departments over the last 5 years,
-- showing only departments with a total budget less than 2.5 million
SELECT 
    did,           -- Department ID
    SUM(budget)    -- Total budget over the selected period
FROM 
    department NATURAL JOIN budget
WHERE 
    -- Select budgets from the current year and the 4 previous years
    byear <= DATE_PART('year', CURRENT_DATE) 
    AND byear >= DATE_PART('year', CURRENT_DATE) - 4
GROUP BY 
    did
HAVING 
    SUM(budget) < 2500000;  -- Filter for departments with total budget less than 2.5 million


-- This query calculates the difference in average salary between employees
-- who are assigned to projects and those who are not
WITH 
    -- CTE for average salary of employees on projects
    inproject (inp) AS (
        SELECT AVG(salary)
        FROM employee
        WHERE eid IN (
            SELECT eid 
            FROM onproject
        )
    ), 
    -- CTE for average salary of employees not on projects
    notinproject (notinp) AS (
        SELECT AVG(salary)
        FROM employee
        WHERE eid NOT IN (
            SELECT eid 
            FROM onproject
        )
    )

-- Main query to calculate the difference
SELECT inp - notinp AS salary_difference
FROM inproject, notinproject;
