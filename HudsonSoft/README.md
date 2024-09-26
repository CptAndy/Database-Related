
# HudsonSoft Database

## Overview

The HudsonSoft database is designed to manage the product sales, purchases, and returns for a company, including customer information and product details. The system also supports the tracking of product types and different types of returns. Additionally, triggers are implemented to automatically update customer spendings, product stock, and return processing.

## Database Structure

### 1. Supporting Tables
#### `Product_type`
Stores the types of products sold by the company.
- `prod_type_id` (INT, Primary Key, Auto Increment): Unique identifier for the product type.
- `prod_type_name` (VARCHAR(50), Not NULL): Name of the product type.

#### `Returns_type`
Stores different types of return policies.
- `Returns_type_id` (INT, Primary Key, Auto Increment): Unique identifier for the return type.
- `Returns_type_name` (VARCHAR(50), NULL): Name of the return type.

### 2. Main Tables
#### `Product`
Stores details about each product.
- `product_id` (INT, Primary Key, Auto Increment): Unique identifier for each product.
- `product_name` (VARCHAR(100), UNIQUE, Not NULL): Name of the product.
- `sales_number` (CHAR(8), UNIQUE, Not NULL): Sales number for the product.
- `price` (DECIMAL(10,2), Not NULL): Price of the product.
- `stock_quantity` (INT, DEFAULT 0, Not NULL): Quantity of the product in stock.
- `type_id` (INT, Foreign Key to `Product_type`): Type of the product.

**Constraints:**
- `CHK_stock_quantity`: Ensures stock quantity is non-negative.
- `CHK_price`: Ensures price is non-negative.

#### `Customer`
Stores customer details.
- `customer_id` (INT, Primary Key, Auto Increment): Unique identifier for each customer.
- `first_name` (VARCHAR(50), Not NULL): Customer's first name.
- `last_name` (VARCHAR(50), Not NULL): Customer's last name.
- `email` (VARCHAR(100), UNIQUE, Not NULL): Customer's email address.
- `phone` (VARCHAR(15), DEFAULT 'Not entered'): Customer's phone number.
- `state` (CHAR(2), Not NULL): State abbreviation where the customer resides.
- `city` (CHAR(25), Not NULL): City where the customer resides.
- `amount_spent` (DECIMAL(10,2), DEFAULT '0.00'): Total amount the customer has spent.
- `product_owned` (INT, DEFAULT 0): Number of products owned by the customer.
- `product_returned` (INT, DEFAULT 0): Number of products returned by the customer.

**Constraints:**
- `CHK_amount_spent`: Ensures amount spent is non-negative.
- `CHK_product_owned`: Ensures products owned is non-negative.
- `CHK_product_returned`: Ensures products returned is non-negative.

### 3. Transaction Tables
#### `Purchases`
Stores details of customer purchases.
- `purchases_id` (INT, Primary Key, Auto Increment): Unique identifier for each purchase.
- `customer_id` (INT, Foreign Key to `Customer`): Reference to the purchasing customer.
- `product_id` (INT, Foreign Key to `Product`): Reference to the purchased product.
- `type_id` (INT, Foreign Key to `Product_type`): Reference to the product type.
- `quantity` (INT, Not NULL): Quantity of product purchased.
- `purchases_date` (DATE): Date of purchase.

**Constraints:**
- `CHK_quantity`: Ensures purchased quantity is non-negative.

#### `Returns`
Stores details of customer returns.
- `Returns_id` (INT, Primary Key, Auto Increment): Unique identifier for each return.
- `purchases_id` (INT, Foreign Key to `Purchases`): Reference to the original purchase.
- `customer_id` (INT, Foreign Key to `Customer`): Reference to the customer returning the product.
- `product_id` (INT, Foreign Key to `Product`): Reference to the returned product.
- `returned_quantity` (INT, Not NULL): Quantity of product returned.
- `date_purchased` (DATE): Date of the original purchase.
- `date_returned` (DATE): Date of the return.
- `return_type_id` (INT, Foreign Key to `Returns_type`): Type of return.
**Constraints:**
- `CHK_returned_quantity`: Ensures returned quantity is non-negative.

## Triggers

### 1. `retrieve_date`
Automatically sets the return date (`date_returned`) to the current date for any new row inserted into the `Returns` table.

**Trigger Definition:**
```sql

DELIMITER //
-- curdate() was not cooperating so a trigger was recommended
CREATE TRIGGER retrieve_date
BEFORE INSERT ON `Returns`
FOR EACH ROW
BEGIN
    SET NEW.date_returned = CURDATE();
END //
DELIMITER ;
```

### 2. `update_amount`
Automatically updates the amount spent, the number of products owned by a customer, and adjusts product stock when a new purchase is made.

**Trigger Definition:**
```sql
DELIMITER //
-- CREATE the trigger
create trigger update_amount 
-- After inserting
after insert   
-- Inside the Purchases table
on `Purchases`
-- For each row inserted
for each row
-- Begin the update_amount process
BEGIN
-- Declare the variable
DECLARE price_of_product DECIMAL (10,2);
DECLARE sales_tax_rate DECIMAL (10,2);
DECLARE sales_tax_amount DECIMAL (10,2);
DECLARE total_cost_of_product DECIMAL (10,2);

SET sales_tax_rate = 0.07;
 -- PRODUCT PRICE into price_of_product
SELECT price INTO price_of_product 
    FROM Product
    WHERE product_id = NEW.product_id;
 -- calculating the amount
 SET total_cost_of_product = price_of_product * NEW.quantity;
 SET sales_tax_amount = total_cost_of_product * sales_tax_rate;
 SET total_cost_of_product = total_cost_of_product + sales_tax_amount;
-- Update amount spent and the quantity of product the customer owns
UPDATE Customer
SET amount_spent = amount_spent + total_cost_of_product,
product_owned = product_owned + NEW.quantity
WHERE customer_id = NEW.customer_id;

-- update inventory
UPDATE Product
SET stock_quantity = stock_quantity - NEW.quantity
 WHERE product_id = NEW.product_id;

END //
DELIMITER ;
```

