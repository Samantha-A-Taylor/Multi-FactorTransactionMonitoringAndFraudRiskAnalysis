-------- Transaction Amount Distribution --------
----------------------------------------------------------------

--- %%sql shape_result <<
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