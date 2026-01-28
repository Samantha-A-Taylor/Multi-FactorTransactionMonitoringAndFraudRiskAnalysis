-------- Transactions with Multi-Factor Risk --------
----------------------------------------------------------------

SELECT *
FROM FraudMetricsWithScores
WHERE MultiFactorScore > 1;