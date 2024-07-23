-- 8 -- 

/*
This query finds lawyers who meet the following criteria:
1. They have reported more than 7 hours of work in total across all cases.
2. They have reported hours on more cases than the number of cases Jessica is responsible for.
*/
SELECT 
    l.lname as "Lawyer Name",
    l.specialization as "Specialization"
FROM 
    lawyer l
	JOIN (
    -- Calculate the total hours reported by each lawyer and filter those with more than 7 hours
    SELECT 
        b.lname,
        SUM(b.hours) AS total_hours
    FROM 
        billing b
    GROUP BY 
        b.lname
    HAVING 
        SUM(b.hours) > 7
	) lh ON l.lname = lh.lname
	JOIN (
    -- Calculate the number of distinct cases each lawyer reported hours on
    SELECT 
        b.lname,
        COUNT(DISTINCT b.cid) AS case_count
    FROM 
        billing b
    GROUP BY 
        b.lname
	) lc ON l.lname = lc.lname
WHERE 
    -- Compare the number of cases each lawyer reported hours on to the number of cases Jessica is responsible for
    lc.case_count > (
        SELECT 
            COUNT(DISTINCT c.cid)
        FROM 
            cases c
        WHERE 
            c.lname = 'jessica'
    );
