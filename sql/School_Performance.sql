SELECT
  s.school_id,
  s.school_name,
  s.city,
  s.state,
  s.region,

  COALESCE(l.total_leads, 0) AS total_leads,
  COALESCE(a.total_applications, 0) AS total_applications,
  COALESCE(e.total_enrollments, 0) AS total_enrollments,
  COALESCE(e.fee_revenue, 0) AS fee_revenue,

  ROUND(
    SAFE_DIVIDE(
      COALESCE(a.total_applications, 0),
      NULLIF(COALESCE(l.total_leads, 0), 0)
    ) * 100,
    2
  ) AS lead_to_application_rate,

  ROUND(
    SAFE_DIVIDE(
      COALESCE(e.total_enrollments, 0),
      NULLIF(COALESCE(a.total_applications, 0), 0)
    ) * 100,
    2
  ) AS application_to_enrollment_rate

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.dim_school` s

LEFT JOIN (
  SELECT
    school_id,
    COUNT(*) AS total_leads
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_leads`
  GROUP BY school_id
) l
ON s.school_id = l.school_id

LEFT JOIN (
  SELECT
    school_id,
    COUNT(*) AS total_applications
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_applications`
  GROUP BY school_id
) a
ON s.school_id = a.school_id

LEFT JOIN (
  SELECT
    school_id,
    COUNT(*) AS total_enrollments,
    SUM(fee_amount) AS fee_revenue
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_enrollments`
  GROUP BY school_id
) e
ON s.school_id = e.school_id

ORDER BY total_enrollments DESC;