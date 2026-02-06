/* PROJECT: SQL JOINS & Window Functions Project
   COURSE: Database Development with PL/SQL (INSY 8311)
   STUDENT: [Your Full Name]
   BUSINESS CONTEXT: E-commerce Electronics Retailer
*/

-- ==========================================================
-- STEP 3: DATABASE SCHEMA DESIGN [cite: 55, 56]
-- ==========================================================

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    join_date DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- ==========================================================
-- STEP 4: PART A - SQL JOINS [cite: 60, 62]
-- ==========================================================

-- 1. INNER JOIN: Retrieve valid sales with customer and product details [cite: 64]
SELECT t.transaction_id, c.customer_name, p.product_name, t.amount
FROM Transactions t
INNER JOIN Customers c ON t.customer_id = c.customer_id
INNER JOIN Products p ON t.product_id = p.product_id;

-- 2. LEFT JOIN: Identify customers who have never made a purchase [cite: 65]
SELECT c.customer_name, t.transaction_id
FROM Customers c
LEFT JOIN Transactions t ON c.customer_id = t.customer_id
WHERE t.transaction_id IS NULL;

-- 3. RIGHT JOIN: Detect products with no sales activity [cite: 66]
SELECT p.product_name, t.transaction_id
FROM Transactions t
RIGHT JOIN Products p ON t.product_id = p.product_id
WHERE t.transaction_id IS NULL;

-- 4. FULL OUTER JOIN: Compare customers and products including unmatched records [cite: 67]
SELECT c.customer_name, p.product_name, t.amount
FROM Customers c
FULL OUTER JOIN Transactions t ON c.customer_id = t.customer_id
FULL OUTER JOIN Products p ON t.product_id = p.product_id;

-- 5. SELF JOIN: Compare transactions within the same region [cite: 69]
SELECT a.customer_id, a.region, b.customer_id as peer_customer
FROM Customers a
JOIN Customers b ON a.region = b.region AND a.customer_id <> b.customer_id;


-- ==========================================================
-- STEP 5: PART B - WINDOW FUNCTIONS [cite: 74, 75]
-- ==========================================================

-- 1. RANKING: Top products by revenue [cite: 78]
SELECT product_id, amount,
    RANK() OVER (ORDER BY amount DESC) as sales_rank,
    DENSE_RANK() OVER (ORDER BY amount DESC) as dense_sales_rank
FROM Transactions;

-- 2. AGGREGATE: Running monthly totals using ROWS and RANGE [cite: 79]
SELECT transaction_date, amount,
    SUM(amount) OVER (ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total_rows,
    SUM(amount) OVER (ORDER BY transaction_date RANGE BETWEEN INTERVAL '30' DAY PRECEDING AND CURRENT ROW) as running_total_range
FROM Transactions;

-- 3. NAVIGATION: Month-over-month growth [cite: 80]
SELECT transaction_date, amount,
    LAG(amount) OVER (ORDER BY transaction_date) as previous_sale,
    amount - LAG(amount) OVER (ORDER BY transaction_date) as growth_diff
FROM Transactions;

-- 4. DISTRIBUTION: Customer segmentation by spending [cite: 81]
SELECT customer_id, amount,
    NTILE(4) OVER (ORDER BY amount DESC) as spending_quartile,
    CUME_DIST() OVER (ORDER BY amount DESC) as cumulative_distribution
FROM Transactions;
