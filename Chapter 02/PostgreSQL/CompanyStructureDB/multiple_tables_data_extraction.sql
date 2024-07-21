
-- (01) Finding the name and salary of employees from department 1 working on the ׳search׳ project
SELECT ename, eo.salary
FROM (employee NATURAL JOIN onproject) as eo, project
WHERE eo.pid = project.pid and eo.did = 1 and pname = 'search';



-- (02) Finding a pair of employees who always work on the same projects 
-- (ie, if one of them is associated with a project, the other is associated with this project, and vice versa).
-- Each pair of workers must appear only once.
-- This query finds pairs of employees who work on exactly the same set of projects
SELECT DISTINCT o1.eid, o2.eid 
FROM onproject AS o1, onproject AS o2
WHERE 
    -- Ensure we don't compare an employee with themselves and avoid duplicate pairs
    o1.eid < o2.eid 
    -- Both employees must work on at least one common project
    AND o1.pid = o2.pid 
    -- Check if o1 doesn't work on any project that o2 doesn't work on
    AND NOT EXISTS (
        SELECT *
        FROM onproject AS o3 
        WHERE o3.eid = o1.eid 
            AND o3.pid NOT IN (
                SELECT pid
                FROM onproject AS o4
                WHERE o4.eid = o2.eid
            )
    )
    -- Check if o2 doesn't work on any project that o1 doesn't work on
    AND NOT EXISTS (
        SELECT * 
        FROM onproject AS o3 
        WHERE o3.eid = o2.eid 
            AND o3.pid NOT IN (
                SELECT pid 
                FROM onproject AS o4 
                WHERE o4.eid = o1.eid
            )
    );
