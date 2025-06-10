# 🍽️ Danny's Diner - SQL Case Study

## 🚀 About the Project

This case study strengthens SQL and data analysis skills by answering real-world business questions based on a fictional diner, **Danny's Diner**.  
Inspired by **Danny Ma's #8WeekSQLChallenge**, this project helps develop SQL querying, joins, aggregations, and window function skills.

---

## 📂 Database and Tables

**Database:** `Dannys_Dinner`

**Tables:**
- `sales` – Records of food purchases by customers (`customer_id`, `order_date`, `product_id`)
- `menu` – Menu items and their prices (`product_id`, `product_name`, `price`)
- `members` – Loyalty program members and their join dates (`customer_id`, `join_date`)

---

## 🛠️ Setup Instructions

1. **Create the database and select it:**

    ```sql
    CREATE DATABASE IF NOT EXISTS Dannys_Dinner;
    USE Dannys_Dinner;
    ```

2. **Create the tables:**
    - `sales`
    - `menu`
    - `members`

3. **Insert the provided sample data** into each table.

4. **Run the SQL queries** to solve business questions.

---

## 🧠 Skills Practiced

- SQL Joins (INNER, LEFT)
- Aggregations with `SUM`, `COUNT`, `MAX`
- Filtering using `WHERE`, `BETWEEN`
- Window Functions: `DENSE_RANK()`, `ROW_NUMBER()`
- Common Table Expressions (CTEs)
- Data storytelling using SQL

---

## 📢 Credits

Inspired by [Danny Ma's 8 Week SQL Challenge](https://8weeksqlchallenge.com/)  
Built by Jeffrin Webster using **MySQL**
