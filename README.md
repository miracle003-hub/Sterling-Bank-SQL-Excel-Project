# Sterling Bank — SQL + Excel Project

A fictional bank transactions database built to practice 13 SQL skills and produce an Excel dashboard.

## Tech Stack
- **Database:** SQL Server (SSMS)
- **Reporting:** Microsoft Excel (charts, dashboard)

## Files
| File | Description |
|---|---|
| `bank_01_schema_ssms.sql` | Creates the `sterling_bank` database and 5 tables: Branches, Customers, Accounts, Transactions, Loans |
| `bank_02_seed_data_ssms.sql` | Populates the tables — 5 branches, 20 customers, 30 accounts, ~60 transactions, 12 loans |
| `bank_03_tasks.md` | 31 SQL tasks covering all 13 skills |

## Database Structure
- **Branches** — branch_id, branch_name, city, manager_name
- **Customers** — customer_id, name, date_of_birth, gender, phone, city, registration_date
- **Accounts** — account_id, customer_id (FK), branch_id (FK), account_type, balance, opened_date
- **Transactions** — transaction_id, account_id (FK), transaction_type, amount, transaction_date, channel
- **Loans** — loan_id, customer_id (FK), loan_type, amount, status, issue_date

## How to Run (SSMS)
1. Open SSMS, connect to your local server.
2. Run `bank_01_schema_ssms.sql` (F5) to create the database and tables.
3. Run `bank_02_seed_data_ssms.sql` (F5) to load the dataset.
4. Work through `bank_03_tasks.md` in a new query window against `sterling_bank`.

## Skills Practiced (13)
**Core (review):** SELECT/WHERE, sorting/limiting, aggregates + GROUP BY/HAVING, JOINs, filtering logic, INSERT/UPDATE/DELETE
**New:** deeper aggregate functions (MIN/MAX/AVG/SUM/COUNT DISTINCT), CASE statements, SQL functions (CONCAT, UPPER, DATEDIFF, YEAR), UNION, UNION ALL, EXCEPT, INTERSECT

## Excel Dashboard
Query results are visualized in Excel across 6 charts: transaction amount by channel, loan amount by type, deposit vs withdrawal vs transfer, accounts per branch, monthly transaction trend, and account balance tiers. Built using Power Query, a PivotTable, XLOOKUP, and Conditional Formatting.

## Excel Automation (Live SQL Connection)
This project supports two ways of getting data into Excel:

**Manual (CSV):** Export each query's results from SSMS as a CSV, then import into Power Query. If the SQL data changes later, the CSV doesn't update on its own — it has to be re-exported and re-imported each time.

**Automated (direct connection):** Power Query connects straight to the `sterling_bank` SQL Server database instead of a CSV file (Data > Get Data > From Database > From SQL Server Database). With this setup, updating the source data is a single step:

1. Data changes in SQL Server (new transactions, updated loan status, etc.)
2. In Excel, click **Data > Refresh All**
3. Power Query re-runs its connection to SQL Server and pulls the current data
4. Because the PivotTable and all 6 charts are built on top of that Power Query table, they refresh automatically in the same step — no manual copy-paste, no re-exporting CSVs

This isn't fully hands-off (Refresh still has to be clicked), but it removes the CSV export/import cycle entirely and keeps the dashboard in sync with the database with one click.

## Author
Meera — Data with Meera
