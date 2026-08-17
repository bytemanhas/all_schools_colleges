# all_schools_colleges
End-to-end school admissions analytics platform using BigQuery, SQL, Power BI, and Python to analyze leads, admissions, marketing performance, school performance, and growth opportunities.

# AllSchoolsColleges — Admissions & Growth Analytics Platform

> End-to-end Business & Data Analytics project using BigQuery, SQL, Python and Power BI to drive admissions, marketing and school growth decisions.

---

## 📌 Project Overview

AllSchoolsColleges is an end-to-end analytics solution designed to provide a centralized view of the organization's admissions, leads, marketing performance, school performance and growth opportunities.

The project combines data engineering, SQL analytics, business intelligence and decision-support analysis into a single reporting ecosystem.

The final solution enables stakeholders to understand:

- Where leads are coming from
- How leads progress through the admissions funnel
- Which marketing campaigns perform best
- Which schools and regions generate the most enrollments
- How marketing spending translates into enrollments and revenue
- Where lead quality can be improved
- Which schools and regions should receive greater business focus

---

## 🎯 Business Objectives

The primary objectives of the project were to:

1. Analyze the complete lead-to-enrollment funnel
2. Measure marketing and campaign performance
3. Identify high-performing schools and regions
4. Monitor admissions and enrollment trends
5. Measure marketing efficiency
6. Evaluate lead quality across acquisition sources
7. Calculate potential commission revenue
8. Identify schools and regions with potential growth opportunities
9. Provide management with actionable insights through an interactive Power BI dashboard

---

# 🏗️ Solution Architecture

