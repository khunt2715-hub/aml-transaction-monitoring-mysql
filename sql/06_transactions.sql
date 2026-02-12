-- ==================================================
-- AML Synthetic Transactions Script
-- Deletes old transactions safely and populates new ones
-- ==================================================

-- 1️⃣ Temporarily disable safe updates and foreign key checks
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;

-- 2️⃣ Delete existing transactions
DELETE FROM transactions;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ==================================================
-- 3️⃣ Populate 50,000 synthetic transactions
-- ==================================================
INSERT INTO transactions (
    account_id,
    transaction_date,
    amount,
    transaction_type,
    counterparty_name,
    counterparty_country,
    is_cash,
    is_high_risk,
    is_sanctions_hit
)
SELECT
    FLOOR(1 + RAND() * 1500), -- random account_id (1-1500)
    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*365) DAY), -- past year
    ROUND((RAND() - 0.5) * 2000, 2), -- +/- 1,000 amounts
    ELT(FLOOR(1 + RAND() * 4), 'Deposit','Withdrawal','Transfer','Payment'),
    CONCAT('Counterparty_', FLOOR(1 + RAND() * 1000)), -- synthetic counterparty
    ELT(FLOOR(1 + RAND() * 8), 'USA','UK','Germany','UAE','India','China','Brazil','Canada'), -- country
    RAND() < 0.2, -- 20% cash transactions
    RAND() < 0.05, -- 5% high-risk flag
    RAND() < 0.01  -- 1% sanctions-hit flag
FROM numbers
WHERE n <= 50000;

-- ==================================================
-- 4️⃣ Summary Counts
-- ==================================================
SELECT 
    COUNT(*) AS total_transactions,
    SUM(is_high_risk) AS high_risk_count,
    SUM(is_sanctions_hit) AS sanctions_hit_count
FROM transactions;

-- 5️⃣ Re-enable safe updates
SET SQL_SAFE_UPDATES = 1;
