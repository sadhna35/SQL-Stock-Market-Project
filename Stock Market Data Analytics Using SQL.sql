--- PROJECT TITLE: Stock Market Data Analytics Usimg MySQL

create database projects;
use projects;
CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    sector VARCHAR(100),
    headquarters VARCHAR(255),
    listed_date DATE
);

INSERT INTO companies VALUES
(1, 'TCS', 'IT', 'Mumbai', '2004-06-15'),
(2, 'Reliance Industries', 'Energy', 'Mumbai', '2001-03-10'),
(3, 'Infosys', 'IT', 'Bangalore', '2002-08-25'),
(4, 'HDFC Bank', 'Finance', 'Mumbai', '2000-01-01');

select* from companies;

CREATE TABLE investors (
    investor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    country VARCHAR(100),
    date_joined DATE
);



INSERT INTO investors VALUES
(1, 'Aman Gupta', 'aman@example.com', 'India', '2023-01-10'),
(2, 'Riya Jain', 'riya@example.com', 'India', '2023-06-22'),
(3, 'John Smith', 'john@example.com', 'USA', '2022-10-05');

select* from investors;

CREATE TABLE stocks (
    stock_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT,
    ticker VARCHAR(20) NOT NULL UNIQUE,
    stock_exchange VARCHAR(50),
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO stocks VALUES
(101, 1, 'TCS', 'NSE'),
(102, 2, 'RELIANCE', 'BSE'),
(103, 3, 'INFY', 'NSE'),
(104, 4, 'HDFC', 'NSE');

select* from stocks;

CREATE TABLE stock_prices (
    price_id INT PRIMARY KEY AUTO_INCREMENT,
    stock_id INT,
    date DATE,
    open_price DECIMAL(15,2),
    close_price DECIMAL(15,2),
    volume_traded INT,
    FOREIGN KEY (stock_id) REFERENCES stocks(stock_id)
);

INSERT INTO stock_prices VALUES
(1, 101, '2024-06-01', 3400, 3425, 120000),
(2, 102, '2024-06-01', 2450, 2480, 220000),
(3, 103, '2024-06-01', 1300, 1315, 180000),
(4, 104, '2024-06-01', 1600, 1620, 150000),
(5, 101, '2024-07-01', 3425, 3450, 110000),
(6, 102, '2024-07-01', 2480, 2500, 200000);

select *from stock_prices;


CREATE TABLE portfolios (
    portfolio_id INT PRIMARY KEY AUTO_INCREMENT,
    investor_id INT,
    stock_id INT,
    quantity INT,
    purchase_date DATE,
    purchase_price DECIMAL(15,2),
    FOREIGN KEY (investor_id) REFERENCES investors(investor_id),
    FOREIGN KEY (stock_id) REFERENCES stocks(stock_id)
);

INSERT INTO portfolios VALUES
(1, 1, 101, 50
, '2024-01-15', 3300),
(2, 1, 104, 30, '2024-02-01', 1550),
(3, 2, 102, 40, '2024-03-10', 2400),
(4, 3, 103, 70, '2024-04-01', 1280);

CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    sector VARCHAR(100),
    headquarters VARCHAR(255),
    listed_date DATE
);

INSERT INTO companies VALUES
(1, 'TCS', 'IT', 'Mumbai', '2004-06-15'),
(2, 'Reliance Industries', 'Energy', 'Mumbai', '2001-03-10'),
(3, 'Infosys', 'IT', 'Bangalore', '2002-08-25'),
(4, 'HDFC Bank', 'Finance', 'Mumbai', '2000-01-01');

select* from companies;

CREATE TABLE investors (
    investor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    country VARCHAR(100),
    date_joined DATE
);

INSERT INTO investors VALUES
(1, 'Aman Gupta', 'aman@example.com', 'India', '2023-01-10'),
(2, 'Riya Jain', 'riya@example.com', 'India', '2023-06-22'),
(3, 'John Smith', 'john@example.com', 'USA', '2022-10-05');

select* from investors;

