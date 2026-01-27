-------- FraudMetricsWithScores Table Creation --------
----------------------------------------------------------------

DROP TABLE IF EXISTS FraudMetricsWithScores;

CREATE TABLE FraudMetricsWithScores AS
WITH HighValue AS (
    SELECT
        TransactionID,
        AccountID,
        TransactionDate,
        TransactionAmount,
        ROUND(AVG(TransactionAmount) OVER (PARTITION BY AccountID),2) AS AvgTransactionAmount,
        CASE
            WHEN TransactionAmount > 3 * AVG(TransactionAmount) OVER (PARTITION BY AccountID) THEN 'FLAG'
            ELSE 'NORMAL'
        END AS HighValueStatus
    FROM bank_transactions_data
),
FrequencySpike AS (
    SELECT
        AccountID,
        DATE(TransactionDate) AS TransactionDate,
        COUNT(TransactionID) AS TransactionsPerDay,
        ROUND(AVG(COUNT(TransactionID)) OVER (PARTITION BY AccountID),2) AS AvgDailyTransactions,
        -- Flag days with >2× average daily transactions
        CASE
            WHEN COUNT(TransactionID) > 2 * AVG(COUNT(TransactionID)) OVER (PARTITION BY AccountID) THEN 'FLAG'
            ELSE 'NORMAL'
        END AS FrequencyStatus
    FROM bank_transactions_data
    GROUP BY AccountID, DATE(TransactionDate)
),
LoginSpike AS (
    SELECT
        TransactionID,
        AccountID,
        LoginAttempts,
        ROUND(AVG(LoginAttempts) OVER (PARTITION BY AccountID),2) AS AvgLoginAttempts,
        CASE
            WHEN LoginAttempts > 3 * AVG(LoginAttempts) OVER (PARTITION BY AccountID) THEN 'FLAG'
            ELSE 'NORMAL'
        END AS LoginStatus
    FROM bank_transactions_data
)
SELECT
    h.TransactionID,
    h.AccountID,
    h.TransactionAmount,
    h.AvgTransactionAmount,
    h.HighValueStatus,
    f.TransactionDate,
    f.TransactionsPerDay,
    f.AvgDailyTransactions,
    f.FrequencyStatus,
    l.LoginAttempts,
    l.AvgLoginAttempts,
    l.LoginStatus,
    (CASE WHEN h.HighValueStatus = 'FLAG' THEN 1 ELSE 0 END
   + CASE WHEN f.FrequencyStatus = 'FLAG' THEN 1 ELSE 0 END
   + CASE WHEN l.LoginStatus = 'FLAG' THEN 1 ELSE 0 END) AS MultiFactorScore,
    CASE 
        WHEN (CASE WHEN h.HighValueStatus = 'FLAG' THEN 1 ELSE 0 END
           + CASE WHEN f.FrequencyStatus = 'FLAG' THEN 1 ELSE 0 END
           + CASE WHEN l.LoginStatus = 'FLAG' THEN 1 ELSE 0 END) = 0 THEN 'LOW'
        WHEN (CASE WHEN h.HighValueStatus = 'FLAG' THEN 1 ELSE 0 END
           + CASE WHEN f.FrequencyStatus = 'FLAG' THEN 1 ELSE 0 END
           + CASE WHEN l.LoginStatus = 'FLAG' THEN 1 ELSE 0 END) = 1 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS MultiFactorLabel
FROM HighValue h
LEFT JOIN FrequencySpike f 
   ON h.AccountID = f.AccountID 
   AND DATE(h.TransactionDate) = f.TransactionDate
JOIN LoginSpike l
    ON h.TransactionID = l.TransactionID;