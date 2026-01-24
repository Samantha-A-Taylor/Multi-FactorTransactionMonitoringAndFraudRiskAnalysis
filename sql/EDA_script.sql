-------- EXPLORATORY DATA ANALYSIS (EDA) --------
----------------------------------------------------------------

-------- Data Structure & Schema --------
PRAGMA table_info(bank_transactions_data);

-------- Scale & Summary --------
-- Mean vs median: If mean > median, right-skewed (AKA outliers)
SELECT 
	COUNT(*) as 'Transaction Count',
	COUNT(DISTINCT(AccountID)) as 'Account Count',
	COUNT(DISTINCT("IP Address")) as 'IP Address Count',
	MIN(TransactionAmount) as 'Min Transaction Amount',
	ROUND(AVG(TransactionAmount),2) as 'Avg Transaction Amount',
	MEDIAN(TransactionAmount) AS 'Mdn Transaction Amount',
	MAX(TransactionAmount) as 'Max Transaction Amount'
FROM bank_transactions_data;

-------- Transaction Amount Distribution (Shape) --------
-- Buckets refined around median range to capture dense transaction behavior
SELECT
  CASE
    WHEN TransactionAmount < 50 THEN '< $50'
    WHEN TransactionAmount < 100 THEN '$50–99'
    WHEN TransactionAmount < 200 THEN '$100–199'
    WHEN TransactionAmount < 300 THEN '$200–299'
    WHEN TransactionAmount < 500 THEN '$300–499'
    WHEN TransactionAmount < 1000 THEN '$500–999'
    ELSE '$1000+'
  END AS "Transaction Amount",
  COUNT(*) AS Transactions
FROM bank_transactions_data
GROUP BY "Transaction Amount"
ORDER BY
  CASE
    WHEN "Transaction Amount" = '< $50' THEN 1
    WHEN "Transaction Amount" = '$50–99' THEN 2
    WHEN "Transaction Amount" = '$100–199' THEN 3
    WHEN "Transaction Amount" = '$200–299' THEN 4
    WHEN "Transaction Amount" = '$300–499' THEN 5
    WHEN "Transaction Amount" = '$500–999' THEN 6
    ELSE 7
  END;

-------- Categorical Transaction Patterns --------
SELECT TransactionType, COUNT(*) AS 'Order Count'
FROM bank_transactions_data
GROUP BY TransactionType
ORDER BY "Order Count" DESC;

SELECT Location, COUNT(*) AS 'Order Count'
FROM bank_transactions_data
GROUP BY Location
ORDER BY "Order Count" DESC;

SELECT Channel, COUNT(*) AS 'Order Count'
FROM bank_transactions_data
GROUP BY Channel
ORDER BY "Order Count" DESC;

-------- Temporal Activity Patterns --------
SELECT STRFTIME('%Y-%m', TransactionDate) AS YearMonth, 
       COUNT(*) AS 'Order Count'
FROM bank_transactions_data
GROUP BY YearMonth
ORDER BY YearMonth;

-------- Account-Level Behavior --------
-- Accounts grouped by transaction frequency to identify behavioral concentration
SELECT
  AccountID,
  COUNT(*) AS Transaction_Count
FROM bank_transactions_data
GROUP BY AccountID;

SELECT
  CASE
    WHEN Transaction_Count < 2 THEN '1'
    WHEN Transaction_Count < 5 THEN '2–4'
    WHEN Transaction_Count < 10 THEN '5–9'
    WHEN Transaction_Count < 15 THEN '10–14'
    ELSE '15+'
  END AS "Transaction Count Range",
  COUNT(*) AS "Accounts"
FROM (
  SELECT AccountID, COUNT(*) AS Transaction_Count
  FROM bank_transactions_data
  GROUP BY AccountID
)
GROUP BY "Transaction Count Range"
ORDER BY 
  CASE
    WHEN "Transaction Count Range" = '1' THEN 1
    WHEN "Transaction Count Range" = '2–4' THEN 2
    WHEN "Transaction Count Range" = '5–9' THEN 3
    WHEN "Transaction Count Range" = '10–14' THEN 4
    ELSE 5
  END;

-------- High-Activity Accounts -------- 
-- Accounts ranked by total spending and activity to highlight the most active users
SELECT 
	AccountID, 
	CustomerAge,
	CustomerOccupation,
	SUM(TransactionAmount) AS 'Total Spent',
	ROUND(AVG(TransactionAmount),2) AS 'Avg Transaction',
	COUNT(TransactionID) AS 'Total Transactions',
	SUM(LoginAttempts) AS 'Total Login Attempts',
	ROUND(AVG(TransactionDuration),1) AS 'Avg Duration'
FROM bank_transactions_data
GROUP BY AccountID
ORDER BY "Total Spent" DESC;

----------------------------------------------------------------
