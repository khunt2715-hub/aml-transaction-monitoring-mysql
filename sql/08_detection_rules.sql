-- 04_detection_rules.sql
-- AML Detection Rules & Suspicion Scoring
-- Portfolio-ready script for MySQL

-- Optional: drop existing view if rerunning
DROP VIEW IF EXISTS suspicious_transactions;

-- Step 1: Create the suspicious_transactions view
CREATE OR REPLACE VIEW suspicious_transactions AS
SELECT
    t.*,
    c.is_pep,
    tc.daily_txn_count,

    -- Rule 1: High-Value Transaction (>10,000)
    CASE WHEN ABS(t.amount) > 10000 THEN 1 ELSE 0 END AS high_value_flag,

    -- Rule 2: Rapid Transaction Velocity (>10 txns/day)
    CASE WHEN tc.daily_txn_count > 10 THEN 1 ELSE 0 END AS rapid_velocity_flag,

    -- Rule 3: High-Risk Counterparty Country
    CASE WHEN t.counterparty_country IN ('UAE','China','Brazil') THEN 1 ELSE 0 END AS high_risk_country_flag,

    -- Rule 4: PEP Interaction
    CASE WHEN c.is_pep = 1 AND (ABS(t.amount) > 5000 OR t.is_cash = 1) THEN 1 ELSE 0 END AS pep_interaction_flag,

    -- Rule 5: High-Risk Transaction Flag
    CASE WHEN t.is_high_risk = 1 THEN 1 ELSE 0 END AS high_risk_flag,

    -- Rule 6: Sanctions Hit
    CASE WHEN t.is_sanctions_hit = 1 THEN 2 ELSE 0 END AS sanctions_hit_score,

    -- Total Suspicion Score
    (CASE WHEN ABS(t.amount) > 10000 THEN 1 ELSE 0 END
     + CASE WHEN tc.daily_txn_count > 10 THEN 1 ELSE 0 END
     + CASE WHEN t.counterparty_country IN ('UAE','China','Brazil') THEN 1 ELSE 0 END
     + CASE WHEN c.is_pep = 1 AND (ABS(t.amount) > 5000 OR t.is_cash = 1) THEN 1 ELSE 0 END
     + CASE WHEN t.is_high_risk = 1 THEN 1 ELSE 0 END
     + CASE WHEN t.is_sanctions_hit = 1 THEN 2 ELSE 0 END) AS total_suspicion_score

FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
JOIN (
    -- Subquery to calculate daily transaction counts per account
    SELECT account_id, transaction_date, COUNT(*) AS daily_txn_count
    FROM transactions
    GROUP BY account_id, transaction_date
) tc
ON t.account_id = tc.account_id AND t.transaction_date = tc.transaction_date;

-- Step 2: Optional summary to verify results
SELECT 
    COUNT(*) AS total_transactions,
    SUM(high_value_flag) AS total_high_value,
    SUM(rapid_velocity_flag) AS total_rapid_velocity,
    SUM(high_risk_country_flag) AS total_high_risk_country,
    SUM(pep_interaction_flag) AS total_pep_interactions,
    SUM(high_risk_flag) AS total_high_risk,
    SUM(sanctions_hit_score) AS total_sanctions_score,
    SUM(total_suspicion_score) AS total_suspicion_score
FROM suspicious_transactions;
