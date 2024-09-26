/*
Written By: Anderson Mota
Date: 9/26/2024
Objective: Simulate a database that handles purchases, profiles, and returns for a company
*/


DROP DATABASE IF EXISTS hudsonsoft;
CREATE DATABASE hudsonsoft;
use hudsonsoft;
-- Create supporting lookup tables first
CREATE TABLE `Product_type` (
  `prod_type_id` INT PRIMARY KEY AUTO_INCREMENT,
  `prod_type_name` VARCHAR(50) NOT NULL
);

CREATE TABLE `Returns_type` (
  `Returns_type_id` INT PRIMARY KEY AUTO_INCREMENT,
  `Returns_type_name` VARCHAR(50) NULL
);

-- Main TABLES
CREATE TABLE `Product` (
  `product_id` INT PRIMARY KEY AUTO_INCREMENT,
  `product_name` VARCHAR(100) UNIQUE NOT NULL,
  `sales_number` CHAR(8) UNIQUE NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `stock_quantity` INT NOT NULL DEFAULT 0,
  `type_id` INT NULL,
  FOREIGN KEY (`type_id`) REFERENCES `Product_type` (`prod_type_id`),
  constraint CHK_stock_quantity check (stock_quantity >= 0),
  constraint CHK_price check (price >= 0)
);

CREATE TABLE `customer` (
  `customer_id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) UNIQUE NOT NULL,
  `phone` varchar(15) DEFAULT 'Not entered.',
  `state` char(2) NOT NULL,
  `city` char(25) NOT NULL,
  `amount_spent` decimal(10,2) DEFAULT '0.00',
  `product_owned` INT DEFAULT 0,
  `product_returned` INT DEFAULT 0,
  constraint CHK_amount_spent check (amount_spent >= 0),
  constraint CHK_product_owned check (product_owned >= 0),
  constraint CHK_product_returned check (product_returned >= 0)
);


-- Transaction tables
CREATE TABLE `Purchases` (
  `purchases_id` INT PRIMARY KEY AUTO_INCREMENT,
  `customer_id` INT,
  `product_id` INT,
  `type_id` INT,
  `quantity` INT,
  `purchases_date` DATE,
  FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`),
  FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`),
  FOREIGN KEY (`type_id`) REFERENCES `Product_type` (`prod_type_id`),
  constraint CHK_quantity CHECK (quantity >= 0)
);

CREATE TABLE `Returns` (
  `Returns_id` INT PRIMARY KEY AUTO_INCREMENT,
  `purchases_id` INT,
  `customer_id` INT,
  `product_id` INT,
  `returned_quantity` INT,
  `date_purchased` DATE,
  `date_returned` DATE,
  `return_type_id` INT NOT NULL,
  FOREIGN KEY (`purchases_id`) REFERENCES `Purchases` (`purchases_id`),
  FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`),
  FOREIGN KEY (`return_type_id`) REFERENCES `Returns_type` (`Returns_type_id`),
  constraint CHK_returned_quantity CHECK (returned_quantity >=0)
);
-- DROP VIEW
DROP VIEW IF EXISTS V_purchase_LOG;
DROP VIEW IF EXISTS V_return_LOG;


DELIMITER //
-- curdate() was not cooperating so a trigger was recommended
CREATE TRIGGER retrieve_date
BEFORE INSERT ON `Returns`
FOR EACH ROW
BEGIN
    SET NEW.date_returned = CURDATE();
END //
DELIMITER ;

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

DELIMITER //
CREATE TRIGGER return_update
AFTER INSERT
ON `Returns`
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



INSERT INTO `Product_type` (`prod_type_name`) VALUES
('Magic'),
('Gasoline'),
('Electricity');
INSERT INTO `Returns_type` (`Returns_type_name`) VALUES
('Defective'),
('Customer Changed Mind'),
('No Longer Needed');
-- Inserting Wizard Staffs with stock_quantity set to 0
INSERT INTO `Product` (`product_name`, `sales_number`, `price`, `stock_quantity`, `type_id`) VALUES
('Elder Wand', 'WSTF0001', 349.99, 0, 1),
('Fire Staff', 'WSTF0002', 199.99, 0, 1),
('Ice Staff', 'WSTF0003', 249.99, 0, 1),
('Storm Staff', 'WSTF0004', 219.99, 0, 1),
('Shadow Staff', 'WSTF0005', 179.99, 0, 1),
('Light Staff', 'WSTF0006', 209.99, 0, 1),
('Earth Staff', 'WSTF0007', 229.99, 0, 1),
('Wind Staff', 'WSTF0008', 189.99, 0, 1),
('Moon Staff', 'WSTF0009', 259.99, 0, 1),
('Sun Staff', 'WSTF0010', 269.99, 0, 1);

-- Inserting Magical Orbs with stock_quantity set to 0
INSERT INTO `Product` (`product_name`, `sales_number`, `price`, `stock_quantity`, `type_id`) VALUES
('Orb of Fire', 'ORBD0001', 99.99, 0, 2),
('Orb of Ice', 'ORBD0002', 109.99, 0, 2),
('Orb of Lightning', 'ORBD0003', 119.99, 0, 2),
('Orb of Earth', 'ORBD0004', 89.99, 0, 2),
('Orb of Water', 'ORBD0005', 94.99, 0, 2),
('Orb of Air', 'ORBD0006', 109.99, 0, 2),
('Orb of Light', 'ORBD0007', 129.99, 0, 2),
('Orb of Shadow', 'ORBD0008', 139.99, 0, 2),
('Orb of Nature', 'ORBD0009', 99.99, 0, 2),
('Orb of Void', 'ORBD0010', 149.99, 0, 2);

