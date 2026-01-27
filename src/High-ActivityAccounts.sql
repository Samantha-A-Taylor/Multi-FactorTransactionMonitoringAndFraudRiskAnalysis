-------- High-Activity Accounts --------
----------------------------------------------------------------

SELECT 
    AccountID, 
    CustomerAge,
    CustomerOccupation,
    ROUND(SUM(TransactionAmount),2) AS 'Total Spent',
    ROUND(AVG(TransactionAmount),2) AS 'Avg Transaction',
    COUNT(TransactionID) AS 'Total Transactions',
    SUM(LoginAttempts) AS 'Total Login Attempts',
    ROUND(AVG(TransactionDuration),1) AS 'Avg Duration'
FROM bank_transactions_data
GROUP BY AccountID
ORDER BY "Total Spent" DESC;