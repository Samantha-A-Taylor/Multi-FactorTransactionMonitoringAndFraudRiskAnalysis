-------- Categorical Transaction Patterns --------
----------------------------------------------------------------

SELECT TransactionType, COUNT(*) AS 'Order Count'
FROM bank_transactions_data
GROUP BY TransactionType
ORDER BY "Order Count" DESC;

SELECT Location, COUNT(*) AS 'Order Count'
FROM bank_transactions_data
GROUP BY Location
ORDER BY "Order Count" DESC
LIMIT 15;

SELECT Channel, COUNT(*) AS 'Order Count'
FROM bank_transactions_data
GROUP BY Channel
ORDER BY "Order Count" DESC;