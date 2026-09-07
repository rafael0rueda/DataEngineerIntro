SELECT 
   table_name,
   column_name,
   data_type
FROM   information_schema.columns
WHERE table_name = 'job_postings_fact';

-- OR use describe, it does not work for all databases

DESCRIBE job_postings_fact;

-- Casting

SELECT 
   CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR),
   job_work_from_home,
   CAST(job_work_from_home AS INT) AS num_work_from_home,
   job_posted_date,
   CAST(job_posted_date AS DATE) AS job_posted,
   salary_year_avg,
   CAST(salary_year_avg AS DECIMAL(10,0)) AS salary_decimal
FROM 
   job_postings_fact
WHERE
   salary_year_avg IS NOT NULL
LIMIT 10;
