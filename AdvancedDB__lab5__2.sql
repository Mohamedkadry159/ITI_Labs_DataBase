SELECT top(2)*from Sales.SalesOrderHeader

--1
select s.SalesOrderID, s.ShipDate   from Sales.SalesOrderHeader s
where (s.ShipDate > '2002-07-28' and s.ShipDate < '2014/07/29')
--2
select p.ProductID , p.Name from Production.Product p
where p.StandardCost < 110
--3
select p.ProductID , p.Name from Production.Product p
where  p.Weight is null
--4
select p.Name, p.Color  from Production.Product p
where p.Color in ('Silver','Black','Red')
--5
select p.Name   from Production.Product p
where LEFT(p.Name ,1) = 'B'
--6
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3
select  * from Production.ProductDescription p
where p.Description like '%\_%' escape '\'
--7
select sum(s.TotalDue) , s.OrderDate 
from Sales.SalesOrderHeader s
group by s.OrderDate 
having s.OrderDate >'7/1/2001' and s.OrderDate<'7/31/2014'
--8
select distinct(e.HireDate) from HumanResources.Employee e
--9
select avg( isnull(p.ListPrice,0) ) from Production.Product p
--10
select  concat('the',' ', p.Name ,' ','is only', p.ListPrice) result from Production.Product p
where p.ListPrice > 100 and p.ListPrice <120 
order by p.ListPrice
--11
-- creating new table 
create table store_Archive (
    rowguid uniqueidentifier,
    Name nvarchar(100),
    SalesPersonID int,
    Demographics xml
)
-- insert into new table
insert into store_Archive (rowguid, Name, SalesPersonID, Demographics)
select rowguid, Name, SalesPersonID, Demographics
from Sales.Store
--knowing how many rows
select count(*)  
from store_Archive
-- viweing data in new table 
select top(5) * from store_Archive

--12
select convert(varchar, getdate(), 101) datee
union
select convert(varchar, getdate(), 103) datee
union
select convert(varchar, getdate(), 104) datee
union
select convert(varchar, getdate(), 105) datee
-- formate
union
select format(getdate(), 'dddd, MMMM dd, yyyy') datee
union
select format(getdate(), 'yyyy-MM-dd HH:mm:ss') datee
union
select format(getdate(), 'hh:mm tt') AS datee
union
select format(getdate(), 'HH:mm:ss') AS datee













































































--kfjdifk