-- Inserting Magical Tomes with stock_quantity set to 0
INSERT INTO `Product` (`product_name`, `sales_number`, `price`, `stock_quantity`, `type_id`) VALUES
('Tome of Ancient Spells', 'TOME0001', 149.99, 0, 3),
('Tome of Forbidden Knowledge', 'TOME0002', 179.99, 0, 3),
('Tome of Elemental Magic', 'TOME0003', 159.99, 0, 3),
('Tome of Enchantments', 'TOME0004', 139.99, 0, 3),
('Tome of Dark Arts', 'TOME0005', 169.99, 0, 3),
('Tome of Healing', 'TOME0006', 149.99, 0, 3),
('Tome of Illusions', 'TOME0007', 129.99, 0, 3);

UPDATE Product
SET stock_quantity = 500;

-- Customers
INSERT INTO customer (first_name, last_name, email, phone, state, city) VALUES
('Alice', 'Smith', 'alices01@example.com', '212-555-1234', 'NY', 'New York'),
('Bob', 'Johnson', 'bobj02@example.com', '646-555-5678', 'NY', 'Brooklyn'),
('Carol', 'Williams', 'carolw03@example.com', '718-555-9012', 'NY', 'Queens'),
('David', 'Brown', 'davidb04@example.com', '917-555-3456', 'NY', 'Bronx'),
('Ella', 'Jones', 'ellaj05@example.com', '212-555-7890', 'NY', 'Staten Island'),
('Frank', 'Miller', 'frankm06@example.com', '646-555-1234', 'NY', 'Manhattan'),
('Grace', 'Davis', 'graced07@example.com', '718-555-2345', 'NY', 'Harlem'),
('Henry', 'Garcia', 'henryg08@example.com', '917-555-6789', 'NY', 'Upper West Side'),
('Ivy', 'Martinez', 'ivym09@example.com', '212-555-3456', 'NY', 'Chelsea'),
('Jack', 'Rodriguez', 'jackr10@example.com', '646-555-7890', 'NY', 'East Village'),
('Kathy', 'Wilson', 'kathyw11@example.com', '718-555-9012', 'NY', 'Greenwich Village'),
('Liam', 'Lopez', 'liaml12@example.com', '917-555-1234', 'NY', 'SoHo'),
('Mia', 'Martinez', 'miam13@example.com', '212-555-5678', 'NY', 'TriBeCa'),
('Nate', 'Miller', 'natem14@example.com', '646-555-9012', 'NY', 'Upper East Side'),
('Olivia', 'Harris', 'oliviah15@example.com', '718-555-6789', 'NY', 'Midtown'),
('Paul', 'Clark', 'paulc16@example.com', '917-555-2345', 'NY', 'Battery Park'),
('Quincy', 'Adams', 'quincya17@example.com', '212-555-8901', 'NY', 'NoMad'),
('Rita', 'Walker', 'ritaw18@example.com', '646-555-3456', 'NY', 'Murray Hill'),
('Steve', 'Scott', 'steves19@example.com', '718-555-4567', 'NY', 'Upper West Side'),
('Tina', 'Young', 'tinay20@example.com', '917-555-5678', 'NY', 'Inwood'),
('Ursula', 'King', 'ursulak21@example.com', '212-555-6789', 'NY', 'Washington Heights'),
('Vera', 'Adams', 'vera22@example.com', '646-555-7890', 'NY', 'Chinatown'),
('Will', 'Green', 'willg23@example.com', '718-555-8901', 'NY', 'Hell’s Kitchen'),
('Xena', 'Allen', 'xenaa24@example.com', '917-555-9012', 'NY', 'South Village'),
('Yara', 'Martin', 'yaray25@example.com', '212-555-0123', 'NY', 'Little Italy'),
('Zane', 'Moore', 'zanem26@example.com', '646-555-1234', 'NY', 'East Harlem'),
('Alice', 'Williams', 'alicew27@example.com', '305-555-6789', 'FL', 'Miami'),
('Bob', 'Johnson', 'bobj28@example.com', '813-555-7890', 'FL', 'Tampa'),
('Carol', 'Smith', 'carols29@example.com', '407-555-8901', 'FL', 'Orlando'),
('David', 'Jones', 'davidj30@example.com', '954-555-9012', 'FL', 'Fort Lauderdale'),
('Ella', 'Brown', 'ellab31@example.com', '239-555-0123', 'FL', 'Naples'),
('Frank', 'Davis', 'frankd32@example.com', '321-555-1234', 'FL', 'Cocoa Beach'),
('Grace', 'Miller', 'gracem33@example.com', '772-555-2345', 'FL', 'Port St. Lucie'),
('Henry', 'Wilson', 'henryw34@example.com', '386-555-3456', 'FL', 'Daytona Beach'),
('Ivy', 'Taylor', 'ivyt35@example.com', '561-555-4567', 'FL', 'West Palm Beach'),
('Jack', 'Moore', 'jackm36@example.com', '305-555-5678', 'FL', 'Homestead'),
('Kathy', 'Anderson', 'kathya37@example.com', '850-555-6789', 'FL', 'Tallahassee'),
('Liam', 'Thomas', 'liamt38@example.com', '941-555-7890', 'FL', 'Sarasota'),
('Mia', 'Jackson', 'mia39@example.com', '352-555-8901', 'FL', 'Gainesville'),
('Nate', 'Lee', 'natel40@example.com', '904-555-9012', 'FL', 'Jacksonville'),
('Olivia', 'Harris', 'oliviah41@example.com', '407-555-0123', 'FL', 'Lake Mary'),
('Paul', 'Clark', 'paulc42@example.com', '321-555-1234', 'FL', 'Melbourne'),
('Quincy', 'Adams', 'quincya43@example.com', '786-555-2345', 'FL', 'Hialeah'),
('Rita', 'Walker', 'ritaw44@example.com', '727-555-3456', 'FL', 'Clearwater'),
('Steve', 'Scott', 'steves45@example.com', '954-555-4567', 'FL', 'Pembroke Pines'),
('Tina', 'Young', 'tinay46@example.com', '863-555-5678', 'FL', 'Lakeland'),
('Ursula', 'King', 'ursulak47@example.com', '305-555-6789', 'FL', 'Key West'),
('Vera', 'Adams', 'vera48@example.com', '772-555-7890', 'FL', 'Fort Pierce'),
('Will', 'Green', 'willg49@example.com', '321-555-8901', 'FL', 'Vero Beach'),
('Xena', 'Allen', 'xenaa50@example.com', '850-555-9012', 'FL', 'Panama City'),
('Yara', 'Martin', 'yaray51@example.com', '561-555-0123', 'FL', 'Boynton Beach'),
('Zane', 'Moore', 'zanem52@example.com', '407-555-1234', 'FL', 'Winter Park'),
('Alice', 'Johnson', 'alicej53@example.com', '312-555-6789', 'IL', 'Chicago'),
('Bob', 'Smith', 'bob54@example.com', '773-555-7890', 'IL', 'Chicago'),
('Carol', 'Williams', 'carolw55@example.com', '630-555-8901', 'IL', 'Naperville'),
('David', 'Brown', 'davidb56@example.com', '708-555-9012', 'IL', 'Oak Brook'),
('Ella', 'Jones', 'ellaj57@example.com', '847-555-0123', 'IL', 'Evanston'),
('Frank', 'Davis', 'frankd58@example.com', '773-555-1234', 'IL', 'Lincoln Park'),
('Grace', 'Miller', 'gracem59@example.com', '217-555-2345', 'IL', 'Springfield'),
('Henry', 'Wilson', 'henryw60@example.com', '618-555-3456', 'IL', 'Carbondale'),
('Ivy', 'Taylor', 'ivyt61@example.com', '312-555-4567', 'IL', 'Downtown Chicago'),
('Jack', 'Moore', 'jackm62@example.com', '630-555-5678', 'IL', 'Aurora'),
('Kathy', 'Anderson', 'kathya63@example.com', '773-555-6789', 'IL', 'South Loop'),
('Liam', 'Thomas', 'liamt64@example.com', '815-555-7890', 'IL', 'Joliet'),
('Mia', 'Jackson', 'mia65@example.com', '309-555-8901', 'IL', 'Peoria'),
('Nate', 'Lee', 'natel66@example.com', '847-555-9012', 'IL', 'Arlington Heights'),
('Olivia', 'Harris', 'oliviah67@example.com', '618-555-0123', 'IL', 'Champaign'),
('Paul', 'Clark', 'paulc68@example.com', '217-555-1234', 'IL', 'Decatur'),
('Quincy', 'Adams', 'quincya69@example.com', '630-555-2345', 'IL', 'Schaumburg'),
('Rita', 'Walker', 'ritaw70@example.com', '708-555-3456', 'IL', 'Oak Park'),
('Steve', 'Scott', 'steves71@example.com', '217-555-4567', 'IL', 'Skokie'),
('Tina', 'Young', 'tinay72@example.com', '847-555-5678', 'IL', 'Champaign'),
('Ursula', 'King', 'ursulak73@example.com', '312-555-6789', 'IL', 'Moline'),
('Vera', 'Adams', 'vera74@example.com', '630-555-7890', 'IL', 'Carbondale'),
('Will', 'Green', 'willg75@example.com', '312-555-8901', 'IL', 'Rockford'),
('Xena', 'Allen', 'xenaa76@example.com', '217-555-9012', 'IL', 'Champaign'),
('Yara', 'Martin', 'yaray77@example.com', '630-555-0123', 'IL', 'Moline'),
('Zane', 'Moore', 'zanem78@example.com', '773-555-1234', 'IL', 'Elmhurst'),
('Alice', 'Davis', 'aliced79@example.com', '214-555-6789', 'TX', 'Dallas'),
('Bob', 'Miller', 'bobm80@example.com', '713-555-7890', 'TX', 'Houston'),
('Carol', 'Wilson', 'carolw81@example.com', '512-555-8901', 'TX', 'Austin'),
('David', 'Taylor', 'davidt82@example.com', '210-555-9012', 'TX', 'San Antonio'),
('Ella', 'Moore', 'ellam83@example.com', '817-555-0123', 'TX', 'Fort Worth'),
('Frank', 'Brown', 'frankb84@example.com', '469-555-1234', 'TX', 'Plano'),
('Grace', 'Davis', 'graced85@example.com', '936-555-2345', 'TX', 'College Station'),
('Henry', 'Miller', 'henrym86@example.com', '806-555-3456', 'TX', 'Lubbock'),
('Ivy', 'Wilson', 'ivyw87@example.com', '682-555-4567', 'TX', 'Arlington'),
('Jack', 'Taylor', 'jackt88@example.com', '214-555-5678', 'TX', 'Garland'),
('Kathy', 'Anderson', 'kathya89@example.com', '281-555-6789', 'TX', 'Killeen'),
('Liam', 'Thomas', 'liamt90@example.com', '817-555-7890', 'TX', 'Midland'),
('Mia', 'Jackson', 'mia91@example.com', '512-555-8901', 'TX', 'San Angelo'),
('Nate', 'Lee', 'natel92@example.com', '214-555-9012', 'TX', 'Frisco'),
('Olivia', 'Harris', 'oliviah93@example.com', '972-555-0123', 'TX', 'McKinney'),
('Paul', 'Clark', 'paulc94@example.com', '817-555-1234', 'TX', 'Lewisville'),
('Quincy', 'Adams', 'quincya95@example.com', '254-555-2345', 'TX', 'Waco'),
('Rita', 'Walker', 'ritaw96@example.com', '214-555-3456', 'TX', 'Grand Prairie'),
('Steve', 'Scott', 'steves97@example.com', '512-555-4567', 'TX', 'Euless'),
('Tina', 'Young', 'tinay98@example.com', '214-555-5678', 'TX', 'The Colony'),
('Ursula', 'King', 'ursulak99@example.com', '713-555-6789', 'TX', 'Sugar Land'),
('Vera', 'Adams', 'vera100@example.com', '817-555-7890', 'TX', 'Denton'),
('Will', 'Green', 'willg101@example.com', '972-555-8901', 'TX', 'Allen'),
('Xena', 'Allen', 'xenaa102@example.com', '214-555-9012', 'TX', 'Burleson'),
('Yara', 'Martin', 'yaray103@example.com', '972-555-0123', 'TX', 'Hurst'),
('Zane', 'Moore', 'zanem104@example.com', '214-555-1234', 'TX', 'Mansfield'),
('Alice', 'Brown', 'aliceb105@example.com', '415-555-6789', 'CA', 'San Francisco'),
('Bob', 'Davis', 'bobd106@example.com', '323-555-7890', 'CA', 'Los Angeles'),
('Carol', 'Wilson', 'carolw107@example.com', '619-555-8901', 'CA', 'San Diego'),
('David', 'Miller', 'davidm108@example.com', '408-555-9012', 'CA', 'San Jose'),
('Ella', 'Taylor', 'ellat109@example.com', '213-555-0123', 'CA', 'Beverly Hills'),
('Frank', 'Smith', 'franks110@example.com', '530-555-1234', 'CA', 'Sacramento'),
('Grace', 'Johnson', 'gracej111@example.com', '818-555-2345', 'CA', 'Burbank'),
('Henry', 'Anderson', 'henrya112@example.com', '310-555-3456', 'CA', 'Santa Monica'),
('Ivy', 'Moore', 'ivym113@example.com', '661-555-4567', 'CA', 'Bakersfield'),
('Jack', 'Jones', 'jackj114@example.com', '949-555-5678', 'CA', 'Irvine'),
('Kathy', 'Martin', 'kathym115@example.com', '619-555-6789', 'CA', 'La Jolla'),
('Liam', 'Garcia', 'liamg116@example.com', '714-555-7890', 'CA', 'Anaheim'),
('Mia', 'Lee', 'mial117@example.com', '415-555-8901', 'CA', 'Richmond'),
('Nate', 'Wilson', 'natew118@example.com', '650-555-9012', 'CA', 'Palo Alto'),
('Olivia', 'Davis', 'oliviad119@example.com', '408-555-0123', 'CA', 'Sunnyvale'),
('Paul', 'Brown', 'paulb120@example.com', '562-555-1234', 'CA', 'Long Beach'),
('Quincy', 'Adams', 'quincya121@example.com', '760-555-2345', 'CA', 'Palm Springs'),
('Rita', 'Taylor', 'ritat122@example.com', '626-555-3456', 'CA', 'Pasadena'),
('Steve', 'Moore', 'stevem123@example.com', '310-555-4567', 'CA', 'West Hollywood'),
('Tina', 'Young', 'tinay124@example.com', '714-555-5678', 'CA', 'Costa Mesa'),
('Ursula', 'King', 'ursulak125@example.com', '805-555-6789', 'CA', 'Santa Barbara'),
('Vera', 'Adams', 'vera126@example.com', '818-555-7890', 'CA', 'Glendale'),
('Will', 'Green', 'willg127@example.com', '909-555-8901', 'CA', 'Riverside'),
('Xena', 'Allen', 'xenaa128@example.com', '949-555-9012', 'CA', 'Chula Vista'),
('Yara', 'Martin', 'yaray129@example.com', '916-555-0123', 'CA', 'Sacramento'),
('Zane', 'Moore', 'zanem130@example.com', '310-555-1234', 'CA', 'Los Angeles'),
('Alice', 'Davis', 'aliced131@example.com', '214-555-6789', 'TX', 'Dallas'),
('Bob', 'Miller', 'bobm132@example.com', '713-555-7890', 'TX', 'Houston'),
('Carol', 'Wilson', 'carolw133@example.com', '512-555-8901', 'TX', 'Austin'),
('David', 'Taylor', 'davidt134@example.com', '210-555-9012', 'TX', 'San Antonio'),
('Ella', 'Moore', 'ellam135@example.com', '817-555-0123', 'TX', 'Fort Worth'),
('Frank', 'Brown', 'frankb136@example.com', '469-555-1234', 'TX', 'Plano'),
('Grace', 'Davis', 'graced137@example.com', '936-555-2345', 'TX', 'College Station'),
('Henry', 'Miller', 'henrym138@example.com', '806-555-3456', 'TX', 'Lubbock'),
('Ivy', 'Wilson', 'ivyw139@example.com', '682-555-4567', 'TX', 'Arlington'),
('Jack', 'Taylor', 'jackt140@example.com', '214-555-5678', 'TX', 'Garland'),
('Kathy', 'Anderson', 'kathya141@example.com', '281-555-6789', 'TX', 'Killeen'),
('Liam', 'Thomas', 'liamt142@example.com', '817-555-7890', 'TX', 'Midland'),
('Mia', 'Jackson', 'mia143@example.com', '512-555-8901', 'TX', 'San Angelo'),
('Nate', 'Lee', 'natel144@example.com', '214-555-9012', 'TX', 'Frisco'),
('Olivia', 'Harris', 'oliviah145@example.com', '972-555-0123', 'TX', 'McKinney'),
('Paul', 'Clark', 'paulc146@example.com', '817-555-1234', 'TX', 'Lewisville'),
('Quincy', 'Adams', 'quincya147@example.com', '254-555-2345', 'TX', 'Waco'),
('Rita', 'Walker', 'ritaw148@example.com', '214-555-3456', 'TX', 'Grand Prairie'),
('Steve', 'Scott', 'steves149@example.com', '512-555-4567', 'TX', 'Euless'),
('Tina', 'Young', 'tinay150@example.com', '214-555-5678', 'TX', 'The Colony'),
('Ursula', 'King', 'ursulak151@example.com', '713-555-6789', 'TX', 'Sugar Land'),
('Vera', 'Adams', 'vera152@example.com', '817-555-7890', 'TX', 'Denton'),
('Will', 'Green', 'willg153@example.com', '972-555-8901', 'TX', 'Allen'),
('Xena', 'Allen', 'xenaa154@example.com', '214-555-9012', 'TX', 'Burleson'),
('Yara', 'Martin', 'yaray155@example.com', '972-555-0123', 'TX', 'Hurst'),
('Zane', 'Moore', 'zanem156@example.com', '214-555-1234', 'TX', 'Mansfield'),
('Aaron', 'Roberts', 'aaronr157@example.com', '303-555-6789', 'CO', 'Denver'),
('Brenda', 'Clark', 'brendac158@example.com', '720-555-7890', 'CO', 'Colorado Springs'),
('Charles', 'Davis', 'charlesd159@example.com', '303-555-8901', 'CO', 'Aurora'),
('Diana', 'Martinez', 'dianam160@example.com', '970-555-9012', 'CO', 'Fort Collins'),
('Edward', 'Johnson', 'edwardj161@example.com', '719-555-0123', 'CO', 'Pueblo'),
('Fiona', 'White', 'fionaw162@example.com', '720-555-1234', 'CO', 'Littleton'),
('George', 'Lee', 'georgel163@example.com', '303-555-2345', 'CO', 'Westminster'),
('Hannah', 'Walker', 'hannahw164@example.com', '970-555-3456', 'CO', 'Boulder'),
('Isaac', 'Young', 'isaacy165@example.com', '719-555-4567', 'CO', 'Colorado Springs'),
('Jessica', 'Harris', 'jessicah166@example.com', '303-555-5678', 'CO', 'Longmont'),
('Kyle', 'Taylor', 'kylet167@example.com', '720-555-6789', 'CO', 'Castle Rock'),
('Lily', 'Smith', 'lilys168@example.com', '970-555-7890', 'CO', 'Loveland'),
('Matthew', 'Brown', 'matthewb169@example.com', '303-555-8901', 'CO', 'Greeley'),
('Natalie', 'White', 'nataliew170@example.com', '719-555-9012', 'CO', 'Highlands Ranch'),
('Oliver', 'Clark', 'oliverc171@example.com', '720-555-0123', 'CO', 'Parker'),
('Pamela', 'Lee', 'pamelal172@example.com', '303-555-1234', 'CO', 'Northglenn'),
('Quentin', 'Davis', 'quentind173@example.com', '970-555-2345', 'CO', 'Wheat Ridge'),
('Rachel', 'Jones', 'rachelj174@example.com', '719-555-3456', 'CO', 'Castle Rock'),
('Samuel', 'Harris', 'samuelh175@example.com', '720-555-4567', 'CO', 'Arvada'),
('Tiffany', 'Adams', 'tiffanya176@example.com', '303-555-5678', 'CO', 'Lafayette'),
('Aiden', 'Parker', 'aidenp177@example.com', '202-555-7890', 'DC', 'Washington'),
('Bella', 'Taylor', 'bellat178@example.com', '212-555-8901', 'NY', 'New York'),
('Caleb', 'Mitchell', 'calebm179@example.com', '213-555-9012', 'CA', 'Los Angeles'),
('Daisy', 'Young', 'daisyy180@example.com', '305-555-0123', 'FL', 'Miami'),
('Ethan', 'Gonzalez', 'ethang181@example.com', '312-555-1234', 'IL', 'Chicago'),
('Faith', 'Martinez', 'faithm182@example.com', '713-555-2345', 'TX', 'Houston'),
('Gage', 'Robinson', 'gager183@example.com', '503-555-3456', 'OR', 'Portland'),
('Holly', 'Harris', 'hollyh184@example.com', '602-555-4567', 'AZ', 'Phoenix'),
('Ian', 'Adams', 'iana185@example.com', '408-555-5678', 'CA', 'San Jose'),
('Jasmine', 'Walker', 'jasminew186@example.com', '720-555-6789', 'CO', 'Denver'),
('Kevin', 'Wilson', 'kevinw187@example.com', '919-555-7890', 'NC', 'Raleigh'),
('Lydia', 'Thompson', 'lydiat188@example.com', '214-555-8901', 'TX', 'Dallas'),
('Mason', 'White', 'masonw189@example.com', '703-555-9012', 'VA', 'Arlington'),
('Nora', 'Brown', 'norab190@example.com', '202-555-0123', 'DC', 'Washington'),
('Owen', 'Harris', 'owenh191@example.com', '505-555-1234', 'NM', 'Albuquerque'),
('Piper', 'Lopez', 'piperl192@example.com', '702-555-2345', 'NV', 'Las Vegas'),
('Quinn', 'Walker', 'quinnw193@example.com', '303-555-3456', 'CO', 'Boulder'),
('Riley', 'Smith', 'rileys194@example.com', '404-555-4567', 'GA', 'Atlanta'),
('Sophie', 'Jenkins', 'sophiej195@example.com', '213-555-5678', 'CA', 'Los Angeles'),
('Travis', 'Lewis', 'travisL196@example.com', '602-555-6789', 'AZ', 'Phoenix'),
('Uma', 'Clark', 'umac197@example.com', '718-555-7890', 'NY', 'Brooklyn'),
('Victor', 'Adams', 'victora198@example.com', '415-555-8901', 'CA', 'San Francisco'),
('Willow', 'Mitchell', 'willowm199@example.com', '301-555-9012', 'MD', 'Silver Spring'),
('Xander', 'Thompson', 'xanderT200@example.com', '206-555-0123', 'WA', 'Seattle'),
('Yara', 'Hall', 'yarah201@example.com', '615-555-1234', 'TN', 'Nashville'),
('Zachary', 'Morris', 'zacharym202@example.com', '312-555-2345', 'IL', 'Chicago'),
('Anna', 'Martin', 'annam203@example.com', '415-555-3456', 'CA', 'San Francisco'),
('Brady', 'Turner', 'bradyt204@example.com', '305-555-4567', 'FL', 'Miami'),
('Carter', 'Green', 'carterg205@example.com', '212-555-5678', 'NY', 'New York'),
('Dylan', 'Hall', 'dylanh206@example.com', '214-555-6789', 'TX', 'Dallas'),
('Eva', 'Wright', 'evaw207@example.com', '713-555-7890', 'TX', 'Houston'),
('Finn', 'Nelson', 'finnn208@example.com', '503-555-8901', 'OR', 'Portland'),
('Grace', 'Scott', 'graces209@example.com', '408-555-9012', 'CA', 'San Jose'),
('Hunter', 'King', 'hunterk210@example.com', '720-555-0123', 'CO', 'Denver'),
('Ivy', 'Morris', 'ivym211@example.com', '212-555-1234', 'NY', 'New York'),
('James', 'Peterson', 'jamesp212@example.com', '504-555-2345', 'LA', 'New Orleans'),
('Kelsey', 'Wright', 'kelseyW213@example.com', '757-555-3456', 'VA', 'Virginia Beach'),
('Leo', 'Watson', 'leow214@example.com', '214-555-4567', 'TX', 'Dallas'),
('Maya', 'Reed', 'mayar215@example.com', '303-555-5678', 'CO', 'Longmont'),
('Nate', 'Miller', 'natem216@example.com', '617-555-6789', 'MA', 'Boston'),
('Olivia', 'White', 'oliviaw217@example.com', '503-555-7890', 'OR', 'Portland'),
('Paul', 'Murphy', 'paulm218@example.com', '614-555-8901', 'OH', 'Columbus'),
('Quinn', 'Cruz', 'quinnc219@example.com', '303-555-9012', 'CO', 'Aurora'),
('Rosa', 'James', 'rosaj220@example.com', '404-555-0123', 'GA', 'Atlanta'),
('Sean', 'Foster', 'seanf221@example.com', '919-555-1234', 'NC', 'Raleigh'),
('Tessa', 'Bennett', 'tessab222@example.com', '703-555-2345', 'VA', 'Arlington'),
('Ulysses', 'Parker', 'ulyssesp223@example.com', '510-555-3456', 'CA', 'Oakland'),
('Vera', 'Collins', 'verac224@example.com', '816-555-4567', 'MO', 'Kansas City'),
('Wyatt', 'Ward', 'wyattw225@example.com', '239-555-5678', 'FL', 'Fort Myers'),
('Xena', 'Mason', 'xenam226@example.com', '719-555-6789', 'CO', 'Colorado Springs'),
('Yvonne', 'Cook', 'yvonnec227@example.com', '860-555-7890', 'CT', 'Hartford'),
('Zane', 'Fisher', 'zanef228@example.com', '817-555-8901', 'TX', 'Fort Worth'),
('Amelia', 'Cooper', 'ameliaC229@example.com', '914-555-9012', 'NY', 'Yonkers'),
('Blake', 'Baker', 'blakeb230@example.com', '504-555-0123', 'LA', 'New Orleans'),
('Chloe', 'Sullivan', 'chloes231@example.com', '650-555-1234', 'CA', 'Palo Alto'),
('Daniel', 'Cruz', 'danielc232@example.com', '303-555-2345', 'CO', 'Denver'),
('Ella', 'Bailey', 'ellab233@example.com', '719-555-3456', 'CO', 'Colorado Springs'),
('Frank', 'Morris', 'frankm234@example.com', '215-555-4567', 'PA', 'Philadelphia'),
('Grace', 'Ward', 'gracew235@example.com', '858-555-5678', 'CA', 'San Diego'),
('Henry', 'Long', 'henryl236@example.com', '312-555-6789', 'IL', 'Chicago'),
('Iris', 'Howard', 'irish237@example.com', '919-555-7890', 'NC', 'Raleigh'),
('Jack', 'Nguyen', 'jackn238@example.com', '612-555-8901', 'MN', 'Minneapolis'),
('Kara', 'Fisher', 'karaf239@example.com', '303-555-9012', 'CO', 'Boulder'),
('Liam', 'Wright', 'liamw240@example.com', '786-555-0123', 'FL', 'Miami'),
('Megan', 'Young', 'megany241@example.com', '303-555-1234', 'CO', 'Denver'),
('Noah', 'Sanchez', 'noahs242@example.com', '505-555-2345', 'NM', 'Albuquerque'),
('Olivia', 'Watson', 'oliviaw243@example.com', '213-555-3456', 'CA', 'Los Angeles'),
('Paul', 'Miller', 'paulm244@example.com', '404-555-4567', 'GA', 'Atlanta'),
('Quinn', 'Young', 'quinnY245@example.com', '702-555-5678', 'NV', 'Las Vegas'),
('Rachel', 'Scott', 'rachels246@example.com', '509-555-6789', 'WA', 'Spokane'),
('Samuel', 'Fisher', 'samuelF247@example.com', '619-555-7890', 'CA', 'San Diego'),
('Tara', 'Lopez', 'taral248@example.com', '215-555-8901', 'PA', 'Philadelphia'),
('Ursula', 'Cook', 'ursulac249@example.com', '312-555-9012', 'IL', 'Chicago'),
('Vince', 'Jenkins', 'vincej250@example.com', '415-555-0123', 'CA', 'San Francisco');


