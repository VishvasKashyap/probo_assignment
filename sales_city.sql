
CREATE TABLE city_sales (
    city VARCHAR(50),
    year INT,
    month INT,
    sales INT
);

-- Insert sample data
INSERT INTO city_sales (city, year, month, sales) VALUES
('Delhi', 2020, 5, 4300),
('Delhi', 2020, 6, 2000),
('Delhi', 2020, 7, 2100),
('Delhi', 2020, 8, 2200),
('Delhi', 2020, 9, 1900),
('Delhi', 2020, 10, 200),
('Mumbai', 2020, 5, 4400),
('Mumbai', 2020, 6, 2800),
('Mumbai', 2020, 7, 6000),
('Mumbai', 2020, 8, 9300),
('Mumbai', 2020, 9, 4200),
('Mumbai', 2020, 10, 9700),
('Bangalore', 2020, 5, 1000),
('Bangalore', 2020, 6, 2300),
('Bangalore', 2020, 7, 6800),
('Bangalore', 2020, 8, 7000),
('Bangalore', 2020, 9, 2300),
('Bangalore', 2020, 10, 8400);

-- Query to calculate the desired table
SELECT
    cs.city,
    cs.year,
    cs.month,
    cs.sales,
    LAG(cs.sales) OVER (PARTITION BY cs.city, cs.year ORDER BY cs.month) AS previous_month_sales,
    LEAD(cs.sales) OVER (PARTITION BY cs.city, cs.year ORDER BY cs.month) AS next_month_sales,
    SUM(cs.sales) OVER (PARTITION BY cs.city, cs.year ORDER BY cs.month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ytd_sales
FROM
    city_sales cs;


-- Save this as <Your Full Name>_SQL_ans2.sql

-- Query to filter sales data for Delhi in 2020
SELECT
    cs.city,
    cs.year,
    cs.month,
    cs.sales,
    LAG(cs.sales) OVER (PARTITION BY cs.city, cs.year ORDER BY cs.month) AS previous_month_sales,
    LEAD(cs.sales) OVER (PARTITION BY cs.city, cs.year ORDER BY cs.month) AS next_month_sales,
    SUM(cs.sales) OVER (PARTITION BY cs.city, cs.year ORDER BY cs.month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ytd_sales
FROM
    city_sales cs
WHERE
    cs.city = 'Delhi' AND cs.year = 2020;

