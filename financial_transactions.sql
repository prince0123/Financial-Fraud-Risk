
-- Step 1: Create & Import the Table

CREATE TABLE financial_transactions (
    TransactionID INT,
    Time DATETIME,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20),
    OldBalance DECIMAL(10,2),
    NewBalance DECIMAL(10,2),
    FraudFlag TINYINT
);

-- Step 2: Exploratory Analysis
-- 🔹 Total Number of Transactions

SELECT COUNT(*) AS Total_Transactions FROM financial_transactions;

-- Transaction Type Breakdown
select TransactionType, count(*) As Count
from financial_transactions
group by TransactionType;

-- Total & Average Amount by Transaction Type
select sum(Amount) as Total, avg(Amount) as Average, TransactionType,count(TransactionType) as Count
from financial_transactions
group by TransactionType; 

-- Step 3: Fraud Detection Analysis
-- Count & Rate of Fraudulent Transactions
select count(*) as Fraud_Count, 100*count(*)/(select count(*) from financial_transactions) as fraud_rate
from financial_transactions
where FraudFlag=1;

-- Average Amount in Fraudulent vs Non-Fraudulent Transactions
select count(*) as Total_Transactions, sum(Amount) as Total_Amount, avg(Amount) as Average_Amount, FraudFlag
from financial_transactions
group by FraudFlag;

-- Suspicious Transactions with Large Amounts
select TransactionType, Amount as Suspicious_Transactions
from financial_transactions
where Amount>15000 and FraudFlag=1
order by Amount;

-- Step 4: Balance Behavior Analysis
-- Transactions with Negative New Balance
select * from financial_transactions
where NewBalance<0;

-- Net Change in Balance
select TransactionType,round(avg(OldBalance-NewBalance),2) as Balance_Change
from financial_transactions
group by TransactionType;

-- FINDINGS:
-- the average amount for credit, debit and transfer is 10429.087176,10159.182035,10053.689019.
-- total fradulent transactions are 23, with a rate of 2.3 of fradulent transactions.
-- there are 7 suspicious transactions with large amount.
-- The net change is balance for credit, debit and transfer are : 1775.29, 3520.43, 4187.21.