-- Identifies the 10 most in-demands skills fo remote data engineer positions

SELECT 
   sd.skills,
   COUNT(sd.skills) AS skill_count
FROM 
   job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd 
   ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
   ON sjd.skill_id = sd.skill_id
WHERE
   jpf.job_title_short = 'Data Engineer'
   AND
   jpf.job_work_from_home = TRUE
   AND
   jpf.job_country = 'Colombia'
GROUP BY sd.skills
ORDER BY skill_count  DESC
LIMIT 10;

/*
Without the country
┌────────────┬─────────────┐
│   skills   │ skill_count │
│  varchar   │    int64    │
├────────────┼─────────────┤
│ sql        │       29221 │
│ python     │       28776 │
│ aws        │       17823 │
│ azure      │       14143 │
│ spark      │       12799 │
│ airflow    │        9996 │
│ snowflake  │        8639 │
│ databricks │        8183 │
│ java       │        7267 │
│ gcp        │        6446 │
└────────────┴─────────────┘
  10 rows        2 columns

With the country
┌───────────┬─────────────┐
│  skills   │ skill_count │
│  varchar  │    int64    │
├───────────┼─────────────┤
│ sql       │         142 │
│ python    │         138 │
│ aws       │          47 │
│ spark     │          40 │
│ pyspark   │          23 │
│ airflow   │          22 │
│ azure     │          21 │
│ pandas    │          21 │
│ gcp       │          19 │
│ snowflake │          19 │
└───────────┴─────────────┘
  10 rows       2 columns

*/