CREATE TABLE stocks (
    stock_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT,
    ticker VARCHAR(20) NOT NULL UNIQUE,
    stock_exchange VARCHAR(50),
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO stocks VALUES
(101, 1, 'TCS', 'NSE'),
(102, 2, 'RELIANCE', 'BSE'),
(103, 3, 'INFY', 'NSE'),
(104, 4, 'HDFC', 'NSE');

select* from stocks;

CREATE TABLE stock_prices (
    price_id INT PRIMARY KEY AUTO_INCREMENT,
    stock_id INT,
    date DATE,
    open_price DECIMAL(15,2),
    close_price DECIMAL(15,2),
    volume_traded INT,
    FOREIGN KEY (stock_id) REFERENCES stocks(stock_id)
);

INSERT INTO stock_prices VALUES
(1, 101, '2024-06-01', 3400, 3425, 120000),
(2, 102, '2024-06-01', 2450, 2480, 220000),
(3, 103, '2024-06-01', 1300, 1315, 180000),
(4, 104, '2024-06-01', 1600, 1620, 150000),
(5, 101, '2024-07-01', 3425, 3450, 110000),
(6, 102, '2024-07-01', 2480, 2500, 200000);

select *from stock_prices;


CREATE TABLE portfolios (
    portfolio_id INT PRIMARY KEY AUTO_INCREMENT,
    investor_id INT,
    stock_id INT,
    quantity INT,
    purchase_date DATE,
    purchase_price DECIMAL(15,2),
    FOREIGN KEY (investor_id) REFERENCES investors(investor_id),
    FOREIGN KEY (stock_id) REFERENCES stocks(stock_id)
);

INSERT INTO portfolios VALUES
(1, 1, 101, 50, '2024-01-15', 3300),
(2, 1, 104, 30, '2024-02-01', 1550),
(3, 2, 102, 40, '2024-03-10', 2400),
(4, 3, 103, 70, '2024-04-01', 1280);

select*from portfolios;
-- count the number of companies per sector.
select sector,count(*) as number_companies
from companies
group by sector;

-- 2) List all companies listed before 2005
SELECT *
FROM companies
WHERE listed_date < '2005-01-01';

-- 3. Show current stock price (latest close price) for each company
SELECT 
    c.company_id,
    c.name,
    sp.close_price,
    sp.date AS price_date
FROM companies c
JOIN stocks s ON c.company_id = s.company_id
JOIN stock_prices sp ON s.stock_id = sp.stock_id
WHERE sp.date = (
    SELECT MAX(sp2.date)
    FROM stock_prices sp2
    WHERE sp2.stock_id = sp.stock_id
);

-- 4) Find investors who joined in the last 1 year (from July 24, 2025)
SELECT *
FROM investors
WHERE date_joined >= DATE_SUB('2025-07-24', INTERVAL 1 YEAR);

-- 5). List portfolios with investment value greater than ₹100,000

SELECT *
FROM portfolios
WHERE quantity * purchase_price > 100000;



-- 6) Join portfolios with investors and stock tickers
SELECT 
    p.portfolio_id,
    i.name AS investor_name,
    i.email,
    s.ticker,
    p.quantity,
    p.purchase_date,
    p.purchase_price
FROM portfolios p
JOIN investors i ON p.investor_id = i.investor_id
JOIN stocks s ON p.stock_id = s.stock_id;
-- 7. List companies whose stock is traded on the NSE
SELECT DISTINCT
    c.company_id,
    c.name,
    c.sector,
    c.headquarters,
    c.listed_date
FROM companies c
JOIN stocks s ON c.company_id = s.company_id
WHERE s.stock_exchange = 'NSE';

-- 8. Show daily volume traded per stock in June 2024

SELECT 
    sp.stock_id,
    s.ticker,
    sp.date,
    SUM(sp.volume_traded) AS total_volume
FROM stock_prices sp
JOIN stocks s ON sp.stock_id = s.stock_id
WHERE sp.date BETWEEN '2024-06-01' AND '2024-06-30'
GROUP BY sp.stock_id, s.ticker, sp.date
ORDER BY sp.stock_id, sp.date;

