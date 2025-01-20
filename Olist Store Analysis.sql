create database olist_store_analysis;
use olist_store_analysis;

#FIRST KPI
#Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics

select 
case when dayname(o.order_purchase_timestamp) in ("Saturday","Sunday") then "Weekend"
else "Weekday" 
end as Weekday_Weekend,
round(sum(p.payment_value))  as Total_Payment 
from olist_orders as o join olist_order_payment as p
on o.order_id=p.order_id
group by Weekday_Weekend;



# SECOND KPI
#Number of Orders with review score 5 and payment type as credit card.

select p.payment_type,r.review_score as review_score,concat(round(count(o.order_id)/1000),"k")as order_id 
from olist_order_payment as p join olist_orders as o
on p.order_id=o.order_id  join olist_order_reviews as r 
on o.order_id=r.order_id 
where payment_type = "credit_card" and review_score = 5 ;


#THIRD KPI
#Average number of days taken for order_delivered_customer_date for pet_shop

select p.product_category_name, 
round(avg(datediff(o.order_delivered_customer_date,o.order_purchase_timestamp)))as Order_delivered_Date 
from olist_orders as o join olist_order_items as i 
on o.order_id=i.order_id 
join olist_products as p 
on i.product_id=p.product_id 
where product_category_name = "pet_shop"; 

#FOURTH KPI 
#Average price and payment values from customers of sao paulo city

select c.customer_city as City  , round(avg(i.price),0) as Average_price, round(avg(p.payment_value),0) as Average_paymentvalue
from olist_customers as c join olist_orders as o 
on c.customer_id=o.customer_id
join olist_order_items as i 
on o.order_id=i.order_id 
join olist_order_payment as p
on i.order_id=p.order_id 
where customer_city = "sao paulo";



#FIFTH KPI 
#Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.

select r.review_score, round(avg(datediff(o.order_delivered_customer_date,o.order_purchase_timestamp)))as Shipping_days 
from olist_orders as o join olist_order_reviews as r
on o.order_id=r.order_id
group by review_score
order by review_score;






