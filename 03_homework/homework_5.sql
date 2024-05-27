-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

SELECT DISTINCT vendor_id
FROM vendor_inventory
	
	
-- Step 1: Calculate the number of customers
WITH customer_count AS (
    SELECT COUNT(*) AS customer_count
    FROM customer
),

-- Step 2: Calculate the number of distinct vendor-product combinations
vendor_product AS (
    SELECT 
		 v.vendor_name,
         p.product_name,
        vi.original_price
    FROM 
        vendor_inventory vi
    JOIN 
        vendor v ON vi.vendor_id = v.vendor_id
    JOIN 
        product p ON vi.product_id = p.product_id
)

-- Step 3: Perform the CROSS JOIN and calculate revenue
SELECT 
    vp.vendor_name,
    vp.product_name,
    vp.original_price * 5 * cc.customer_count AS total_revenue
FROM 
    vendor_product vp
CROSS JOIN 
    customer_count cc
ORDER BY 
    vp.vendor_name, vp.product_name;

-- Step 1: Get the counts of distinct vendors and product names (x) and customers (y)
WITH VendorProductCounts AS (
    SELECT COUNT(DISTINCT Vendor) AS vendor_count, COUNT(DISTINCT Product_name) AS product_count
    FROM Product
	JOIN vendor
),
CustomerCounts AS (
    SELECT COUNT(DISTINCT CustomerID) AS customer_count
    FROM Customer
)

-- Step 2: CROSS JOIN to create the Cartesian product of vendors, products, and customers
, CrossJoined AS (
    SELECT 
        v.Vendor, 
        p.ProductName, 
        c.CustomerID
    FROM 
        (SELECT DISTINCT Vendor, ProductName FROM Products) AS vp
    CROSS JOIN 
        (SELECT DISTINCT CustomerID FROM Customers) AS c
)

-- Step 3: Use the CROSS JOIN result and filter as necessary, then GROUP BY
SELECT
    cj.Vendor,
    cj.ProductName,
    cj.CustomerID,
    COUNT(*) AS count
FROM 
    CrossJoined AS cj
GROUP BY
    cj.Vendor,
    cj.ProductName,
    cj.CustomerID;




-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */
CREATE TABLE product_units AS
SELECT 
    *,
    CURRENT_TIMESTAMP AS snapshot_timestamp
FROM 
    product
WHERE 
    product_qty_type = 'unit';



/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units (product_id, product_name, product_size, product_category_id, product_qty_type, snapshot_timestamp)
VALUES (24, 'Apple Pie', '10"', 8, 'unit', CURRENT_TIMESTAMP);



-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/
-- Assuming the table structure and the primary key column name are known:

DELETE FROM product_units
WHERE product_id = 24;





-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */

-- Step 1: Add the new column current_quantity to the product_units table
ALTER TABLE product_units
ADD current_quantity INT;

-- Step 2: Update the current_quantity column based on the last quantity value from vendor_inventory_details
UPDATE product_units 
SET  current_quantity = COALESCE((
        SELECT MAX(vi.quantity)
        FROM vendor_inventory vi
        WHERE vi.product_id = product_units.product_id
    ), 0);


