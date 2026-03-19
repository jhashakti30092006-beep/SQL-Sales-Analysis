--=============================================
--E-COMMERCE RETAIL SALES ANALYSIS PROJECT
--DATASET:ONLINE RETAIL DATASET
--=============================================

--DATASET PREVIEW
select*from retail;

--DATA CLEANING
DELETE FROM retail
WHERE InvoiceNo LIKE 'C%';

DELETE FROM retail 
WHERE Quantity<=0;

DELETE FROM retail 
WHERE UnitPrice<=0;


--TOTAL REVENUE
select 
sum(Quantity*UnitPrice) as total_revenue
from retail;
--TOTAL ORDERS
select count(distinct InvoiceNo) as total_orders from retail;
--TOTAL CUSTOMERS
select count(distinct CustomerID) as total_customers from retail;


--TOTAL REVENUE BY MONTH
select year(InvoiceDate) as year,month(InvoiceDate) as month,
sum(Quantity*UnitPrice) as Revenue 
from retail
group by year(InvoiceDate),month(InvoiceDate)
order by year,month;



--TOP 10 PRODUCTS BY REVENUE
select top 10
Description,sum(Quantity*UnitPrice) as Revenue from retail
group by Description 
order by Revenue desc;


--TOP 10 CUSTOMERS
select top 10
CustomerID,sum(Quantity*UnitPrice) as total_spent from retail
where CustomerID is not null and CustomerID<>0
group by CustomerID 
order by total_spent desc;


--COUNTRIES WITH HIGHEST SALES
select top 10 Country,sum(Quantity*UnitPrice) as total_sales from retail
group by Country 
order by total_sales desc;


--AVERAGE ORDER VALUE
select avg(ordervalue) as avg_order_value
from
(select InvoiceNo,sum(Quantity*UnitPrice) as ordervalue from retail
group by InvoiceNo) as orders;


--PRODUCT REVENUE RANKING
select Description,sum(Quantity*UnitPrice) as revenue,
rank()over(order by sum(Quantity*UnitPrice)desc) as
rank_product from retail
group by Description;