### 3. `return_update`
Automatically updates the customer's account, including refunds and product ownership details, when a return is made.

**Trigger Definition:**
```sql
DELIMITER //
CREATE TRIGGER return_update
AFTER INSERT ON `Returns`
FOR EACH ROW
BEGIN
    -- DECLARATION
DECLARE refund_price DECIMAL (10,2);
DECLARE sales_tax_rate DECIMAL (10,2);
DECLARE sales_tax_amount DECIMAL (10,2);
DECLARE total_refund DECIMAL (10,2);
-- END of DECLARATIONS

SET sales_tax_rate = 0.07;

-- PRICE INTO refund_price
SELECT price INTO refund_price
FROM Product
WHERE product_id = NEW.product_id;

-- CALCULATIONS
SET total_refund = (refund_price * NEW.returned_quantity);
SET sales_tax_amount = (total_refund * sales_tax_rate);
SET total_refund = (total_refund + sales_tax_amount);

-- UPDATE
UPDATE Customer
SET amount_spent = amount_spent - total_refund
WHERE customer_id = NEW.customer_id;

-- UPDATE product_owned of customer
UPDATE Customer
SET product_owned = product_owned - NEW.returned_quantity
WHERE customer_id = NEW.customer_id;

-- UPDATE returned product of customer
UPDATE Customer
SET product_returned = product_returned + NEW.returned_quantity
WHERE customer_id = NEW.customer_id;
END //
DELIMITER ;
```
## Views

### 1. `V_purchase_LOG`
This view provides a detailed log of all purchases, showing invoice details, customer information, product details, and the total cost of each purchase, including taxes.

**View Definition:**
```sql
CREATE VIEW V_purchase_LOG AS 
SELECT p.purchases_id AS "Invoice No.",  
p.purchases_date AS "Date of Purchase", 
c.customer_id AS "Account No.",
CONCAT(c.first_name,', ',c.last_name) AS "Name", 
pr.product_id AS "Sales Number",
pr.product_name AS "Product Name", 
pt.prod_type_name AS "Product Variaition",
p.quantity AS "Quantity", 
(pr.price * p.quantity) AS "Subtotal",
ROUND(((pr.price * 0.07) + pr.price),2) * p.quantity AS "Total"
FROM Purchases p
JOIN Customer c ON p.customer_id = c.customer_id
JOIN Product pr ON p.product_id = pr.product_id
JOIN product_type pt ON p.type_id = pt.prod_type_id
ORDER BY p.purchases_id;
```

### 2. `v_return_LOG`

**View Definition:**
```sql
CREATE VIEW V_return_LOG AS 
SELECT r.returns_id AS "Return Invoice No.",  
r.date_returned AS "Date Returned",
pu.purchases_date AS "Date of Purchase",
c.customer_id AS "Acctount No.",
CONCAT(c.first_name,' ',c.last_name) AS "Name",
p.product_id AS "Sales Number",
p.product_name AS "Product Name",
pt.prod_type_name AS "Product Variation",  -- You can still retrieve the product type from the Product table
r.returned_quantity AS "Returned Quantity",
rt.returns_type_name AS "Reasoning",
(p.price * returned_quantity) AS "Subtotal",
ROUND(((p.price * 0.07) + p.price),2) * r.returned_quantity AS  "Total Refund"
FROM returns r
JOIN Customer c ON c.customer_id = r.customer_id 
JOIN Product p ON p.product_id = r.product_id
JOIN Product_type pt ON pt.prod_type_id = p.type_id  -- Join through the Product table
JOIN Returns_type rt ON rt.returns_type_id = r.return_type_id
JOIN Purchases pu ON pu.purchases_id = r.purchases_id
ORDER BY r.returns_id;
```

## Demonstration

### Example

```sql
-- Example usage: The type of product
INSERT INTO `Product_type` (`prod_type_name`) VALUES
('Magic'),
('Gasoline'),
('Electricity');

-- Example usage: Reason for return
INSERT INTO `Returns_type` (`Returns_type_name`) VALUES
('Defective'),
('Customer Changed Mind'),
('No Longer Needed');

-- Example usage: Insert a product
INSERT INTO `Product` (`product_name`, `sales_number`, `price`, `stock_quantity`, `type_id`) VALUES
('Elder Wand', 'WSTF0001', 349.99, 0, 1);

-- EXAMPLE PURPOSES FOR NOW CAN REMOVE THIS IN OFFICIAL AS WELL AS HERE TO PUT IN ANY QUANTITY
UPDATE Product
SET stock_quantity = 500;

-- Example usage: Insert into customer
INSERT INTO customer (first_name, last_name, email, phone, state, city) VALUES
('Alice', 'Smith', 'alices01@example.com', '212-555-1234', 'NY', 'New York'),

-- Example usage: Insert into purchases
INSERT INTO Purchases (customer_id, product_id, type_id, quantity, purchases_date) 
VALUES (1, 1, 1, 5, '2024-09-26');

-- Example usage: Return a product
INSERT INTO Returns (purchases_id, customer_id, product_id, returned_quantity, date_purchased, return_type_id, type_id)
VALUES (1, 1, 1, 1, '2024-09-26', 1, 1);

-- View customer's
SELECT * FROM Customer;
-- View returns
SELECT * FROM returns;

-- More in-depth look with descriptions
SELECT * FROM v_purchase_log;
SELECT * FROM v_return_log;

```
## NOTES
-    This was done using MySQL workbench.
