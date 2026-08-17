SELECT
  DATE_TRUNC(lead_date, MONTH) AS month,
  COUNT(*) AS total_leads,
  COUNTIF(status = 'Qualified') AS qualified_leads,
  COUNTIF(status = 'Converted') AS converted_leads

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_leads`

GROUP BY month
ORDER BY month;