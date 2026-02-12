-- Injecting Suspicious Behaviour into the Transaction table 
-- The purpose is to ensure that the Structuring rule will trigger as intended

INSERT INTO transactions (
    account_id,
    transaction_date,
    transaction_type,
    amount,
    counterparty_country,
    counterparty_name,
    is_cash
)
SELECT
    account_id,
    NOW(),
    'credit',
    9500,
    'USA',
    'Structuring_Source',
    TRUE
FROM accounts
WHERE customer_id IN (10,20,30,40,50)
LIMIT 20;