-- 9 Find the stock price difference (close - open) per day
SELECT
    stock_id,
    date,
    close_price - open_price AS price_difference
FROM stock_prices
ORDER BY stock_id, date;
-- 10 Identify investors holding stocks from the IT sector
SELECT DISTINCT
    i.investor_id,
    i.name,
    i.email,
    i.country,
    i.date_joined
FROM investors i
JOIN portfolios p ON i.investor_id = p.investor_id
JOIN stocks s ON p.stock_id = s.stock_id
JOIN companies c ON s.company_id = c.company_id
WHERE c.sector = 'IT';

-- 11 Find the total volume traded per stock
SELECT 
    stock_id,
    SUM(volume_traded) AS total_volume_traded
FROM stock_prices
GROUP BY stock_id;
-- 12. Calculate average close price for each company in June 2024
SELECT 
    c.company_id,
    c.name,
    AVG(sp.close_price) AS avg_close_price_june_2024
FROM stock_prices sp
JOIN stocks s ON sp.stock_id = s.stock_id
JOIN companies c ON s.company_id = c.company_id
WHERE sp.date BETWEEN '2024-06-01' AND '2024-06-30'
GROUP BY c.company_id, c.name;

-- 13. Total portfolio value per investor
SELECT 
    investor_id,
    SUM(quantity * purchase_price) AS total_portfolio_value
FROM portfolios
GROUP BY investor_id;

-- 14. Number of investors per country
SELECT 
    country,
    COUNT(*) AS investors_count
FROM investors
GROUP BY country;
-- 15. Total quantity of shares purchased per stock
SELECT 
    stock_id,
    SUM(quantity) AS total_quantity_purchased
FROM portfolios
GROUP BY stock_id;

-- 16. Rank companies based on total traded volume.
SELECT 
    c.company_id,
    c.name,
    SUM(sp.volume_traded) AS total_volume,
    RANK() OVER (ORDER BY SUM(sp.volume_traded) DESC) AS volume_rank
FROM companies c
JOIN stocks s ON c.company_id = s.company_id
JOIN stock_prices sp ON s.stock_id = sp.stock_id=sp.stock_id
group by c.company_id,c.name
order by volume_rank;

-- 17. Show month-over-month price change for each stock.
DESCRIBE stock_prices;
select
sp.stock_id,
DATE_format(sp.date,'%Y-%m')as month,
sp.close_price-LAG(sp.close_price)over(partition by sp.stock_id
order by sp.date)as prev_month_price,
sp.close_price-LAG(sp.close_price)over(partition by sp.stock_id
order by sp.date)
as month_price_change from stock_prices sp
order by sp.stock_id,sp.date;

-- 18. Use a LAG to compare a stocks close price with the previous day.
select 
stock_id,
date,
close_price,
LAG(close_price)over(partition by stock_id
order by date)
as previous_day_close,
close_price-LAG(close_price)over(
partition by stock_id order by date)
as price_change from stock_prices
order by stock_id,date;

-- 19 USE a CTE to find all investors with more than one holding

with investor_holdings as(
select investor_id,
count(*) as holding_count
from portfolios
group by investor_id)
select i.investor_id,
inv.name,
holding_count
from investor_holdings i
join investors inv on i.investor_id = inv.investor_id
where holding_count >1;

-- 20 Use a cte to calculate profit/loss per portfolio holding.
with latest_prices as(
select
stock_id,
max(date)as latest_date
from stock_prices
group by stock_id),
latest_stock_prices as(
select 
sp.stock_id,
sp.close_price
from stock_prices sp
join latest_prices lp
on sp.stock_id = lp.stock_id and sp.date = lp.latest_date),
portfolio_profit_loss as(
select
p.portfolio_id,
p.investor_id,
p.stock_id,
p.quantity,
p.purchase_price,
lsp.close_price,
(lsp.close_price - p.purchase_price)*p.quantity as
profit_loss
from portfolios p 
join latest_stock_prices lsp on p.stock_id = lsp.stock_id
)
select
pp.portfolio_id,
i.name as investor_name,
s.ticker as stock,
pp.quantity,
pp.purchase_price,
pp.profit_loss
from portfolio_profit_loss pp
join investors i on pp.investor_id = i.investor_id
join stocks s on pp.stock_id = s.stock_id 
order by pp.profit_loss DESC;

