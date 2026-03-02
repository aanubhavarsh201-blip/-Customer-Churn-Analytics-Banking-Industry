# -Customer-Churn-Analytics-Banking-Industry
> **A comprehensive SQL-based churn analysis identifying key retention drivers and risk factors across 10,000 bank customers.**
---

## 📌 Project Overview

This project was completed as part of the **UpGrad MentorMind Menternship Program**  
📋 **Course Code:** UGC | BA&C | March'25 | ENG-TXCHO4H0-20250331  
👤 **Author:** Anubhav  
🏢 **Organization:** UpGrad

The analysis investigates why customers leave a bank, quantifies the impact of each churn driver, and delivers three prioritized, actionable focus areas to guide retention strategy.

---

## 🎯 Objective

Identify the top factors driving customer churn in the banking industry and build composite scoring metrics (Engagement Score, Risk Score, Financial Value Score) to segment customers by risk and value — enabling targeted, cost-efficient retention interventions.

---

## 📁 Repository Structure

```
📦 customer-churn-analytics-banking
 ┣ 📄 Complete_Churn_Analysis.sql          # Full SQL codebase (EDA + composite scores + window functions)
 ┣ 📊 Customer_Churn_Analytics.pdf         # Presentation: Full EDA, key drivers, composite metrics & recommendations
 ┣ 📊 Study_customer_churn_analytics_...pdf # Presentation: Top 3 focus areas & business impact
 ┗ 📄 README.md                            # This file
```

---

## 🗃️ Dataset

| Attribute | Detail |
|---|---|
| **Records** | 10,000 customers |
| **Source** | Retail banking dataset |
| **Database** | PostgreSQL |

### Features Used

**Demographics:** `Geography`, `Gender`, `Age`  
**Behavioral:** `Tenure`, `NumOfProducts`, `HasCrCard`, `IsActiveMember`  
**Financial:** `Balance`, `EstimatedSalary`, `CreditScore`  
**Target Variable:** `Exited` (True / False)

---

## 📊 Key Findings

### Overall Churn Rate
> **20.37%** — 2,037 out of 10,000 customers churned

### Demographic Drivers

| Segment | Churn Rate |
|---|---|
| 🇩🇪 Germany | **32.44%** |
| 🇫🇷 France | 16.15% |
| 🇪🇸 Spain | 16.67% |
| Female customers | **25.07%** |
| Male customers | 16.46% |
| Age 56–65 | **48.32%** ← highest risk group |
| Age 18–35 | 8.36% |

### Behavioral Drivers

| Segment | Churn Rate |
|---|---|
| Inactive members | **26.85%** |
| Active members | 14.27% |
| 4 products held | **100%** |
| 3 products held | 82.71% |
| 2 products held | **7.58%** ← lowest risk ("sweet spot") |
| 1 product held | 27.71% |

### Financial Drivers

| Segment | Churn Rate |
|---|---|
| Zero balance | 13.82% |
| Balance 1–75k | 23.82% |
| Balance 75k–150k | 24.29% |
| Balance 150k+ | 23.12% |
| Credit score (all bands) | ~19–23% (weak signal) |
| Salary percentiles | ~19–21% (weak signal) |

---

## 🧮 Composite Scoring Metrics

Three composite scores were engineered to synthesize weak individual signals into powerful churn predictors.

### 1. Engagement Score (ES)
Measures how actively a customer interacts with the bank.

| Component | Condition | Points |
|---|---|---|
| `IsActiveMember` | Active | 2 |
| `IsActiveMember` | Inactive | 0 |
| `NumOfProducts` | 2 products | 2 |
| `NumOfProducts` | 3–4 products | 1 |
| `NumOfProducts` | 1 product | 0 |
| `HasCrCard` | Yes | 1 |
| `HasCrCard` | No | 0 |

**Buckets:** 0–1 = Low | 2–3 = Medium | 4–5 = High

| ES Bucket | Customers | Churn Rate |
|---|---|---|
| Low | 2,571 | **37.73%** |
| Medium | 4,886 | 17.48% |
| High | 2,543 | **8.38%** |

---

### 2. Risk Score (RS)
Combines the strongest individual churn predictors.

