# 🍔 Foodie-Fi - SQL Case Study

## 🚀 About the Project
This case study is focused on analyzing a fictional subscription-based streaming service, **Foodie-Fi**.  
Inspired by **Danny Ma's #8WeekSQLChallenge**, it strengthens SQL querying, customer journey analysis, and business insights skills.

---

## 📂 Database and Tables
**Database:** `Foodie_Fi`

**Tables:**
- `subscription_plans` – Subscription plan details (`plan_id`, `plan_name`, `price`)
- `customer_subscriptions` – Customer journey tracking (`customer_id`, `plan_id`, `start_date`)

---

## 🛠️ Setup Instructions

1. **Create the database and select it:**
    ```sql
    CREATE DATABASE IF NOT EXISTS Foodie_Fi;
    USE Foodie_Fi;
    ```

2. **Create the tables:**
    ```sql
    CREATE TABLE subscription_plans (
        plan_id INT PRIMARY KEY,
        plan_name VARCHAR(50),
        price DECIMAL(10,2) NULL
    );

    CREATE TABLE customer_subscriptions (
        customer_id INT,
        plan_id INT,
        start_date DATE,
        PRIMARY KEY (customer_id, start_date),
        FOREIGN KEY (plan_id) REFERENCES subscription_plans(plan_id)
    );
    ```

3. **Insert sample data**:
    - For `subscription_plans`
    - For `customer_subscriptions`

4. **Run the SQL queries** to solve business analysis questions.

---

## ❓ Business Questions Solved

### A. 🧑‍💻 Customer Journey
- View customers' plan history with start dates.

### B. 📊 Data Analysis Questions
1. **How many customers has Foodie-Fi ever had?**
2. **Monthly distribution of trial plan start dates.**
3. **Plan start dates after 2020, broken down by plan name.**
4. **Customer count and percentage of churned customers.**
5. **Customers who churned directly after the free trial.**
6. **Plans customers moved to after the free trial (excluding churns).**
7. **Plan distribution as of 2020-12-31.**
8. **Number of customers who upgraded to an annual plan in 2020.**
9. **Average days taken to upgrade to an annual plan.**
10. **Breakdown of upgrade times to an annual plan in 30-day periods.**
11. **Customers who downgraded from Pro Monthly to Basic Monthly in 2020.**

---

## 🧠 Skills Practiced
- SQL Joins
- Aggregations
- Date Functions
- CASE Statements
- Customer Lifecycle Analysis
- Business Metrics Interpretation

---

## 📢 Credits
Inspired by [Danny Ma's 8 Week SQL Challenge](https://8weeksqlchallenge.com/)
