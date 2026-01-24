-------- TRANSACTION MONITORING AND MULTI-FACTOR FRAUD ANALYSIS --------
----------------------------------------------------------------

-------- Flag Counts Summary -------- 
-- Count the number of transactions flagged by each metric
SELECT
    SUM(CASE WHEN HighValueStatus = 'FLAG' THEN 1 ELSE 0 END) AS HighValueFlagCount,
    SUM(CASE WHEN FrequencyStatus = 'FLAG' THEN 1 ELSE 0 END) AS FrequencyFlagCount,
    SUM(CASE WHEN LoginStatus = 'FLAG' THEN 1 ELSE 0 END) AS LoginFlagCount
FROM FraudMetrics;

-------- High-value AND login spike flags -------- 
-- Show transactions flagged by both High-Value and Login Spike metrics
SELECT *
FROM FraudMetrics
WHERE MultiFactorScore > 1;

-------- High-value OR login spike flags --------
-- Show transactions flagged by at least one metric (High-Value or Login Spike)
SELECT *
FROM FraudMetrics
WHERE MultiFactorScore = 1;

----------------------------------------------------------------
