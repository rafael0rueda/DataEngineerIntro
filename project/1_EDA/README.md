# Exploratory Data Analysis w/ SQL: Job Market Analysis

![Image](../../images/1_1_Project1_EDA.png "Project 1")

```sql
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
```
