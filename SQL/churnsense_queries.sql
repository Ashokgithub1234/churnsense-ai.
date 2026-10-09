ChurnSense AI: SQL analysis
 
-- Database: churnsense.db (SQLite)

Table: customers_clean (cleaned Telco data, with churn_flag and tenure_group added)
churn_flag = 1 if the customer left, 0 if they stayed, so AVG(churn_flag) is the churn rate.

 1. Overall churn
SELECT COUNT(*) AS total, SUM(churn_flag) AS churned,
       ROUND(100.0 * AVG(churn_flag), 1) AS churn_rate
FROM customers_clean;

 2. Churn by contract
SELECT Contract, COUNT(*) AS customers,
       ROUND(100.0 * AVG(churn_flag), 1) AS churn_rate
FROM customers_clean
GROUP BY Contract
ORDER BY churn_rate DESC;

3. Churn by tenure group
SELECT tenure_group, COUNT(*) AS customers,
       ROUND(100.0 * AVG(churn_flag), 1) AS churn_rate
FROM customers_clean
GROUP BY tenure_group
ORDER BY MIN(tenure);

4. Churn by tech support
SELECT TechSupport, COUNT(*) AS customers,
       ROUND(100.0 * AVG(churn_flag), 1) AS churn_rate
FROM customers_clean
GROUP BY TechSupport
ORDER BY churn_rate DESC;

 5. Churn by internet service
SELECT InternetService, COUNT(*) AS customers,
       ROUND(100.0 * AVG(churn_flag), 1) AS churn_rate
FROM customers_clean
GROUP BY InternetService
ORDER BY churn_rate DESC;

 6. Churn by payment method
SELECT PaymentMethod, COUNT(*) AS customers,
       ROUND(100.0 * AVG(churn_flag), 1) AS churn_rate
FROM customers_clean
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

7. Churn by senior citizen
SELECT SeniorCitizen, COUNT(*) AS customers,
       ROUND(100.0 * AVG(churn_flag), 1) AS churn_rate
FROM customers_clean
GROUP BY SeniorCitizen;

8. Average bill and tenure: churned vs stayed
SELECT Churn, ROUND(AVG(MonthlyCharges), 2) AS avg_monthly,
       ROUND(AVG(tenure), 1) AS avg_tenure
FROM customers_clean
GROUP BY Churn;

9. Revenue lost to churn
SELECT ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges END), 0) AS monthly_revenue_lost,
       ROUND(SUM(MonthlyCharges), 0) AS total_monthly_revenue
FROM customers_clean;

10. High-risk segment: month-to-month, 12 months or less, no tech support
SELECT COUNT(*) AS customers,
       ROUND(100.0 * AVG(churn_flag), 1) AS churn_rate
FROM customers_clean
WHERE Contract = 'Month-to-month'
  AND tenure <= 12
  AND TechSupport = 'No';