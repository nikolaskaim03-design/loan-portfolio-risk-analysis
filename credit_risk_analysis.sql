USE credit_risk_db;
CREATE TABLE IF NOT EXISTS customer_info (id INT PRIMARY KEY, full_name VARCHAR(100), city VARCHAR(50));
INSERT INTO customer_info (id, full_name, city) VALUES
(1, 'Nikos Papadopoulos', 'Athens'),
(2, 'Maria Dimitriou', 'Thessaloniki'),
(3, 'Giannis Nikolaou', 'Patra'),
(4, 'Eleni Kostopoulou', 'Larissa'),
(5, 'Andreas Markou', 'Lamia')
ON DUPLICATE KEY UPDATE id=id;
SELECT c.full_name, c.city, d.`Credit amount` AS Loan_Amount,
d.`Age in years` AS age
FROM customer_info AS c
JOIN dataset AS d
ON c.id=d.id;
SELECT id AS customer_ID,
`Age in years` AS Age,
`Credit Amount` AS Loan_Amount,
`Duration in months` AS Duration,
`Purpose of the credit` AS purpose,
CASE
WHEN `Credit amount`<3000 AND `Duration in months`<=12 THEN 'Low Risk'
WHEN `Credit amount` BETWEEN 3000 AND 7000 THEN 'Medium Risk'
ELSE 'High Risk'
END AS Risk_category
FROM dataset
WHERE `Age in years`>=18
ORDER BY `Credit amount` DESC;
SELECT `Purpose of the credit` AS Purpose,
COUNT(id) AS Total_Loans,
AVG(`Credit amount`) AS Average_Loan_Amount
FROM dataset
GROUP BY `Purpose of the credit`
ORDER BY Total_loans DESC;

