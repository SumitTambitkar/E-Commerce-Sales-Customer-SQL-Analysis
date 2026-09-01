
-- CREATE DATABASE --
create database  ecommerce_sales_customer_analysis;

-- USE DATABASE --
use ecommerce_sales_customer_analysis;

-- CREATE TABLES --

-- create table customer
create table customers ( 
customer_id int primary key, 
first_name varchar(50),
last_name varchar(50),
address varchar(100),
email varchar(100),
phone_number varchar(30));

desc customers;

-- create table order_items
create table order_items(
order_item_id int primary key,
order_id int,
product_id int,
quantity int,
price_at_purchase decimal(10,2));

desc order_items;

-- create table orders
create table orders(
order_id int primary key,
order_date date,
customer_id int,
total_price decimal(10,2));

desc orders;

-- create table payment
create table payment(
payment_id int primary key,
order_id int,
payment_method varchar(50),
amount decimal(10,2),
transaction_status varchar(50));

desc payment;

-- create table products
create table products(
product_id int primary key,
product_name varchar(200),
category varchar(100),
price decimal(10,2),
supplier_id int);

desc products;

-- create table review
create table reviews(
review_id int primary key,
product_id int,
customer_id int,
rating decimal(5,2),
review_text text,
review_date date);

desc reviews;

-- create table shipments
create table shipments(
shipment_id int primary key,
order_id int,
shipment_date date,
carrier varchar(100),
tracking_number varchar(100),
delivery_date date,
shipment_status varchar(100));

desc shipments;

-- create table suppliers
create table suppliers(
supplier_id int primary key,
supplier_name varchar(100),
contact_name varchar(100),
address varchar(200),
phone_number varchar(30),
email varchar(200));

desc suppliers;

-- SHOW ALL TABLES DATA --
select * from customers;
select * from orders;
select * from products;
select * from order_items;
select * from payment;
select * from reviews;
select * from shipments;
select * from suppliers;

-- COUNT ALL TABLES ROWS --
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM payment;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM reviews;
SELECT COUNT(*) FROM shipments;
SELECT COUNT(*) FROM suppliers;


-- DATA CLEANING --

-- NULL VALUES CHECK --
-- check NULL customers
select
sum(customer_id is null) as null_customer_id,
sum(first_name is null) as null_first_name,
sum(last_name is null) as null_last_name,
sum(address is null) as null_address,
sum(email is null) as null_email,
sum(phone_number is null) as null_phone_number
from customers;

-- check NULL order_items
select
sum(order_item_id is null) as null_order_item_id,
sum(order_id is null) as null_order_id,
sum(product_id is null) as null_product_id,
sum(quantity is null) as null_quantity,
sum(price_at_purchase is null) as null_price_at_perchase
from order_items;

-- check NULL orders
select
sum(order_id is null) as null_order_id,
sum(order_date is null) as null_order_date,
sum(customer_id is null) as null_customer_id,
sum(total_price is null) as null_total_price
from orders;

-- check NULL payment
select
sum(payment_id is null) as null_payment_id,
sum(order_id is null) as null_order_id,
sum(payment_method is null) as null_payment_method,
sum(amount is null) as null_amount,
sum(transaction_status is null) as null_transaction_status
from payment;

-- check NULL products
select
sum(product_id is null) as null_product_id,
sum(product_name is null) as null_product_name,
sum(category is null) as null_category,
sum(price is null) as null_price,
sum(supplier_id is null) as null_supplier_id
from products;

-- check NULL reviews
select
sum(review_id is null) as null_review_id,
sum(product_id is null) as null_product_id,
sum(customer_id is null) as null_customer_id,
sum(rating is null) as null_rating,
sum(review_text is null) as null_review_text,
sum(review_date is null) as null_review_date
from reviews;

-- check NULL shipments
select
sum(shipment_id is null) as null_shipment_id,
sum(order_id is null) as null_order_id,
sum(shipment_date is null) as null_shipment_date,
sum(carrier is null) as null_carrier,
sum(tracking_number is null) as null_tracking_number,
sum(delivery_date is null) as null_delivery_date,
sum(shipment_status is null) as null_shipment_status
from shipments;

-- check NULL suppliers
select
sum(supplier_id is null) as null_supplier_id,
sum(supplier_name is null) as null_supplier_name,
sum(contact_name is null) as null_contact_name,
sum(address is null) as null_address,
sum(phone_number is null) as null_phone_number,
sum(email is null) as null_email
from suppliers;