```text
                 DATA SOURCES
                     │
                     ▼
              Python / CSV Data
                     │
                     ▼
                BIGQUERY
                     │
        ┌────────────┴────────────┐
        │                         │
        ▼                         ▼
   Data Storage             SQL Analytics
        │                         │
        └────────────┬────────────┘
                     ▼
                 POWER BI
                     │
        ┌────────────┼────────────┐
        ▼            ▼            ▼
   KPI Reporting  Analysis   Decision Support
                     │
                     ▼
              Growth Strategy




| Technology          | Purpose                                                |
| ------------------- | ------------------------------------------------------ |
| **Python**          | Data preparation and analysis                          |
| **Google BigQuery** | Cloud data warehouse and SQL analytics                 |
| **SQL**             | Data transformation, aggregation and business analysis |
| **Power BI**        | Interactive dashboards and visualization               |
| **DAX**             | Business metrics and analytical calculations           |
| **Git & GitHub**    | Version control and project documentation              |




🗄️ Data Model

The analytical model follows a fact-and-dimension structure.

Fact Tables
fact_leads
fact_ppc
fact_applications
fact_enrollments
fact_returns
fact_inventory
fact_support
Dimension Tables
dim_date
dim_school
dim_student
dim_product
dim_store
dim_supplier

The exact tables used by individual dashboard pages depend on the analytical requirement.

🔎 SQL & BigQuery Analytics

BigQuery was used as the central analytical environment for querying and aggregating the project data.

The SQL analysis covers areas including:

Overall funnel performance
Campaign performance
Lead source performance
Monthly lead trends
Monthly PPC trends
PPC school performance
Revenue by region
School performance
School coverage
Example analytical questions
-- Example: Lead quality by source


SELECT
    lead_source,
    COUNT(*) AS total_leads,
    COUNTIF(status = 'Qualified') AS qualified_leads,
    SAFE_DIVIDE(
        COUNTIF(status = 'Qualified'),
        COUNT(*)
    ) AS lead_quality_rate
FROM `project.dataset.fact_leads`
GROUP BY lead_source;

SQL scripts used in the project are available in:

bigquery/
└── analytics/
📊 Power BI Dashboard

The Power BI solution consists of five analytical pages.

01 — Executive Overview

Provides a high-level view of overall business performance.

Key areas:

Total leads
Applications
Enrollments
Revenue
Key performance indicators
Year-over-year performance
Overall trends
Business Question

What is happening across the business?

02 — Admissions Performance

Focuses on the admissions funnel and enrollment performance.

Key analysis includes:

Applications
Enrollments
Enrollment rates
Free enrollment rate
Withdrawal rate
Admissions trends
Funnel performance
Business Question

How effectively are leads progressing through the admissions process?

03 — Marketing Performance

Analyzes marketing activity and campaign effectiveness.

Key analysis includes:

Marketing spend
Lead generation
Lead source performance
Campaign performance
Regional marketing spend
Marketing funnel
Conversion rates
Lead quality
Business Question

Which marketing activities are generating the strongest results?

04 — School Performance

Provides school- and geography-level analysis.

Key analysis includes:

Enrollment by state
Enrollment by region
Top schools by enrollment
School performance
Revenue vs enrollment
Geographic performance
Business Question

Which schools and regions are performing best?

05 — Growth & Targeting Strategy

The decision-support layer of the dashboard.

This page connects operational performance with the organization's commission-based business model.

Key analysis includes:

Commission revenue
Commission per enrollment
Marketing spend
Marketing spend / commission
Lead quality rate
Commission ROI
School targeting opportunity
Regional commission opportunity
Lead quality by source
Priority schools by region
Commission Model

The analysis assumes a 10% commission on student fees.

Commission Revenue = Total Student Fees × 10%

This allows marketing and admissions performance to be evaluated in terms of the business's actual revenue opportunity.

Business Question

Where should the organization focus its next sales and marketing efforts?

💰 Business Metrics

Several business metrics were developed using DAX.

Commission Revenue
Commission Revenue =
[Total Revenue] * 0.10
Commission per Enrollment
Commission per Enrollment =
DIVIDE(
    [Commission Revenue],
    [Total Enrollments]
)
Lead Quality Rate
Lead Quality Rate =
DIVIDE(
    [Qualified Leads],
    [Total Leads]
)
Commission ROI
Commission ROI =
DIVIDE(
    [Commission Revenue] - [Total Marketing Spend],
    [Total Marketing Spend]
)

These metrics allow the dashboard to move beyond descriptive reporting toward business decision support.

📈 Key Analytical Areas

The project focuses on five major analytical layers:

1. Acquisition

Where are leads coming from?

Organic vs PPC → Campaign → Leads

2. Funnel

How efficiently do leads progress?

Leads → Qualified → Applications → Enrollments

3. Marketing Efficiency

How efficiently is marketing spend generating outcomes?

Spend → Leads → Enrollments → Commission

4. Geographic & School Performance

Which locations and schools are contributing most to performance?

State → Region → School → Enrollment → Revenue

5. Growth Strategy

Where should additional effort be focused?

Lead Quality + Enrollment + Commission Opportunity → Targeting

🎯 Decision Support

The final dashboard is designed to help stakeholders answer questions such as:

Which acquisition source generates better-quality leads?
Which campaigns generate the most enrollments?
Which regions generate the highest commission?
Which schools have strong enrollment performance?
Where is marketing spend most effective?
Which schools should receive greater sales attention?
Which regions should be prioritized for future growth?
How can lead quality be improved?

📸 Dashboard Preview
Executive Overview

<img width="1159" height="738" alt="image" src="https://github.com/user-attachments/assets/6faec99b-c7cf-47c3-8827-59462a6b5429" />

Admissions Performance

<img width="1156" height="733" alt="image" src="https://github.com/user-attachments/assets/20a4b4f3-2069-4b27-97da-6c5e24c4656d" />

Marketing Performance

<img width="1161" height="730" alt="image" src="https://github.com/user-attachments/assets/ff3220fb-ea5f-4b29-9270-6c7e10d8bd53" />

School Performance

<img width="1164" height="720" alt="image" src="https://github.com/user-attachments/assets/ae78ee79-d6ec-4b8f-97e7-e4721d2ff137" />

Growth & Targeting Strategy
<img width="1163" height="684" alt="image" src="https://github.com/user-attachments/assets/28aedee4-16a6-43d5-aa2a-c6c34edd90d3" />


🚀 Key Outcome

The project transforms raw admissions and marketing data into an integrated business intelligence solution.

Instead of simply reporting historical numbers, the dashboard connects:

Marketing
     ↓
Leads
     ↓
Lead Quality
     ↓
Applications
     ↓
Enrollments
     ↓
Student Fees
     ↓
10% Commission
     ↓
Growth & Targeting Decisions

This enables stakeholders to move from:

"What happened?"

to:

"Why did it happen?"

and ultimately:

"What should we do next?"

👤 Author

Yashwant Manhas

Business Analyst | Data Analytics | Business Intelligence

Skills demonstrated
SQL
Google BigQuery
Power BI
DAX
Python
Data Modeling
Data Visualization
Business Analysis
Marketing Analytics
Admissions Analytics
Growth Analytics
⭐ Project Focus

Turning business data into actionable decisions.






