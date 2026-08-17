SELECT
  COUNT(*) AS total_leads,

  COUNTIF(status = 'New') AS new_leads,
  COUNTIF(status = 'Contacted') AS contacted_leads,
  COUNTIF(status = 'Qualified') AS qualified_leads,
  COUNTIF(status = 'Converted') AS converted_leads,
  COUNTIF(status = 'Lost') AS lost_leads,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(status = 'Qualified'),
      COUNT(*)
    ) * 100, 2
  ) AS qualification_rate,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(status = 'Converted'),
      COUNT(*)
    ) * 100, 2
  ) AS lead_conversion_rate

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_leads`;