INSERT INTO `Purchases` (`customer_id`, `product_id`, `type_id`, `quantity`, `purchases_date`) VALUES
(35, 12, 1, 5, '2020-01-15'),
(120, 7, 2, 3, '2020-02-22'),
(89, 15, 3, 4, '2020-03-12'),
(210, 10, 1, 6, '2020-04-09'),
(56, 8, 2, 2, '2020-05-25'),
(145, 25, 3, 1, '2020-06-30'),
(72, 14, 1, 4, '2020-07-19'),
(34, 19, 2, 7, '2020-08-22'),
(80, 21, 3, 3, '2020-09-15'),
(92, 3, 1, 5, '2020-10-11'),
(143, 27, 2, 2, '2020-11-04'),
(67, 9, 3, 6, '2020-12-21'),
(108, 11, 1, 7, '2021-01-13'),
(77, 22, 2, 4, '2021-02-09'),
(39, 16, 3, 3, '2021-03-19'),
(158, 5, 1, 6, '2021-04-15'),
(12, 20, 2, 1, '2021-05-28'),
(174, 13, 3, 5, '2021-06-30'),
(84, 6, 1, 2, '2021-07-21'),
(55, 18, 2, 8, '2021-08-14'),
(33, 26, 3, 7, '2021-09-05'),
(49, 4, 1, 3, '2021-10-12'),
(28, 17, 2, 6, '2021-11-23'),
(145, 24, 3, 2, '2021-12-09'),
(81, 10, 1, 4, '2022-01-14'),
(200, 12, 2, 5, '2022-02-20'),
(16, 27, 3, 3, '2022-03-18'),
(79, 8, 1, 7, '2022-04-07'),
(117, 23, 2, 2, '2022-05-11'),
(41, 14, 3, 8, '2022-06-15'),
(63, 25, 1, 6, '2022-07-20'),
(148, 19, 2, 5, '2022-08-10'),
(109, 22, 3, 4, '2022-09-25'),
(13, 11, 1, 7, '2022-10-14'),
(55, 7, 2, 3, '2022-11-16'),
(94, 20, 3, 6, '2022-12-30'),
(72, 26, 1, 4, '2023-01-08'),
(88, 5, 2, 8, '2023-02-05'),
(152, 12, 3, 2, '2023-03-12'),
(119, 16, 1, 6, '2023-04-25'),
(190, 21, 2, 3, '2023-05-30'),
(80, 13, 3, 5, '2023-06-23'),
(64, 27, 1, 7, '2023-07-19'),
(37, 22, 2, 6, '2023-08-20'),
(103, 8, 3, 4, '2023-09-15'),
(25, 9, 1, 2, '2023-10-20'),
(54, 18, 2, 5, '2023-11-15'),
(113, 24, 3, 6, '2023-12-30'),
(46, 6, 1, 8, '2024-01-10'),
(68, 20, 2, 7, '2024-02-22'),
(170, 15, 3, 4, '2024-03-15'),
(122, 3, 1, 2, '2024-04-18'),
(95, 25, 2, 6, '2024-05-23'),
(29, 21, 3, 8, '2024-06-30'),
(137, 11, 1, 7, '2024-07-14'),
(50, 27, 2, 5, '2024-08-21'),
(83, 14, 3, 6, '2024-09-10'),
(141, 8, 1, 3, '2024-10-16'),
(19, 17, 2, 8, '2024-11-20'),
(91, 26, 3, 4, '2024-12-01'),
(144, 7, 1, 5, '2020-01-25'),
(112, 13, 2, 6, '2020-02-18'),
(60, 18, 3, 7, '2020-03-15'),
(130, 5, 1, 4, '2020-04-20'),
(67, 23, 2, 2, '2020-05-12'),
(176, 27, 3, 8, '2020-06-30'),
(95, 20, 1, 6, '2020-07-25'),
(124, 15, 2, 5, '2020-08-15'),
(88, 22, 3, 7, '2020-09-19'),
(52, 4, 1, 3, '2020-10-05'),
(133, 11, 2, 6, '2020-11-10'),
(69, 25, 3, 4, '2020-12-15'),
(77, 9, 1, 7, '2021-01-30'),
(154, 12, 2, 8, '2021-02-25'),
(85, 21, 3, 6, '2021-03-18'),
(104, 26, 1, 5, '2021-04-10'),
(139, 7, 2, 4, '2021-05-20'),
(8, 20, 3, 3, '2021-06-15'),
(127, 16, 1, 6, '2021-07-25'),
(49, 13, 2, 2, '2021-08-30'),
(76, 8, 3, 7, '2021-09-10'),
(101, 27, 1, 5, '2021-10-14'),
(24, 15, 2, 6, '2021-11-20'),
(58, 22, 3, 4, '2021-12-05'),
(140, 11, 1, 8, '2022-01-22'),
(65, 5, 2, 3, '2022-02-14'),
(179, 20, 3, 7, '2022-03-28'),
(119, 27, 1, 6, '2022-04-20'),
(147, 18, 2, 5, '2022-05-10'),
(64, 8, 3, 4, '2022-06-30'),
(92, 23, 1, 7, '2022-07-15'),
(14, 15, 2, 8, '2022-08-20'),
(113, 21, 3, 6, '2022-09-25'),
(80, 26, 1, 2, '2022-10-14'),
(59, 12, 2, 5, '2022-11-11'),
(102, 7, 3, 6, '2022-12-01'),
(48, 5, 1, 4, '2023-01-30'),
(130, 20, 2, 6, '2023-02-20'),
(141, 15, 3, 3, '2023-03-15'),
(58, 23, 1, 7, '2023-04-25'),
(164, 27, 2, 4, '2023-05-30'),
(87, 8, 3, 5, '2023-06-10'),
(29, 16, 1, 2, '2023-07-15'),
(118, 25, 2, 8, '2023-08-20'),
(141, 11, 3, 7, '2023-09-30'),
(54, 21, 1, 3, '2023-10-15'),
(76, 9, 2, 5, '2023-11-10'),
(139, 22, 3, 6, '2023-12-25'),
(68, 13, 1, 7, '2024-01-30'),
(145, 18, 2, 4, '2024-02-15'),
(84, 7, 3, 8, '2024-03-05'),
(92, 26, 1, 5, '2024-04-22'),
(175, 20, 2, 6, '2024-05-18'),
(31, 23, 3, 4, '2024-06-30'),
(100, 11, 1, 8, '2024-07-15'),
(24, 15, 2, 3, '2024-08-21'),
(102, 25, 3, 6, '2024-09-14'),
(57, 22, 1, 5, '2024-10-10'),
(163, 16, 2, 7, '2024-11-12'),
(88, 7, 3, 4, '2024-12-30'),
(112, 18, 1, 6, '2024-01-15'),
(73, 27, 2, 3, '2024-02-22'),
(66, 23, 3, 8, '2024-03-10'),
(48, 20, 1, 5, '2024-04-18'),
(99, 12, 2, 6, '2024-05-25'),
(117, 25, 3, 4, '2024-06-10'),
(132, 21, 1, 7, '2024-07-19'),
(45, 9, 2, 3, '2024-08-15'),
(110, 14, 3, 5, '2024-09-30'),
(95, 11, 1, 6, '2024-10-22'),
(182, 8, 2, 2, '2024-11-10'),
(122, 27, 3, 4, '2024-12-05'),
(147, 16, 1, 8, '2024-01-25'),
(66, 20, 2, 7, '2024-02-14'),
(78, 25, 3, 5, '2024-03-21'),
(91, 18, 1, 6, '2024-04-30'),
(132, 7, 2, 4, '2024-05-22'),
(140, 12, 3, 7, '2024-06-19'),
(87, 23, 1, 5, '2024-07-15'),
(31, 26, 2, 3, '2024-08-10'),
(56, 14, 3, 6, '2024-09-25'),
(79, 20, 1, 4, '2024-10-15'),
(92, 5, 2, 8, '2024-11-02'),
(101, 11, 3, 7, '2024-12-23'),
(120, 27, 1, 6, '2024-01-10'),
(45, 8, 2, 4, '2024-02-27'),
(67, 21, 3, 5, '2024-03-14'),
(139, 12, 1, 3, '2024-04-18'),
(103, 18, 2, 7, '2024-05-22'),
(13, 7, 3, 4, '2024-06-30'),
(116, 20, 1, 8, '2024-07-20'),
(57, 25, 2, 5, '2024-08-15'),
(13, 26, 3, 6, '2024-09-05'),
(168, 22, 1, 2, '2024-10-11'),
(13, 5, 2, 8, '2024-11-01'),
(1, 3, 1, 10, '2024-11-01'),
(1, 9, 2, 10, '2024-11-01'),
(121, 18, 3, 3, '2024-12-30');

INSERT INTO `Returns` (`purchases_id`, 
    `customer_id`, 
    `product_id`, 
    `returned_quantity`, 
    `date_purchased`, 
    `return_type_id`
) VALUES (
    1, 1, 1, 2, (SELECT `purchases_date` FROM `Purchases` WHERE `purchases_id` = 1), 1
);


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
