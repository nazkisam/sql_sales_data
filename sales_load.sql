


-- 4 DATA EXPLORATION
SELECT COUNT(DISTINCT customer_id)
FROM sales_data

SELECT COUNT(DISTINCT category),category
FROM sales_data
GROUP BY category

--SALES DONE ON 2022-11-05
SELECT *FROM sales_data
WHERE sale_date = '2022-11-05'


--ALL TRANSACTION WHERE CATE = clothing and quantity >4,month nov 2022  
SELECT *FROM sales_data
WHERE category = 'Clothing'  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantiy>=4

--calculate total sales for each category
SELECT category,SUM(total_sale),count(*)AS total_orders
FROM sales_data
GROUP BY category

--AVG age of customers who purchased form beauty category
SELECT ROUND(AVG(age)) 
FROM sales_data
WHERE category = 'Beauty'

--transactions where total sale is >1000
SELECT *FROM sales_data
WHERE total_sale > 1000

--total number of transactions made by each gender in each category
SELECT gender,category,COUNT(transactions_id)
FROM sales_data
GROUP BY gender,category


--AVG Sale each month,best selling month in each year

WITH ranked_sales AS (
SELECT  EXTRACT( year FROM sale_date) AS YEAR,EXTRACT(month FROM sale_date)AS MONTH, AVG(total_sale) AS total_sales,
RANK() OVER(PARTITION BY EXTRACT( year FROM sale_date) ORDER BY AVG(total_sale) DESC ) AS RNK

FROM sales_data

GROUP BY EXTRACT( year FROM sale_date) ,EXTRACT(month FROM sale_date) 
)
SELECT rnk,year,month, MAX (Total_Sales)
FROM ranked_sales

WHERE  RNK =1
GROUP BY year,month,rnk

--top % customers based on sales
SELECT *FROM sales_data 

SELECT  customer_id ,SUM(total_sale) AS total_sales,
 RANK() OVER (ORDER BY SUM(total_sale) DESC) AS sales_rank
--RANK() OVER(PARTITION BY  customer_id ORDER BY SUM(total_sale) DESC)
FROM sales_data
group by 1
ORDER BY 2 DESC
LIMIT 5
--number of unique customers, who bought from each category


SELECT COUNT( DISTINCT customer_id),category
FROM sales_data
GROUP BY category


-- create time shift morning <=12 , after noon 12 and 17 , evening >17
SELECT COUNT(transactions_id),
    CASE 
	 WHEN EXTRACT(HOUR FROM sale_time)< 12 THEN 'Morning '
	 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'After Noon'
	 ELSE 'evening '
	 END AS shifts
 FROM sales_data
 GROUP BY shifts





























-- 3 DELETING THE ROWS WITH NULL VAL

DELETE FROM sales_data
WHERE
     TRANSACTIONS_id IS NULL 
	 OR
	 sale_date IS NULL
     OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 GENDER IS NULL
	 OR
	 AGE IS NULL
	 OR
	 category IS NULL
	 OR
     QUANTIY IS NULL
     OR
	 PRICE_PER_UNIT IS  NULL
     OR 
	 COGS IS NULL
     OR 
     TOTAL_SALE IS  NULL
     











-- 2 DEAL WITH NULL VALUES
SELECT *FROM sales_data
WHERE transactions_id IS NULL
-- 1 REPLACING NULL VALUES WITH DEFALUT VALUES
SELECT COALESCE(
	
	
	
	gender ,
	
	category ,
	
	
	

   'Default Value')
FROM sales_data;






SELECT *FROM sales_data 
WHERE 
     TRANSACTIONS_id IS NULL 
	 OR
	 sale_date IS NULL
     OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 GENDER IS NULL
	 OR
	 AGE IS NULL
	 OR
	 category IS NULL
	 OR
     QUANTIY IS NULL
     OR
	 PRICE_PER_UNIT IS  NULL
     OR 
	 COGS IS NULL
     OR 
     TOTAL_SALE IS  NULL
     
	 












SELECT *FROM sales_data

SELECT COUNT(*) FROM sales_data


CREATE TABLE sales_data(
transactions_id	INT,
	sale_date DATE,
	sale_time TIME,
	customer_id INT PRIMARY KEY,
	gender VARCHAR(30),
	age INT,
	category VARCHAR(30),
	quantiy INT,
	price_per_unit INT,
	cogs INT,
	total_sale INT

)

COPY sales_data(
	transactions_id,
	sale_date ,
	sale_time ,
	customer_id ,
	gender ,
	age ,
	category ,
	quantiy ,
	price_per_unit ,
	cogs ,
	total_sale
)
FROM 'D:\PLCPP\SQL\newproject\SQL - Retail Sales Analysis.csv'
DELIMITER ','
CSV HEADER






ALTER TABLE sales_data
ALTER COLUMN cogs TYPE FLOAT

ALTER TABLE sales_data
DROP CONSTRAINT sales_data_PKEY












