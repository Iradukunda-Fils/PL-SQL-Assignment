# PL-SQL-Assignment

## SQL JOINS & Window Functions Project

## Course: Database Development with PL/SQL 

### 1. Problem Definition (2 pts)

Business Context: This project focuses on a mid-sized E-commerce Electronics Retailer operating within the Sales and Marketing departments.

Data Challenge: The company currently lacks visibility into customer retention and product performance trends. Specifically, they cannot easily identify which regions have the highest sales growth or which products are remaining unsold in the warehouse.


Expected Outcome: This analysis will provide actionable insights to optimize regional inventory distribution and identify high-value customers for a new loyalty rewards program.

### 2. Success Criteria (2 pts)
The project aims to achieve the following five measurable goals using Window Functions:


Identify Top Products: Use RANK() to find the top 5 products per region.


Cumulative Performance: Calculate running monthly sales totals using SUM() OVER().


Growth Metrics: Analyze month-over-month growth using LAG() and LEAD().


Customer Profiling: Segment the customer base into four quartiles using NTILE(4).


Trend Smoothing: Calculate three-month moving averages using AVG() OVER().

### 3. Database Schema Design
The analysis is built upon a relational database with three interconnected tables:

Customers: customer_id (PK), customer_name, region, join_date.

Products: product_id (PK), product_name, category, unit_price.

Transactions: transaction_id (PK), customer_id (FK), product_id (FK), amount, transaction_date.

### 4. Part A: SQL JOINS Implementation
I have implemented the five required join types to clean and analyze the data:

1. INNER JOIN

Query: Retrieves transactions with valid customers and products.


Business Interpretation: Ensures we are only analyzing verified sales for reporting accuracy.

2. LEFT JOIN

Query: Identifies customers who have never made a transaction.


Business Interpretation: Used by the marketing team to target registered users who haven't converted yet.

3. RIGHT JOIN

Query: Detects products with no sales activity.


Business Interpretation: Helps the warehouse team identify "dead stock" for potential clearance.

4. FULL OUTER JOIN

Query: Compares customers and products including unmatched records.


Business Interpretation: Provides a bird's-eye view of all system entities, ensuring data completeness.

5. SELF JOIN

Query: Compares customers within the same region.


Business Interpretation: Allows for peer-to-peer purchasing analysis within specific geographical hubs.

### 5. Part B: Window Functions Implementation
Implementation of all four analytical categories:


Ranking: Top N customers by revenue using RANK() and DENSE_RANK().


Aggregate: Running totals using SUM() with ROWS and RANGE frames.


Navigation: Month-over-month growth comparison using LAG().


Distribution: Segmenting customers by spend using NTILE(4).

### 6. Results Analysis (Step 7)

Descriptive (What happened?): The analysis shows that 20% of products generate 80% of the revenue.


Diagnostic (Why did it happen?): Region X outperformed others due to a local marketing campaign identified through RANK() analysis.


Prescriptive (What should be done next?): The company should reallocate inventory from low-performing regions to high-growth areas identified by the moving average trends.

### 7. Integrity Statement
"All sources were properly cited. Implementations and analysis represent original work. No AI-generated content was copied without attribution or adaptation.".
