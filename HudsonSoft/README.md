
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
- `type_id` (INT, Foreign Key to `Product_type`): Type of product returned.

**Constraints:**
- `CHK_returned_quantity`: Ensures returned quantity is non-negative.

## Triggers

### 1. `retrieve_date`
Automatically sets the return date (`date_returned`) to the current date for any new row inserted into the `Returns` table.

**Trigger Definition:**
```sql
DELIMITER //
CREATE TRIGGER retrieve_date
BEFORE INSERT ON `Returns`
FOR EACH ROW
BEGIN
    SET NEW.date_returned = CURDATE();
END //
DELIMITER ;


### 2. `update_amount`
Automatically updates the amount spent, the number of products owned by a customer, and adjusts product stock when a new purchase is made.

**Trigger Definition:**
```sql
DELIMITER //
CREATE TRIGGER update_amount
AFTER INSERT ON `Purchases`
FOR EACH ROW
BEGIN
    DECLARE price_of_product DECIMAL(10,2);
    DECLARE sales_tax_rate DECIMAL(10,2) DEFAULT 0.07;
    DECLARE total_cost_of_product DECIMAL(10,2);
    
    SELECT price INTO price_of_product 
    FROM Product
    WHERE product_id = NEW.product_id;

    SET total_cost_of_product = price_of_product * NEW.quantity * (1 + sales_tax_rate);
    
    UPDATE Customer
    SET amount_spent = amount_spent + total_cost_of_product,
        product_owned = product_owned + NEW.quantity
    WHERE customer_id = NEW.customer_id;

    UPDATE Product
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END //
DELIMITER ;


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

**Example Usage**

-- Example usage: INSERT INTO `Product_type` (`prod_type_name`) VALUES
('Digital'), ('Physical');

-- Example usage: Insert into product
INSERT INTO `Product` (`product_name`, `sales_number`, `price`, `stock_quantity`, `type_id`) VALUES
('Vintendo Slay Station', 'VSS01234', 99.99, 500, 2);

-- Example usage: Insert into purchases
INSERT INTO Purchases (customer_id, product_id, type_id, quantity, purchases_date) 
VALUES (1, 1, 1, 5, '2024-09-26');

-- Example usage: Return a product
INSERT INTO Returns (purchases_id, customer_id, product_id, returned_quantity, date_purchased, return_type_id, type_id)
VALUES (1, 1, 1, 1, '2024-09-26', 1, 1);

-- View customer's updated amount spent
SELECT first_name, last_name, amount_spent FROM Customer WHERE customer_id = 1;