-- 21 Create a cte to extract the highest stock price per company

with highest_price_per_company as(
select c.name as company_name,
max(sp.close_price) as highest_price
from stock_prices sp
join stocks s on sp.stock_id = s.stock_id
join companies c on s.company_id = c.company_id
group by c.name
)
select*from highest_price_per_company
order by highest_price DESC;

-- 22 Procedure to list all stocks held by a given investor.solve

Delimiter //
create Procedure getstockbyinvestor1( in in_investor_id int)
begin 
select 
i.name as investor_name,
s.ticker as stock_ticker,
c.name as company_name,
p.quantity,
p.purchase_date,
p.purchase_price
from portfolios p
join stocks s on p.stock_id = s.stock_id
join companies c on s.company_id = c.company_id
join investors i on p.investor_id = i.investor_id
where p.investor_id = in_investor_id;
end //
Delimiter ;
call getstockbyinvestor1(1);

-- 23 Procedure to return stock performance for a date range

Drop procedure if exists GetStockPerformance4;
Delimiter //
create procedure GetStockPerformance4(
in in_ticker varchar(10),
in in_start_date date,
in in_end_date date
)
Begin
select
c.name as company_name,
s.ticker,
sp.date,
sp.open_price,
sp.close_price,
sp.volume_traded
from stock_prices sp
join stocks s on sp.stock_id = s.stock_id
join companies c on s.company_id = c.company_id
where s.ticker = in_ticker
and sp.date between in_start_date and in_end_date 
order by sp.date;
end //
Delimiter //
call GetStockPerformance4('tcs','2024-06-01','2024-07-01');

-- 24 Procedure to get all stocks in a given sector
 Drop Procedure if exists getstocksbysector_1;
 Delimiter //
 create procedure getstocksbysector_1(
 in in_sector varchar(100)
 )
 begin
 select 
 c.name as company_name,
 c.sector,
 s.ticker,
 s.stock_id
 from companies c
 join stocks s on c.company_id = s.company_id
 where c.sector = in_sector;
 end //
 Delimiter ;
 call getstocksbysector_1('Technology');
 
 -- 25 Create a udf to calculate return on investment(ROI).
 Delimiter //
 create function calculate_roi1(current_price
 DECIMAL(10,2),purchase_price DECIMAL(10,2))
 RETURNS DECIMAL(10,2)
 DETERMINISTIC
 BEGIN
 DECLARE roi DECIMAL(10,2);
 if purchase_price = 0 then
 set roi = 0;
 else
 set roi =((current_price - purchase_price) /
 purchase_price)*100;
 end if;
 return roi;
 end;
 //
 DELIMITER ;
 select calculate_roi(3450,3300)as roi;
 
 -- 26 Create a UDF to flag-high- volume trading days (volume>200,000).
 delimiter //
 create function flag_high_volume(volume int)
 returns varchar(20)
 deterministic
 begin 
 declare result varchar(20);
 if volume > 200000 then 
 set result ='high volume';
 else 
 set result = 'normal volume';
 end if ;
 return result;
 end;
 //
 delimiter ;
 
 select date, volume_traded,
 flag_high_volume(volume_traded) as volume_status
 from stock_prices;
 
 -- 27 UDF to classify stocks as 'low','mid', or 'high' cap based on price.
 delimiter //
 create function classify_market_cap(price
 decimal(10,2))
 returns varchar(20)
 deterministic
 begin
 declare cap_category varchar(20);
 if price <1500 then
 set cap_category = 'low cap';
 Elseif price >= 1500 and price <= 2500 then
  set cap_category = 'mid cap';
