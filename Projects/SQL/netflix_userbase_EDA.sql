SELECT TOP 10 *
FROM dbo.userbase;

--- DATA CLEANING ---
-- Create a new table to remove duplicate and null values

CREATE TABLE cleaned_userbase ( 
	user_id INT PRIMARY KEY, 
	subscription_type VARCHAR(50) NOT NULL,
	monthly_revenue INT NOT NULL,
	join_date DATE NOT NULL,
	last_payment_date DATE NOT NULL,
	country VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	gender VARCHAR(100) NOT NULL,
	device VARCHAR(100) NOT NULL)

-- copy data 
INSERT INTO cleaned_userbase (
	user_id,
	subscription_type,
	monthly_revenue,
	join_date,
	last_payment_date,
	country,
	age,
	gender,
	device)
SELECT
	User_ID, 
	Subscription_Type, 
	Monthly_Revenue, Join_Date,
	Last_Payment_Date, 
	Country, 
	Age, 
	Gender, 
	Device
FROM dbo.userbase;

SELECT TOP 10 * 
FROM cleaned_userbase;

-- convert dates into standard format
UPDATE cleaned_userbase
SET join_date = CONVERT(VARCHAR, join_date, 101)

UPDATE cleaned_userbase
SET last_payment_date = CONVERT(VARCHAR, last_payment_date, 101)

-- EXPLORE DATA ---
-- What country has the most users?
SELECT country, COUNT(*)
FROM cleaned_userbase
GROUP BY country
ORDER BY COUNT(*) DESC;

-- What device type is most used?
SELECT device, COUNT(*)
FROM cleaned_userbase
GROUP BY device
ORDER BY COUNT(*) DESC;

-- What subscription is most common for each device type?
SELECT device, subscription_type, COUNT(subscription_type)
FROM cleaned_userbase
GROUP BY device, subscription_type
ORDER BY device, COUNT(subscription_type) DESC;

-- What device type produces the greatest monthly revenue?
SELECT device, SUM(monthly_revenue) as total_monthly_revenue
FROM cleaned_userbase
GROUP BY device
ORDER BY total_monthly_revenue DESC;

-- What is the average age of users by subscription type? 
SELECT subscription_type, AVG(age)
FROM cleaned_userbase
GROUP BY subscription_type;

-- What subscription type produces the greatest monthly revenue?
SELECT subscription_type, SUM(monthly_revenue) as total_monthly_revenue
FROM cleaned_userbase
GROUP BY subscription_type
ORDER BY total_monthly_revenue DESC;

-- What's the average length of subscription?
SELECT AVG(DATEDIFF(MONTH, join_date, last_payment_date)) AS average_subscription_length
FROM cleaned_userbase;

-- What month did most users join Netflix?
SELECT MONTH(join_date) as month, COUNT(*)
FROM cleaned_userbase
GROUP BY MONTH(join_date)
ORDER BY COUNT(*) DESC;

-- Year?
SELECT YEAR(join_date) as year, COUNT(*)
FROM cleaned_userbase
GROUP BY YEAR(join_date)
ORDER BY COUNT(*) DESC;