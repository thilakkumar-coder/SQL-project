create database Sales;
use Sales;

create table Customers
(Customer_Id int primary key,Name varchar(40),City varchar(40));

create table Orders
(Order_Id int primary key,Customer_Id int,Order_Date date,Amount int,foreign key (Customer_Id) references Customers(Customer_Id));

create table Products
(Product_Id int primary Key,Product_Name varchar(40),Category varchar(30),Price int);

create table Oredr_items
(Order_item_id int primary key,Order_Id int,Product_Id int,Quantity int,
foreign key(Order_Id) references Orders(Order_Id),foreign key(Product_Id)references Products(Product_Id));

alter table Customers rename column Name to Customer_Name;
select * from Customers;
insert into Customers(Customer_Id,Customer_Name,City) values
(01,'Thilak','Dindigul'),
(02,'Kumar','Chennai'),
(03,'Surya','Madurai'),
(04,'Siva','Chennai'),
(05,'Harish','Coimbatore');

insert into Orders(Order_Id,Customer_Id,Order_Date,Amount) values
(11,01,'2025-12-10',65000),
(12,02,'2026-05-22',82550),
(13,03,'2026-02-14',53500),
(14,04,'2025-10-05',100000),
(15,05,'2025-8-19',98000);

insert into Products(Product_Id,Product_Name,Category,Price) values
(101,'Laptop','Electronics',25000),
(102,'Mouse','Electronics',6200),
(103,'Desk','Furniture',45000),
(104,'Printer','Electronics',15550),
(105,'Chair','Furniture',12520);

insert into Oredr_items(Order_item_id,Order_Id,Product_Id,Quantity) values
(111,11,101,4),
(112,12,102,12),
(113,13,103,2),
(114,14,104,9),
(115,15,105,8);

alter table Customers add Email varchar(40);
alter table customers modify Customer_Name varchar(100);
select * from Customers;
select distinct City from Customers;
select * from Customers where City='Chennai';
select * from Customers order by Customer_Name;
select * from Customers limit 3;
select * from Customers where Customer_Name like 'S%';
select Order_Id,Amount from Orders where Amount between 80000 and 100000;
select Customer_Id,Customer_Name from Customers where City in('Dindigul','Coimbatore');
select count(*) as Number_of_Customers from Customers;
select sum(Quantity) as Total_Sales from Oredr_items;
select sum(Amount) As Total_Sales from Orders;
select avg(Amount) as Average_Amount from Orders;
select min(Amount) as Minimum,max(Amount) as Maximum from Orders;
select Customer_Id,sum(Amount) from Orders group by Customer_Id;
select Customer_Id,sum(Amount) from Orders group by Customer_Id having sum(Amount) > 80000;

select c.Customer_Name,o.Order_Id
from Customers c
inner join Orders o on c.Customer_Id=o.Customer_Id;

select c.Customer_Name,o.Order_Id,c.City
from Customers c
left join Orders o on c.Customer_Id=o.Customer_Id;

select c.Customer_Name,o.Order_Id,c.City
from Customers c
right join Orders o on c.Customer_Id=o.Customer_Id;

select c.Customer_Name,o.Order_Id,c.City
from Customers c
left join Orders o on c.Customer_Id=o.Customer_Id
	union
select c.Customer_Name,o.Order_Id,c.City
from Customers c
right join Orders o on c.Customer_Id=o.Customer_Id;


select Order_Id,Product_Id,Quantity,row_number()over(order by Quantity Desc) as row_num from Oredr_items ;

select Customer_Id, rank() over (order by Amount Desc) as Rank_num from Orders;

select Customer_Id,Customer_Name,City, dense_rank() over (partition by city) as City_Rank from Customers;