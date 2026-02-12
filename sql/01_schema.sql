USE aml_transaction_monitoring_mysql;

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS high_risk_countries;
DROP TABLE IF EXISTS sanctions_list;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    country VARCHAR(50),
    risk_rating VARCHAR(20),
    is_pep BOOLEAN,
    onboarding_date DATE
);

CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(18,2),
    open_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    transaction_date DATETIME,
    transaction_type VARCHAR(20),
    amount DECIMAL(18,2),
    counterparty_country VARCHAR(50),
    counterparty_name VARCHAR(100),
    is_cash BOOLEAN DEFAULT 0,   -- UPDATED
    is_high_risk BOOLEAN DEFAULT 0,   -- NEW
    is_sanctions_hit BOOLEAN DEFAULT 0,   -- NEW
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE high_risk_countries (
    country VARCHAR(50) PRIMARY KEY
);

CREATE TABLE sanctions_list (
    name VARCHAR(100) PRIMARY KEY
);
