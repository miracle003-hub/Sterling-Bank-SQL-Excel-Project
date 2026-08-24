USE sterling_bank;
GO

-- ============================
-- View 1: Transaction amount by channel (Chart 1)
-- ============================
CREATE VIEW vw_channel_totals AS
SELECT channel, SUM(amount) AS total_amount
FROM Transactions
GROUP BY channel;
GO

-- ============================
-- View 1b: Deposit amount by channel only (Chart 1b)
-- ============================
CREATE VIEW vw_deposit_channel_totals AS
SELECT channel, SUM(amount) AS total_amount
FROM Transactions
WHERE transaction_type = 'Deposit'
GROUP BY channel;
GO

-- ============================
-- View 2: Loan amount by type (Chart 2)
-- ============================
CREATE VIEW vw_loans_by_type AS
SELECT loan_type,
       MIN(amount) AS min_amount,
       MAX(amount) AS max_amount,
       AVG(amount) AS avg_amount,
       SUM(amount) AS total_amount
FROM Loans
GROUP BY loan_type;
GO

-- ============================
-- View 3: Deposit vs Withdrawal vs Transfer totals (Chart 3)
-- ============================
CREATE VIEW vw_transaction_type_totals AS
SELECT transaction_type, SUM(amount) AS total_amount
FROM Transactions
GROUP BY transaction_type;
GO

-- ============================
-- View 4: Active accounts per branch (Chart 4)
-- Only counts accounts that have at least one transaction
-- ============================
CREATE VIEW vw_accounts_per_branch AS
SELECT b.branch_name, COUNT(DISTINCT a.account_id) AS account_count
FROM Branches b
JOIN Accounts a ON b.branch_id = a.branch_id
JOIN Transactions t ON a.account_id = t.account_id
GROUP BY b.branch_name;
GO

-- ============================
-- View 5: Monthly transaction trend (Chart 5)
-- ============================
CREATE VIEW vw_monthly_transaction_trend AS
SELECT YEAR(transaction_date) AS trans_year,
       MONTH(transaction_date) AS trans_month,
       SUM(amount) AS total_amount
FROM Transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date);
GO

-- ============================
-- View 6: Account balance tiers (Chart 6)
-- ============================
CREATE VIEW vw_balance_tiers AS
SELECT
    CASE
        WHEN balance > 500000 THEN 'High Balance'
        WHEN balance BETWEEN 100000 AND 500000 THEN 'Medium Balance'
        ELSE 'Low Balance'
    END AS balance_tier,
    COUNT(*) AS account_count
FROM Accounts
GROUP BY
    CASE
        WHEN balance > 500000 THEN 'High Balance'
        WHEN balance BETWEEN 100000 AND 500000 THEN 'Medium Balance'
        ELSE 'Low Balance'
    END;
GO

-- ============================
-- View 7: Loan status breakdown (Chart 8)
-- ============================
CREATE VIEW vw_loan_status_breakdown AS
SELECT status, COUNT(*) AS loan_count, SUM(amount) AS total_amount
FROM Loans
GROUP BY status;
GO

-- ============================
-- Quick test: run these to confirm each view works
-- ============================
-- SELECT * FROM vw_channel_totals;
-- SELECT * FROM vw_deposit_channel_totals;
-- SELECT * FROM vw_loans_by_type;
-- SELECT * FROM vw_transaction_type_totals;
-- SELECT * FROM vw_accounts_per_branch;
-- SELECT * FROM vw_monthly_transaction_trend;
-- SELECT * FROM vw_balance_tiers;
-- SELECT * FROM vw_loan_status_breakdown;