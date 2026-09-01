# E-Commerce Sales & Customer SQL Analysis

## 📌 Project Overview

In this project, I analyzed e-commerce sales and customer data using SQL.

I explored customer purchasing behavior, product and category performance, sales trends, payment methods, supplier performance, customer reviews, and shipment details.

During this project, I used SQL for data validation, data cleaning, exploratory data analysis, joins, time-based analysis, and advanced SQL concepts.
---

## 🎯 Project Objectives

The main objectives of this project are to:

- Analyze overall sales and business performance.
- Identify top-performing products and categories.
- Understand customer purchasing behavior and spending patterns.
- Identify high-value customers and customer segments.
- Analyze monthly revenue trends and revenue growth.
- Evaluate payment methods and transaction status.
- Analyze supplier contribution and performance.
- Explore product ratings and customer reviews.
- Evaluate shipment and delivery performance.
- Apply advanced SQL techniques to answer business questions.

---

## 🛠️ Tools & Technologies

- MySQL
- MySQL Workbench
- SQL

---

## 📊 Dataset Overview

The dataset contains e-commerce business data across 8 related tables.

| Table | Records | Description |
|---|---:|---|
| Customers | 10,000 | Customer details |
| Orders | 15,000 | Order information |
| Order Items | 20,000 | Products purchased in each order |
| Payment | 15,000 | Payment transaction details |
| Products | 2,000 | Product and category information |
| Reviews | 1,106 | Customer product reviews |
| Shipments | 15,000 | Shipment and delivery details |
| Suppliers | 100 | Supplier information |

---

# 🗂️ Database Schema

The dataset consists of multiple related tables.

```text
Customers
    │
    │ customer_id
    ▼
Orders
    │
    ├──────────────► Payments
    │
    ├──────────────► Shipments
    │
    ▼
Order Items
    │
    │ product_id
    ▼
Products
    │
    ├──────────────► Suppliers
    │
    └──────────────► Reviews
```

### Table Relationships

- `customers.customer_id` → `orders.customer_id`
- `orders.order_id` → `order_items.order_id`
- `products.product_id` → `order_items.product_id`
- `orders.order_id` → `payment.order_id`
- `suppliers.supplier_id` → `products.supplier_id`
- `products.product_id` → `reviews.product_id`
- `customers.customer_id` → `reviews.customer_id`
- `orders.order_id` → `shipments.order_id`

---

# 🔍 Data Validation & Quality Checks

Before performing the analysis, several data quality checks were performed.

### Checks Performed

- Verified record counts for all tables.
- Checked for NULL values across all columns.
- Checked for invalid product prices.
- Checked for invalid order quantities.
- Checked for invalid purchase prices.
- Checked for invalid order prices.
- Checked for invalid payment amounts.
- Validated product ratings.
- Checked for invalid delivery dates.
- Validated relationships between related tables.
- Identified invalid foreign key references.
- Corrected invalid purchase prices where required.

---

# 🔗 Relationship Validation

The relationships between tables were validated using SQL joins.

The following relationships were checked:

- Orders → Customers
- Order Items → Orders
- Order Items → Products
- Payments → Orders
- Products → Suppliers
- Reviews → Products
- Reviews → Customers
- Shipments → Orders

This validation ensured that records across related tables could be used reliably for analysis.

---

# 📊 Analysis Performed

## 1. Business Overview

The following overall business metrics were analyzed:

- Total orders
- Total customers
- Total revenue
- Average order value
- First order date
- Last order date
- Total products
- Total suppliers
- Total reviews
- Average product rating
- Total product categories

---

## 2. Customer Analysis

Customer behavior and purchasing patterns were analyzed using:

- Top customers by total spending
- Customer order frequency
- Customers with no orders
- Customer spending ranking
- Customer segmentation based on total spending

Customers were classified into:

- High Value Customer
- Medium Value Customer
- Low Value Customer

---

## 3. Product & Category Analysis

Product and category performance was analyzed using:

- Category-wise revenue
- Category-wise units sold
- Category-wise total orders
- Top products by revenue
- Product category performance
- Average product price by category
- Products with no sales

---

## 4. Time-Based Sales Analysis

Sales trends were analyzed using order dates.

The analysis includes:

- Monthly revenue trend
- Monthly order volume
- Month-over-month revenue change
- Month-over-month revenue growth percentage
- Top revenue months

This section uses date functions and window functions to identify sales trends over time.

---

## 5. Payment Analysis

Payment information was analyzed to understand:

- Revenue by payment method
- Total orders by payment method
- Average payment amount
- Transaction status
- Total transaction amount

---

## 6. Supplier Analysis

Supplier performance was analyzed using multiple related tables.

The analysis includes:

- Number of products supplied
- Supplier-wise revenue
- Units sold by supplier
- Top suppliers by revenue

The following relationship was used:

```text
Suppliers
    ↓
Products
    ↓
Order Items
```

---

## 7. Review & Rating Analysis

Customer review data was analyzed to understand product satisfaction.

The analysis includes:

- Product average ratings
- Total reviews per product
- Category-wise average ratings
- Products with no reviews
- Customer review activity

---

## 8. Shipment & Delivery Analysis

Shipment and delivery performance was analyzed using:

- Shipment status
- Carrier performance
- Total shipments
- Delivered shipments
- Average delivery time
- Fastest delivery time
- Slowest delivery time
- Shipment status percentage

