-------- Fraud Flags Summary --------
----------------------------------------------------------------

--- %%sql flags_counts << 
SELECT
    SUM(CASE WHEN HighValueStatus = 'FLAG' THEN 1 ELSE 0 END) AS HighValueFlagCount,
    SUM(CASE WHEN FrequencyStatus = 'FLAG' THEN 1 ELSE 0 END) AS FrequencyFlagCount,
    SUM(CASE WHEN LoginStatus = 'FLAG' THEN 1 ELSE 0 END) AS LoginFlagCount
FROM FraudMetricsWithScores;