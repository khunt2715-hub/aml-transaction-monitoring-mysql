-- Top 50 Suspicious Transactions

SELECT *
FROM suspicious_transactions
ORDER BY total_suspicion_score DESC
LIMIT 50;
