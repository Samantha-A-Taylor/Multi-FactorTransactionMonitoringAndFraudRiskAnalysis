-------- Data Integrity Check --------
----------------------------------------------------------------

SELECT *
FROM bank_transactions_data
WHERE TransactionID IS NULL
   OR AccountID IS NULL
   OR TransactionAmount IS NULL
   OR TransactionDate IS NULL
   OR TransactionType IS NULL
   OR Location IS NULL
   OR DeviceID IS NULL
   OR "IP Address" IS NULL
   OR MerchantID IS NULL
   OR Channel IS NULL
   OR CustomerAge IS NULL
   OR CustomerOccupation IS NULL
   OR TransactionDuration IS NULL
   OR LoginAttempts IS NULL
   OR AccountBalance IS NULL
   OR PreviousTransactionDate IS NULL
;