--Create table
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales

  -- Data Cleaning
  SELECT * FROM retail_sales
  WHERE transactions_id IS NULL

  SELECT * FROM retail_sales
  WHERE sale_date IS NULL

  SELECT * FROM retail_sales
  WHERE sale_time IS NULL

  SELECT * FROM retail_sales
   WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
    --Data Cleaning
   DELETE FROM retail_sales
    WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

	select * from retail_sales;
	

--Data Exploration
--How many sales we have?
Select count(*) as total_sales from retail_sales ;

--How many unique  customers do we have?
Select count( distinct customer_id) as Total_Customers from retail_sales;

--How many unique categories do we have?
Select  distinct category from retail_sales;


--Data Analysis &Business key problems & Answers 
--To Retrive all data in specific date
	select *
	from retail_sales 
	where sale_date ='2022-11-05';

--To Retrive all data with category is cloth in specific data,quantity greater than 4
	SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantiy >= 4;

 --calculate total sales foe each category
 select category
 ,sum(total_sale)
 ,count (quantiy)
 from retail_sales
 group by category;

 --the avg age of customers who purchased items from the 'beauty' category 
 select  round (avg(age))as Avg_Age
 from retail_sales
 where category = 'Beauty'

 --find all transactions where total sales >1000
 select * 
 from retail_sales 
where total_sale >1000

--total number of transactions made by each gender in each category
select gender,
category,
count(*)as total_trans
from retail_sales 
group by category,gender

--avg sales for each month	
SELECT 
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
  ROUND(AVG(total_sale)) AS avg_total_sale,
  RANK() OVER (
    PARTITION BY EXTRACT(YEAR FROM sale_date)
    ORDER BY AVG(total_sale) DESC
  ) AS monthly_rank
FROM retail_sales
GROUP BY 1,2;

--top5 customers based on total sales 
select  customer_id ,
sum(total_sale) as total_sale
from retail_sales
group by 1
order by 2 desc

--crete shift num of orders 
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift


	

	
