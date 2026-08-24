CREATE DATABASE sterling_bank;
GO

USE sterling_bank;
GO

-- Table: Branches
-- ============================
CREATE TABLE Branches (
    branch_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    manager_name VARCHAR(50)
    )
    Go

-- Table: Customers
-- ============================
CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10),
    phone VARCHAR(20),
    city VARCHAR(50),
    registration_date DATE
);
GO


-- Table: Accounts
-- ============================
CREATE TABLE Accounts (
    account_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_type VARCHAR(20) NOT NULL, -- Savings, Current
    balance DECIMAL(12,2) NOT NULL,
    opened_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);
GO


-- Table: Transactions
-- ============================
CREATE TABLE Transactions (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL, -- Deposit, Withdrawal, Transfer
    amount DECIMAL(12,2) NOT NULL,
    transaction_date DATE NOT NULL,
    channel VARCHAR(20), -- ATM, Online, Branch, Mobile
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
GO


-- Table: Loans
-- ============================
CREATE TABLE Loans (
    loan_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    loan_type VARCHAR(30), -- Personal, Auto, Mortgage, Business
    amount DECIMAL(12,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active', -- Active, Paid Off, Defaulted
    issue_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO


