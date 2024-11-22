-- 1.	Find all suppliers who supply a beverage (category).
select distinct CompanyName 
from suppliers s
inner join products p
	on p.SupplierID = s.SupplierID
inner join Categories c
	on c.CategoryID = p.CategoryID
		and CategoryName = 'Beverages';
		
-- 2.	Find suppliers (print supplier companyname and region) who supplied both condiments and confections (categories).
select distinct CompanyName, Region 
from suppliers s
inner join products p
	on p.SupplierID = s.SupplierID
inner join Categories c
	on c.CategoryID = p.CategoryID
		and CategoryName in ('Condiments','Confections');
		
-- 3.	Find all orders (print only orderId, orderdate, Product Name) by customer “Piccolo und mehr” through the employee named  “Michael Suyama”.
select o.OrderID,o.OrderDate,p.ProductName
from Orders o
inner join "Order Details" od
	on od.OrderID = o.OrderID
inner join Products p
	on p.ProductID = od.ProductID
inner join Customers c
	on c.CustomerID = o.CustomerID
		and c.CompanyName = 'Piccolo und mehr'
inner join Employees e
	on e.EmployeeID = o.EmployeeID
		and (e.FirstName = 'Michael' and e.LastName = 'Suyama')
limit 5;
		
-- 4.	Count the number of shipments handled by each shipping company. What if you group by year?
-- Part 1: shipping company only
select CompanyName,count(distinct(o.OrderID)) as order_count
from orders o
inner join Shippers s
	on s.ShipperID = o.ShipVia
group by 1;


-- Part 2: By shipping company, year
select strftime('%Y',OrderDate) as order_yr, s.CompanyName,count(distinct(o.OrderID)) as order_count
from orders o
inner join Shippers s
	on s.ShipperID = o.ShipVia
group by 1,2
order by 1,3;