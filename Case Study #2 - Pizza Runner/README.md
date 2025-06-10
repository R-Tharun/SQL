# 🍕 Pizza Runner - SQL Case Study

## 🚀 About the Project
This case study strengthens SQL and data analysis skills by answering real-world business questions based on a fictional pizza delivery company, **Pizza Runner**.  
Inspired by **Danny Ma's #8WeekSQLChallenge**, it focuses on SQL querying, data cleaning, and performance metrics.

---

## 📂 Database and Tables
**Database:** `Pizza_Runner`

**Tables:**
- `runners` – Details of pizza runners (`runner_id`, `registration_date`)
- `customer_orders` – Orders placed by customers (`order_id`, `customer_id`, `pizza_id`, `exclusions`, `extras`, `order_time`)
- `runner_orders` – Delivery details (`order_id`, `runner_id`, `pickup_time`, `distance`, `duration`, `cancellation`)
- `pizza_names` – Pizza types (`pizza_id`, `pizza_name`)
- `pizza_recipes` – Ingredients for each pizza (`pizza_id`, `toppings`)
- `pizza_toppings` – Topping names (`topping_id`, `topping_name`)

---

## 🛠️ Setup Instructions

1. **Create the database and select it:**
    ```sql
    CREATE DATABASE IF NOT EXISTS Pizza_Runner;
    USE Pizza_Runner;
    ```

2. **Create the tables:**
    - `runners`
    - `customer_orders`
    - `runner_orders`
    - `pizza_names`
    - `pizza_recipes`
    - `pizza_toppings`

3. **Insert the provided sample data** into each table.

4. **Run the SQL queries** to solve business questions.

---

## ❓ Business Questions Solved

### A. 🍕 Pizza Metrics
- 🛒 Total pizzas ordered.
- 👥 Unique customer orders.
- 🚚 Successful deliveries by each runner.
- 🧾 Pizza types delivered count.
- 🧍‍♂️ Customer-wise Vegetarian and Meatlovers orders.
- 🏆 Maximum pizzas in a single order.
- 🔄 Pizzas delivered with/without changes (exclusions or extras).
- ✍️ Pizzas delivered with both exclusions and extras.
- 🕰️ Pizzas ordered per hour of the day.
- 📅 Orders volume per day of the week.

### B. 🛵 Runner and Customer Experience
- 📅 Weekly runner sign-ups.
- 🚗 Runner performance analysis (speed, distance, cancellations).
- ⏳ Average delivery times.
- 💸 Revenue calculations per runner.

---

## 🧠 Skills Practiced
- SQL Joins
- Aggregations
- CASE Statements
- Data Cleaning
- Time and Date Functions
- Analytical Thinking

---

## 📢 Credits
Inspired by [Danny Ma's 8 Week SQL Challenge](https://8weeksqlchallenge.com/)
