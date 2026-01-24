# Multi-Factor Transaction Monitoring and Fraud Risk Analysis
***

[![Multi-Factor Transaction Monitoring and Fraud Risk Analysis Dashboard)](visualizations/Multi-Factor%Transaction%Monitoring%and%Fraud%Risk%Analysis%Dashboard.png)](https://public.tableau.com/app/profile/samanthaataylor/viz/Multi-FactorTransactionMonitoringandFraudRiskAnalysis/Dashboard)

## Project Overview ☰

This project analyzes financial transaction data to identify potential fraud risk using a multi-factor, behavior-based approach. Through exploratory data analysis (EDA), anomaly detection, and engineered fraud metrics, the project evaluates transaction value, frequency patterns, and login behavior to surface high-risk activity and support proactive transaction monitoring.

## Key Takeaways 🔎

      ✓ Explored transaction behavior across accounts, locations, and channels  
      ✓ Identified anomalous transaction values relative to account-level baselines  
      ✓ Detected transaction frequency spikes indicative of abnormal activity  
      ✓ Flagged suspicious login attempt patterns tied to elevated fraud risk  
      ✓ Developed a multi-factor fraud risk score and categorical risk labels  
      ✓ Visualized fraud risk patterns across transaction behavior and geography  

## Key Features 🔑

* **Data Exploration & Preparation:**

      ✓ Reviewed table schema and data structure for analytical readiness  
      ✓ Assessed transaction amount distributions and skewness  
      ✓ Analyzed categorical patterns by transaction type, channel, and location  
      ✓ Evaluated temporal trends in transaction activity  
      ✓ Examined account-level transaction frequency and spending behavior  

* **Fraud Metric Engineering:**

      ✓ Flagged high-value transactions exceeding 3× account-level averages  
      ✓ Identified daily transaction frequency spikes per account  
      ✓ Detected abnormal login attempt behavior relative to account norms  
      ✓ Combined multiple risk signals into a unified fraud metrics table  
      ✓ Generated numeric multi-factor scores and LOW / MEDIUM / HIGH risk labels  

* **Transaction Monitoring & Analysis:**

      ✓ Quantified the volume of transactions flagged by each fraud signal  
      ✓ Isolated high-risk transactions triggered by multiple anomaly factors  
      ✓ Compared single-factor vs multi-factor flagged activity  
      ✓ Enabled downstream visualization and monitoring workflows  

## Visualizations 📶

      ✓ Transaction amount distribution histograms (flagged vs normal behavior)  
      ✓ City-level fraud risk map showing geographic risk concentration  
      ✓ Login attempt distributions by transaction count and risk level  
      ✓ Multi-factor fraud risk comparisons across behavioral dimensions  

## Technologies Used 🛠️

      ✓ SQL (CTEs, window functions, aggregation logic)  
      ✓ Tableau (interactive dashboards and maps)  
      ✓ SQLite  

## Data 📂

* **Source:** Simulated financial transaction dataset  
* **Format:** Relational table queried and transformed using SQL  

## License

MIT License  

Copyright (c) 2026 Samantha-A-Taylor
***
