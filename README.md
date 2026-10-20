# Streamly Customer Churn & Retention Investigation

## Project Overview

Streamly is a subscription-based business seeking to better understand why customers leave, which customer segments experience higher churn, and what opportunities exist to improve customer retention.

This project investigates customer churn using SQL and Tableau. It examines customer demographics, subscription plans, revenue, payment failures, support interactions, and customer tenure to identify patterns that may help explain customer losses and inform retention decisions.

The project combines data analysis with business interpretation, translating analytical results into insights that can support practical business decisions.

## Business Problem

Although Streamly continues to acquire customers, customer churn presents a challenge to sustainable growth and revenue retention. Without a clear understanding of churn patterns, the business may struggle to identify at-risk customer segments, address recurring customer problems, and prioritise retention initiatives.

The investigation therefore focuses on understanding the scale of churn, examining patterns across customer groups, and identifying areas that warrant further investigation.

## Project Objectives

The main objectives are to:

- Measure Streamly's customer base, active customers, churned customers, and overall churn rate.
- Compare churn rates across subscription plans and countries.
- Investigate relationships between churn, support ticket volume, payment failures, and customer tenure.
- Examine successful subscription revenue across plans and compare revenue with churn rates.
- Identify customer and operational patterns that may be relevant to retention.
- Present findings through interactive Tableau dashboards.
- Develop evidence-based recommendations and identify additional data that could strengthen future analysis.

## Tools and Technologies

| Tool | Purpose |
|---|---|
| SQL (MySQL) | Data querying, aggregation, segmentation, and churn analysis |
| Tableau Public | Data visualisation and interactive dashboards |
| Microsoft Excel | Dataset storage and source data preparation |

## Dataset Overview

The project uses a relational dataset containing five tables:

| Table | Description |
|---|---|
| `customers` | Customer identifiers, signup dates, countries, and age groups |
| `subscriptions` | Subscription plans, billing frequency, subscription dates, and status |
| `usage` | Monthly customer sessions and minutes used |
| `payments` | Payment amounts, dates, and payment status |
| `support_tickets` | Support issue types, ticket dates, resolution status, and resolution time |

The tables are linked through `customer_id`, allowing customer information to be analysed alongside subscription, usage, payment, and support records.

The tables have different levels of detail. Customer-level analysis therefore requires appropriate aggregation to avoid double-counting customers or inflating revenue and ticket counts.

## Investigation Scope

The investigation is organised into eight themes:

1. **Customer Base:** Total customers, active customers, churned customers, overall churn rate, and churn trends.
2. **Customer Segments:** Churn across subscription plans, billing frequencies, countries, age groups, and tenure segments.
3. **Customer Behaviour:** Product usage, session frequency, time spent, and engagement patterns.
4. **Revenue and Payments:** Successful payment revenue, revenue across plans, payment failures, and payment issues before churn.
5. **Customer Support:** Ticket volume, issue types, unresolved tickets, and support resolution patterns.
6. **Retention and Cohort Analysis:** Customer tenure, retention rates, and differences across customer cohorts.
7. **Early Warning Signals:** Behaviours and customer experiences that may be associated with subsequent churn.
8. **Recommendations and Data Gaps:** Potential retention improvements, priority areas, and additional data requirements.

The scope includes both questions that can be investigated with the available dataset and questions that may require additional data or further analysis.

## Key Findings

The SQL analysis completed so far produced the following initial findings:

- **Customer base:** The dataset contains 1,200 customers, comprising 1,006 active customers and 194 churned customers.
- **Overall churn:** The observed churn rate is 16.17%.
- **Subscription plans:** The Basic plan has the highest observed churn rate at 18.89%, followed by Premium at 15.76% and Standard at 12.97%.
- **Geographic differences:** South Africa, Nigeria, and Ghana appeared among the countries with higher churn rates in the initial country-level analysis. These comparisons should be interpreted alongside customer counts and checked against the final dashboard.
- **Successful payment revenue:** The initial SQL query returned 60,207,000 in successful payment revenue, in the dataset's recorded currency units.
- **Revenue by plan:** Standard generated the highest total successful payment revenue among the three subscription plans in the initial analysis.
- **Support interactions:** Customers with six or more support tickets showed a higher observed churn rate than customers in lower-ticket groups.
- **Support issues:** Technical issues were the most frequently recorded support issue type among churned customers, followed by product issues.
- **Payment failures:** The initial analysis identified 19 churned customers with a failed payment within the 90 days preceding their recorded subscription end date.
- **Customer tenure:** The initial tenure analysis reported an average tenure of approximately five months for churned customers.

