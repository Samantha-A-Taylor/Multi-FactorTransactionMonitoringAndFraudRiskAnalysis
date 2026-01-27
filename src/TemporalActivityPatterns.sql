-------- Temporal Activity Patterns --------
----------------------------------------------------------------

SELECT STRFTIME('%Y-%m', TransactionDate) AS YearMonth, 
       COUNT(*) AS 'Order Count'
FROM bank_transactions_data
GROUP BY YearMonth
ORDER BY YearMonth;