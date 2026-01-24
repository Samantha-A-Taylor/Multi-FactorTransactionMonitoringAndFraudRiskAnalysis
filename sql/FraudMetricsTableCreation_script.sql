-------- MULTI-FACTOR FRAUD METRICS SUMMARY TABLE CREATION --------
----------------------------------------------------------------

-- Drop table if it already exists
DROP TABLE IF EXISTS FraudMetricsWithScores;

-------- Table Creation with Multi-Factor Score --------
CREATE TABLE FraudMetricsWithScores AS
-- High transaction amounts by account
WITH HighValue AS (
    SELECT
        TransactionID,
        AccountID,
        TransactionDate,
        TransactionAmount,
        ROUND(AVG(TransactionAmount) OVER (PARTITION BY AccountID),2) AS AvgTransactionAmount,
        -- Flag transactions >3× the average | Use AVG() OVER(PARTITION BY AccountID)
        CASE
            WHEN TransactionAmount > 3 * AVG(TransactionAmount) OVER (PARTITION BY AccountID) THEN 'FLAG'
            ELSE 'NORMAL'
        END AS HighValueStatus
    FROM bank_transactions_data
),
-- Frequency spikes per account
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
-- Login attempts spikes per account
LoginSpike AS (
    SELECT
        TransactionID,
        AccountID,
        LoginAttempts,
        ROUND(AVG(LoginAttempts) OVER (PARTITION BY AccountID),2) AS AvgLoginAttempts,
        -- Flag transactions >3× average login attempts per account
        CASE
            WHEN LoginAttempts > 3 * AVG(LoginAttempts) OVER (PARTITION BY AccountID) THEN 'FLAG'
            ELSE 'NORMAL'
        END AS LoginStatus
    FROM bank_transactions_data
)
-- Combine all metrics into one result and add multi-factor score
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
    -- Calculate a numeric score based on how many metrics flagged this transaction
    (CASE WHEN h.HighValueStatus = 'FLAG' THEN 1 ELSE 0 END
   + CASE WHEN f.FrequencyStatus = 'FLAG' THEN 1 ELSE 0 END
   + CASE WHEN l.LoginStatus = 'FLAG' THEN 1 ELSE 0 END) AS MultiFactorScore,
    -- Optional categorical label for easier interpretation
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

----------------------------------------------------------------
