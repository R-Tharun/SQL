-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS Data_Mart;
USE Data_Mart;

-- Create data_bank table
CREATE TABLE data_bank (
    week_data DATE,
    region VARCHAR(50),
    platform VARCHAR(50),
    segment VARCHAR(50),
    customer_type VARCHAR(50),
    transacti INT,
    age_band VARCHAR(50),
    demographic VARCHAR(50)
);

-- Insert data into data_bank table
INSERT INTO data_bank (week_data, region, platform, segment, customer_type, transacti, age_band, demographic) VALUES
('2025-04-01', 'South', 'Retail', 'Retail', 'New', 100, '18-25', 'Urban'),
('2025-04-08', 'North', 'Shopify', 'Shopify', 'Existing', 150, '26-35', 'Rural'),
('2025-04-15', 'East', 'Retail', 'Retail', 'New', 200, '36-45', 'Urban'),
('2025-04-22', 'West', 'Shopify', 'Shopify', 'Existing', 250, '46-55', 'Rural');

-- Create customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100)
);

-- Insert data into customers table
INSERT INTO customers (customer_name, customer_email)
VALUES
    ('John Doe', 'john.doe@example.com'),
    ('Jane Smith', 'jane.smith@example.com'),
    ('Alice Johnson', 'alice.johnson@example.com'),
    ('Bob Brown', 'bob.brown@example.com'),
    ('Charlie Davis', 'charlie.davis@example.com');

-- Create transactions table
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    txn_date DATE,
    txn_type VARCHAR(20),
    txn_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert data into transactions table
INSERT INTO transactions (customer_id, txn_date, txn_type, txn_amount)
VALUES
    (1, '2025-04-01', 'Purchase', 150.75),
    (2, '2025-04-02', 'Refund', 50.00),
    (3, '2025-04-03', 'Purchase', 200.00),
    (4, '2025-04-04', 'Purchase', 100.50),
    (5, '2025-04-05', 'Refund', 30.25);

-- Show tables
SHOW TABLES;

-- 1. What day of the week is used for each week_date value?
SELECT week_data, DAYNAME(week_data) AS day_of_week
FROM data_bank;

-- 2. What range of week numbers are missing from the dataset?
CREATE TABLE IF NOT EXISTS numbers (
    number INT
);

INSERT INTO numbers (number)
SELECT a.N + b.N * 10 + 1 AS number
FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 
      UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 
      UNION ALL SELECT 8 UNION ALL SELECT 9) a,
     (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 
      UNION ALL SELECT 4) b
WHERE a.N + b.N * 10 < 53;

SELECT n.number AS week_number
FROM numbers n
LEFT JOIN (
    SELECT DISTINCT WEEK(week_data) AS week_number
    FROM data_bank
) w ON n.number = w.week_number
WHERE w.week_number IS NULL
AND n.number BETWEEN 1 AND 53
ORDER BY n.number;

-- 3. How many total transactions were there for each year in the dataset?
SELECT 
    YEAR(week_data) AS year,
    SUM(transacti) AS total_transactions
FROM 
    data_bank
GROUP BY 
    YEAR(week_data)
ORDER BY 
    year;

-- 4. What is the total sales for each region for each month?
SELECT 
    region,
    YEAR(week_data) AS year,
    MONTH(week_data) AS month,
    SUM(transacti) AS total_sales
FROM 
    data_bank
GROUP BY 
    region, YEAR(week_data), MONTH(week_data)
ORDER BY 
    region, year, month;

-- 5. What is the total count of transactions for each platform?
SELECT 
    platform,
    SUM(transacti) AS total_transactions
FROM 
    data_bank
GROUP BY 
    platform
ORDER BY 
    total_transactions DESC;

-- 6. What is the percentage of sales for Retail vs Shopify for each month?
WITH monthly_sales AS (
    SELECT 
        YEAR(week_data) AS year,
        MONTH(week_data) AS month,
        platform,
        SUM(transacti) AS total_sales
    FROM 
        data_bank
    WHERE platform IN ('Retail', 'Shopify')
    GROUP BY 
        YEAR(week_data), MONTH(week_data), platform
),
monthly_totals AS (
    SELECT 
        year,
        month,
        SUM(total_sales) AS month_total
    FROM 
        monthly_sales
    GROUP BY 
        year, month
)

SELECT 
    ms.year,
    ms.month,
    ms.platform,
    ms.total_sales,
    ROUND((ms.total_sales / mt.month_total) * 100, 2) AS sales_percentage
FROM 
    monthly_sales ms
JOIN 
    monthly_totals mt 
ON 
    ms.year = mt.year AND ms.month = mt.month
ORDER BY 
    ms.year, ms.month, ms.platform;

-- 7. What is the percentage of sales by demographic for each year in the dataset?
WITH yearly_sales AS (
    SELECT 
        YEAR(week_data) AS year,
        demographic,
        SUM(transacti) AS total_sales
    FROM 
        data_bank
    GROUP BY 
        YEAR(week_data), demographic
),
year_totals AS (
    SELECT 
        year,
        SUM(total_sales) AS year_total
    FROM 
        yearly_sales
    GROUP BY 
        year
)

SELECT 
    ys.year,
    ys.demographic,
    ys.total_sales,
    ROUND((ys.total_sales / yt.year_total) * 100, 2) AS sales_percentage
FROM 
    yearly_sales ys
JOIN 
    year_totals yt 
ON 
    ys.year = yt.year
ORDER BY 
    ys.year, ys.demographic;

-- 8. Which age_band and demographic values contribute the most to Retail sales?
SELECT age_band, demographic, 
SUM(transacti) AS total_retail_sales
FROM data_bank
WHERE segment = 'Retail'
GROUP BY age_band, demographic
ORDER BY total_retail_sales DESC;

-- 9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
SELECT 
    YEAR(week_data) AS year,
    segment,
    AVG(transacti) AS avg_transaction
FROM data_bank
WHERE segment IN ('Retail', 'Shopify')
GROUP BY YEAR(week_data), segment
ORDER BY year, segment;


-- 10. Create a heatmap view for sales by region, platform, and age band
SELECT 
    region, 
    platform, 
    age_band, 
    SUM(transacti) AS total_sales
FROM data_bank
GROUP BY region, platform, age_band
ORDER BY region, platform, age_band;
