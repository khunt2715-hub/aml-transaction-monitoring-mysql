## **AML Transaction Monitoring \& Risk Scoring Engine (MySQL)**



**Executive Summary**

This project simulates an end-to-end Anti-Money Laundering (AML) transaction monitoring framework built in MySQL using synthetic financial data.

It demonstrates how rule-based detection logic and risk-based customer scoring can be implemented to identify potentially suspicious financial activity in a banking environment.

The design reflects core components commonly delivered by compliance and AML consulting teams, including transaction monitoring, alert generation, and customer risk prioritization.



**Project Scope**



The solution includes:



Relational data model for customers, accounts, and transactions



Synthetic data generation at scale



**Implementation of key AML detection scenarios:**



* Structuring (smurfing)
* High-risk geography exposure
* Rapid movement of funds
* Sanctions screening
* Risk-weighted scoring model to prioritize customer alerts



**Methodology**



Detection rules are applied using time-window analysis, aggregation logic, and threshold-based monitoring.

Alert outputs are consolidated into a weighted risk scoring framework that classifies customers into risk tiers (Low, Medium, High, Critical), reflecting a risk-based compliance approach aligned with modern AML regulatory expectations.



**Technical Stack**



* MySQL 8+
* Structured SQL scripting
* Git/GitHub version control



**Future Enhancements**



* Behavioral deviation analysis
* Fuzzy sanctions matching
* Network risk modeling
* Case management simulation layer
