-- 6 --

-- Query to find clients with at least 2 active cases managed by the same partner lawyer
-- Display client name and the IDs of 2 such cases, with each pair appearing only once    
SELECT DISTINCT 
    ac1.cname AS "Client Name",
    ac1.cid AS "Case ID 1",
    ac2.cid AS "Case ID 2"
FROM 
    cases ac1
    -- Join the cases table with itself to pair cases for the same client
    JOIN cases ac2 
    	ON ac1.cname = ac2.cname 
		AND ac1.lname = ac2.lname 
		AND ac1.cid < ac2.cid
    -- Join with the lawyer table to check for partner status
    JOIN lawyer l 
    	ON ac1.lname = l.lname
WHERE 
    -- Ensure both cases are active (status is NULL)
    ac1.status IS NULL
    AND ac2.status IS NULL
    -- Check if the lawyer is a partner
    AND l.partner IS NOT NULL
    -- Subquery to ensure the client has at least 2 active cases
    AND (
        SELECT COUNT(*)
        FROM cases ac3
        WHERE ac3.cname = ac1.cname 
          AND ac3.lname = ac1.lname
          AND ac3.status IS NULL
    ) >= 2;
