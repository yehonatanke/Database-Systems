-- 4

-- Query to display information about all open cases
-- including case number, title, responsible lawyer, and their specialization
SELECT 
    c.cid AS "Case Number",
    c.title AS "Case Title",
    l.lname AS "Responsible Lawyer",
    l.specialization AS "Specialization"
FROM 
    cases c
    -- Join with lawyer table to get lawyer's specialization
    JOIN lawyer l ON c.lname = l.lname
WHERE 
    -- Assuming open cases have NULL status
    c.status IS NULL
