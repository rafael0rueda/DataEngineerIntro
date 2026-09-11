-- Subquery
SELECT *
FROM (
   SELECT *
   FROM job_postings_fact
   WHERE salary_year_avg IS NOT NULL
   OR salary_hour_avg IS NOT NULL
) AS valid_salaries
LIMIT 10;

-- CTE
WITH valid_salaries AS (
   SELECT *
   FROM job_postings_fact
   WHERE salary_year_avg IS NOT NULL
   OR salary_hour_avg IS NOT NULL
)
SELECT *
FROM valid_salaries
LIMIT 10;

-- Show each job's salary next to the overall market median

SELECT
   job_title_short,
   salary_year_avg,
   (
      SELECT MEDIAN(salary_year_avg)
      FROM job_postings_fact
   ) AS market_median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;

-- Stage only jobs that are remote before aggregating to determine the remote median salary per job

SELECT
   job_title_short,
   MEDIAN(salary_year_avg) AS median_salary,
   (
      SELECT MEDIAN(salary_year_avg)
      FROM job_postings_fact
      WHERE job_work_from_home = TRUE
   ) AS market_remote_median_salary
FROM (
   SELECT
      job_title_short,
      salary_year_avg
   FROM job_postings_fact
   WHERE job_work_from_home = TRUE
) AS clean_jobs
WHERE salary_year_avg IS NOT NULL
GROUP BY  job_title_short
LIMIT 10;

-- Keep only job titles whose median salary is above the overall median

SELECT
   job_title_short,
   MEDIAN(salary_year_avg) AS median_salary,
   (
      SELECT MEDIAN(salary_year_avg)
      FROM job_postings_fact
      WHERE job_work_from_home = TRUE
   ) AS market_remote_median_salary
FROM (
   SELECT
      job_title_short,
      salary_year_avg
   FROM job_postings_fact
   WHERE job_work_from_home = TRUE
) AS clean_jobs
WHERE salary_year_avg IS NOT NULL
GROUP BY  job_title_short
HAVING MEDIAN(salary_year_avg) > market_remote_median_salary
LIMIT 10;

-- Compare how much more or less remote roles pay compared to onsite roles for each job title
WITH title_median AS (
   SELECT
      job_title_short,
      job_work_from_home,
      MEDIAN(salary_year_avg)::INT AS median_salary
   FROM job_postings_fact
   WHERE job_country = 'Colombia'
   GROUP BY
      job_title_short,
      job_work_from_home
)

SELECT
   r.job_title_short,
   r.median_salary AS remote_median_salary,
   o.median_salary AS onsite_median_salary,
   (r.median_salary - o.median_salary) AS remote_premium
FROM title_median AS r
INNER JOIN title_median AS o
   ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
   AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC;

-- Filters

SELECT *
FROM range(3) AS src(key);

SELECT *
FROM range(2) AS tgt(key);

SELECT *
FROM range(3) AS src(key)
WHERE EXISTS (
   SELECT 1
   FROM range(2) AS tgt(key)
   WHERE tgt.key = src.key
);

SELECT *
FROM range(3) AS src(key)
WHERE NOT EXISTS (
   SELECT 1
   FROM range(2) AS tgt(key)
   WHERE tgt.key = src.key
);

-- Identify job postings that have no associated skills before loading them into a data mart

SELECT *
FROM job_postings_fact
ORDER BY job_id
LIMIT 10;

SELECT *
FROM skills_job_dim
ORDER BY job_id
LIMIT 40;

SELECT *
FROM job_postings_fact AS tgt
WHERE NOT EXISTS (
   SELECT 1
   FROM skills_job_dim as src
   WHERE tgt.job_id = src.job_id
)
ORDER BY job_id;

