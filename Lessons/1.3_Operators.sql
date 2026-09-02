SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM
  job_postings_fact
WHERE
  job_location = 'Anywhere'
LIMIT 10;

SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg,
  job_work_from_home
FROM
  job_postings_fact
WHERE
  job_work_from_home = TRUE
LIMIT 10;

SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg,
  job_schedule_type
FROM
  job_postings_fact
WHERE job_schedule_type <> 'Contractor';

SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg,
  job_schedule_type
FROM
  job_postings_fact
WHERE
  salary_year_avg > 100000;

SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM
  job_postings_fact
WHERE 
  job_location = 'Anywhere' 
  AND job_work_from_home = TRUE;

SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM
  job_postings_fact
WHERE NOT
  (job_location = 'Anywhere' 
  AND job_work_from_home = TRUE);

SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM
  job_postings_fact
WHERE 
  salary_year_avg BETWEEN 100_000 AND 200_000;

SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM
  job_postings_fact
WHERE 
  job_title_short IN ('Data Analyst', 'Data Engineer', 'Senior Data Engineer');

SELECT 
  job_id,
  job_title_short,
  job_location,
  job_via,
  salary_year_avg
FROM
  job_postings_fact
WHERE 
  (
    (job_title_short = 'Data Analyst' AND salary_year_avg BETWEEN 100_000 AND 125_000) 
    OR 
    (job_title_short ='Data Engineer' AND salary_year_avg BETWEEN 75_000 AND 100_000)
  )
  AND 
  (
    job_location IN ('Bentonville, AR', 'San Diego, CA')
    OR
    job_work_from_home = TRUE
  )
ORDER BY 
salary_year_avg DESC;
