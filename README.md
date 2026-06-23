# Fintech Onboarding Funnel Analytics

A Python + SQL product analytics project that simulates a fintech onboarding journey and identifies where users drop off before becoming active customers.

This project is intentionally built as a **portfolio-ready analytics case study**: it includes synthetic data generation, event-level data, SQL queries, Python analysis, data quality checks, a simple prioritisation model, opportunity sizing, visual outputs, tests, and a Streamlit dashboard.

> **Important:** all data is synthetic. No real customer, company or banking data is used.

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



### 2. Drop-off by stage



### 3. Activation by acquisition channel and device



### 4. First transaction by country

![First transaction by country](outputs/charts/04_first_transaction_by_country.png)

### 5. Weekly cohort performance



### 6. Simulated KYC guidance variant



### 7. Activation model signals



---

## Business recommendations

1. **Prioritise the KYC bottleneck.** It creates the largest absolute user loss. The product team should investigate document instructions, user guidance, trust signals, reminders and recovery flows.
2. **Separate acquisition volume from acquisition quality.** Paid Ads brings volume but weaker activation in this simulation. Growth decisions should include activation and payback, not only signups.
3. **Investigate weaker device experiences.** Web users activate less than iOS users, suggesting possible differences in UX, friction or user intent.
4. **Monitor cohorts weekly.** Cohort tracking helps confirm whether changes improve activation over time.
5. **Use experimentation carefully.** The simulated Guided KYC variant performs better, but a real product team would validate this through controlled experimentation and guardrail metrics.

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