Else
  set cap_category ='high cap';
 end if;
 return cap_category;
 end;
 //
 delimiter ;
 select 
 stock_id,
 date,
 close_price,
 classify_market_cap(close_price) as
 market_cap_category
 from
 stock_prices;
 
 --- 1 Customers
 
 create table customers(
 customer_id int primary key,
 name varchar(500),
 email varchar(500),
 city varchar(500),
 state varchar(500),
 signup_date date 
 );
 
 insert into customers values
 (1,'amit roy','amit@example.com','delhi','delhi','2022-03-10'),
 (2,'sonal jain','sonal@example.com','mumbai','maharashtra','2023-01-22'),
 (3,'rakesh singh','rakesh@example.com','lucknow','up','2021-11-05');
 
 select *from customers;
 
 -- 2. products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

INSERT INTO products VALUES
(101, 'Wireless Mouse', 'Electronics', 599.00, 100),
(102, 'Bluetooth Speaker', 'Electronics', 1299.00, 50),
(103, 'Cotton Shirt', 'Fashion', 899.00, 200),
(104, 'Cooking Oil 1L', 'Grocery', 175.00, 300);
select*from products;

-- 3. orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(1001, 1, '2024-06-01', 'Delivered'),
(1002, 2, '2024-06-05', 'Delivered'),
(1003, 1, '2024-06-10', 'Returned'),
(1004, 3, '2024-06-11', 'Cancelled');
select *from orders;

-- 4. order_items
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price_each DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items VALUES
(1, 1001, 101, 2, 599.00),
(2, 1002, 103, 1, 899.00),
(3, 1003, 102, 1, 1299.00),
(4, 1004, 104, 5, 175.00);
select *from order_items;

-- 5. payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_date DATE,
    payment_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO payments VALUES
(501, 1001, 'Credit Card', '2024-06-01', 1198.00),
(502, 1002, 'UPI', '2024-06-05', 899.00),
(503, 1003, 'Net Banking', '2024-06-10', 1299.00);
select *from payments;

-- 6. reviews
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    order_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO reviews VALUES
(901, 1001, 5, 'Great product', '2024-06-03'),
(902, 1002, 4, 'Good fit and quality', '2024-06-06'),
(903, 1003, 2, 'Stopped working in 2 days', '2024-06-12');
select *from reviews;

 --- 1 Count the number of customers per state
 
select state,count(*) as customer_count from customers group by state;

--- 2 show total orders placed in june 2024

select count(*) as total_orders_june_2024
from orders
where order_date between '2024-06-01' and '2024-06-30';

 --- 3 Find the most sold product by quantity
 
 select p.product_name,sum(oi.quantity)as
 total_quantity_sold
 from order_items oi
 join products p on oi.product_id = p.product_id
 group by p.product_name
 order by total_quantity_sold desc
 limit 1;
 
 --- 4 List all customers who signed up before 2023
 
select*from customers
where signup_date <'2023-01-01';

--- 5 Find products with price above average price

select * from products
where price >(
select avg(price) from products);

--- 6  Join orders with customers to show buyer details per order

select o.order_id,o.order_date,
o.status,c.customer_id,c.name as customer_name,
c.email,c.city,c.state from orders o 
join customers c on o.customer_id = c.customer_id;

--- 7 Join order_items with products to show product names per order

select oi.order_id,oi. product_id,p.product_name,oi.quantity,
oi.price_each from order_items oi 
join products p on oi.product_id = p.product_id;

--- 8 Join reviews with orders and customers to analyze feedback by region

select r.review_id,r.rating,r.review_text,r.review_date,
o.order_id, c.customer_id,c.name as customer_name,
c.city,c.state from reviews r join orders o on r.order_id 
join customers c on o.customer_id = c.customer_id;

--- 9 Find all products bought by a specific customer

select c.name as customer_name,p.product_name,oi.quantity,
o.order_date from customer c join orders o on c.customer_id=o.customer_id
join order_items oi on oi.order_id=oi.order_id
join products p on oi.product_id = p.product_id
where c.customer_id = 1;

