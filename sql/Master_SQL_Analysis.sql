SELECT
  (SELECT COUNT(DISTINCT school_id)
   FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.dim_school`) AS total_schools,

  (SELECT COUNT(DISTINCT school_id)
   FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_leads`) AS schools_with_leads,

  (SELECT COUNT(DISTINCT school_id)
   FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_applications`) AS schools_with_applications,

  (SELECT COUNT(DISTINCT school_id)
   FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_enrollments`) AS schools_with_enrollments,

  (SELECT COUNT(DISTINCT school_id)
   FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_ppc`) AS schools_with_ppc;

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


SELECT
  COUNT(*) AS total_applications,

  COUNTIF(status = 'Applied') AS applied,
  COUNTIF(status = 'Under Review') AS under_review,
  COUNTIF(status = 'Accepted') AS accepted,
  COUNTIF(status = 'Rejected') AS rejected,

  ROUND(
    SAFE_DIVIDE(
      COUNTIF(status = 'Accepted'),
      COUNT(*)
    ) * 100, 2
  ) AS acceptance_rate

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_applications`;

SELECT
  COUNT(*) AS total_enrollments,
  COUNT(DISTINCT student_id) AS unique_students,
  COUNT(DISTINCT school_id) AS schools,

  SUM(fee_amount) AS total_fee_revenue,

  ROUND(AVG(fee_amount), 2) AS average_fee,

  MIN(enrolled_at) AS earliest_enrollment,
  MAX(enrolled_at) AS latest_enrollment

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_enrollments`;



SELECT
  COUNT(*) AS total_records,
  COUNT(DISTINCT school_id) AS unique_schools,
  COUNT(DISTINCT campaign_id) AS unique_campaigns,

  SUM(leads) AS total_leads,
  SUM(impressions) AS total_impressions,
  SUM(clicks) AS total_clicks,
  ROUND(SUM(spend), 2) AS total_spend,
  SUM(applications) AS total_applications,
  SUM(enrollments) AS total_enrollments,

  ROUND(
    SAFE_DIVIDE(SUM(clicks), SUM(impressions)) * 100, 2
  ) AS ctr,

  ROUND(
    SAFE_DIVIDE(SUM(spend), SUM(clicks)), 2
  ) AS cost_per_click,

  ROUND(
    SAFE_DIVIDE(SUM(spend), SUM(leads)), 2
  ) AS cost_per_lead

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_ppc`;


SELECT
  campaign_id,

  SUM(leads) AS total_leads,
  SUM(impressions) AS total_impressions,
  SUM(clicks) AS total_clicks,
  ROUND(SUM(spend), 2) AS total_spend,
  SUM(applications) AS total_applications,
  SUM(enrollments) AS total_enrollments,

  ROUND(
    SAFE_DIVIDE(SUM(clicks), SUM(impressions)) * 100, 2
  ) AS ctr,

  ROUND(
    SAFE_DIVIDE(SUM(spend), SUM(leads)), 2
  ) AS cost_per_lead,

  ROUND(
    SAFE_DIVIDE(SUM(enrollments), SUM(leads)) * 100, 2
  ) AS lead_to_enrollment_rate

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_ppc`

GROUP BY campaign_id
ORDER BY total_leads DESC;




SELECT
  campaign_id,

  SUM(leads) AS total_leads,
  SUM(applications) AS total_applications,
  SUM(enrollments) AS total_enrollments,
  ROUND(SUM(spend), 2) AS total_spend,

  ROUND(
    SAFE_DIVIDE(SUM(enrollments), SUM(leads)) * 100, 2
  ) AS lead_to_enrollment_rate,

  ROUND(
    SAFE_DIVIDE(SUM(spend), SUM(enrollments)), 2
  ) AS cost_per_enrollment

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_ppc`

GROUP BY campaign_id

HAVING SUM(enrollments) > 0

ORDER BY total_enrollments DESC;



SELECT
  s.school_id,
  s.school_name,
  s.city,
  s.state,
  s.region,

  COALESCE(l.leads, 0) AS total_leads,
  COALESCE(a.applications, 0) AS total_applications,
  COALESCE(e.enrollments, 0) AS total_enrollments,
  COALESCE(e.fee_revenue, 0) AS fee_revenue,

  ROUND(
    SAFE_DIVIDE(
      COALESCE(e.enrollments, 0),
      NULLIF(COALESCE(l.leads, 0), 0)
    ) * 100, 2
  ) AS lead_to_enrollment_rate

FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.dim_school` s

LEFT JOIN (
  SELECT
    school_id,
    COUNT(*) AS leads
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_leads`
  GROUP BY school_id
) l
ON s.school_id = l.school_id

LEFT JOIN (
  SELECT
    school_id,
    COUNT(*) AS applications
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_applications`
  GROUP BY school_id
) a
ON s.school_id = a.school_id

LEFT JOIN (
  SELECT
    school_id,
    COUNT(*) AS enrollments,
    SUM(fee_amount) AS fee_revenue
  FROM `project-53983553-3770-4fa0-a04.allschoolscolleges.fact_enrollments`
  GROUP BY school_id
) e
ON s.school_id = e.school_id

ORDER BY total_enrollments DESC;