-- Finding employees with classification 1-3 whose salary is lower than 12000

-- option 1:
SELECT eid 
from employee
WHERE (classification <= 3 AND classification >= 1) and salary < 12000;

-- option 2:
SELECT eid 
from employee
WHERE (classification = 3 AND classification = 2 classification = 1) and salary < 12000;
