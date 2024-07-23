-- 7 --

-- Calculate the total billing amount for each lawyer and case in the current month
SELECT 
    b.lname as "Lawyer Name",        
    b.cid as "Case ID",             
	SUM(b.hours) AS "Total Hours",  
    SUM(b.hours * l.hbilling) AS "Total Amount"  
FROM
    billing b
	-- Join with lawyer table to get the hourly billing rate
    JOIN lawyer l         
        ON b.lname = l.lname
WHERE 
    -- The following conditions ensure we only consider billings from the current month up to today
    
    -- Commented out condition for last 30 days:
    -- b.bdate < CURRENT_DATE and b.bdate > CURRENT_DATE - 30
    
    -- Check if the billing is from the current year
    date_part('year', b.bdate) = date_part('year', CURRENT_DATE) 
    -- Check if the billing is from the current month
    AND date_part('month', b.bdate) = date_part('month', CURRENT_DATE) 
    -- Ensure we don't include future dates
    AND b.bdate <= CURRENT_DATE
GROUP BY
	-- Group results by lawyer and case
    b.lname, b.cid;   
