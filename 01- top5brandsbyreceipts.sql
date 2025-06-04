-- What are the top 5 brands by receipts scanned for most recent month? --this report returns receipts that were scanned the last full month, not the previous month from the date of running the query

SELECT B.brand_id AS Brand_ID, BR.brand_code AS Brand_Code, BR.name AS Brand_Name , BR.description AS Brand_Description, B.noscanned AS Number_Scanned FROM 
            -- Sub query returns top 5 brand ids in reciepts scanned in the last month
            (SELECT TOP 5 count(A.reciept_id) AS noscanned, A.brand_id FROM 
                        -- Sub query that returns the brand_ID for every reciept scanned in the last month
                        (SELECT R.receipt_id, R.scanned_date, PI.brand_id

                        FROM purchase_items PI
                        JOIN receipt R 
                        ON R.receipt_id = PI.receipt_id

                        WHERE to_date(R.scanned_date,'YYYY-MM-DD') between add_months(trunc(sysdate,'mm'),-1) and last_day(add_months(trunc(sysdate,'mm'),-1)) 
                        --Returns receipts that were scanned Last month, not the previous month from the date of running the query
                        ) A 

            GROUP BY A.brand_ID 
            ORDER BY count(A.reciept_id) 
            ) B 
JOIN brand BR 
ON BR.brand_id = B.brand_id