-- FOREIGN KEY RELATIONSHIP VALIDATION --

-- CHECK ORDERS TO CUSTOMERS RELATIONSHIP
select count(*) as invalid_customer_references
from orders o
left join customers c
    on o.customer_id = c.customer_id
where c.customer_id is null;

-- CHECK ORDER ITEMS TO ORDERS RELATIONSHIP
select count(*) as invalid_order_references
from order_items oi 
left join orders o on
oi.order_id=o.order_id
where o.order_id is null;

-- CHECK ORDER ITEMS TO PRODUCTS RELATIONSHIP
select count(*) as invalid_product_references
from order_items oi
left join products p
on oi.product_id=p.product_id
where p.product_id is null;

 -- CHECK PAYMENT TO ORDERS RELATIONSHIP
 select count(*) as invalid_order_references
 from payment p
 left join orders o
 on p.order_id=o.order_id
 where o.order_id is null;
 
 -- CHECK PRODUCT TO SUPPLIERS RELATIONSHIP
 select count(*) as invalid_supplier_references
 from products p
 left join suppliers s 
 on p.supplier_id=s.supplier_id
 where s.supplier_id is null;
 
 -- CHECK REVIEWS TO PRODUCTS RELATIONSHIP
 select count(*) as invalid_product_references
 from reviews r
 left join products p 
 on r.product_id=p.product_id
 where p.product_id is null;
 
 -- CHECK REVIEWS TO CUSTOMERS RELATIONSHIP
 select count(*) as invalid_customer_references
 from reviews r 
 left join customers c 
 on r.customer_id=c.customer_id
 where c.customer_id is null;
 
 --  CHECK SHIPMENTS TO ORDERS RELATIONSHIP
 select count(*) as invalide_order_references
 from shipments s 
 left join orders o 
 on s.order_id=o.order_id
 where o.order_id is null;
 
 
 
-- DATA QUALITY CHECK --

-- Check for invalid product prices
select count(*) as invalid_product_prices
from products
where price <= 0;


-- Check for invalid order item quantities
select count(*) as invalid_quantities
from order_items
where quantity <= 0;


-- Check for invalid purchase prices
select count(*) as invalid_purchase_prices
from order_items
where price_at_purchase <= 0;


-- Check for invalid order total prices
select count(*) as invalid_order_prices
from orders
where total_price <= 0;


-- Check for invalid payment amounts
select count(*) as invalid_payment_amounts
from payment
where amount <= 0;


-- VIEW INVALID PURCHASE PRICE RECORDS --
select * from order_items where price_at_purchase <= 0;


-- CHECK CORRECT PRODUCT PRICES --
select 
    oi.order_item_id,
    oi.product_id,
    oi.price_at_purchase,
    p.price as current_product_price
from order_items oi
join products p
    on oi.product_id = p.product_id
where oi.price_at_purchase <= 0;


-- FIX INVALID PURCHASE PRICES --
update order_items oi
join products p
    on oi.product_id = p.product_id
set oi.price_at_purchase = p.price
where oi.price_at_purchase <= 0;


-- CHECK INVALID RATINGS --
select count(*) as invalid_ratings
from reviews
where rating < 1 or rating > 5;


-- CHECK INVALID ORDER DATES --
select count(*) as invalid_dates
from orders
where order_date is null;

-- CHECK INVALID REVIEWS DATES --
select count(*) as invalid_dates
from reviews
where review_date is null;

-- CHECK INVALID SHIPMENT AND DELIVERY DATES --
select count(*) as invalid_delivery_dates
from shipments
where delivery_date<shipment_date;


-- DATA ANALYSIS --

-- OVERALL BUSINESS OVERVIEW
select
count(*) as total_orders,
count(distinct customer_id) as total_customers,
sum(total_price) as total_revenue,
avg(total_price) as average_order_value,
min(order_date) as first_order_date,
max(order_date) as last_order_date
from orders;

-- OVERALL PRODUCT, SUPPLIER AND REVIEW OVERVIEW
select
(select count(*)from products) as total_products,
(select count(*)from suppliers) as total_suppliers,
(select count(*)from reviews) as total_reviews,
(select round(avg(rating), 2) from reviews) as average_rating,
(select count(distinct category) from products) as total_categories;

-- CATEGORY-WISE SALES AND REVENUE ANALYSIS
select
p.category,
round(sum(oi.quantity * oi.price_at_purchase), 2) as total_revenue,
sum(oi.quantity) as total_unit_sold,
count(distinct oi.order_id) as total_orders
from order_items oi
inner join products p 
on oi.product_id=p.product_id
group by p.category
order by total_revenue desc;

