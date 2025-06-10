# Data Bank SQL Case Study

This project explores a fictional **Data Bank** system using SQL.  
We have **three tables**: `regions`, `customers`, and `transactions`, with a variety of queries to extract insights about customer activities, transactions, and balances.

---

## 🗄 Database Structure

- **regions**: Contains the regions where customers are located.
- **customers**: Links each customer to a region and node, along with their active dates.
- **transactions**: Tracks all customer transactions (deposits, withdrawals, purchases).

### Database and Tables Setup

```sql
CREATE DATABASE IF NOT EXISTS Data_Bank;
USE Data_Bank;

-- Create regions table
CREATE TABLE regions (
    region_id INTEGER PRIMARY KEY,
    region_name VARCHAR(50)
);

-- Create customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    region_id INTEGER,
    node_id INTEGER,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- Create transactions table
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    txn_date DATE,
    txn_type VARCHAR(20),
    txn_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
