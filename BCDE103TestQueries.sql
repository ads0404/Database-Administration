FROM [NORTHWND];

--- QUERY 1

SELECT Firstname, Lastname, Address, City, Region, Country
FROM Employees
WHERE Country = 'USA'

---QUERY 2

SELECT CompanyName, ContactName, City
FROM Suppliers
ORDER BY CompanyName

---Query 3

SELECT OrderID, CustomerID, OrderDate
FROM orders
WHERE OrderDate > '1997-12-31'

---Query 4

SELECT Firstname, Lastname, City, HireDate
FROM Employees
WHERE Lastname LIKE 'D%'

---Query 5

SELECT * FROM Products
WHERE ProductID = 1 AND UnitsInStock >0

---Query 6

SELECT Firstname, Lastname, Address, City, Region, ShipCountry
FROM Employees
INNER JOIN Orders
ON
Orders.EmployeeID = Employees.EmployeeID
WHERE ShipCountry = 'Belgium'

---Query 7
SELECT ProductName, UnitsInStock, UnitsOnOrder
FROM Products
WHERE UnitsInStock < UnitsOnOrder
ORDER BY ProductName

---Query 8

SELECT ProductName, CategoryID, UnitPrice, UnitsInStock, (UnitPrice*UnitsInStock) AS 'Total value of Products in Stock'
FROM Products

---Query 9

SELECT concat (FirstName, ' ',LastName) as "Full Name", City
FROM Employees
WHERE City LIKE 'S%' OR City LIKE 'T%'

---Query 10. Give a list of customers (show the company names) along with the number of orders they have placed. (The query returns 89 records.)

SELECT ContactName, CompanyName, Quantity
FROM Customers
INNER JOIN Orders ON Orders.CustomerID = Customers.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID

---Query 11

SELECT LastName,FirstName, TerritoryDescription, RegionDescription
FROM Employees
INNER JOIN EmployeeTerritories ON EmployeeTerritories.EmployeeID = Employees.EmployeeID
INNER JOIN Territories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
INNER JOIN Region ON Region.RegionID = Territories.RegionID
ORDER BY LastName, FirstName ASC

---Query 12	Give a list of employees who report to the Vice President, Sales. Show their ID, first name, and last name. Hint: a table can be joined to itself

SELECT

---Query 13.Give the product names of all products shipped by United Package. Each product’s name should appear only once in the list.

SELECT ProductName, CompanyName
FROM Products
INNER JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
INNER JOIN Orders ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Shippers ON Shippers.ShipperID = Orders.OrderID
WHERE CompanyName = 'United Package'



---Query 14.List the country names and the number of customers in each country. Order them by descending order of number of customers.

SELECT Country,
 COUNT(CustomerID) AS 'Number of Customers'
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC



---Query 15.List the product categories and the average price of products in each of those categories.	(3 Marks)

SELECT CategoryName, AVG(UnitPrice) AS 'Average Price'
FROM Products
INNER JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName
ORDER BY CategoryName ASC, AVG(UnitPrice)





---Query 16.Give the first name, last name, and city for employees who have sold to customers who live in the same city as they (the employees) do. Employee names should not appear more than once in the list.	(3 Marks)



---Query 17.For all products which are Condiments (a category), display the product name, and the company name of the supplier.	(3 Marks)
---Query 18.Give the ID and the company name of the suppliers that supply more than three products. Also give the number of products that they supply (labelled as “No. of Products” in the output).	(4 Marks)
---Query 19.Give the company names of customers who have made more than 10 orders. Also show the number of orders. Sort the list by the number of orders, with the highest number first.	(4 Marks)
---Query 20.Give the first and last names of employees, the customer’s company name, contact name, and city and the shipper’s company name (renamed as ‘Shipper Name’) for orders that are sent by the company ‘Speedy Express’ to customers in Bruxelles (which is a city).	(4 Marks)
---Query 21.Give the title, first name, and last name of employees who have sold at least one of the products ‘Gravad Lax’ or ‘Mishi Kobe Niku’. Names should not be repeated if they have sold both or one item twice.





