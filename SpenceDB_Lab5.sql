--1.
Select Agents.city from Agents, Orders
Where Agents.aid = Orders.aid and Orders.cid = 'c006';

--2.
Select Distinct Orders.pid
from Orders
inner join (Orders Orders2 inner join Customers on
Customers.city = 'Kyoto' and Customers.cid = Orders2.cid) on 
Orders.aid = Orders2.aid
Order by pid DESC;

--3.
Select Distinct Customers.name from Customers, Orders
where Customers.cid not in (
Select Customers.cid
from Customers, Orders
where Orders.cid = Customers.cid);

--4.
Select Distinct Customers.name from Customers
left outer join Orders on Customers.cid = Orders.cid
where Orders.cid IS null;

--5.
Select Distinct Customers.name, Agents.name
From Orders
inner join Customers on Customers.cid = Orders.cid
inner join Agents on Agents.aid = Orders.aid
where customers.city = agents.city; 

--6.
Select Distinct Customers.name, Agents.name, Customers.city
from Customers,
Agents inner join Orders on Orders.aid = Agents.aid,
Orders o inner join Customers  c on o.cid = c.cid
where Customers.city = Agents.city;

--7.
Select Customers.name, Customers.city from Customers 
inner join (
Select city, count(city)as count
from Products
group by city
limit 1) tbl on tbl.city = Customers.city;

