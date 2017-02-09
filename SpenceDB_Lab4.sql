--1.
Select city from Agents
Where aid in (
select aid from Orders
Where cid = 'c006'
);

--2.
Select Distinct pid from Orders
Where aid in (
	Select aid from Orders
	where cid in (
		select cid from Customers
		where city = 'Kyoto'
		)
	)
Order by pid DESC;

--3.
Select cid, name from Customers
Where cid  not in (
Select cid from Orders
where aid = 'a01'
);

--4.
Select Distinct cid from Orders
where pid = 'p01' and cid in (
Select cid from Orders
where pid = 'p07'
);

--5.
--Selects pids that are in orders but not ordered by a customer who ordered from a08.
--Also selects pids that are not in orders, so were not ordered by a customer
--who ordered from a08.
Select pid from Products where
pid in (
	Select Distinct pid from Orders where
	cid not in (
		Select cid from Orders
		where aid = 'a08'
		) 
) or pid not in (
	Select Distinct pid from Orders
)
Order by pid DESC;

--6.
Select name, discount, city From Customers
Where cid in (
Select cid From Orders
Where aid in(
Select aid from Agents
Where city = 'Tokyo' or city = 'New York'
)
);

--7.
Select * from Customers
Where discount in (
Select discount from Customers
Where city = 'Duluth' or city = 'London'
);

--8.
/*Check constraints allow the content of a data field to be limited beyond its type.
For example, a column could be labeled as an int, but a check constrain could further
limit what value of int it can be. For example, if you wanted a column to never have
negative values of ints, than you can do that using the check constrain, as it prevents
incorrect values from inserting into the database.

The benefit of putting this in the database is so that once the constraint
has been put in, the database will prevent the constraint from being violated,
by preventing noncompliant data from inserting into the database.

A good use of a check constraint would be for a lap time at a racetrack.
The time, an int, should be prevented from being less than or equal to 0, as that
time would be impossible. Therefore, if all laptimes should be greater than 0, a
check constraint should be put into place to ensure only valid data is entered.

I think that there could be many bad uses for a check constraint, as they could
restrict inserting data which is not erroneous or incorrect. An example of this
would be a column measuring temperature, with an int. I could restrict the values
entered to be from -100 to 200, in degrees fahrenheit. However, a reading of -110
degrees would be prevented from being inserted, even though it is a valid temperature.
P.S. The coldest temperature recorded was -128.6 degrees Fahrenheit.
*/