-- TOP 10 PRODUCTS BY REVENUE
select
p.product_id,
p.product_name,
p.category,
round(sum(oi.quantity * oi.price_at_purchase), 2) as total_revenue,
sum(oi.quantity) as total_unit_sold
from order_items oi
inner join products p 
on oi.product_id=p.product_id
group by p.product_id, p.product_name, p.category
order by total_revenue desc
limit 10;

-- TOP 10 CUSTOMERS BY TOTAL SPENDING
select * from customers;
select * from orders;
select 
c.customer_id,
c.first_name,
c.last_name,
round(sum(o.total_price), 2) as total_spending,
count(o.order_id) as total_orders
from customers c 
inner join orders o 
on c.customer_id=o.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_spending desc
limit 10;

-- CUSTOMER ORDER FREQUENCY ANALYSIS
select
c.customer_id,
c.first_name,
c.last_name,
count(o.order_id) as total_orders
from customers c 
inner join orders o 
on c.customer_id=o.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_orders desc;

-- CUSTOMERS WITH NO ORDERS
select
c.customer_id,
c.first_name,
c.last_name
from customers c 
left join orders o 
on c.customer_id=o.customer_id
where o.order_id is null;

-- MONTHLY REVENUE TREND
select 
date_format(order_date, '%y-%m') as month,
round(sum(total_price), 2) as total_revenue,
count(order_id) as total_orders
from orders
group by date_format(order_date, '%y-%m')
order by month;


-- MONTH-OVER-MONTH REVENUE GROWTH
with monthly_revenue as (
select
date_format(order_date, '%Y-%m') as month,
sum(total_price) as total_revenue
from orders
group by date_format(order_date, '%Y-%m')
)

select
    month,
round(total_revenue, 2) as total_revenue,
round(lag(total_revenue) over (order by month),2) as previous_month_revenue,
round( total_revenue - lag(total_revenue) over (order by month),2) as revenue_change,
round(
        (
            total_revenue
            - lag(total_revenue) over (order by month)
        ) / lag(total_revenue) over (order by month) * 100,
        2
    ) as revenue_growth_percentage
from monthly_revenue
order by month;

-- TOP 5 REVENUE MONTHS
select 
date_format(order_date, '%y-%m') as month,
round(sum(total_price), 2) as total_revenue,
count(order_id) as total_orders
from orders
group by date_format(order_date, '%y-%m')
order by total_revenue desc
limit 5;

-- PAYMENT METHOD-WISE REVENUE ANALYSIS
select
   p.payment_method,
    round(sum(p.amount), 2) as total_revenue,
    count(distinct p.order_id) as total_orders,
    round(avg(p.amount), 2) as average_order_value
from payment p
inner join orders o
    on p.order_id = o.order_id
group by p.payment_method
order by total_revenue desc;

-- PAYMENT STATUS ANALYSIS
select
transaction_status,
count(*) as total_transactions,
round(sum(amount), 2) as total_amount,
round(avg(amount), 2) as average_transaction_amount
from payment
group by transaction_status
order by total_transactions desc;

-- PRODUCT CATEGORY PERFORMANCE ANALYSIS
select
p.category,
count(distinct p.product_id) as total_products,
round(avg(p.price), 2) as average_product_price,
round(sum(oi.quantity * oi.price_at_purchase), 2) as total_revenue,
sum(oi.quantity) as total_unit_sold
from products p 
inner join order_items oi
on p.product_id=oi.product_id
group by p.category 
order by total_revenue desc;

-- PRODUCTS WITH NO SALES
select * from products;
select
p.product_id,
p.product_name,
p.category,
p.price
from products p 
left join order_items oi
on p.product_id=oi.product_id
where oi.order_item_id is null;

-- SUPPLIER PERFORMANCE ANALYSIS
select
    s.supplier_id,
    s.supplier_name,
    count(distinct p.product_id) as total_products_supplied,
    round(sum(oi.quantity * oi.price_at_purchase), 2) as total_revenue,
    sum(oi.quantity) as total_units_sold
from suppliers s
inner join products p
    on s.supplier_id = p.supplier_id
inner join order_items oi
    on p.product_id = oi.product_id
group by s.supplier_id, s.supplier_name
order by total_revenue desc;

