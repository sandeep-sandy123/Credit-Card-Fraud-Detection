USE fraud_detection;
SELECT COUNT(*) FROM creditcard_clean;

USE fraud_detection;
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';

--1. Fraud Overview:
USE fraud_detection;
SELECT
    Class,
    COUNT(*) AS Total_Transactions,
    ROUND(AVG(Amount), 2) AS Avg_Amount,
    ROUND(SUM(Amount), 2) AS Total_Amount,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 3) AS Percentage
FROM creditcard_clean
GROUP BY Class;

-- 2. Fraud by Hour:
SELECT TOP 10
    Hour,
    COUNT(*) AS Fraud_Cases,
    ROUND(SUM(Amount), 2) AS Total_Fraud_Amount
FROM creditcard_clean
WHERE Class = 1
GROUP BY Hour
ORDER BY Fraud_Cases DESC;

-- 3. Fraud by Amount Range:
SELECT
    Amount_Range,
    COUNT(*) AS Fraud_Cases,
    ROUND(SUM(Amount), 2) AS Total_Fraud_Value,
    ROUND(AVG(Amount), 2) AS Avg_Fraud_Amount
FROM creditcard_clean
WHERE Class = 1
GROUP BY Amount_Range
ORDER BY Fraud_Cases DESC;

--4. Top 10 Highest Fraud Transactions:
SELECT TOP 10
    Amount,
    Hour,
    Class
FROM creditcard_clean
WHERE Class = 1
ORDER BY Amount DESC;
