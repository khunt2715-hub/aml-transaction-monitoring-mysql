**AML Transaction Monitoring - Detection Rules and Scoring**



**Overview:**

This project uses synthetic banking transaction data to demonstrate AML detection rules, including high-value transactions, velocity checks, high-risk counterparty interactions, PEP interactions, and sanctions hits. Each transaction is scored based on the number and severity of rules it triggers.



**Detection Rules and Scoring:**



**Rule:** High-Value Transaction

**Description:** Transactions exceeding $10,000

**Scoring:** 1 point



**Rule:** Rapid Transaction Velocity

**Description:** More than 10 transactions per account per day

**Scoring:** 1 point



**Rule:** High-Risk Counterparty Country

**Description:** Transactions with counterparties in UAE, China, or Brazil

**Scoring:** 1 point



**Rule**: PEP Interaction

**Description:** Transactions from politically exposed persons (PEPs) greater than $5,000 or cash transactions

**Scoring:** 1 point



**Rule:** High-Risk Flag

**Description:** Transactions marked as high-risk in the synthetic data

**Scoring:** 1 point



**Rule:** Sanctions Hit

**Description:** Transactions that match a sanctions list

**Scoring:** 2 points



**Scoring Methodology:**

Each transaction receives points for every rule it triggers. Transactions with multiple flags accumulate points, creating a total suspicion score. Higher scores indicate a higher likelihood of suspicious activity.



**Usage:**

Analysts can filter or rank transactions by total suspicion score for review. Scoring enables a prioritization workflow, similar to a real AML monitoring environment. The scoring system is implemented in SQL in the file 08\_detection\_rules.sql.



