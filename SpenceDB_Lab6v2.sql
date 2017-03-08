--1.
Select Customers.name, Customers.city from Customers 
inner join (
Select city, count(city)as count
from Products
group by city
order by count DESC
limit 1) tbl on tbl.city = Customers.city;

--2.
Select name from products
where priceUSD > (
Select avg(priceUSD) from Products)
order by name desc;

--3.
Select Customers.name, Orders.pid, sum(Orders.totalUsd) from Orders
inner join Customers on Customers.cid = Orders.cid
group by Orders.pid, Customers.name
Order By sum(totalUsd) ASC; 

--4.
--does not use coalesce yet
Select Customers.name, sum(Orders.totalUSD) from Orders, Customers
where Orders.cid = Customers.cid
group by Orders.cid, Customers.name
order by Customers.name;

--5.
Select Customers.name, Products.name, Agents.name from Agents,
Customers, Products, Orders
where Customers.cid = Orders.cid
and Agents.aid = Orders.aid and Products.pid = Orders.pid
and Agents.city = 'Newark';

--6.
Select Orders.OrdNumber, round((Orders.qty * Products.priceUSD
* (100 - Customers.Discount)/100)::numeric, 2) as confirmedTotal, Orders.totalUSD
from Orders, Products, Customers
where Products.pid = Orders.pid
and Customers.cid = Orders.cid
	
--7.
/*Imagine tables A and B. A left outer join would return everything in table A,
and any matching rows in table B. A right outer join would include all rows in B,
with any matching rows in table A. left and right join perform the same operations,
but in the opposite way.*/