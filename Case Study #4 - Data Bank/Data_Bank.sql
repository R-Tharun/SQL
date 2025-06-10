create database if not exists Data_Bank;
use Data_Bank;

-- Create the regions table
CREATE TABLE regions (
    region_id INTEGER PRIMARY KEY,
    region_name VARCHAR(50)
);

-- Insert data into regions
INSERT INTO regions (region_id, region_name) VALUES
(1, 'North'),
(2, 'South'),
(3, 'East');

-- Create the customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    region_id INTEGER,
    node_id INTEGER,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- Insert data into customers
INSERT INTO customers (customer_id, region_id, node_id, start_date, end_date) VALUES
(1, 2, 102, '2022-02-10', '2022-04-22'),
(2, 1, 106, '2022-10-10', '2023-02-11'),
(3, 1, 105, '2022-05-31', '2022-09-28'),
(4, 1, 104, '2022-11-18', '2023-02-09'),
(5, 3, 102, '2022-11-13', '2023-02-19'),
(6, 2, 103, '2022-01-10', '2022-04-11'),
(7, 2, 102, '2022-03-15', '2022-06-18'),
(8, 3, 105, '2022-04-20', '2022-09-05'),
(9, 1, 106, '2022-06-10', '2022-10-10'),
(10, 3, 104, '2022-08-01', '2022-12-12'),
(11, 1, 104, '2022-02-22', '2022-05-30'),
(12, 2, 103, '2022-01-01', '2022-04-15'),
(13, 3, 102, '2022-03-10', '2022-06-30'),
(14, 1, 106, '2022-04-14', '2022-07-20'),
(15, 2, 105, '2022-05-18', '2022-08-25'),
(16, 3, 103, '2022-06-01', '2022-09-01'),
(17, 2, 104, '2022-07-07', '2022-10-15'),
(18, 1, 106, '2022-08-20', '2022-11-30'),
(19, 2, 103, '2022-09-12', '2022-12-15'),
(20, 3, 105, '2022-10-18', '2023-01-20');

-- Create the transactions table
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    txn_date DATE,
    txn_type VARCHAR(20),
    txn_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- Insert data into transactions (sample for customers 1-5)
INSERT INTO transactions (customer_id, txn_date, txn_type, txn_amount) VALUES
(1, '2022-03-13', 'deposit', 3750.45),
(1, '2022-05-18', 'deposit', 1133.82),
(1, '2022-10-18', 'purchase', 1641.92),
(1, '2022-11-26', 'withdrawal', 800.07),
(1, '2022-12-02', 'withdrawal', 2038.60),

(2, '2022-11-01', 'deposit', 1500.00),
(2, '2022-11-12', 'withdrawal', 700.00),
(2, '2022-11-15', 'purchase', 400.00),

(3, '2022-06-10', 'deposit', 1200.00),
(3, '2022-06-20', 'withdrawal', 300.00),
(3, '2022-07-05', 'purchase', 500.00),

(4, '2022-12-01', 'deposit', 2000.00),
(4, '2022-12-10', 'purchase', 1000.00),

(5, '2023-01-01', 'deposit', 2500.00),
(5, '2023-01-10', 'withdrawal', 1500.00);


# Questions and Solutions

#1.How many unique nodes are there on the Data Bank system?

SELECT COUNT(DISTINCT node_id) AS unique_nodes
FROM customers;


#2.What is the number of nodes per region?

SELECT 
    r.region_name,
    COUNT(DISTINCT c.node_id) AS num_nodes
FROM customers c
JOIN regions r ON c.region_id = r.region_id
GROUP BY r.region_name
ORDER BY num_nodes DESC;

    
#3.How many customers are allocated to each region?

SELECT 
    r.region_name,
    COUNT(c.customer_id) AS num_customers
FROM customers c
JOIN regions r ON c.region_id = r.region_id
GROUP BY r.region_name
ORDER BY num_customers DESC;


#4.What is the unique count and total amount for each transaction type?

SELECT 
    txn_type,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(txn_amount) AS total_amount
FROM transactions
GROUP BY txn_type
ORDER BY total_amount DESC;

    
#5.Average number and amount of deposits per customer

WITH customer_deposits AS (
    SELECT 
        customer_id,
        COUNT(*) AS deposit_count,
        SUM(txn_amount) AS deposit_amount
    FROM transactions
    WHERE txn_type = 'deposit'
    GROUP BY customer_id
)
SELECT 
    ROUND(AVG(deposit_count), 2) AS avg_deposit_count,
    ROUND(AVG(deposit_amount), 2) AS avg_deposit_amount
FROM customer_deposits;

    
#6.Closing balance per customer at the end of each month

WITH txn_with_sign AS (
    SELECT 
        customer_id,
        txn_date,
        DATE_FORMAT(txn_date, '%Y-%m') AS txn_month,
        CASE 
            WHEN txn_type = 'deposit' THEN txn_amount
            WHEN txn_type IN ('withdrawal', 'purchase') THEN -txn_amount
            ELSE 0
        END AS signed_amount
    FROM transactions
),
monthly_txn_totals AS (
    SELECT 
        customer_id,
        txn_month,
        SUM(signed_amount) AS net_amount
    FROM txn_with_sign
    GROUP BY customer_id, txn_month
),
running_balance AS (
    SELECT 
        customer_id,
        txn_month,
        SUM(net_amount) OVER (
            PARTITION BY customer_id
            ORDER BY txn_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS closing_balance
    FROM monthly_txn_totals
)
SELECT 
    customer_id,
    txn_month,
    closing_balance
FROM running_balance
ORDER BY customer_id, txn_month;

   
#7.What is the percentage of customers who increase their closing balance by more than 5%?

WITH txn_with_sign AS (
    SELECT 
        customer_id,
        txn_date,
        DATE_FORMAT(txn_date, '%Y-%m') AS txn_month,
        CASE 
            WHEN txn_type = 'deposit' THEN txn_amount
            WHEN txn_type IN ('withdrawal', 'purchase') THEN -txn_amount
            ELSE 0
        END AS signed_amount
    FROM transactions
),
monthly_totals AS (
    SELECT 
        customer_id,
        txn_month,
        SUM(signed_amount) AS net_amount
    FROM txn_with_sign
    GROUP BY customer_id, txn_month
),
running_balance AS (
    SELECT 
        customer_id,
        txn_month,
        SUM(net_amount) OVER (
            PARTITION BY customer_id 
            ORDER BY txn_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS closing_balance
    FROM monthly_totals
),
balance_change AS (
    SELECT 
        customer_id,
        txn_month,
        closing_balance,
        LAG(closing_balance) OVER (
            PARTITION BY customer_id ORDER BY txn_month
        ) AS prev_balance
    FROM running_balance
),
improved_customers AS (
    SELECT DISTINCT customer_id
    FROM balance_change
    WHERE 
        prev_balance IS NOT NULL
        AND closing_balance > prev_balance * 1.05
)
SELECT 
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT customer_id) FROM transactions), 2) AS percent_customers_improved
FROM improved_customers;


    
