-- 1. Top 3 Customers based on orders
select
c.first_name,
c.last_name,
sum(o.total_amount) total_order_amount
from Customers as c
join Orders o ON o.customer_id
group by c.customer_id
order by total_order_amount desc
limit 3
;

-- 2. Average order value for each customer
select
c.first_name,
c.last_name,
avg(o.total_amount) average_order
from Customers c
join Orders o on c.customer_id = o.customer_id
group by c.customer_id
;

-- 3. Employees with >4 resolved ticket support
select
e.first_name,
e.last_name,
count(s.ticket_id)
from Employees e
join SupportTickets s on e.employee_id = s.employee_id
where s.status = 'resolved'
group by e.employee_id
having count(s.ticket_id)>4
;

-- 4. Product that have never been ordered
select
products.product_name
from products
left join orderdetails od on od.product_id = products.product_id
where od.order_id is null
;

-- 5. Total revenue
select
sum(quantity*unit_price)
from orderdetails
;

-- 6. Average price by product category
with cte_avg_price as (
select category, avg(price) average
from products
group by category
)
select * from cte_avg_price where average>500
;

-- 7. Customers who have ordered more than 1000
select * 
from customers
where
customer_id in
(select customer_id
from orders
where total_amount>1000
)
;