| Component | Condition | Points |
|---|---|---|
| `Geography` | Germany | 2 |
| `Geography` | France / Spain | 0 |
| `Age` | 56–65 | 2 |
| `Age` | 36–55 | 1 |
| `Age` | 18–35 or 65+ | 0–1 |
| `IsActiveMember` | Inactive | 2 |
| `IsActiveMember` | Active | 0 |
| `NumOfProducts` | 3–4 products | 2 |
| `NumOfProducts` | 1 product | 1 |
| `NumOfProducts` | 2 products | 0 |

**Buckets:** 0–2 = Low | 3–4 = Medium | 5+ = High

| RS Bucket | Customers | Churn Rate |
|---|---|---|
| Low Risk | 4,741 | 7.76% |
| Medium Risk | 3,952 | 24.16% |
| High Risk | 1,307 | **54.63%** |

---

### 3. Financial Value Score (FVS)
Captures the economic value of each customer.

| Component | Condition | Points |
|---|---|---|
| `Balance` | 0 | 0 |
| `Balance` | 1–75k | 1 |
| `Balance` | 75k–150k | 2 |
| `Balance` | 150k+ | 3 |
| `EstimatedSalary` | 20th percentile | 1 |
| `EstimatedSalary` | 40th percentile | 2 |
| `EstimatedSalary` | 60th percentile | 3 |
| `EstimatedSalary` | 80th percentile | 4 |
| `EstimatedSalary` | Top 20% | 5 |
| `NumOfProducts` | 1 product | 1 |
| `NumOfProducts` | 2 products | 2 |
| `NumOfProducts` | 3–4 products | 3 |

**Buckets:** 0–4 = Low Value | 5–7 = Medium Value | 8+ = High Value

> 💡 Intersecting **High FVS + High RS** identifies the most critical customers for premium retention action.

---

## 🎯 Top 3 Focus Areas

### Area 1 — 🇩🇪 Germany-Focused Retention Initiative
- 814 customers churned from Germany alone vs. 810 + 413 from France and Spain combined
- Top 5 at-risk German customers had an average balance of ₹207,389, representing ₹1M+ in revenue exposure
- **Action:** Deploy localized campaigns with German-language support and priority relationship manager outreach

### Area 2 — 💤 Inactive Account Reactivation Program
- 12.6% churn differential between inactive and active customers = ~1,262 preventable exits
- All top-5 high-balance German target customers were inactive
- **Action:** Trigger automated re-engagement campaigns when `IsActiveMember` transitions to False

### Area 3 — 📦 Two-Product Bundle Strategy
- 2-product customers churn at only 7.58% vs. 27.71% (1 product) and 82–100% (3–4 products)
- 4 of 5 top German target customers already held 2-product relationships
- **Action:** Execute structured cross-sell campaigns moving single-product customers to the 2-product sweet spot

---

## 🛠️ SQL Techniques Used

- `CREATE TABLE` & schema design for retail banking data
- `GROUP BY` aggregations with `COUNT`, `ROUND`, `AVG`, `MIN`, `MAX`, `STDDEV_SAMP`
- `PERCENTILE_CONT` for median and percentile calculations
- `FILTER (WHERE ...)` for conditional aggregation
- `CASE WHEN` for bucketing age, tenure, balance, salary, and credit score
- `NULLIF` for safe division
- `UNION ALL` for combined segment comparisons
- **Window Functions:** `ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)` for customer ranking
- Subqueries and CTEs for multi-step analysis
- Composite score engineering via weighted `CASE WHEN` logic

---

## 📈 Business Impact Summary

| Initiative | Estimated Impact |
|---|---|
| Germany retention campaigns | Protect ₹1M+ in high-balance accounts |
| Inactive account reactivation | Prevent ~1,262 customer exits |
| 2-product cross-sell strategy | Reduce single-product churn by ~20 percentage points |

---

## 🤝 Acknowledgements

This project was completed under the **UpGrad MentorMind Menternship** program as part of the Business Analytics & Consulting track.  
Special thanks to UpGrad mentors and the MentorMind community for their guidance and feedback throughout the project.

---

*Prepared by **Anubhav** | UpGrad MentorMind Menternship | March 2025*
