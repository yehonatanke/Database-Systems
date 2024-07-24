-- 9 --

-- Query to select cases with the maximum number of lawyers, excluding cases handled by partners
SELECT 
    case_counts.cid as "Case ID",
    case_counts.lawyer_count as "Number Of Lawyers"
FROM (
    SELECT 
        c.cid,
        COUNT(DISTINCT oc.lname) AS lawyer_count
    FROM 
        cases c
    JOIN 
        onCase oc ON c.cid = oc.cid
    WHERE 
        c.status IS NULL -- Case is active
        AND c.cid NOT IN (
            -- Subquery to find cases with a partner lawyer as the responsible lawyer
            SELECT 
                cid
            FROM 
                cases c2
            JOIN 
                lawyer l1 ON c2.lname = l1.lname
            WHERE 
                l1.partner IS NOT NULL
        )
        AND c.cid NOT IN (
            -- Subquery to find cases with a partner lawyer in any role
            SELECT 
                oc2.cid
            FROM 
                onCase oc2
            JOIN 
                lawyer l2 ON oc2.lname = l2.lname
            WHERE 
                l2.partner IS NOT NULL
        )
    GROUP BY 
        c.cid
) AS case_counts
WHERE 
    case_counts.lawyer_count = (
        -- Subquery to find the maximum number of lawyers for any eligible case
        SELECT 
            MAX(sub.lawyer_count)
        FROM (
            SELECT 
                COUNT(DISTINCT oc3.lname) AS lawyer_count
            FROM 
                cases c3
            JOIN 
                onCase oc3 ON c3.cid = oc3.cid
            WHERE 
                c3.status IS NULL
                AND c3.cid NOT IN (
                    SELECT 
                        cid
                    FROM 
                        cases c4
                    JOIN 
                        lawyer l3 ON c4.lname = l3.lname
                    WHERE 
                        l3.partner IS NOT NULL
                )
                AND c3.cid NOT IN (
                    SELECT 
                        oc4.cid
                    FROM 
                        onCase oc4
                    JOIN 
                        lawyer l4 ON oc4.lname = l4.lname
                    WHERE 
                        l4.partner IS NOT NULL
                )
            GROUP BY 
                c3.cid
        ) AS sub
    );
