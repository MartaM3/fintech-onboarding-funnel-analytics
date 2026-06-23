# Fintech Onboarding Funnel Analytics

A Python + SQL product analytics project that simulates a fintech onboarding journey and identifies where users drop off before becoming active customers.

This project is intentionally built as a **portfolio-ready analytics case study**: it includes synthetic data generation, event-level data, SQL queries, Python analysis, data quality checks, a simple prioritisation model, opportunity sizing, visual outputs, tests, and a Streamlit dashboard.

> **Important:** all data is synthetic. No real customer, company, banking, or Revolut data is used.

---

## Business problem

A fictional fintech app wants to improve new-user activation. Users move through this onboarding funnel:

```text
Signed up -> Email verified -> KYC completed -> Card ordered -> First top-up -> First transaction -> Active in 30 days
```

The core business question is:

> Where do users drop off in the onboarding journey, which segments are underperforming, and what should the product team prioritise to improve activation?

---

## Why this project is relevant

This case study mirrors common product analytics work in fintech:

- measuring signup and onboarding funnel conversion;
- finding drop-off points;
- analysing segments by country, device and acquisition channel;
- comparing weekly cohorts;
- using SQL to make metrics reproducible;
- translating analysis into product recommendations;
- checking data quality before trusting metrics;
- estimating the size of improvement opportunities.

---

## Dataset

The generated dataset contains:

- **15,000 synthetic users**;
- **event-level onboarding data** in `data/events.csv`;
- **user-level funnel data** in `data/users.csv`;
- signup date, country, device, acquisition channel, age group and declared use case;
- KYC guidance variant, onboarding stage flags and timestamps;
- simple 30-day revenue and payback estimates for growth-quality analysis.

Example columns:

```text
user_id, signup_date, country, device, acquisition_channel, declared_use_case,
email_verified, kyc_completed, card_ordered, first_topup, first_transaction,
active_30d, transaction_count_30d, estimated_revenue_30d_eur
```

---

## Key results

- **First transaction conversion:** 26.1% of signed-up users.
- **30-day activation:** 19.3% of signed-up users.
- **Largest absolute bottleneck:** KYC completed, with 3,192 users lost from the previous stage.
- **Best acquisition channel:** Referral with 29.8% 30-day activation.
- **Weakest acquisition channel:** Paid Ads with 10.0% 30-day activation.
- **Simulated KYC guidance lift:** Guided KYC improves KYC completion by 4.1% vs Control; p-value = 2.618e-08.
- **Activation model:** logistic regression using pre-onboarding features reaches AUC 0.666. This is used for prioritisation, not causal claims.
- **Top opportunity:** improving `acquisition_channel = Paid Ads` to its benchmark segment would add an estimated 843 active users in this simulation.

---

## Funnel summary

| label             | users   | step_conversion_rate   | overall_conversion_rate   | users_lost_from_previous_stage   |
|:------------------|:--------|:-----------------------|:--------------------------|:---------------------------------|
| Signed up         | 15,000  | 100.0%                 | 100.0%                    |                                  |
| Email verified    | 13,527  | 90.2%                  | 90.2%                     | 1,473                            |
| KYC completed     | 10,335  | 76.4%                  | 68.9%                     | 3,192                            |
| Card ordered      | 7,350   | 71.1%                  | 49.0%                     | 2,985                            |
| First top-up      | 4,702   | 64.0%                  | 31.3%                     | 2,648                            |
| First transaction | 3,914   | 83.2%                  | 26.1%                     | 788                              |
| Active in 30 days | 2,901   | 74.1%                  | 19.3%                     | 1,013                            |

---

## Visual outputs

### 1. Funnel overview

![Funnel overview](outputs/charts/01_funnel_overview.png)

### 2. Drop-off by stage

![Drop-off by stage](outputs/charts/02_dropoff_by_stage.png)

### 3. Activation by acquisition channel and device

![Activation by channel and device](outputs/charts/03_activation_by_channel_device.png)

### 4. First transaction by country

![First transaction by country](outputs/charts/04_first_transaction_by_country.png)

### 5. Weekly cohort performance

