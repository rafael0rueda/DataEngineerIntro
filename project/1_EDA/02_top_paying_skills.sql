-- Analyzes the 25 highest-paying skills with salary and demand metrics

SELECT
   sd.skills,
   ROUND(MEDIAN(jpf.salary_year_avg), 1) AS median_salary,
   COUNT(jpf.*) AS skill_count
FROM
   job_postings_fact jpf
INNER JOIN skills_job_dim AS sjd
   ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
   ON sjd.skill_id = sd.skill_id
WHERE
   jpf.job_title_short = 'Data Engineer'
   AND 
   jpf.job_work_from_home = True
   AND
   jpf.job_country = 'Colombia'
GROUP BY sd.skills
HAVING
   COUNT(jpf.*) >= 10
ORDER BY median_salary DESC
LIMIT 25;

/*
Without contry and more that 100 jobs required the skill
┌────────────┬───────────────┬─────────────┐
│   skills   │ median_salary │ skill_count │
│  varchar   │    double     │    int64    │
├────────────┼───────────────┼─────────────┤
│ rust       │      210000.0 │         232 │
│ terraform  │      184000.0 │        3248 │
│ golang     │      184000.0 │         912 │
│ spring     │      175500.0 │         364 │
│ neo4j      │      170000.0 │         277 │
│ gdpr       │      169615.5 │         582 │
│ zoom       │      168437.5 │         127 │
│ graphql    │      167500.0 │         445 │
│ mongo      │      162250.0 │         265 │
│ fastapi    │      157500.0 │         204 │
│ django     │      155000.0 │         265 │
│ bitbucket  │      155000.0 │         478 │
│ crystal    │      154223.5 │         129 │
│ atlassian  │      151500.0 │         249 │
│ c          │      151500.0 │         444 │
│ typescript │      151000.0 │         388 │
│ kubernetes │      150500.0 │        4202 │
│ airflow    │      150000.0 │        9996 │
│ node       │      150000.0 │         179 │
│ ruby       │      150000.0 │         736 │
│ css        │      150000.0 │         262 │
│ redis      │      149000.0 │         605 │
│ vmware     │      148798.3 │         136 │
│ ansible    │      148798.3 │         475 │
│ jupyter    │      147500.0 │         400 │
└────────────┴───────────────┴─────────────┘
  25 rows                        3 columns

With country and more that 10 jobs required the skill

1. Demand and pay are inversely related for the top skills.
SQL and Python are required constantly (142 and 138 postings) but sit mid-pack 
on salary (~$110–122K). AWS shows up far less often (47) but pays the most (~$153K). 
That's a classic supply/demand signal — everyone has SQL/Python, so it's table stakes 
rather than a differentiator; fewer people are strong in cloud infrastructure, 
so it commands a premium.

2. Cloud/infra skills pay more than pure data-analysis skills.
AWS ($153K) and Databricks ($136K) beat out Python, pandas, and NumPy (~$122.5K) 
even though the latter are far more common. This suggests the market rewards people 
who can deploy and scale data systems, not just analyze data.

3. The Python data-science stack is priced as a single bundle.
Python, pandas, NumPy, and PySpark all cluster at exactly $122,500 — likely 
because they tend to appear together in the same senior/ML-focused roles rather 
than being individually differentiating.

4. Multi-cloud beats single-cloud, so far.
GCP ($110,937) and Azure ($110,000) trail AWS by a noticeable margin — worth 
checking if that's a real skill-value gap or just fewer/different role types in 
the dataset.

5. Some "common" skills pay poorly.
Airflow and Redshift both show relatively high counts (22 and 10) but the lowest 
salaries in the top 18 ($30K) — that's a big enough gap from the rest of the table 
that it's worth sanity-checking (could be a data issue, part-time/junior postings, 
or a real signal that orchestration/warehouse-specific skills aren't valued standalone).

┌────────────┬───────────────┬─────────────┐
│   skills   │ median_salary │ skill_count │
│  varchar   │    double     │    int64    │
├────────────┼───────────────┼─────────────┤
│ aws        │      153437.5 │          47 │
│ databricks │      135937.5 │          15 │
│ numpy      │      122500.0 │          18 │
│ pyspark    │      122500.0 │          23 │
│ python     │      122500.0 │         138 │
│ pandas     │      122500.0 │          21 │
│ sql server │      116250.0 │          11 │
│ gcp        │      110937.5 │          19 │
│ sql        │      110000.0 │         142 │
│ azure      │      110000.0 │          21 │
│ spark      │      110000.0 │          40 │
│ kafka      │      110000.0 │          15 │
│ bigquery   │       91250.0 │          17 │
│ nosql      │       60000.0 │          11 │
│ snowflake  │       56250.0 │          19 │
│ airflow    │       30000.0 │          22 │
│ redshift   │       30000.0 │          10 │
│ mongodb    │          NULL │          12 │
└────────────┴───────────────┴─────────────┘
  18 rows                        3 columns
*/