-- TOP 10 SUPPLIERS BY REVENUE
select
    s.supplier_id,
    s.supplier_name,
    round(sum(oi.quantity * oi.price_at_purchase), 2) as total_revenue,
    sum(oi.quantity) as total_units_sold
from suppliers s
inner join products p
    on s.supplier_id = p.supplier_id
inner join order_items oi
    on p.product_id = oi.product_id
group by s.supplier_id, s.supplier_name
order by total_revenue desc
limit 10;

-- PRODUCT RATING ANALYSIS
select
p.product_id,
p.product_name,
p.category,
count(r.review_id) as total_reviews,
round(avg(r.rating), 2) as average_rating
from products p 
inner join reviews r 
on p.product_id=r.product_id
group by p.product_id, p.product_name, p.category
order by average_rating desc, total_reviews desc;

-- CATEGORY-WISE AVERAGE RATING ANALYSIS
select
p.category,
count(r.review_id) as total_reviews,
round(avg(r.rating), 2) as average_rating
from products p 
inner join reviews r 
on p.product_id=r.product_id
group by p.category 
order by average_rating desc;

-- PRODUCTS WITH NO REVIEWS
select
p.product_id,
p.product_name,
p.category,
p.price
from products p 
left join reviews r 
on p.product_id=r.product_id
where r.review_id is null;

-- CUSTOMER REVIEW ANALYSIS
select
c.customer_id,
c.first_name,
c.last_name,
count(r.review_id) as total_review_given,
round(avg(r.rating), 2) as average_rating_given
from customers c 
inner join reviews r 
on c.customer_id=r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_review_given desc, average_rating_given desc;

-- SHIPMENT PERFORMANCE ANALYSIS
select
shipment_status,
count(*) as total_shipments
from shipments
group by shipment_status 
order by total_shipments desc;

-- CARRIER PERFORMANCE ANALYSIS
select
carrier,
    count(*) as total_shipments,
    sum(
        case
            when shipment_status = 'Delivered' then 1
            else 0
        end
) as delivered_shipments
from shipments
group by carrier
order by total_shipments desc;

-- AVERAGE DELIVERY TIME ANALYSIS
select
round(avg(datediff(delivery_date, shipment_date)),2) as average_delivery_days,
min(datediff(delivery_date, shipment_date)) as fastest_delivery_days,
min(datediff(delivery_date, shipment_date)) as slowest_delivery_days
from shipments
where delivery_date is not null
and shipment_date is not null;
  
  -- DETAILED SHIPMENT STATUS ANALYSIS
 select
shipment_status,
count(*) as total_shipments,
round(count(*) * 100.0 / (select count(*) from shipments),2) as shipment_percentage
from shipments
group by shipment_status
order by total_shipments desc; 

-- RANK PRODUCT CATEGORIES BY REVENUE
with category_revenue as (
select
p.category,
round(sum(oi.quantity * oi.price_at_purchase), 2) as total_revenue
from products p
inner join order_items oi
on p.product_id = oi.product_id
group by p.category)

select
category,
total_revenue,
rank() over ( order by total_revenue desc ) as revenue_rank
from category_revenue;

-- TOP 3 PRODUCTS IN EACH CATEGORY BY REVENUE
with product_revenue as (
select
p.product_id,
p.product_name,
p.category,
round(sum(oi.quantity * oi.price_at_purchase),2) as total_revenue
from products p
inner join order_items oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name, p.category),

ranked_products as (
select
product_id,
product_name,
category,
total_revenue,
rank() over ( partition by category order by total_revenue desc ) as product_rank
from product_revenue
)

select
product_id,
product_name,
category,
total_revenue,
product_rank
from ranked_products
where product_rank <= 3
order by
category,
product_rank;
    
-- CUSTOMER SPENDING RANKING
with customer_spending as (
select
c.customer_id,
c.first_name,
c.last_name,
round(sum(o.total_price), 2) as total_spending
from customers c
inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name)

select
customer_id,
first_name,
last_name,
total_spending,
rank() over ( order by total_spending desc ) as spending_rank
from customer_spending
order by spending_rank;

-- CUSTOMER SEGMENTATION BY TOTAL SPENDING
with customer_spending as (
select
c.customer_id,
c.first_name,
c.last_name,
round(sum(o.total_price), 2) as total_spending
from customers c
inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name)

select
customer_id,
first_name,
last_name,
total_spending,
case
	when total_spending >= 1000 then 'High Value Customer'
	when total_spending >= 500 then 'Medium Value Customer'
	else 'Low Value Customer'
end as customer_segment
from customer_spending
order by total_spending desc;