![Weekly cohort performance](outputs/charts/05_weekly_cohort_performance.png)

### 6. Simulated KYC guidance variant

![KYC guidance variant](outputs/charts/06_kyc_guidance_variant.png)

### 7. Activation model signals

![Activation model signals](outputs/charts/07_activation_model_signals.png)

---

## Business recommendations

1. **Prioritise the KYC bottleneck.** It creates the largest absolute user loss. The product team should investigate document instructions, user guidance, trust signals, reminders and recovery flows.
2. **Separate acquisition volume from acquisition quality.** Paid Ads brings volume but weaker activation in this simulation. Growth decisions should include activation and payback, not only signups.
3. **Investigate weaker device experiences.** Web users activate less than iOS users, suggesting possible differences in UX, friction or user intent.
4. **Monitor cohorts weekly.** Cohort tracking helps confirm whether changes improve activation over time.
5. **Use experimentation carefully.** The simulated Guided KYC variant performs better, but a real product team would validate this through controlled experimentation and guardrail metrics.

---

## Repository structure

```text
fintech-onboarding-funnel-analytics/
|
|-- app/
|   |-- streamlit_app.py
|
|-- data/
|   |-- users.csv
|   |-- events.csv
|   |-- onboarding.sqlite
|
|-- notebooks/
|   |-- 01_onboarding_funnel_analysis.ipynb
|
|-- outputs/
|   |-- executive_summary.md
|   |-- funnel_summary.csv
|   |-- segment_performance.csv
|   |-- weekly_cohort_performance.csv
|   |-- kyc_guidance_variant_summary.csv
|   |-- kyc_guidance_ab_test.csv
|   |-- activation_model_summary.csv
|   |-- opportunity_sizing.csv
|   |-- charts/
|
|-- scripts/
|   |-- generate_synthetic_data.py
|   |-- build_database.py
|   |-- run_analysis.py
|   |-- run_sql_reports.py
|
|-- sql/
|   |-- 01_funnel_conversion.sql
|   |-- 02_segment_performance.sql
|   |-- 03_weekly_cohort_analysis.sql
|   |-- 04_kyc_guidance_variant.sql
|   |-- 05_event_level_step_times.sql
|
|-- src/
|   |-- config.py
|   |-- funnel.py
|
|-- tests/
|   |-- test_funnel_metrics.py
|
|-- README.md
|-- GUIA_RAPIDA_ES.md
|-- INTERVIEW_NOTES_ES.md
|-- requirements.txt
|-- Makefile
```

---

## How to run

Install dependencies:

```bash
pip install -r requirements.txt
```

Regenerate synthetic data:

```bash
python scripts/generate_synthetic_data.py
```

Build the local SQLite database:

```bash
python scripts/build_database.py
```

Run the full analysis:

```bash
python scripts/run_analysis.py
```

Run SQL reports:

```bash
python scripts/run_sql_reports.py
```

Run tests:

```bash
python -m pytest tests
```

Open the dashboard:

```bash
streamlit run app/streamlit_app.py
```

---

## SQL examples

The `sql/` folder includes queries for:

- funnel conversion;
- segment performance;
- weekly cohort analysis;
- KYC variant comparison;
- event-level step times.

These queries run against `data/onboarding.sqlite` and write CSV outputs to `outputs/sql/`.

---

## Methodology notes

- The data is synthetic and deliberately designed to contain realistic product patterns.
- The KYC guidance comparison is a simulated experiment, not evidence from a real product.
- The activation model is predictive, not causal.
- Opportunity sizing is a prioritisation tool. It estimates potential upside under simplified benchmark assumptions.
- Revenue and payback columns are simplified estimates to demonstrate growth-quality thinking.

---

## CV description

```text
Fintech Onboarding Funnel Analytics | Python, pandas, SQL, matplotlib, Streamlit
Built an end-to-end product analytics project simulating a fintech onboarding journey from signup to first transaction and 30-day activation. Analysed conversion, drop-off, cohort behaviour, KYC friction, acquisition-quality differences and segment-level performance. Developed reproducible SQL queries, Python visualisations, opportunity sizing and a Streamlit dashboard to translate funnel metrics into product recommendations.
```