--- 10 List orders which were returned but still have payment records

select o.order_id, o.status,p.payment_id,p.payment_amount,
p.payment_method,p.payment_date 
from orders o join payments p on o.order_id=p.order_id
where o.status = "Returned";

--- 11 Calculate total revenue per product category
select p.category,sum(oi.quantity*oi.price_each)as total_revenue
from order_items oi
join products p on oi.product_id = p.product_id
join orders o on oi.order_id
where o.status ="Delivered" 
group by p.category;

--- 12 Find average rating per product
select p.product_name,
ROUND(avg(r.rating),2)as average_rating from reviews r 
join orders o on r.order_id=o.order_id
join order_items oi on o.order_id=oi.order_id
join products p on oi.product_id=p.product_id
group by p.product_name;

--- 13 Count number of reviews per rating level

select rating ,count(*) as review_count
from reviews 
group by rating 
order by rating DESC;

--- 14 Find monthly order count trends

select date_format(order_date,'%Y-%m')as month,
count(*) as order_count
from orders
group by date_format(order_date,'%Y-%m')
order by month;

--- 15 Total value of orders placed by each customer
select c.customer_id,
c.name as customer_name,
sum(oi.quantity*oi.price_each)as total_order_value
from customers c
join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id=oi.order_id
group by c.customer_id,c.name
order by total_order_value DESC;

--- 16 Rank products by total sales value

select p.product_id,p.product_name,
sum(oi.quantity*oi.price_each)as total_sales_value,
rank()over(order by sum(oi.quantity*oi.price_each)DESC)as sales_rank
from products p
join order_items oi on p.product_id=oi.product_id
group by p.product_id,p.product_name
order by total_sales_value DESC;

--- 17 Use LAG to compare customer spending across consecutive orders

select o.customer_id,c.name as customer_name,o.order_id,
sum(oi.quantity*oi.price_each)as order_value,
LAG(sum(oi.quantity*oi.price_each))
over (partition by o.customer_id order by
o.order_date)as value_difference
from orders o 
join customers c on o.customer_id =c.customer_id
join order_items oi on o.order_id = oi.order_id
group by o.customer_id, c.name,o.order_id,o.order_date
order by o.customer_id,o.order_date;

--- 18 Use LEAD to forecast expected next purchase (based on order_date)

select o.customer_id,c.name as customer_name,
o.order_id,
o.order_date,
LEAD(o.order_date)over(
partition by o.customer_id
order by o.order_date
)as next_order_date,
DATEDIFF(
LEAD(o.order_date)over(
partition by o.customer_id
order by o.order_date
),
o.order_date
)as days_until_next_purchase
from orders o 
join customers c 
on o.customer_id=c.customer_id
order by o.customer_id,o.order_date;

--- 19 USE a CTE to identify high-value customers(total spend >2000;

with customer_spending as(
select o.customer_id,
c.name as customer_name,
sum(oi.quantity*oi.price_each)as total_spent
from orders o 
join order_items oi
on o.order_id = oi.order_id
join customers c
on o.customer_id = c.customer_id
group by o.customer_id,c.name
)
select * from customer_spending
where total_spent > 2000
order by total_spent DESC;

--- 20 CTE to calculate category - wise sales performance. 

with categorysales as (
select p.category,
sum(oi.quantity *oi.price_each )as total_sales
from order_items oi
join products p on oi.product_id=p.product_id
group by p.category
)
select category ,total_sales
from categorysales
order by total_sales DESC;

--- 21 Procedure to get all orders by a customer ID

DELIMITER $$
create procedure getordersbycustomerid3(in cust_id int)
begin
select 
o.order_id,
o.order_date,
o.status,
sum(oi.quantity*oi.price_each)as total_order_value
from orders o 
join order_items oi
where o.customer_id=cust_id
group by o.order_id,o.order_date,o.status
order by o.order_date desc;
end $$
delimiter ;
call getordersbycustomerid3(101);
