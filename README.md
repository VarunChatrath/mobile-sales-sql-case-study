# Mobile Sales Analytics – Advanced SQL Case Study

## Overview
This repository contains an advanced SQL analytics case study focused on analyzing mobile phone sales data using a star-schema data model.  
The project demonstrates strong SQL proficiency, structured analytical thinking, and the ability to convert business requirements into accurate, production-ready SQL queries.

The analysis mirrors real-world analytics workflows commonly used in data analytics, business intelligence, and decision-support systems.

---

## Data Model
The database is designed using a star schema, a standard approach in analytical and BI environments.

### Fact Table
- FACT_TRANSACTIONS  
  Stores transaction-level sales data including total price, quantity, customer, product, location, and date.

### Dimension Tables
- DIM_CUSTOMER – Customer details  
- DIM_MODEL – Mobile phone models and unit pricing  
- DIM_MANUFACTURER – Manufacturer information  
- DIM_LOCATION – Geographic attributes  
- DIM_DATE – Time dimension with derived year, quarter, and month fields  

This design enables efficient aggregations, scalable querying, and time-based analysis.

---

## Business Questions Addressed
This case study answers multiple business-oriented analytical questions, including:

- Identifying states and regions contributing to sales over time  
- Determining top-performing manufacturers based on sales quantity and revenue  
- Analyzing pricing trends and demand at the model level  
- Identifying products consistently performing well across multiple years  
- Comparing manufacturer activity year-over-year  
- Evaluating customer spend behavior with year-over-year percentage change  

Each query is written to return a single, meaningful analytical result set.

---

## SQL Concepts and Techniques Used
The project focuses on industry-relevant SQL practices, including:

- Multi-table JOINs across fact and dimension tables  
- Aggregations using GROUP BY and HAVING clauses  
- Nested and correlated subqueries  
- Set-based operations such as INTERSECT and EXCEPT  
- Ranking and Top-N analysis using DENSE_RANK()  
- Window functions (LAG) for time-series and YoY analysis  
- Date-driven filtering using a dedicated time dimension  

The queries emphasize correctness, clarity, and business relevance.

---

## Repository Structure
mobile-sales-sql-case-study/
│
├── README.md
│ └── Project overview, data model, and analytical approach
│
├── analysis_queries.sql
│ └── Advanced SQL queries answering business-driven questions
│
└── database_setup.sql
└── Database schema creation and data population


---

## How to Use
1. Execute database_setup.sql to create the database schema and populate the data  
2. Run queries from analysis_queries.sql against the created database  
3. Each query is aligned with a specific analytical or business requirement  

---

## Key Takeaways
- Demonstrates strong command of intermediate-to-advanced SQL  
- Reflects experience working with analytical data models  
- Emphasizes business problem-solving over academic-style querying  
- Showcases practical usage of window functions and ranking logic  

---

## About
This project represents hands-on experience in SQL-based data analysis and reflects the type of analytical work performed in data analytics, business intelligence, and reporting-focused roles.

---

## Notes
- This repository is shared for portfolio and demonstration purposes  
- The focus is on analytical approach and SQL proficiency rather than proprietary datasets
