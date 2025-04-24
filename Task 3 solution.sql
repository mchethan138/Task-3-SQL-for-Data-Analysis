-- Use SELECT, WHERE, ORDER BY, GROUP BY
select * from customers;
select * from customers
	where country ilike 'germany'
	order by postal_code asc;

select * from employees;
select concat_ws(',',first_name,last_name) from public.employees
	where birth_date > '01-01-1960' and hire_date > '01-01-1994'
	order by first_name desc;

--Use JOINS (INNER, LEFT, RIGHT)
select orders.order_id, 
	customers.contact_name,
	employees.first_name || ' ' ||employees.last_name as "Employee Name"
from orders
join customers ON orders.customer_id = customers.customer_id
join employees ON orders.employee_id = employees.employee_id;

select products.product_id, products.product_name, suppliers.company_name
from products
left join suppliers ON products.supplier_id = suppliers.supplier_id;

select products.product_id, products.product_name, suppliers.company_name
from products
right join suppliers ON products.supplier_id = suppliers.supplier_id;

select 
  employees.employee_id, 
  employees.first_name || ' ' ||employees.last_name as "Employee Name",
  orders.order_id,
  customers.contact_name as "customer name"
from employees
left join orders on employees.employee_id = orders.employee_id
right join customers ON orders.customer_id = customers.customer_id;

--Write subqueries
select * from customers
where customer_id not in (
  select distinct customer_id from orders
);

-- Use aggregate functions (SUM, AVG) with groupby
select 
  customers.contact_name, 
  sum(order_details.unit_price * order_details.quantity) as "total revenue"
from customers
join orders on customers.customer_id = orders.customer_id
join order_details on orders.order_id = order_details.order_id
group by customers.contact_name
order by 2 desc;

--Create views for analysis
create view top_products as
select products.product_name,sum(order_details.quantity) as "total sold"
from order_details
join products on order_details.product_id = products.product_id
group by products.product_name
ORDER BY 1 desc
limit 5;

select * from top_products;


