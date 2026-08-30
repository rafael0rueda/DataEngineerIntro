-- What are the most optimal skills for data engineers—balancing both demand and salary?

SELECT
   sd.skills,
   MEDIAN(jpf.salary_year_avg) AS median_salary,
   COUNT(jpf.*) AS skill_count,
   ROUND(LN(COUNT(jpf.*)), 1) AS ln_skill_count,
   ROUND((median_salary * LN(COUNT(jpf.*))) / 1_000_000, 2) AS score
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
   --jpf.salary_year_avg IS NOT NULL
   --AND
   jpf.job_country = 'Colombia'
GROUP BY sd.skills
HAVING
   COUNT(jpf.*) >= 10
ORDER BY score DESC
LIMIT 25;

/*

without country
┌────────────┬───────────────┬─────────────┬────────────────┬────────┐
│   skills   │ median_salary │ skill_count │ ln_skill_count │ score  │
│  varchar   │    double     │    int64    │     double     │ double │
├────────────┼───────────────┼─────────────┼────────────────┼────────┤
│ terraform  │      184000.0 │         193 │            5.3 │   0.97 │
│ python     │      135000.0 │        1133 │            7.0 │   0.95 │
│ sql        │      130000.0 │        1128 │            7.0 │   0.91 │
│ aws        │   137320.3125 │         783 │            6.7 │   0.91 │
│ airflow    │      150000.0 │         386 │            6.0 │   0.89 │
│ spark      │      140000.0 │         503 │            6.2 │   0.87 │
│ kafka      │      145000.0 │         292 │            5.7 │   0.82 │
│ snowflake  │      135500.0 │         438 │            6.1 │   0.82 │
│ azure      │      128000.0 │         475 │            6.2 │   0.79 │
│ java       │      135000.0 │         303 │            5.7 │   0.77 │
│ scala      │ 137290.484375 │         247 │            5.5 │   0.76 │
│ kubernetes │      150500.0 │         147 │            5.0 │   0.75 │
│ git        │      140000.0 │         208 │            5.3 │   0.75 │
│ databricks │      132750.0 │         266 │            5.6 │   0.74 │
│ redshift   │      130000.0 │         274 │            5.6 │   0.73 │
│ gcp        │      136000.0 │         196 │            5.3 │   0.72 │
│ nosql      │      134415.0 │         193 │            5.3 │   0.71 │
│ hadoop     │      135000.0 │         198 │            5.3 │   0.71 │
│ pyspark    │      140000.0 │         152 │            5.0 │    0.7 │
│ mongodb    │      135750.0 │         136 │            4.9 │   0.67 │
│ docker     │      135000.0 │         144 │            5.0 │   0.67 │
│ go         │      140000.0 │         113 │            4.7 │   0.66 │
│ r          │      134775.0 │         133 │            4.9 │   0.66 │
│ bigquery   │      135000.0 │         123 │            4.8 │   0.65 │
│ github     │      135000.0 │         127 │            4.8 │   0.65 │
└────────────┴───────────────┴─────────────┴────────────────┴────────┘
  25 rows                                                  5 columns

With country

1. The score compresses the AWS outlier effect.
On raw salary, AWS ($153K) crushed everyone. On the composite score, AWS (0.59) 
is barely behind Python (0.60) and actually ahead of SQL (0.55) — its high pay 
still wins even after penalizing it for lower demand. That tells you AWS's salary 
premium is large enough to survive a demand penalty, which is a stronger signal 
than the salary chart alone.

2. Spark and PySpark separate cleanly, and that's informative.
Spark scores 0.41, PySpark scores 0.38 — close, but Spark (40 postings) edges out 
PySpark (23) mostly on demand, since their salaries are similar ($110K vs $122.5K, 
actually PySpark pays more). This suggests general "Spark" experience/ecosystem 
knowledge is asked for more broadly, while "PySpark" specifically is a subset 
ask — worth knowing if you're deciding which keyword to put on a resume.

3. There's a "cloud data platform" cluster in the middle.
Databricks, pandas, numpy, azure, gcp, kafka all land in a tight 0.30–0.37 band. 
Despite very different salaries (Databricks $136K vs Kafka $110K) and different demand 
levels, the log-dampening makes them roughly equivalent "value" skills. 
That band is a good target list for a second/third skill to pair with Python or AWS.

4. Snowflake and NoSQL underperform relative to their demand.
Both have decent posting counts (19 and 11) but low salaries ($56K, $60K), 
so their scores (0.17, 0.14) sit well below skills with similar demand like 
Databricks or SQL Server. If the counts are trustworthy, 
this hints these are either junior-heavy roles or skills that are 
expected/commoditized rather than compensated for.

5. Airflow is the clearest "false positive" in raw demand.
It has 22 postings (more than PySpark's 23, nearly tied) but the lowest score (0.09) 
in the ranked set. 
Anyone using raw skill_count as a proxy for "valuable skill to learn" would be misled 
here — airflow looks in-demand but isn't well-paid, which the composite score correctly flags.
┌────────────┬───────────────┬─────────────┬────────────────┬────────┐
│   skills   │ median_salary │ skill_count │ ln_skill_count │ score  │
│  varchar   │    double     │    int64    │     double     │ double │
├────────────┼───────────────┼─────────────┼────────────────┼────────┤
│ python     │      122500.0 │         138 │            4.9 │    0.6 │
│ aws        │      153437.5 │          47 │            3.9 │   0.59 │
│ sql        │      110000.0 │         142 │            5.0 │   0.55 │
│ spark      │      110000.0 │          40 │            3.7 │   0.41 │
│ pyspark    │      122500.0 │          23 │            3.1 │   0.38 │
│ databricks │      135937.5 │          15 │            2.7 │   0.37 │
│ pandas     │      122500.0 │          21 │            3.0 │   0.37 │
│ numpy      │      122500.0 │          18 │            2.9 │   0.35 │
│ azure      │      110000.0 │          21 │            3.0 │   0.33 │
│ gcp        │      110937.5 │          19 │            2.9 │   0.33 │
│ kafka      │      110000.0 │          15 │            2.7 │    0.3 │
│ sql server │      116250.0 │          11 │            2.4 │   0.28 │
│ bigquery   │       91250.0 │          17 │            2.8 │   0.26 │
│ snowflake  │       56250.0 │          19 │            2.9 │   0.17 │
│ nosql      │       60000.0 │          11 │            2.4 │   0.14 │
│ airflow    │       30000.0 │          22 │            3.1 │   0.09 │
│ redshift   │       30000.0 │          10 │            2.3 │   0.07 │
│ mongodb    │          NULL │          12 │            2.5 │   NULL │
└────────────┴───────────────┴─────────────┴────────────────┴────────┘
  18 rows                                                  5 columns

*/
