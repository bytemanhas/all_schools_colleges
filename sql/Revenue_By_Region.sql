SELECT
  s.region,

  COUNT(DISTINCT s.school_id) AS schools,
  COUNT(DISTINCT e.enrollment_id) AS total_enrollments,

  ROUND(SUM(e.fee_amount), 2) AS total_revenue,

  ROUND(
    SAFE_DIVIDE(
      SUM(e.fee_amount),
      COUNT(DISTINCT e.enrollment_id)
    ), 2
  ) AS average_fee_per_enrollment

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.dim_school` s

LEFT JOIN `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_enrollments` e
  ON s.school_id = e.school_id

GROUP BY s.region

ORDER BY total_revenue DESC;