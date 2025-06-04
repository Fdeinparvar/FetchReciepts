--When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
SELECT A.rewards_receipt_status AS Receipt_Status, A.Item_Count AS Item_Count, CASE A.r WHEN 1 THEN CONCAT(A.rewards_receipt_status , ' reciepts have the largest number of total items purchased') ELSE '' END AS Result FROM       
            --Subquery returns the total number of items purchased for rewards receipt status that are accepted or rejected. It orders them by total number of items purchased   
            (SELECT ROW_NUMBER() AS r, rewards_receipt_status, sum(purchased_item_count) AS Item_Count FROM receipt 
            WHERE rewards_receipt_status IN ('Accepted','Rejected')
            GROUP BY rewards_receipt_status
            ORDER BY sum(purchased_item_count)
            ) A