--1.
Select Agents.city from Agents, Orders
Where Agents.aid = Orders.aid and Orders.cid = 'c006';

--2.
--Currently returns three aid of agents who took orders from a customer in Kyoto.
Select Distinct Orders.aid
from Orders
inner join Customers on Customers.city = 'Kyoto' and
Customers.cid = Orders.cid;

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