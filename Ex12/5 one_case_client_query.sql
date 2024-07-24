-- 5 --

-- Query to find clients with only one case and only one lawyer working on that case
SELECT DISTINCT 
    c.cname AS "Client Name"
FROM 
	  client c
    JOIN cases cs ON c.cname = cs.cname
WHERE 
    -- Ensure the client has only one case
    c.cname IN (
        SELECT cname 
        FROM cases 
        GROUP BY cname 
        HAVING COUNT(*) = 1
    )
    -- Ensure only one lawyer (the responsible one) is working on the case
    AND cs.cid NOT IN (
        SELECT cid 
        FROM onCase
    )
    -- Ensure the client's name is not in the result of the subquery
    AND c.cname NOT IN (
        SELECT c2.cname
        FROM client c2
        JOIN cases cs2 ON c2.cname = cs2.cname
        JOIN onCase oc ON cs2.cid = oc.cid
    );
