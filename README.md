# NovaCart: E-Commerce Database Design

A end-to-end relational database project for **NovaCart**, a fictional online store. It goes from conceptual modeling to a working MySQL database, sample data, and 34 analytical SQL queries.

## Overview

NovaCart lets customers browse products grouped by category, place orders containing multiple products, pay for them, and leave reviews. This project models that business as seven normalized tables and demonstrates how to query it, from simple SELECTs to window functions and reporting views.

## Data Model

### Conceptual ERD
Entities and the relationships between them, before any keys are added.

![Conceptual ERD](images/conceptual-erd.png)

### Logical ERD (Relational Mapping)
The ERD mapped to tables with primary keys, foreign keys, and unique constraints. `Order_Details` resolves the many-to-many relationship between `Orders` and `Product`.

![Logical ERD](images/logical-erd.png)

### Relationships

| Relationship | Cardinality |
|---|---|
| Customer places Orders | 1 : N |
| Category contains Products | 1 : N |
| Order has Payment | 1 : 1 |
| Order includes Order_Details | 1 : N |
| Product appears in Order_Details | 1 : N |
| Customer writes Reviews | 1 : N |
| Product receives Reviews | 1 : N |

### Design Highlights

- **Normalized to 3NF**, with a composite primary key `(Order_ID, Product_ID)` in `Order_Details`.
- **Unit_Price is stored per order line**, so historical orders keep their price even if the product price changes later.
- **One payment per order** and **one review per customer per product**, enforced with `UNIQUE` constraints.
- **Data integrity** through `CHECK` constraints (non-negative prices and stock, positive quantity, rating between 1 and 5) and `ENUM` columns for order status and payment method.
- **Referential actions**: `RESTRICT` protects core records such as customers and products, while `CASCADE` cleans up dependent rows such as order lines and reviews.

## Repository Structure

```
NovaCart-Database-Design/
├── images/
│   ├── conceptual-erd.png
│   └── logical-erd.png
├── 1_NovaCart_DDL.sql        -- creates the database and all tables
├── 2_NovaCart_Insert.sql     -- sample data (10 customers, 15 products, 10 orders, ...)
├── 3_NovaCart_Queries.sql    -- 34 queries and 3 views
└── README.md
```

## Getting Started

Requires **MySQL 8.0+** (CTEs and window functions).

```bash
mysql -u root -p < 1_NovaCart_DDL.sql
mysql -u root -p < 2_NovaCart_Insert.sql
mysql -u root -p < 3_NovaCart_Queries.sql
```

> Warning: the DDL script drops and recreates the `NovaCart` database.

## SQL Topics Covered

| Part | Topics |
|---|---|
| 1. Basic queries | SELECT, WHERE, ORDER BY |
| 2. Aggregates | COUNT, AVG, MIN, MAX, SUM |
| 3. Grouping | GROUP BY, HAVING |
| 4. Joins | INNER JOIN, LEFT JOIN, multi-table joins |
| 5. Subqueries | IN, NOT IN, scalar and derived-table subqueries |
| 6. CTEs | Monthly revenue, customer spending |
| 7. Window functions | RANK, DENSE_RANK, LAG, running totals |
| 8. Views | `vw_revenue_by_month`, `vw_best_selling_products`, `vw_customer_summary` |

Author: Rahma Ashraf Ali Faragallah

## Tools



MySQL 8.0 · MySQL Workbench · Git
