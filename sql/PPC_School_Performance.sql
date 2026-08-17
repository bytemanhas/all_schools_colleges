SELECT
  s.school_id,
  s.school_name,
  s.city,
  s.state,
  s.region,

  COALESCE(p.total_spend, 0) AS total_spend,
  COALESCE(p.total_leads, 0) AS ppc_leads,
  COALESCE(p.total_applications, 0) AS ppc_applications,
  COALESCE(p.total_enrollments, 0) AS ppc_enrollments,

  ROUND(
    SAFE_DIVIDE(
      p.total_spend,
      NULLIF(p.total_leads, 0)
    ), 2
  ) AS cost_per_lead,

  ROUND(
    SAFE_DIVIDE(
      p.total_spend,
      NULLIF(p.total_enrollments, 0)
    ), 2
  ) AS cost_per_enrollment,

  ROUND(
    SAFE_DIVIDE(
      p.total_enrollments,
      NULLIF(p.total_leads, 0)
    ) * 100, 2
  ) AS ppc_conversion_rate

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.dim_school` s

LEFT JOIN (
  SELECT
    school_id,
    SUM(spend) AS total_spend,
    SUM(leads) AS total_leads,
    SUM(applications) AS total_applications,
    SUM(enrollments) AS total_enrollments
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_ppc`
  GROUP BY school_id
) p
ON s.school_id = p.school_id

ORDER BY total_spend DESC;