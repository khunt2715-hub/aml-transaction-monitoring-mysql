-- Generating a synthetic list of 1000 Customers

INSERT INTO customers (full_name, country, risk_rating, is_pep, onboarding_date)
SELECT
    CONCAT('Customer_', rn),
    ELT(FLOOR(1 + RAND() * 8), 'USA','UK','Germany','UAE','India','China','Brazil','Canada'),
    ELT(FLOOR(1 + RAND() * 3), 'Low','Medium','High'),
    RAND() < 0.05,
    DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*1000) DAY)
FROM (
    SELECT n, ROW_NUMBER() OVER (ORDER BY n) AS rn
    FROM numbers
) AS t
WHERE rn <= 1000;

