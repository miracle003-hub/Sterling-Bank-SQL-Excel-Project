--1.	List all customers from "Port Harcourt".
		select  *
		from Customers
	where city = 'Port Harcourt'

--2.	Show all accounts with a balance above 300,000.
			select  *
		from Accounts
	where balance > 300000

--3.	List the top 5 accounts by balance, highest first.
		select top 5 *
		from Accounts
	order by balance desc

--4.	Show the 5 most recent transactions.
		select top 5 *
		from Transactions
	order by amount desc

--5.	Find total deposits amount per channel (ATM, Online, Branch, Mobile).
		select  
			sum(amount) as total_amount,
			channel
		from Transactions
		where transaction_type = 'Deposit'
	group by channel

	SELECT channel, SUM(amount) AS total_amount
FROM Transactions
GROUP BY channel


	
--6.	Count how many accounts each branch holds.
		select 
			b.branch_name,
			count(distinct t.account_id) as total_accounts
		from Branches b
		join Accounts a on b.branch_id = a.branch_id
		JOIN Transactions t on a.account_id = t.account_id
		group by b.branch_name

--7.	Show branches with more than 5 accounts (HAVING).
		select
			b.branch_name,
			count(a.account_id)as total_acc
		from Accounts a
		inner join Branches b on b.branch_id = a.branch_id
		group by b.branch_name
		having  count(b.branch_name) > 5

--8.	List each account with its customer's full name and branch name (3-table join).
		select
			a.*,
			c.first_name,
			c.last_name,
			b.branch_name
		from Accounts a
		inner join Customers c on c.customer_id = a.customer_id
		inner join Branches b on b.branch_id = a.branch_id

--9.	Show all transactions with the customer name and account type attached.
		select
			a.account_type,
			c.first_name,
			c.last_name,
			t.*
		from Accounts a
		inner join Customers c on c.customer_id = a.customer_id
		inner join Transactions t on a.account_id = t.account_id

		insert into Customers(
    first_name,
    last_name ,
    date_of_birth ,
    gender ,
    phone,
    city,
    registration_date 
)
values ('faith' ,'obi','1999-12-12','male','08021110019', 'Benin City', '2024-05-15')

--10.	Find all customers who have never opened an account (LEFT JOIN + IS NULL
		select
			c.*
		from Customers c
		left join Accounts a on c.customer_id =a. customer_id
		where a.account_id is  null
		
		delete from Customers
		where customer_id =24
		

--11.	Find transactions between '2026-03-01' and '2026-03-31'.
		select 
			transaction_type, 
			amount, 
			transaction_date, 
			channel
		from Transactions
		where transaction_date between  '2026-03-01' 
		and '2026-03-31'

--12.	Find customers whose last name contains "eze" (LIKE).
		select
			c.*
		from Customers c
		where last_name like '%i'

--Find transactions where type IN ('Withdrawal', 'Transfer') AND amount > 50000.
		select 
			transaction_type,
			amount,
			transaction_date, 
			channel
		from Transactions
		where transaction_type in ('Withdrawal', 'Transfer')
		and amount  > 50000

--14.	Insert a new customer of your choice.
		INSERT INTO Customers (first_name, last_name, date_of_birth, gender, phone, city, registration_date) 
		VALUES    ('amanda', 'Nnamdi', '2001-04-12', 'Female', '08045110001', 'Aba', '2024-05-05')

--15.	Insert a new account for that customer.
		INSERT INTO Accounts (customer_id, branch_id, account_type, balance, opened_date)
		VALUES (25, 5, 'Savings', 350000.00, '2024-01-06')

--16.	Update one loan's status from 'Active' to 'Paid Off'.
		update Loans
		set status= 'Paid Off'	
		where  customer_id = 20

--17.	Delete one transaction of your choice.
		delete  from Transactions
		where transaction_id = 82

--18.	Find the MIN, MAX, and AVG loan amount, grouped by loan_type.

			SELECT loan_type,
				   MIN(amount) AS min_amount,
				   MAX(amount) AS max_amount,
				   AVG(amount) AS avg_amount,
				   SUM(amount) AS total_amount
			FROM Loans
			GROUP BY loan_type

--19.	Find the total (SUM) transaction amount per account, sorted highest to lowest.
			select
				  account_id,
				sum(amount) as total_amount
			from Transactions
			group by account_id
			order by total_amount desc

--20.	Count how many distinct customers have made at least one transaction.
			select
				count(distinct a.customer_id) as total_distinct_customer
				from Transactions t
				inner join Accounts a on t.account_id= a.account_id

				SELECT b.branch_name, COUNT(a.account_id) AS account_count
FROM Branches b
LEFT JOIN Accounts a ON b.branch_id = a.branch_id
GROUP BY b.branch_name

---21.	Add a column that labels each account as 'High Balance' (>500,000), 'Medium Balance' (100,000–500,000), or 'Low Balance' (<100,000) using CASE.
			select
				account_type, 
				balance, 
				opened_date,
			case
				when balance  > 500000 then 'High Balance'
				when balance between 100000 and 500000 then 'Medium Balance'
				when balance < 100000 then 'Low Balance'
			end as balance_category
			from Accounts

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


--22.	Add a column that labels each transaction as 'Large' (>100,000) or 'Normal' using CASE.
				select
					 transaction_type,
					 amount, 
					 transaction_date, 
					 channel,
				case
					when amount > 80000 then 'Large'
					when amount <= 100000 then 'Normal'
				end as category
				from Transactions

--23.	Using CASE inside SUM, count total deposit amount vs total withdrawal amount side by side in one query.
		select
			sum(case when transaction_type= 'Deposit' then amount else 0 end) as total_deposit,
			sum(case when transaction_type = 'Withdrawal' then amount else 0 end) as total_withdrawal
		from Transactions

--24.	Use CONCAT to combine first_name and last_name into one full_name column for Customers.
			select CONCAT(first_name,'', last_name) as full_name
			from Customers

--25.	Use UPPER() to display all branch names in uppercase.
			select UPPER(branch_name) 
			from Branches

--26.	Use DATEDIFF to calculate how many days ago each loan was issued (from today).
			select
				Loan_id,
				issue_date,
			DATEDIFF(day, issue_date, getdate())as days_since_issued
			from Loans

--27.	Use YEAR() to group and count how many customers registered in each year.
			select
				year(registration_date) as registration_year,
				count(*) as total_customers
				from Customers
				group by year(registration_date)
				order by registration_year

--28.	Combine a list of customer cities from Customers with a list of branch cities from Branches using UNION (removes duplicates).
				select
					city
				from Customers
			union
		select
			city
		from Branches

--29.	Do the same combination using UNION ALL and compare the row count 
			select
					city
				from Customers
			union all
		select
			city
		from Branches

--30.	Find customers who have an account but do NOT have a loan (Accounts customer_ids EXCEPT Loans customer_ids).
			select
				a.customer_id
			from Accounts a
			except
			select
				L.customer_id
			from Loans l

--31. Find customers who have an account but do NOT have a loan (Accounts customer_ids EXCEPT Loans customer_ids).add their names
			select
			c.first_name,
			c.last_name,
				c.customer_id
			from Customers c
			where customer_id in(select customer_id from Accounts
			except
			select
				customer_id
			from Loans )

--32.	Find customers who have BOTH an account AND a loan (Accounts customer_ids INTERSECT Loans customer_ids).
			select
				a.customer_id
			from Accounts a
			intersect
			select
				L.customer_id
			from Loans l


			SELECT YEAR(transaction_date) AS trans_year,
       MONTH(transaction_date) AS trans_month,
       SUM(amount) AS total_amount
FROM Transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date);