---

# 🚀 Advanced SQL Techniques Used

This project demonstrates several important SQL concepts and techniques.

## INNER JOIN

`INNER JOIN` was used to analyze matching records between related tables.

Examples include:

- Customers and Orders
- Order Items and Products
- Products and Suppliers
- Suppliers, Products and Order Items

---

## LEFT JOIN

`LEFT JOIN` was used to identify records that do not have matching records in another table.

Examples include:

- Customers with no orders
- Products with no sales
- Products with no reviews

---

## Aggregate Functions

The following aggregate functions were used:

```sql
SUM()
COUNT()
AVG()
MIN()
MAX()
```

These functions were used to calculate business metrics such as revenue, order counts, average values, and delivery performance.

---

## GROUP BY

`GROUP BY` was used to perform grouped analysis such as:

- Revenue by category
- Revenue by payment method
- Revenue by supplier
- Reviews by product
- Shipment status distribution

---

## Common Table Expressions (CTEs)

CTEs were used to simplify complex queries and organize intermediate calculations.

```sql
WITH
```

CTEs were used for:

- Monthly revenue calculations
- Product revenue analysis
- Category ranking
- Customer spending analysis
- Product ranking within categories

---

## Window Functions

Window functions were used for advanced analytical calculations.

```sql
OVER()
```

They were used to perform ranking and previous-period comparisons.

---

## LAG()

`LAG()` was used to retrieve the revenue of the previous month.

This was used to calculate:

- Previous month revenue
- Revenue change
- Month-over-month revenue growth percentage

Example:

```sql
LAG(total_revenue) OVER (ORDER BY month)
```

---

## RANK()

`RANK()` was used to rank:

- Product categories by revenue
- Products within each category
- Customers by total spending

Example:

```sql
RANK() OVER (ORDER BY total_revenue DESC)
```

---

## PARTITION BY

`PARTITION BY` was used to divide data into groups before applying ranking functions.

For example, products were ranked within their respective categories.

```sql
PARTITION BY category
```

---

## CASE Statement

The `CASE` statement was used for customer segmentation.

Example:

```sql
CASE
    WHEN total_spending >= 1000 THEN 'High Value Customer'
    WHEN total_spending >= 500 THEN 'Medium Value Customer'
    ELSE 'Low Value Customer'
END
```

---

# 💡 SQL Concepts Demonstrated

This project demonstrates the following SQL concepts:

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Aggregate Functions
- INNER JOIN
- LEFT JOIN
- Multiple Table Joins
- Subqueries
- CASE Statements
- Common Table Expressions (CTEs)
- Window Functions
- LAG()
- RANK()
- PARTITION BY
- DATE_FORMAT()
- DATEDIFF()
- NULL Value Checks
- Data Validation

---

# 📈 Business Questions Answered

The SQL analysis answers several business questions, including:

1. How many customers, orders, products, and suppliers are present in the dataset?
2. What is the overall revenue generated by the business?
3. What is the average order value?
4. Which customers have the highest total spending?
5. Which customers have placed the highest number of orders?
6. Which customers have not placed any orders?
7. Which product categories generate the highest revenue?
8. Which products generate the highest revenue?
9. Which products have no sales?
10. How does revenue change month by month?
11. What is the month-over-month revenue growth?
12. Which months generated the highest revenue?
13. Which payment methods generate the highest transaction value?
14. What is the distribution of transaction statuses?
15. Which suppliers generate the highest revenue?
16. Which products receive the highest ratings?
17. Which categories have the highest average ratings?
18. Which products have not received reviews?
19. How many reviews has each customer provided?
20. Which carriers handle the highest number of shipments?
21. What is the average delivery time?
22. What is the distribution of shipment statuses?
23. Which product categories rank highest by revenue?
24. Which products are among the top performers within each category?
25. Which customers rank highest by total spending?
26. How can customers be segmented based on spending behavior?

---

# 📁 Project Structure

```text
E-Commerce-Sales-Customer-SQL-Analysis/
│
├── E-Commerce-Sales-Customer-Analysis.sql
│
├── dataset/
│   ├── customers.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── payment.csv
│   ├── products.csv
│   ├── reviews.csv
│   ├── shipments.csv
│   └── suppliers.csv
│
└── README.md
```

---

# 📌 Key Skills Demonstrated

- SQL Data Analysis
- Data Cleaning
- Data Validation
- Exploratory Data Analysis
- Relational Database Analysis
- Business Analysis
- Customer Analysis
- Sales Analysis
- Product Performance Analysis
- Supplier Analysis
- Payment Analysis
- Review Analysis
- Shipment Analysis
- SQL Joins
- CTEs
- Window Functions
- Business Problem Solving

---

# 🎯 Project Learning Outcomes

Through this project, the following skills were applied and demonstrated:

- Working with multiple related tables.
- Understanding relational database relationships.
- Performing data validation before analysis.
- Using joins to combine data from multiple tables.
- Performing sales and customer analysis.
- Analyzing business performance using SQL.
- Performing time-based analysis.
- Calculating month-over-month growth.
- Using CTEs to simplify complex queries.
- Using window functions for ranking and comparisons.
- Segmenting customers using conditional logic.

---

# 👨‍💻 Author

**Sumit Tambitkar**

Aspiring Data Analyst

**Skills:** SQL | Excel | Power BI

---

⭐ If you found this project interesting, feel free to star the repository!
