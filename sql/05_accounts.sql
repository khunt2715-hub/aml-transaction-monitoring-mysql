-- Generating a list of 1500 accounts using synthetic data

INSERT INTO accounts (customer_id, account_type, balance, open_date)
SELECT
    FLOOR(1 + RAND() * 1000), -- random customer_id between 1 and 1000
    ELT(FLOOR(1 + RAND() * 3), 'Checking','Savings','Investment'),
    ROUND(RAND() * 50000, 2),
    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*1000) DAY)
FROM numbers
WHERE n <= 1500;

