import pandas as pd
import xlsxwriter
import pyodbc


conn = pyodbc.connect('Driver={SQL Server}; Server=ServerIP; uid=UID; pwd=Password; Trusted_Connection=No;')
duplicatebarcodes = "SELECT P.* FROM (SELECT barcode, Count(product_id) as count FROM product GROUP BY barcode HAVING COUNT(product_id) > 1) X JOIN product P ON X.product_id = P.product_id ORDER BY P.barcode"
duplicateuserids = "SELECT U.* FROM (SELECT user_id from users group by user_id HAVING COUNT(user_id) > 1) X JOIN users ON U.user_id = X.user_id"
missingproductsorbrands = "SELECT Receipt_ID, 'Missing product barcode' AS Mismatch FROM purchase_items PI WHERE PI.product_barcode NOT IN (SELECT barcode FROM product) UNION SELECT Receipt_ID, 'Missing brand code' AS Mismatch FROM purchase_items PI WHERE PI.brand_code NOT IN (SELECT brand_code FROM brand)" 
missingusers = "SELECT * FROM receipts R WHERE R.user_id NOT IN (SELECT user_id FROM users)"

with pd.ExcelWriter("Validation.xlsx", engine="xlsxwriter", options = {'strings_to_numbers': False, 'strings_to_formulas': False}) as writer:
        try:
            df = pd.read_sql(duplicatebarcodes, conn)
            df.to_excel(writer, sheet_name = "duplicatebarcodes", header = True, index = False)
            print("duplicate barcodes sheet created successfully!")
        except:
            print("There is an error with duplicate barcodes sheet")

with pd.ExcelWriter("Validation.xlsx", engine="xlsxwriter", options = {'strings_to_numbers': False, 'strings_to_formulas': False}) as writer:
        try:
            df = pd.read_sql(duplicateuserids, conn)
            df.to_excel(writer, sheet_name = "duplicateuserids", header = True, index = False)
            print("duplicate User IDs sheet created successfully!")
        except:
            print("There is an error with duplicate User IDs sheet")

with pd.ExcelWriter("Validation.xlsx", engine="xlsxwriter", options = {'strings_to_numbers': False, 'strings_to_formulas': False}) as writer:
        try:
            df = pd.read_sql(missingproductsorbrands, conn)
            df.to_excel(writer, sheet_name = "missingproductsorbrands", header = True, index = False)
            print("missing products or brands sheet created successfully!")
        except:
            print("There is an error with missing products or brands sheet sheet")

with pd.ExcelWriter("Validation.xlsx", engine="xlsxwriter", options = {'strings_to_numbers': False, 'strings_to_formulas': False}) as writer:
        try:
            df = pd.read_sql(missingusers, conn)
            df.to_excel(writer, sheet_name = "missingusers", header = True, index = False)
            print("Missing Users sheet created successfully!")
        except:
            print("There is an error with Missing Users IDs sheet")

