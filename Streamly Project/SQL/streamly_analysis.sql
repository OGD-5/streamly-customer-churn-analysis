 /*CREATE DATABASE streamly;
USE streamly;
SHOW TABLES;
SELECT * FROM customers LIMIT 10;

-- ==========================================
-- Hypothesis 1
-- Business Question: How many customers does Streamly have?
-- ==========================================
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM customers;


-- ==========================================
-- Hypothesis 2
-- Business Question: How many customers are currently active?
-- ==========================================
SELECT
    COUNT(*) AS active_customers
FROM subscriptions
WHERE status = 'Active';
-- Streamly currently has 1006 customers active


-- ==========================================
-- Hypothesis 3
-- Business Question: How many customers have churned?
-- ==========================================
SELECT
    COUNT(*) AS churned_customers
FROM subscriptions
WHERE status = 'Churned';
-- 194 Streamly's customer base has already churned.


-- ==========================================
-- Hypothesis 4
-- Business Question: What is the overall churn rate?
-- ==========================================
SELECT
    COUNT(CASE WHEN status = 'Churned' THEN 1 END) AS churned_customers,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(CASE WHEN status = 'Churned' THEN 1 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM subscriptions;
-- Churn represents a 16.17 perecentage of Streamly's total customer base. 



-- ==========================================
-- Hypothesis 5
-- Business Question: Which subscription plans have the highest churn?
-- ==========================================
SELECT
    plan,
    COUNT(*) AS total_customers,
    SUM(status = 'Churned') AS churned_customers,
    ROUND(
        SUM(status = 'Churned') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM subscriptions
GROUP BY plan
ORDER BY churn_rate DESC;
-- Basic plan has the highest churned customers with 106 and a rate of 18.89, then premium and standard plan with 29 and 59 churned customers with a churn rate of 15.76 and 12.97 respectively  


-- ==========================================
-- Hypothesis 6
-- Business Question: Which countries have the highest churn?
-- ==========================================
SELECT
    c.country,
    COUNT(*) AS customers,
    SUM(s.status = 'Churned') AS churned_customers,
    ROUND(
        SUM(s.status = 'Churned') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers c
JOIN subscriptions s
    ON c.customer_id = s.customer_id
GROUP BY c.country
ORDER BY churn_rate DESC;
-- south africa has teh highest churn followed by Nigeria and Ghana 


-- ==========================================
-- Hypothesis 7
-- Business Question: How much subscription revenue has Streamly generated?
-- ========================================== 
SELECT
    SUM(amount) AS total_successful_revenue
FROM payments
WHERE payment_status = 'Successful';
-- Streamly has generated a sucessful revenue of '60207000'


-- ==========================================
-- Hypothesis 8
-- Business Question: Which plans generate the most revenue?
-- ========================================== 
SELECT
    s.plan,
    SUM(p.amount) AS total_revenue,
    COUNT(DISTINCT p.customer_id) AS paying_customers
FROM payments p
JOIN subscriptions s
    ON p.customer_id = s.customer_id
WHERE p.payment_status = 'Successful'
GROUP BY s.plan
ORDER BY total_revenue DESC;
-- Standard has more total revenue, followed by premium and Basic 


-- ==========================================
-- Hypothesis 9
-- Business Question: Which plans have both high revenue and high churn?
-- ========================================== 
WITH plan_metrics AS (
    SELECT
        s.plan,

        COUNT(DISTINCT s.customer_id) AS customers,

        SUM(s.status = 'Churned') AS churned_customers,

        ROUND(
            SUM(s.status = 'Churned') * 100.0 / COUNT(*),
            2
        ) AS churn_rate,

        COALESCE(
            SUM(
                CASE
                    WHEN p.payment_status = 'Successful'
                    THEN p.amount
                END
            ),
            0
        ) AS revenue

    FROM subscriptions s

    LEFT JOIN payments p
        ON s.customer_id = p.customer_id

    GROUP BY s.plan
)

SELECT *
FROM plan_metrics
ORDER BY revenue DESC;
-- Standard leads the row with total customers of  '455' and  revenue of '26940000' 





-- ==========================================
-- Hypothesis 10
-- Business Question: How many customers experienced payment problems before churning?
-- ========================================== 
SELECT
    COUNT(DISTINCT s.customer_id) AS churners_with_recent_payment_failure
FROM subscriptions s
JOIN payments p
    ON s.customer_id = p.customer_id
WHERE
    s.status = 'Churned'
    AND p.payment_status = 'Failed'
    AND p.payment_date BETWEEN
        DATE_SUB(s.end_date, INTERVAL 90 DAY)
        AND s.end_date;
-- we have 19 churners with recent payment failure 


-- ==========================================
-- Hypothesis 11
-- Business Question: Do customers with more support tickets churn more?
-- ========================================== 
WITH ticket_counts AS (
    SELECT
        customer_id,
        COUNT(*) AS ticket_count
    FROM support_tickets
    GROUP BY customer_id
)

SELECT
    CASE
        WHEN COALESCE(ticket_count, 0) = 0 THEN '0 tickets'
        WHEN ticket_count <= 2 THEN '1-2 tickets'
        WHEN ticket_count <= 5 THEN '3-5 tickets'
        ELSE '6+ tickets'
    END AS ticket_group,

    COUNT(*) AS customers,

    SUM(s.status = 'Churned') AS churned_customers,

    ROUND(
        SUM(s.status = 'Churned') * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM subscriptions s
LEFT JOIN ticket_counts t
    ON s.customer_id = t.customer_id

GROUP BY ticket_group
ORDER BY churn_rate DESC;
-- customers with 6+ tickets churn more


-- ==========================================
-- Hypothesis 12
-- Business Question: Which support issue types are most common among churned customers?
-- ========================================== 
SELECT
    st.issue_type,

    COUNT(*) AS total_tickets,

    COUNT(
        CASE
            WHEN s.status = 'Churned'
            THEN 1
        END
    ) AS churned_customer_tickets,

    ROUND(
        COUNT(
            CASE
                WHEN s.status = 'Churned'
                THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churned_ticket_percentage

FROM support_tickets st

JOIN subscriptions s
    ON st.customer_id = s.customer_id

GROUP BY st.issue_type

ORDER BY churned_customer_tickets DESC;
-- Technical issue types are most common among churned customers then product issue type



-- ==========================================
-- Hypothesis 13
-- Business Question: How long do customers typically stay?
-- ========================================== 
WITH tenure AS (
    SELECT
        customer_id,
        status,

        TIMESTAMPDIFF(
            MONTH,
            start_date,
            COALESCE(end_date, '2026-07-01')
        ) AS tenure_months

    FROM subscriptions
)

SELECT
    status,
    COUNT(*) AS customers,
    ROUND(AVG(tenure_months), 2) AS average_tenure_months,
    MIN(tenure_months) AS minimum_tenure_months,
    MAX(tenure_months) AS maximum_tenure_months
FROM tenure
GROUP BY status;
-- The average Tenure months of the Churned customers is 5 */