These findings are descriptive. They identify patterns in the available data but do not, by themselves, establish that a particular factor causes churn. Findings involving payment history, support activity, and revenue should also be interpreted in light of the analysis period and the structure of the source tables.

## Tableau Dashboards

### 1. Executive Churn Overview

Provides a high-level view of Streamly's customer base and churn performance. It includes key customer metrics, churn rate comparisons across subscription plans and countries, and monthly customer churn trends.

The dashboard is designed to help viewers understand the scale of customer losses and identify where churn is more concentrated.

### 2. Customer Behaviour & Risk

Explores churn patterns across support ticket volume, payment failures, customer tenure, and subscription plans. It also examines the distribution of support issues among churned customers, successful revenue by subscription plan, and the relationship between plan revenue and churn rate.

The dashboard helps identify patterns that may warrant further investigation and highlights potential opportunities for improving customer retention.

## Dashboard Preview

### Executive Churn Overview

![Executive Churn Overview](screenshots/executive_churn_overview.png)

### Customer Behaviour & Risk

![Customer Behaviour & Risk](screenshots/customer_behaviour_risk.png)

## Business Recommendations

Based on the initial findings, the following actions are proposed for further investigation:

1. **Investigate Basic plan churn:** Examine why the Basic plan has the highest observed churn rate, including customer expectations, perceived value, product limitations, and pricing.
2. **Review recurring technical and product issues:** Investigate common technical and product-related support problems, prioritising issues that are frequent or difficult to resolve.
3. **Examine repeated support interactions:** Review customers with high ticket volumes to determine whether repeated contacts reflect unresolved issues, recurring faults, or other customer difficulties.
4. **Strengthen early customer engagement:** Investigate churn among customers with shorter tenure and assess whether improved onboarding and early engagement could address common problems.
5. **Monitor payment-related churn risks:** Examine payment failures, recovery attempts, and subsequent subscription outcomes to determine whether payment support or retry processes need improvement.
6. **Balance revenue and retention priorities:** Assess both revenue contribution and churn rate when reviewing subscription plans, rather than prioritising revenue alone.
7. **Establish ongoing monitoring:** Track churn rates, retention, support issues, and payment failures over time to assess whether future retention initiatives are associated with improvements.

These are proposed actions, not proven solutions. Their effectiveness should be evaluated using additional investigation and subsequent performance data.

## Data Limitations and Opportunities for Further Analysis

The current dataset supports several useful descriptive analyses, but some questions require additional care or data.

- **Usage before churn:** Monthly usage history must be aligned to subscription end dates to determine whether declining engagement consistently precedes churn.
- **Retention and cohorts:** Accurate cohort retention analysis requires a clearly defined cohort date, observation period, and treatment of customers who have not yet completed each retention interval.
- **Payment problems before churn:** Payment failures should be linked to customer timelines, with clear definitions of the observation window and subscription end date.
- **Support resolution:** Ticket timing and resolution status should be examined relative to churn dates before drawing conclusions about their relationship with churn.
- **Revenue interpretation:** Successful payment totals represent recorded payment transactions during the available period; they should not automatically be interpreted as recurring revenue, profit, or revenue lost through churn.
- **Causation:** The available descriptive analysis cannot establish that a factor causes churn without further investigation and an appropriate analytical design.
- **Customer risk prediction:** Building a reliable predictive churn model would require appropriately timed historical features, a defined prediction target, and validation on unseen data.

Additional data on customer acquisition channels, product features used, pricing changes, cancellation reasons, marketing campaigns, and customer feedback could improve the investigation.

## Project Deliverables

- SQL queries for customer, subscription, revenue, payment, support, and tenure analysis.
- Two Tableau Public dashboards.
- Documentation of the business questions, analytical findings, and interpretations.
- Proposed business recommendations and identified data gaps.

## Conclusion

This project demonstrates how SQL and Tableau can be combined to investigate customer churn, compare customer segments, examine support and payment patterns, and communicate results through business-focused visualisations.

The initial findings highlight areas for further attention, particularly Basic plan churn, repeated support interactions, technical issues, and early customer tenure. Further analysis and ongoing monitoring would be required to establish the underlying drivers of churn and evaluate the effectiveness of proposed retention initiatives.

The overall goal is to turn customer data into useful evidence that supports better-informed retention decisions.

## Author

**Olabode Goodness Daniel**

Business and Data Analyst, focused on investigating business problems, understanding performance through data, and translating analytical findings into meaningful insights.
