SELECT
  l.total_leads,
  a.total_applications,
  e.total_enrollments,

  ROUND(
    SAFE_DIVIDE(a.total_applications, l.total_leads) * 100,
    2
  ) AS lead_to_application_rate,

  ROUND(
    SAFE_DIVIDE(e.total_enrollments, a.total_applications) * 100,
    2
  ) AS application_to_enrollment_rate,

  ROUND(
    SAFE_DIVIDE(e.total_enrollments, l.total_leads) * 100,
    2
  ) AS lead_to_enrollment_rate

FROM (
  SELECT COUNT(*) AS total_leads
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_leads`
) l

CROSS JOIN (
  SELECT COUNT(*) AS total_applications
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_applications`
) a

CROSS JOIN (
  SELECT COUNT(*) AS total_enrollments
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_enrollments`
) e;