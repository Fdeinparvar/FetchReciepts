--When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
SELECT A.rewards_receipt_status, A.Average_Spent, CASE A.r WHEN 1 THEN CONCAT(A.rewards_receipt_status , ' reciepts have the higher average spent per receipt') ELSE '' END AS Result FROM       
            --Subquery returns the average spent for rewards receipt status that are accepted or rejected. It orders them by average spent    
            (SELECT ROW_NUMBER() AS r, rewards_receipt_status, AVG(total_spent) AS Average_Spent FROM receipt 
            WHERE rewards_receipt_status IN ('Accepted','Rejected')
            GROUP BY rewards_receipt_status
            ORDER BY AVG(total_spent)
            ) A