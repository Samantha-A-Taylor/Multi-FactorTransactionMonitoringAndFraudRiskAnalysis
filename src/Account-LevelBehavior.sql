-------- Account-Level Behavior --------
----------------------------------------------------------------

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