# Exploratory Data Analysis w/ SQL: Job Market Analysis

![Image](../../images/1_1_Project1_EDA.png "Project 1")

This is a SQL project analyzing the data engineer job market using real work posting data.

## Executive Summary

- **Project Scope:** Built 3 analytical queries that answer key questions about the job market for data engineer.
- **Data modeling:** Used multi-table joins between fact and dimensions tables to extract insights.
- **Analytics:** Extract information about demand, salary and value for demand skills in the filed of data engineering. Using aggregations, filtering, and sorting.
- **Outcomes:** Find that SQL, and Python are the most in demand skills, follow by cloud skills and niche technologies.

Associates queries:
[Top Demanded Skills Query](01_top_demanded_skills.sql)
[Top Paying skills](02_top_paying_skills.sql)
[Optimal skills](03_optimal_skills.sql)

## Problem & Context

Job market analysts need to answer questions like:

    🎯 Most in-demand: Which skills are most in-demand for data engineers?
    💰 Highest paid: Which skills command the highest salaries?
    ⚖️ Best trade-off: What is the optimal skill set balancing demand and compensation?

The warehouse structure consists of:
![Image](../../images/1_2_Data_Warehouse.png "Data Warehouse")

- Fact Table: job_postings_fact - Central table containing job posting details (job titles, locations, salaries, dates, etc.)
- Dimension Tables:

  - company_dim - Company information linked to job postings
  - skills_dim - Skills catalog with skill names and types

- Bridge Table: skills_job_dim - Resolves the many-to-many relationship between job postings and skills

## Tech Stack

- **Language:** SQL
- **Data Model:** Star schema with fact, dimension, and bridge tables
- **Query Engine:** DuckDB
- **Development:** Neovim and DuckDB CLI
- **Version Control:** Git/Github for versioned control

## Analysis Overview

### Query structure

1. **[Top Demanded Skills Query](01_top_demanded_skills.sql):** Identifies the 10 most in-demand skills for remote data engineer positions.
2. **[Top Paying skills](02_top_paying_skills.sql):** Analyzes the 25 highest-paying skills with salary and demand metrics
3. **[Optimal skills](03_optimal_skills.sql):** Calculates an optimal score using natural log of demand combined with median salary to identify the most valuable skills to learn

### Key insights

- SQL and Python are required constantly (29221 and 28776 postings) but sit mid-pack on salary (~$110–135K), almost all job postings required SQL/Python.
- Cloud Skills are in high demand special AWS commanding high salary. This suggests the market rewards people who can deploy and scale data systems, not just analyze data.
- The Python data-science stack is priced as a single bundle. Python, pandas, NumPy, and PySpark all cluster because they tend to appear together in the same senior/ML-focused roles rather than being individually differentiating.
