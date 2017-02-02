Select ordNumber, totalUSD from Orders;

Select name, city from Agents
where name = 'Smith';

Select pid, name, priceUSD from Products 
where quantity > 200100;

select name, city from Customers
where city = 'Duluth';

select name from Agents
where city <> 'New York' and city <> 'Duluth';

select * from Products
where city <> 'Dallas' and city <> 'Duluth' and priceUSD >= 1;

select * from Orders
where month = 'Feb' or month = 'May';

select * from Orders
where month = 'Feb' and totalUSD >= 600;

select * from Orders 
where cid = 'C005';
