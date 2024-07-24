-- 10 --

/*
This query finds a non-partner lawyer who:
1. Is responsible for exactly one case
2. Assists in all other cases 
*/
SELECT l.lname AS "Lawyer Name"
FROM lawyer l
WHERE 
    l.partner IS NULL -- Non-partner lawyer
    -- Lawyer is responsible for exactly one case 
    AND l.lname IN ( 
        SELECT lname
        FROM cases
        GROUP BY lname
        HAVING COUNT(DISTINCT cid) = 1
    )
    -- Lawyer is involved in all cases except one
    AND l.lname IN (
        SELECT lname 
        FROM oncase
        GROUP BY lname 
        HAVING COUNT(DISTINCT cid) = (
            -- Calculate total number of cases minus one
            SELECT COUNT(DISTINCT cid) - 1 AS total_cases
            FROM cases
        )
    );       
