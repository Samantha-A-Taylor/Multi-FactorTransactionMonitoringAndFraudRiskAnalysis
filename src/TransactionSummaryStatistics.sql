-------- Transaction Summary Statistics --------
----------------------------------------------------------------

SELECT 
    COUNT(*) as 'Transaction Count',
    COUNT(DISTINCT(AccountID)) as 'Account Count',
    COUNT(DISTINCT("IP Address")) as 'IP Address Count',
    MIN(TransactionAmount) as 'Min Transaction Amount',
    ROUND(AVG(TransactionAmount),2) as 'Avg Transaction Amount',
    ROUND((
        SELECT AVG(TransactionAmount) 
        FROM (
            SELECT TransactionAmount
            FROM bank_transactions_data
            ORDER BY TransactionAmount
            LIMIT 2 - (SELECT COUNT(*) FROM bank_transactions_data) % 2
            OFFSET (SELECT (COUNT(*) - 1) / 2 FROM bank_transactions_data)
        )
    ), 2) AS 'Mdn Transaction Amount',
    MAX(TransactionAmount) as 'Max Transaction Amount'
FROM bank_transactions_data;