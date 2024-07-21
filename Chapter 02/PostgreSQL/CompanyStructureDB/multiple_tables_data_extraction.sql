
-- Finding the name and salary of employees from department 1 working on the ׳search׳ project
SELECT ename, eo.salary
FROM (employee NATURAL JOIN onproject) as eo, project
WHERE eo.pid = project.pid and eo.did = 1 and pname = 'search';


-- Finding a pair of employees who always work on the same projects 
-- (ie, if one of them is associated with a project, the other is associated with this project, and vice versa).
-- Each pair of workers must appear only once.
