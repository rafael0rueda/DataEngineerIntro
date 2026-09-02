SELECT 
  job_id, 
  job_location
FROM 
  job_postings_fact
LIMIT 10;

SELECT DISTINCT 
  job_title_short
FROM 
  job_postings_fact;

SELECT
  job_title_short,
  job_title,
  salary_year_avg
FROM 
  job_postings_fact
WHERE 
  job_title_short = 'Data Engineer'
  AND
  salary_year_avg = 100000
LIMIT 10;

SELECT
  job_title_short,
  job_title,
  salary_year_avg
FROM 
  job_postings_fact
WHERE 
  job_title_short = 'Data Engineer'
  AND
  salary_year_avg IS NOT NULL
ORDER BY 
  salary_year_avg DESC 
LIMIT 10;

SELECT
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM 
  job_postings_fact
WHERE 
  job_title_short = 'Data Engineer'
ORDER BY 
  salary_year_avg DESC 
LIMIT 10;

-- 1.2 problem
SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM 
  job_postings_fact
WHERE 
  job_location IS NULL
LIMIT 10;
