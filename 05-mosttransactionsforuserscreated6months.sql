--Which brand has the most transactions among users who were created within the past 6 months?
SELECT TOP 1 PI.Brand_code AS Brand_Code,count(R.receipt_id) as total_transactions 
FROM purchase_items PI
JOIN receipt R 
ON R.receipt_id = PI.receipt_id
JOIN users U 
ON U.user_id = R.user_id
WHERE to_date(U.created_date,'YYYY-MM-DD') between add_months(trunc(sysdate,'mm'),-6) and trunc(sysdate,'mm')
GROUP BY x.brand_code
ORDER BY count(R.receipt_id)