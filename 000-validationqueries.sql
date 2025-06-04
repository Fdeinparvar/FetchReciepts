--Returns products that have duplicate barcodes
SELECT P.* FROM 

            (SELECT barcode, Count(product_id) as count FROM product 
            GROUP BY barcode
            HAVING COUNT(product_id) > 1) X

JOIN product P
ON X.barcode = P.barcode
ORDER BY P.barcode


--Returns Users with Duplicate old user IDs
SELECT U.* FROM
            (SELECT old_id from users 
            group by old_id
            HAVING COUNT(user_id) > 1) X
JOIN Users
ON U.old_id = X.old_id


--Returns Receipt IDs with missing product barcodes or brand codes
SELECT Receipt_ID, 'Missing product barcode' AS Mismatch FROM purchase_items PI
WHERE PI.product_barcode NOT IN (SELECT barcode FROM product) 
UNION 
SELECT Receipt_ID, 'Missing brand code' AS Mismatch FROM purchase_items PI
WHERE PI.brand_code NOT IN (SELECT brand_code FROM brand) 


--Returns Receipts with missing users
SELECT * FROM receipts R
WHERE R.user_id NOT IN (SELECT user_id FROM users) 






