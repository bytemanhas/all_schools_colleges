SELECT
  campaign_id,
  SUM(leads) AS total_leads,
  SUM(impressions) AS total_impressions,
  SUM(clicks) AS total_clicks,
  ROUND(SUM(spend), 2) AS total_spend,
  SUM(applications) AS total_applications,
  SUM(enrollments) AS total_enrollments,

  ROUND(
    SAFE_DIVIDE(SUM(clicks), SUM(impressions)) * 100,
    2
  ) AS ctr,

  ROUND(
    SAFE_DIVIDE(SUM(leads), SUM(clicks)) * 100,
    2
  ) AS lead_conversion_rate,

  ROUND(
    SAFE_DIVIDE(SUM(spend), SUM(leads)),
    2
  ) AS cost_per_lead

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_ppc`

GROUP BY campaign_id
ORDER BY total_leads DESC;