-- remove timeout 
USE [youtube_db] ;  
GO  
EXEC sp_configure 'remote query timeout', 0 ;  
GO  
RECONFIGURE ;  
GO 
-------------------------------

use [leetcode_db]
Create table Sales (sale_id int, product_id int, year int, quantity int, price int)
Create table Product (product_id int, product_name varchar(10))
Truncate table Sales
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000')
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000')
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000')
Truncate table Product
insert into Product (product_id, product_name) values ('100', 'Nokia')
insert into Product (product_id, product_name) values ('200', 'Apple')
insert into Product (product_id, product_name) values ('300', 'Samsung')

select * from Sales
select * from Product


/* Write an SQL query that reports all product names of the products in the Sales 
table along with their selling year and price.*/

select 
	p.product_name as product_name,
    s.year as year,
    s.price as price
from 
	Product p
left join 
	Sales s
on p.product_id = s.product_id
--------------------------------


Create table Sales (sale_id int, product_id int, year int, quantity int, price int)
Create table Product (product_id int, product_name varchar(10))
Truncate table Sales
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000')
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000')
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000')
Truncate table Product
insert into Product (product_id, product_name) values ('100', 'Nokia')
insert into Product (product_id, product_name) values ('200', 'Apple')
insert into Product (product_id, product_name) values ('300', 'Samsung')

select * from Sales
select * from Product

/* Write an SQL query that reports all product names of the products in the Sales 
table along with their selling year and price.*/

select 
	p.product_name as product_name,
    s.year as year,
    s.price as price
from 
	Product p
left join 
	Sales s
on p.product_id = s.product_id

/*Write a SQL query to get the second highest salary from the Employee table.*/
Create table  Employee (Id int, Salary int)

insert into Employee (Id, Salary) values ('1', '100')
insert into Employee (Id, Salary) values ('2', '200')
insert into Employee (Id, Salary) values ('3', '300')
insert into Employee (Id, Salary) values ('6', '300')

select max(salary) from  Employee where Salary not in (select max(salary) from Employee)

select a.salary from 
	(select Id, salary, dense_RANK() over (order by salary desc) as rnk from employee)a
where rnk =2


select salary as SecondHighestSalary
from(select dense_rank() over (order by salary desc) as rank, salary
from employee
) as a
where rank = 2

/*Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking.
Note that after a tie, the next ranking number should be the next consecutive integer value. 
In other words, there should be no "holes" between ranks.*/
Create table Scores (Id int, Score DECIMAL(3,2))
insert into Scores (Id, Score) values ('1', '3.5')
insert into Scores (Id, Score) values ('2', '3.65')
insert into Scores (Id, Score) values ('3', '4.0')
insert into Scores (Id, Score) values ('4', '3.85')
insert into Scores (Id, Score) values ('5', '4.0')
insert into Scores (Id, Score) values ('6', '3.65')

select * from Scores

select 
	Score,
	dense_rank() over(order by score desc) as rank
from 
	Scores
--------------
/*Write an SQL query to find all numbers that appear at least three times consecutively.
Return the result table in any order.
The query result format is in the following example:*/
Create table Logs (Id int, Num int)
insert into Logs (Id, Num) values ('1', '1')
insert into Logs (Id, Num) values ('2', '1')
insert into Logs (Id, Num) values ('3', '1')
insert into Logs (Id, Num) values ('4', '2')
insert into Logs (Id, Num) values ('5', '1')
insert into Logs (Id, Num) values ('6', '2')
insert into Logs (Id, Num) values ('7', '2')
select * from logs
use [leetcode_db]

--method 1
select distinct a.num as ConsecutiveNums
from Logs a join Logs b on a.Id+1=b.Id
join Logs c on b.Id+1 = c.Id
where a.Num = b.Num and b.Num = c.Num

--method 2
select a.num from (
select num, count(num) over (order by id) as cnt from logs) as a
where a.cnt = 3

/*Given the Employee table, write a SQL query that finds out employees who earn more 
than their managers. For the above table, Joe is the only employee who earns more than his manager.*/
Create table Emp (Id int, Nm varchar(255), Salary int, ManagerId int)
insert into Emp (Id, Nm, Salary, ManagerId) values ('1', 'Joe', '70000', '3')
insert into Emp (Id, Nm, Salary, ManagerId) values ('2', 'Henry', '80000', '4')
insert into Emp (Id, Nm, Salary, ManagerId) values ('3', 'Sam', '60000', null)
insert into Emp (Id, Nm, Salary, ManagerId) values ('4', 'Max', '90000', null)

-------------------------
Create table manager (Id int, Nm varchar(255), Salary int, ManagerId int)
insert into manager (Id, Nm, Salary, ManagerId) values ('1', 'Joe', '70000', '3')
insert into manager (Id, Nm, Salary, ManagerId) values ('2', 'Henry', '80000', '4')
insert into manager (Id, Nm, Salary, ManagerId) values ('3', 'Sam', '60000', null)
insert into manager (Id, Nm, Salary, ManagerId) values ('4', 'Max', '90000', null)
use [leetcode_db]
select * from emp

select
	e1.nm as emp_name,
	e2.nm as manager_name,
	e1.Salary as emp_sal,
	e2.Salary as manager_sal
from Emp e1 join emp e2 
	on e2.ID = e1.ManagerId and
	e1.Salary > e2.Salary

/*The Employee table holds the salary information in a year.
Write a SQL to get the cumulative sum of an employee's salary over a period of 3 months but exclude the most recent month.
The result should be displayed by 'Id' ascending, and then by 'Month' descending. */

Create table Employee1 (Id int, Month int, Salary int)
insert into Employee1 (Id, Month, Salary) values ('1', '1', '20')
insert into Employee1 (Id, Month, Salary) values ('2', '1', '20')
insert into Employee1 (Id, Month, Salary) values ('1', '2', '30')
insert into Employee1 (Id, Month, Salary) values ('2', '2', '30')
insert into Employee1 (Id, Month, Salary) values ('3', '2', '40')
insert into Employee1 (Id, Month, Salary) values ('1', '3', '40')
insert into Employee1 (Id, Month, Salary) values ('3', '3', '60')
insert into Employee1 (Id, Month, Salary) values ('1', '4', '60')
insert into Employee1 (Id, Month, Salary) values ('3', '4', '70')
select * from Employee1
use [leetcode_db]
select a.id,a.month,a.cumm_Sal from (
select id, month, salary, sum(salary) over(partition by id order by month) as cumm_Sal ,
max(month) over(partition by id) as last_month
from Employee1) a
where a.month <> a.last_month
order by id, month desc

/* A university uses 2 data tables, student and department, to store data about its students and the departments 
associated with each major.Write a query to print the respective department name and number of 
students majoring in each department for all departments in the department table (even ones with no current students).
Sort your results by descending number of students; if two or more departments have the same number of students, 
then sort those departments alphabetically by department name.*/

CREATE TABLE student (student_id INT,student_name VARCHAR(45), gender VARCHAR(6), dept_id INT)
CREATE TABLE department (dept_id INT, dept_name VARCHAR(255))
insert into student (student_id, student_name, gender, dept_id) values ('1', 'Jack', 'M', '1')
insert into student (student_id, student_name, gender, dept_id) values ('2', 'Jane', 'F', '1')
insert into student (student_id, student_name, gender, dept_id) values ('3', 'Mark', 'M', '2')
insert into department (dept_id, dept_name) values ('1', 'Engineering')
insert into department (dept_id, dept_name) values ('2', 'Science')
insert into department (dept_id, dept_name) values ('3', 'Law')

select * from department 
select * from student

select 
	d.dept_name,
	count(s.student_id) as student_count
from 
	department d
left join 
	student s
on d.dept_id = s.dept_id
group by d.dept_name
order by count(s.student_id) desc, d.dept_name

/*Write a SQL query to delete all duplicate email entries in a table named Person, 
keeping only unique emails based on its smallest Id.*/

create table Person (id int, email varchar(50))
insert into Person (Id, Email) values ('1', 'john@example.com')
insert into Person (Id, Email) values ('2', 'bob@example.com')
insert into Person (Id, Email) values ('3', 'john@example.com')

insert into Person (Id, Email) values ('2', 'abc@efg.com')
insert into Person (Id, Email) values ('1', 'abc@efg.com')

select * from person
use [leetcode_db]
delete from person  
where id in (
select a.id from
(select email,id, row_number() over (partition by email order by email) as row_num from Person)a
where a.row_num > 1)

/*Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned)
each day between "2013-10-01" and "2013-10-03".*/
Create table Trips (Id int, Client_Id int, Driver_Id int, City_Id int, Status varchar(50), Request_at varchar(50))

Truncate table Trips
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03')
insert into Trips (Id, Client_Id, Driver_Id, City_Id, Status, Request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03')
Create table Users (Users_Id int, Banned varchar(50), Role varchar(10))
Truncate table Users
insert into Users (Users_Id, Banned, Role) values ('1', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('2', 'Yes', 'client')
insert into Users (Users_Id, Banned, Role) values ('3', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('4', 'No', 'client')
insert into Users (Users_Id, Banned, Role) values ('10', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('11', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('12', 'No', 'driver')
insert into Users (Users_Id, Banned, Role) values ('13', 'No', 'driver')

select * from Trips
select * from Users
select id,
	sum(case when Status = 'completed' then 1 else 0 end) as completedTrips,
	sum(case when Status like '%cancelled%' then 1 else 0 end) as canceledTrips
from Trips t
where id in (select distinct users_id from users where role = 'driver')
group by id

select Request_at,
cast(ROUND(sum(case when status like '%cancelled%' then 1 else 0 end)*1.0/count(status),2) as float) as cancellation_rate
from Trips
where Request_at between '2013-10-01' and '2013-10-03'
--and Client_Id not in (select distinct Users_Id from Users where banned = 'Yes')
--and Driver_Id not in (select distinct Users_Id from Users where banned = 'Yes')
group by Request_at

select * from trips

select 
cast(round((sum(case when status like '%cancelled%' then 1 else 0 end)*1.0 /count(status) )*100,2) as float) as cancellation_rate
from trips
where Request_at between '2013-10-01' and '2013-10-03'
and Client_Id not in (select distinct Users_Id from Users where banned = 'Yes')
and Driver_Id not in (select distinct Users_Id from Users where banned = 'Yes')

SELECT cast(ROUND(235.415, 2)as float) AS RoundValue;
use [leetcode_db]
/*Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table*/
Create table Emp3 (Id int, Name varchar(255), Department varchar(255), ManagerId int)
Truncate table Emp3
insert into Emp3 (Id, Name, Department, ManagerId) values ('101', 'John', 'A', null)
insert into Emp3 (Id, Name, Department, ManagerId) values ('102', 'Dan', 'A', '101')
insert into Emp3 (Id, Name, Department, ManagerId) values ('103', 'James', 'A', '101')
insert into Emp3 (Id, Name, Department, ManagerId) values ('104', 'Amy', 'A', '101')
insert into Emp3 (Id, Name, Department, ManagerId) values ('105', 'Anne', 'A', '101')
insert into Emp3 (Id, Name, Department, ManagerId) values ('106', 'Ron', 'B', '101')
insert into Emp3 (Id, Name, Department, ManagerId) values ('104', 'Jay', 'A', '102')
insert into Emp3 (Id, Name, Department, ManagerId) values ('105', 'Sourabh', 'A', '102')
insert into Emp3 (Id, Name, Department, ManagerId) values ('106', 'Rahul', 'B', '103')
insert into Emp3 (Id, Name, Department, ManagerId) values ('104', 'amit', 'A', '102')
insert into Emp3 (Id, Name, Department, ManagerId) values ('105', 'kapil', 'A', '102')
insert into Emp3 (Id, Name, Department, ManagerId) values ('104', 'vivek', 'A', '102')
insert into Emp3 (Id, Name, Department, ManagerId) values ('105', 'anshul', 'A', '102')
select * from emp3

--- not the right approach
select name from 
(select x.managerid from 
(select managerid,count(*) as directReportCount from emp3 group by managerid) x
where x.directReportCount>=5)y join emp3 e on y.managerid = e.Id

select * from emp3
-- this is optimum approach
select
	e2.Name,
	count(*) as number_of_reportee
from emp3 e1 join Emp3 e2 on e1.ManagerId = e2.Id
group by e2.Name
having count(*) >=5

/*Write a sql to find the name of the winning candidate, the above example will return the winner B.*/
Create table Candidate (id int, Name varchar(255))
Create table Vote (id int, CandidateId int)
Truncate table Candidate
insert into Candidate (id, Name) values ('1', 'A')
insert into Candidate (id, Name) values ('2', 'B')
insert into Candidate (id, Name) values ('3', 'C')
insert into Candidate (id, Name) values ('4', 'D')
insert into Candidate (id, Name) values ('5', 'E')
Truncate table Vote
insert into Vote (id, CandidateId) values ('1', '2')
insert into Vote (id, CandidateId) values ('2', '4')
insert into Vote (id, CandidateId) values ('3', '3')
insert into Vote (id, CandidateId) values ('4', '2')
insert into Vote (id, CandidateId) values ('5', '5')
insert into Vote (id, CandidateId) values ('5', '3')

select * from Candidate
select * from Vote

select c.name from 
(select CandidateId,
rank() over(order by count(id) desc) as rnk
from Vote
group by CandidateId)a
join Candidate c on a.CandidateId=c.id
where a.rnk = 1

select a.name as name from (
select c.Name,
	--count(v.id) as vote_count
	dense_rank() over(order by count(v.id) desc) as rnk 
from
	Candidate c 
join 
	vote v 
on c.id = v.candidateId
group by c.Name)a 
where a.rnk = 1

/*Write a SQL query to find employees who earn the top three salaries in each of the
department. For the above tables, your SQL query should return the following rows (order of rows does not mater).*/
Create table Emp5 (Id int, Name varchar(255), Salary int, DepartmentId int)
Create table Dept (Id int, Name varchar(255))
Truncate table Emp5
insert into Emp5 (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '85000', '1')
insert into Emp5 (Id, Name, Salary, DepartmentId) values ('2', 'Henry', '80000', '2')
insert into Emp5 (Id, Name, Salary, DepartmentId) values ('3', 'Sam', '60000', '2')
insert into Emp5 (Id, Name, Salary, DepartmentId) values ('4', 'Max', '90000', '1')
insert into Emp5 (Id, Name, Salary, DepartmentId) values ('5', 'Janet', '69000', '1')
insert into Emp5 (Id, Name, Salary, DepartmentId) values ('6', 'Randy', '85000', '1')
insert into Emp5 (Id, Name, Salary, DepartmentId) values ('7', 'Will', '70000', '1')
Truncate table Dept
insert into Dept (Id, Name) values ('1', 'IT')
insert into Dept (Id, Name) values ('2', 'Sales')
select * from Emp5
select * from dept

select x.* from (
select e.Name as empName,
		e.Salary as salary,
		d.Name as deptname,
		dense_rank() over (partition by d.name order by e.salary desc) as rnk
from emp5 e join Dept d on e.DepartmentId =d.Id) x
where x.rnk<=3

----------------------
name | salary | Rank
------------------------
select a.department,a.employee,a.salary
from (
select 
	e.Name as employee, 
	e.Salary as salary,
	d.name as Department,
	dense_rank() over(partition by d.name order by e.salary desc) as rnk
from 
	Emp5 e
join 
	dept d
on e.DepartmentId = d.id) a
where rnk <=3
use [leetcode_db]

/*Write an SQL query to find the most frequently ordered product(s) for each customer.
The result table should have the product_id and product_name for each customer_id who 
ordered at least one order. Return the result table in any order.*/

Create table Customers (customer_id int, name varchar(10))
Create table Orders (order_id int, order_date date, customer_id int, product_id int)
Create table Products (product_id int, product_name varchar(20), price int)
Truncate table Customers
insert into Customers (customer_id, name) values ('1', 'Alice')
insert into Customers (customer_id, name) values ('2', 'Bob')
insert into Customers (customer_id, name) values ('3', 'Tom')
insert into Customers (customer_id, name) values ('4', 'Jerry')
insert into Customers (customer_id, name) values ('5', 'John')
Truncate table Orders
insert into Orders (order_id, order_date, customer_id, product_id) values ('1', '2020-07-31', '1', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('2', '2020-7-30', '2', '2')
insert into Orders (order_id, order_date, customer_id, product_id) values ('3', '2020-08-29', '3', '3')
insert into Orders (order_id, order_date, customer_id, product_id) values ('4', '2020-07-29', '4', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('5', '2020-06-10', '1', '2')
insert into Orders (order_id, order_date, customer_id, product_id) values ('6', '2020-08-01', '2', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('7', '2020-08-01', '3', '3')
insert into Orders (order_id, order_date, customer_id, product_id) values ('8', '2020-08-03', '1', '2')
insert into Orders (order_id, order_date, customer_id, product_id) values ('9', '2020-08-07', '2', '3')
insert into Orders (order_id, order_date, customer_id, product_id) values ('10', '2020-07-15', '1', '2')
Truncate table Products
insert into Products (product_id, product_name, price) values ('1', 'keyboard', '120')
insert into Products (product_id, product_name, price) values ('2', 'mouse', '80')
insert into Products (product_id, product_name, price) values ('3', 'screen', '600')
insert into Products (product_id, product_name, price) values ('4', 'hard disk', '450')
 
select * from Orders
select * from Products
select * from Customers
use [leetcode_db]

select a.customer_id,a.product_id,p.product_name from 
(
select customer_id, product_id, 
dense_rank() over (partition by customer_id order by count(product_id) desc) as bougth_frequency
from Orders
group by customer_id, product_id) a
join Products p
on a.product_id = p.product_id
where bougth_frequency  >= 1
use [leetcode_db]
/*Write an SQL query to find the most recent order(s) of each product.*/
Create table Cust (customer_id int, name varchar(10))
Create table Ord (order_id int, order_date date, customer_id int, product_id int)
Create table Prod (product_id int, product_name varchar(20), price int)
Truncate table Cust
insert into Cust (customer_id, name) values ('1', 'Winston')
insert into Cust (customer_id, name) values ('2', 'Jonathan')
insert into Cust (customer_id, name) values ('3', 'Annabelle')
insert into Cust (customer_id, name) values ('4', 'Marwan')
insert into Cust (customer_id, name) values ('5', 'Khaled')
Truncate table Ord
insert into Ord (order_id, order_date, customer_id, product_id) values ('1', '2020-07-31', '1', '1')
insert into Ord (order_id, order_date, customer_id, product_id) values ('2', '2020-7-30', '2', '2')
insert into Ord (order_id, order_date, customer_id, product_id) values ('3', '2020-08-29', '3', '3')
insert into Ord (order_id, order_date, customer_id, product_id) values ('4', '2020-07-29', '4', '1')
insert into Ord (order_id, order_date, customer_id, product_id) values ('5', '2020-06-10', '1', '2')
insert into Ord (order_id, order_date, customer_id, product_id) values ('6', '2020-08-01', '2', '1')
insert into Ord (order_id, order_date, customer_id, product_id) values ('7', '2020-08-01', '3', '1')
insert into Ord (order_id, order_date, customer_id, product_id) values ('8', '2020-08-03', '1', '2')
insert into Ord (order_id, order_date, customer_id, product_id) values ('9', '2020-08-07', '2', '3')
insert into Ord (order_id, order_date, customer_id, product_id) values ('10', '2020-07-15', '1', '2')
Truncate table Products
insert into Prod (product_id, product_name, price) values ('1', 'keyboard', '120')
insert into Prod (product_id, product_name, price) values ('2', 'mouse', '80')
insert into Prod (product_id, product_name, price) values ('3', 'screen', '600')
insert into Prod (product_id, product_name, price) values ('4', 'hard disk', '450')

select * from ord
select * from products
select * from customers


select p.product_id,p.product_name,x.order_Date,x.order_id from 
(select o.order_id,o.product_id, o.order_Date,DENSE_RANK() over (partition by product_id order by order_date desc) as rnk
from ord o) x join products p on x.product_id = p.product_id
where rnk = 1

--approach 1
select b.product_name,b.product_id,o.order_id,b.order_date from 
(select a.product_id,p.product_name,a.order_date
from (
(SELECT DISTINCT product_id, max(order_date) as order_date
FROM Ord
GROUP BY product_id)) a
join Prod p 
on 
	a.product_id = p.product_id)b
join ord o
on o.order_date = b.order_date

--approach 2
select a.product_id,p.product_name,a.order_id,a.order_Date from 
(select o.product_id,o.order_id,o.order_Date,DENSE_RANK() over (partition by o.product_id order by o.order_date desc) as rnk
from ord o) a
join prod p 
on a.product_id = p.product_id
where rnk = 1


/**/
Create table Emp7(emp_id int, event_day date, in_time int, out_time int)
Truncate table Emp7
insert into Emp7 (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '4', '32')
insert into Emp7 (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '55', '200')
insert into Emp7 (emp_id, event_day, in_time, out_time) values ('1', '2020-12-3', '1', '42')
insert into Emp7 (emp_id, event_day, in_time, out_time) values ('2', '2020-11-28', '3', '33')
insert into Emp7 (emp_id, event_day, in_time, out_time) values ('2', '2020-12-9', '47', '74')

select 
    event_day as day,
    emp_id,
    sum(out_time-in_time) as total_time
from 
    Emp7
group by 
    event_day,
    emp_id

/*Write a SQL query to find the id and the name 
of all students who are enrolled in 
departments that no longer exists.*/
Create table Departments (id int, name varchar(30))
Create table Students (id int, name varchar(30), department_id int)
Truncate table Departments
insert into Departments (id, name) values ('1', 'Electrical Engineering')
insert into Departments (id, name) values ('7', 'Computer Engineering')
insert into Departments (id, name) values ('13', 'Bussiness Administration')
Truncate table Students
insert into Students (id, name, department_id) values ('23', 'Alice', '1')
insert into Students (id, name, department_id) values ('1', 'Bob', '7')
insert into Students (id, name, department_id) values ('5', 'Jennifer', '13')
insert into Students (id, name, department_id) values ('2', 'John', '14')
insert into Students (id, name, department_id) values ('4', 'Jasmine', '77')
insert into Students (id, name, department_id) values ('3', 'Steve', '74')
insert into Students (id, name, department_id) values ('6', 'Luis', '1')
insert into Students (id, name, department_id) values ('8', 'Jonathan', '7')
insert into Students (id, name, department_id) values ('7', 'Daiana', '33')
insert into Students (id, name, department_id) values ('11', 'Madelynn', '1')

select * from Departments 
select * from Students

select 
	s.id,
	s.name
from 
	Students s
where s.department_id not in
(select distinct id from Departments)

/*Write a query to return the list of 
customers NOT referred by the person with id '2'.*/
drop table cust1;
CREATE TABLE cust1 (id INT,name VARCHAR(25),referee_id INT);
Truncate table cust1
insert into cust1 (id, name, referee_id) values ('1', 'Will', null)
insert into cust1 (id, name, referee_id) values ('2', 'Jane', null)
insert into cust1 (id, name, referee_id) values ('3', 'Alex', 2)
insert into cust1 (id, name, referee_id) values ('4', 'Bill', null)
insert into cust1 (id, name, referee_id) values ('5', 'Zack', 1)
insert into cust1 (id, name, referee_id) values ('6', 'Mark', 2)
1 - list all the customer
2 - apply filter for person with id 2

select * from cust1

select c.*
from cust1 c
where c.referee_id != 2 or c.referee_id is null

select name from cust1
where referee_id != 2 or referee_id is null

/**/
Create table follow (followee varchar(255), follower varchar(255))
Truncate table follow
insert into follow (followee, follower) values ('A', 'B')
insert into follow (followee, follower) values ('B', 'C')
insert into follow (followee, follower) values ('B', 'D')
insert into follow (followee, follower) values ('D', 'E')

select follower, count(followee) from follow group by follower

/*Write a SQL query to report, How much cubic feet of volume does the inventory occupy in each warehouse.*/
Create table Warehouse (name varchar(50), product_id int, units int)
Create table Prod1 (product_id int, product_name varchar(50), Width int,Length int,Height int)
Truncate table Warehouse
insert into Warehouse (name, product_id, units) values ('LCHouse1', '1', '1')
insert into Warehouse (name, product_id, units) values ('LCHouse1', '2', '10')
insert into Warehouse (name, product_id, units) values ('LCHouse1', '3', '5')
insert into Warehouse (name, product_id, units) values ('LCHouse2', '1', '2')
insert into Warehouse (name, product_id, units) values ('LCHouse2', '2', '2')
insert into Warehouse (name, product_id, units) values ('LCHouse3', '4', '1')
Truncate table Prod1
insert into Prod1 (product_id, product_name, Width, Length, Height) values ('1', 'LC-TV', '5', '50', '40')
insert into Prod1 (product_id, product_name, Width, Length, Height) values ('2', 'LC-KeyChain', '5', '5', '5')
insert into Prod1 (product_id, product_name, Width, Length, Height) values ('3', 'LC-Phone', '2', '10', '10')
insert into Prod1 (product_id, product_name, Width, Length, Height) values ('4', 'LC-T-Shirt', '4', '10', '20')

select * from Warehouse
select * from Prod1


select w.name as warehouseName,
		sum(x.prod_volume*w.units) as total_volume
from Warehouse w join 
(select p.*,(p.Height*p.Length*p.Width) as prod_volume from  prod1 p) x
on w.product_id = x.product_id
group by w.name


select w.name, sum(p.Height*p.Length*p.Width*w.units) as volume
from Warehouse w 
join Prod1 p
on w.product_id = p.product_id
group by w.name

/*Write a SQL query that reports the first login date for each player.*/
Create table Activity (player_id int, device_id int, event_date date, games_played int)
Truncate table Activity
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5')
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-05-02', '6')
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5')
use [leetcode_db]
select * from Activity

select a.player_id, min(a.event_date) as first_login
from Activity a
group by a.player_id

select * from Activity
/*Write a SQL query that reports the device that is first logged in for each player.*/
with my_cte as
(select 
	player_id,device_id,event_date,
	dense_rank() over (partition by player_id order by event_date asc) as rank from Activity ) 

select player_id,device_id from my_cte where rank=1


/*Write a SQL query that reports for each player and date, 
how many games played so far by the player. That is, the total number of 
games played by the player until that date. Check the example for clarity.*/

select player_id,event_date,
sum(games_played) over(partition by player_id order by event_date) as games_played_so_far
from Activity

/*Write a SQL query that reports the fraction of players 
that logged in again on the day after the day they first logged in,
rounded to 2 decimal places. In other words, 
you need to count the number of players that logged in for at least two consecutive 
days starting from their first login date,
then divide that number by the total number of players.*/
use leetcode_db
select * from activity

select ROUND(COUNT(T.player_id)/ (select count(distinct player_id) FROM Activity),2) as fraction
from (select player_id, MIN(event_date) as first_login from Activity group by player_id)T
inner join activity A on T.player_id=A.player_id and (T.first_login-A.event_date) = -1

SELECT ROUND(COUNT(T.player_id)*1.0/(SELECT COUNT(DISTINCT player_id)*1.0 FROM Activity),2) AS fraction
FROM (SELECT player_id, MIN(event_date) AS First_Logon FROM Activity GROUP BY player_id) T
INNER JOIN Activity A ON T.player_id = A.player_id AND DATEDIFF(day,T.First_Logon,A.event_date) = 1

/*Cummulative Sum*/
Create table salary_sum (emp_id int,month_num int, sal int)
Truncate table salary_sum
insert into salary_sum (emp_id, month_num,sal) values (201,1,100)
insert into salary_sum (emp_id,month_num, sal) values (201,2,200)
insert into salary_sum (emp_id, month_num,sal) values (201,3,300)
insert into salary_sum (emp_id, month_num,sal) values (302,1,150)
insert into salary_sum (emp_id, month_num,sal) values (302,2,300)
insert into salary_sum (emp_id, month_num,sal) values (201,4,null)
insert into salary_sum (emp_id, month_num,sal) values (201,5,null)
insert into salary_sum (emp_id, month_num,sal) values (302,4,null)
insert into salary_sum (emp_id, month_num,sal) values (302,5,600)
insert into salary_sum (emp_id, month_num,sal) values (302,6,null)

select * from salary_sum

select s.emp_id,month_num,
sum(s.sal) over (partition by emp_id order by month_num) as cumm_salary
from salary_sum s

-- lag and lead functions

select s.emp_id,month_num,s.sal
,lag(sal) over (partition by emp_id order by month_num) as last_month_sal
,lead(sal) over (partition by emp_id order by month_num) as next_month_sal
,sum(s.sal) over (partition by emp_id order by month_num) as cumm_salary
from salary_sum s

select * from salary_sum order by emp_id

select emp_id,month_num, sal,
case when sal is not null then sal else FIRST_value(sal) over(partition by emp_id order by month_num RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING) end as updated_sal
from salary_sum
	
-- Concept (https://blog.jooq.org/using-ignore-nulls-with-sql-window-functions-to-fill-gaps/) for ignoring nulls 
select emp_id,month_num, sal,
LAST_value(sal) IGNORE NULLS over(partition by emp_id order by month_num RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING) as updated_sal
from salary_sum


/**/

Create table Prod10 (order_day varchar(10),order_id varchar(10),product_id varchar(10), quantity int, price int)

insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-01','ord1','prod1',5,5)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-01','ord2','prod2',2,10)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-01','ord3','prod3',10,25)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-01','ord4','prod1',20,5)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-02','ord5','prod3',5,25)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-02','ord6','prod4',6,20)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-02','ord7','prod1',2,5)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-02','ord8','prod5',1,50)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-02','ord9','prod6',2,50)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-02','ord10','prod2',4,10)
insert into Prod10 (order_day,order_id,product_id, quantity, price) values ('2015-05-02','ord6','prod4',7,660)

/*write a sql query to get all the prod that got sold on both the days and the number of times the prod is sold */

select * from Prod10

select product_id, order_day, count(8) as number_of_orders from prod10 group by product_id,order_day
having count(distinct order_Day) > 1

select product_id,count(product_id)--,count(distinct order_day)
from prod10 
group by product_id
having count(distinct order_day) >1

--this is wrong -  this will not cover edge case like is we have more then one oreder for a one date
select product_id,count( order_day)
from prod10
group by product_id
having count( order_day) >= 2

use leetcode_db
select * from Prod10

/*write a sql to get prod that was ordered on 02-may-2015 but not in 01-may-2015*/
select product_id from prod10 where order_day = '2015-05-02'
and product_id not in (
select distinct product_id from prod10 where order_day = '2015-05-01')

/*write a sql query to get highest sold product (qty*price) on both the days*/
--with subquery
select a.order_day,a.product_id,a.sold_amt from (
select order_day,product_id, quantity*price as sold_amt,
dense_rank() over(partition by order_Day order by quantity*price desc) as rnk
from prod10)a
where a.rnk = 1

---with CTE
with cte as 
(select order_day,product_id, quantity*price as sold_amt,
dense_rank() over(partition by order_Day order by quantity*price desc) as rnk
from prod10)
select order_day,product_id,sold_amt from cte where rnk  = 1

/*write a sql to get all products total sales on 1st may and 2nd may adjacent to each other*/
select * from Prod10

select 
	coalesce(a.product_id,b.product_id)  
	,isnull(a.Total_sales,0) as Total_sales_01
	,isnull(b.Total_sales,0) as Total_sales_02
from
(select product_id, sum(quantity*price) as Total_sales from Prod10 where order_day = '2015-05-01' group by product_id ) a
full outer join 
(select product_id, sum(quantity*price) as Total_sales from Prod10 where order_day = '2015-05-02'group by product_id ) b
on a.product_id = b.product_id
order by coalesce(a.product_id,b.product_id)

with 
cte1 as (select product_id, sum(quantity*price) as Total_sales from Prod10 where order_day = '2015-05-01' group by product_id ),
cte2 as (select product_id, sum(quantity*price) as Total_sales from Prod10 where order_day = '2015-05-02'group by product_id )

select 
	coalesce(a.product_id,b.product_id) as prod_id 
	,isnull(a.Total_sales,0) as Total_sales_01
	,isnull(b.Total_sales,0) as Total_sales_02
from
cte1 a
full outer join 
cte2 b
on a.product_id = b.product_id
order by coalesce(a.product_id,b.product_id)

/*write a sql to get all products day wise, that was ordered more then once*/
select * from prod10
select order_day,product_id
,count(product_id) as prod_cnt
from prod10
group by order_day,product_id
having count(product_id) >1

select product_id,order_day
,count(product_id) as prod_cnt
from prod10
group by product_id,order_day
having count(product_id) >1
order by product_id,order_day

/*write a sql query which will explode the row based on given number in a colummn here it is quantity*/
https://www.youtube.com/watch?v=ON5p3kJ1Gug

select * from prod10

with 
ord AS (SELECT order_id,product_id,quantity FROM Prod10),

CTE_order as
(
--anchor table
select order_id, product_id, 1 as quantity, 1 as cnt from ord

union all
--Recursive part
select a.order_id,a.product_id,b.quantity,b.cnt+1
from ord a inner join CTE_order b
on a.product_id = b.product_id
where b.cnt+1 <=a.quantity
)
select order_id,product_id,quantity from CTE_order order by product_id,order_id

/*create emp00 table*/
Create table emp00  (empid int,ename varchar(10),sal int, dept_id int)

insert into emp00 (empid,ename,sal, dept_id) values (1001,'Mark',60000,2)
insert into emp00 (empid,ename,sal, dept_id) values (1002,'Anthony',40000,2)
insert into emp00 (empid,ename,sal, dept_id) values (1003,'Andrew',15000,1)
insert into emp00 (empid,ename,sal, dept_id) values (1004,'Peter',35000,1)
insert into emp00 (empid,ename,sal, dept_id) values (1005,'John',55000,1)
insert into emp00 (empid,ename,sal, dept_id) values (1006,'Albert',25000,3)
insert into emp00 (empid,ename,sal, dept_id) values (1007,'Donald',35000,3)

/*write a sql to find all emp who earn more then the average salary in their corresponding department*/

select * from emp00
--method 1
with CTE as(
select e.*,
avg(e.sal) over(partition by e.dept_id) as dept_avg_sal
from emp00 e)

select ename from CTE
where dept_avg_sal< sal

-- method 2
select x.ename,x.sal,x.average_sal from
(select e.*, avg(e.sal) over(partition by dept_id) as average_sal from emp00 e)x
where x.sal>x.average_sal

--with CTE
with 
avg_salary as (select dept_id, avg(sal) as avg_sal from emp00 group by dept_id)

select 
	e.ename
	,e.dept_id	
	,e.sal
	,asal.avg_sal
from 
	emp00 e join avg_salary asal
on e.dept_id = asal.dept_id and e.sal > asal.avg_sal

--sub query
select 
	e.ename
	,e.dept_id	
	,e.sal
	,asal.avg_sal
from 
	emp00 e join (select dept_id, avg(sal) as avg_sal from emp00 group by dept_id) asal
on e.dept_id = asal.dept_id and e.sal > asal.avg_sal


---- char character 
use leetcode_db
Create table char_table (trxn_num int,trxn_type char(2));
insert into char_table (trxn_num,trxn_type) values(1,'Cr')
insert into char_table (trxn_num,trxn_type) values(1,'Cr')
insert into char_table (trxn_num,trxn_type) values(1,'D')
insert into char_table (trxn_num,trxn_type) values(1,'DDD')
select * from char_table


/*create trxn table*/
Create table trxn (acct_num int,trxn_time varchar(25),trxn_id int, bal int);
insert into trxn (acct_num,trxn_time,trxn_id, bal) values (550,'2020-05-12 05:29:44.120',1001,2000);
insert into trxn (acct_num,trxn_time,trxn_id, bal) values (550,'2020-05-15 10:29:25.630',1002,8000);
insert into trxn (acct_num,trxn_time,trxn_id, bal) values (460,'2020-03-15 11:29:23.620',1003,9000);
insert into trxn (acct_num,trxn_time,trxn_id, bal) values (460,'2020-04-30 11:29:57.320',1004,7000);
insert into trxn (acct_num,trxn_time,trxn_id, bal) values (460,'2020-04-30 12:32:44.233',1005,5000);
insert into trxn (acct_num,trxn_time,trxn_id, bal) values (640,'2020-02-18 06:29:34.420',1006,5000);
insert into trxn (acct_num,trxn_time,trxn_id, bal) values (640,'2020-02-18 06:29:37.120',1007,9000);
select * from  trxn

/*write a sql to get most recent bal, trxn id for acct num*/

--method 1
with
cte as(
select  acct_num,trxn_time,trxn_id,bal,
dense_rank() over(partition by acct_num order by trxn_time desc) as rnk
from trxn
)

select acct_num,trxn_time,trxn_id,bal from cte where rnk = 1

--method 2
select a.acct_num,a.trxn_time,a.trxn_id, a.bal
from trxn a join 
(select acct_num,max(trxn_time) as latest_time
from trxn
group by  acct_num) b
on a.trxn_time = b.latest_time

--method 3
select  acct_num,trxn_time,trxn_id,bal from trxn
where trxn_time in
(select max(trxn_time) from trxn group by acct_num)

/*create table*/
Create table sales1 (P_id int,prod varchar(25),sales_year int, qty_sold int);
insert into sales1 (p_id,prod,sales_year, qty_sold) values (1,'laptop',1998,2500);
insert into sales1 (p_id,prod,sales_year, qty_sold) values (2,'laptop',1999,3600);
insert into sales1 (p_id,prod,sales_year, qty_sold) values (3,'laptop',2000,4200);
insert into sales1 (p_id,prod,sales_year, qty_sold) values (4,'keyboard',1998,2300);
insert into sales1 (p_id,prod,sales_year, qty_sold) values (5,'keyboard',1999,4800);
insert into sales1 (p_id,prod,sales_year, qty_sold) values (6,'keyboard',2000,5000);
insert into sales1 (p_id,prod,sales_year, qty_sold) values (7,'mouse',1998,6000);
insert into sales1 (p_id,prod,sales_year, qty_sold) values (8,'mouse',1999,3400);
insert into sales1 (p_id,prod,sales_year, qty_sold) values (9,'mouse',2000,4600);

select * from  sales1
use leetcode_db
/*write a sql to get the total sales in years for all prod*/
-- this solu is not nessasary
select distinct sales_year, sum(qty_sold) over(partition by sales_year order by sales_year) as total_sales
from sales1

--this solution is stright forward
select sales_year,sum(qty_sold) from sales1 group by sales_year

select 'total_sales' as total_sales, t1.sales as '1998' ,
t2.sales as '1999',
t3.sales as '2000'
from 
(select sum(qty_sold) as sales from sales1 where sales_year = '1998') t1,
(select sum(qty_sold) as  sales from sales1 where sales_year = '1999')t2,
(select sum(qty_sold) as sales from sales1 where sales_year = '2000')t3

/*create table*/

Create table prod00 (pname varchar(25),pcode varchar(25),qty int, inventory_date date);
insert into prod00 (pname,pcode,qty, inventory_date) values ('KB','K1001',20,'2020-03-01');
insert into prod00 (pname,pcode,qty, inventory_date) values ('KB','K1001',30,'2020-03-02');
insert into prod00 (pname,pcode,qty, inventory_date) values ('KB','K1001',10,'2020-03-03');
insert into prod00 (pname,pcode,qty, inventory_date) values ('KB','K1001',40,'2020-03-04');
insert into prod00 (pname,pcode,qty, inventory_date) values ('Laptop','L1002',100,'2020-03-01');
insert into prod00 (pname,pcode,qty, inventory_date) values ('Laptop','L1002',60,'2020-03-02');
insert into prod00 (pname,pcode,qty, inventory_date) values ('Laptop','L1002',40,'2020-03-03');
insert into prod00 (pname,pcode,qty, inventory_date) values ('Monitor','M5005',30,'2020-03-01');
insert into prod00 (pname,pcode,qty, inventory_date) values ('Monitor','M5005',20,'2020-03-02');

select * from prod00

/*write sql for running total / cummulative sum of quantity for each prod code*/

select p.*,sum(p.qty) over (partition by p.pcode order by p.inventory_date) as running_total
from prod00 p

use [leetcode_db]
/*Resursive CTE concept*/
/*print A to Z*/
select char(97)
select ASCII('A')

with 
alphabet as
(
select char(ASCII('A')) letter -- Anchor query
union all
select char(ASCII(letter)+ 1) -- Recursive query
from alphabet
where letter <> 'Z'
)
select * from alphabet

/*creat table*/
Create table trxn00 (trxn_dt varchar(25),trxn_id varchar(25), trxn_type varchar(10),amt float);
insert into trxn00 (trxn_dt,trxn_id,trxn_type, amt) values ('2020-05-12 05:29:44.120','A10001','Credit',50000);
insert into trxn00 (trxn_dt,trxn_id,trxn_type, amt) values ('2020-05-13 10:30:20.100','B10001','Debit',10000);
insert into trxn00 (trxn_dt,trxn_id,trxn_type, amt) values ('2020-05-13 11:27:50.130','B10002','Credit',20000);
insert into trxn00 (trxn_dt,trxn_id,trxn_type, amt) values ('2020-05-14 08:35:30.123','C10001','Debit',5000);
insert into trxn00 (trxn_dt,trxn_id,trxn_type, amt) values ('2020-05-14 09:43:51.100','C10002','Debit',5000);
insert into trxn00 (trxn_dt,trxn_id,trxn_type, amt) values ('2020-05-15 05:51:11.117','D10001','Credit',30000);
select * from  trxn00

/*write a sql query to derive the net_balance column based on C/D of the amt*/
with 
CTE as
(select trxn_dt,trxn_id,trxn_type,
case 
	when trxn_type = 'Credit' then amt
	when trxn_type = 'Debit' then amt*-1
	else null end as amt
from trxn00)
--select * from CTE
select t.*,
sum(amt) over(order by trxn_dt) as net_bal
from  CTE t

/*create table
convert columns into rows
https://www.youtube.com/watch?v=rb7jZGqCgwk&list=PLt_np4tyN7RO9XgsyKhr5YOXK8LA7X85-&index=19
*/

/*creat table*/
drop table trade
Create table trade (trade_id varchar(10),trade_time time,trade_stock varchar(25),qty int, price int);
insert into trade (trade_id,trade_time,trade_stock,qty, price) values ('T1','10:01:05.000000','ABC',100,20);
insert into trade (trade_id,trade_time,trade_stock,qty, price) values ('T2','10:01:06.000000','ABC',20,15);
insert into trade (trade_id,trade_time,trade_stock,qty, price) values ('T3','10:01:08.000000','ABC',150,30);
insert into trade (trade_id,trade_time,trade_stock,qty, price) values ('T4','10:01:09.000000','ABC',300,32);
insert into trade (trade_id,trade_time,trade_stock,qty, price) values ('T5','10:10:00.000000','ABC',-100,19);
insert into trade (trade_id,trade_time,trade_stock,qty, price) values ('T6','10:10:01.000000','ABC',-300,19);
select * from  trade

/*writ a sql to find  all couple of trade for same stock that happend in the 
range of 10 sec and having price diff by more them 10%. result should also list precentage of proce diff netween the 2 trade*/

select t1.trade_id first_trade, t2.trade_id as second_trade, datediff(second,t1.trade_time,t2.trade_time) as time_diff from 
trade t1 join trade t2 on t1.trade_id < t2.trade_id
where 
	datediff(second,t1.trade_time,t2.trade_time) <= 100 and
	abs(((t2.price - t1.price)/t1.price)*100) >=90

select t1.trade_id as firts_trade, t2.trade_id as second_trade,
datediff(second,t1.trade_time,t2.trade_time) as time_diff
,floor(abs(((t2.price - t1.price)/t1.price)*100)) as price_diff
from 
	trade t1 join trade t2 on t1.trade_id < t2.trade_id
where 
	datediff(second,t1.trade_time,t2.trade_time) <= 10 and
	abs(((t2.price - t1.price)/t1.price)*100) >=10

/*create table*/
Create table balance (amt int, dt date);
insert into balance (amt,dt) values (26000,'2020-01-01');
insert into balance (amt,dt) values (26000,'2020-01-02');
insert into balance (amt,dt) values (26000,'2020-01-03');
insert into balance (amt,dt) values (30000,'2020-01-04');
insert into balance (amt,dt) values (30000,'2020-01-05');
insert into balance (amt,dt) values (26000,'2020-01-06');
insert into balance (amt,dt) values (26000,'2020-01-07');
insert into balance (amt,dt) values (32000,'2020-01-08');
insert into balance (amt,dt) values (31000,'2020-01-09');
select * from  balance
use [leetcode_db]

select amt, 
min(dt) over(partition by amt order by max(dt))  as start_Date,
max(dt) over(partition by amt order by min(dt))  as end_Date
from balance
group by amt

/*this is not correct*/
https://www.youtube.com/watch?v=1gziHPyvAAk&list=PLt_np4tyN7RO9XgsyKhr5YOXK8LA7X85-&index=21
select amt,
min(dt) over(partition by amt order by dt) as start_dt,
max(dt) over(partition by amt order by dt) as end_dt
from balance

/*create table*/
drop table std
Create table std (sname varchar(20), total_marks int, yr int);
insert into std (sname,total_marks,yr) values ('Rahul',90,2010);
insert into std (sname,total_marks,yr) values ('Sanjay',80,2010);
insert into std (sname,total_marks,yr) values ('Mohan',70,2010);
insert into std (sname,total_marks,yr) values ('Rahul',90,2011);
insert into std (sname,total_marks,yr) values ('Sanjay',85,2011);
insert into std (sname,total_marks,yr) values ('Mohan',65,2011);
insert into std (sname,total_marks,yr) values ('Rahul',80,2012);
insert into std (sname,total_marks,yr) values ('sanjay',80,2012);
insert into std (sname,total_marks,yr) values ('Mohan',90,2012);
select * from  std
/*write a sql to display name, total marks and year for those whose total marks greater or equal to previous year*/
--solution 1
with cte
as (
select sname,yr,total_marks,
LAG(total_marks) over(partition by sname order by yr) as previou_year_marks,
LEAD(total_marks) over(partition by sname order by yr) as _year_marks
from std)

--select * from cte

select sname,yr,total_marks,previou_year_marks
from cte
where total_marks >= previou_year_marks

-------solution 2
select * from (
SELECT
  A.sname,
  A.Total_Marks,
  A.yr,
  B.Total_Marks AS Prev_Yr_Marks
FROM std A
JOIN std B
  ON A.sname = B.sname
  AND A.yr = B.yr + 1
  )a
  where a.Total_Marks >= a.Prev_Yr_Marks

/*create table*/
Create table sales00 (sales_dt date,sales_amt float,currency varchar(5))
insert into sales00 (sales_dt,sales_amt,currency) values ('2020-01-01',500,'INR');
insert into sales00 (sales_dt,sales_amt,currency) values ('2020-01-01',100,'GBP');
insert into sales00 (sales_dt,sales_amt,currency) values ('2020-01-02',1000,'INR');
insert into sales00 (sales_dt,sales_amt,currency) values ('2020-01-02',500,'GBP');
insert into sales00 (sales_dt,sales_amt,currency) values ('2020-01-03',500,'INR');
insert into sales00 (sales_dt,sales_amt,currency) values ('2020-01-17',200,'GBP');
select * from sales00

Create table exchange_rate (source_currency varchar(5),target_currency varchar(5),exchange_rate float,effective_strt_date date)
insert into exchange_rate (source_currency,target_currency,exchange_rate,effective_strt_date) values ('INR','USD',0.014,'2019-12-31');
insert into exchange_rate (source_currency,target_currency,exchange_rate,effective_strt_date) values ('INR','USD',0.015,'2020-01-02');
insert into exchange_rate (source_currency,target_currency,exchange_rate,effective_strt_date) values ('GBP','USD',1.32,'2019-12-20');
insert into exchange_rate (source_currency,target_currency,exchange_rate,effective_strt_date) values ('GBP','USD',1.3,'2020-01-01');
insert into exchange_rate (source_currency,target_currency,exchange_rate,effective_strt_date) values ('GBP','USD',1.35,'2019-01-16');
select * from exchange_rate

/*write a sql to get sales amt in usd for each date*/
with
cte as 
(select a.*,
isnull(lead(dateadd(day,-1,a.effective_strt_date)) over(partition by a.source_currency order by a.source_currency),'9999-12-31') as effective_end_date
from exchange_rate a)
--select * from cte

select s.sales_dt,sum(s.sales_amt*e.exchange_rate) as total_sales
from 
	sales00 s
left join 
	cte e
on s.currency = e.source_currency
and s.sales_dt between e.effective_strt_date and e.effective_end_date
group by s.sales_dt


/*creat etable */

Create table travel (source varchar(25),destination varchar(25),distance int)
insert into travel (source,destination,distance) values ('Delhi','Pune',1400);
insert into travel (source,destination,distance) values ('Pune','Delhi',1400);
insert into travel (source,destination,distance) values ('Banglore','Chennai',350);
insert into travel (source,destination,distance) values ('Chennai','Banglore',350);
insert into travel (source,destination,distance) values ('Mumbai','Ahmedabad',500);
insert into travel (source,destination,distance) values ('Patna','Ranchi',300);
insert into travel (source,destination,distance) values ('Jabalpur','bhopal',300);
insert into travel (source,destination,distance) values ('bhopal','Jabalpur',300);

select * from travel
/*write a sql to get unique combination of two columns source and destination irrespective of order of columns*/
with 
CTE as
(
select source, destination, distance,
case
	when source > destination then source+destination else destination+source end as combine_loc
from travel
)
select * from cte
Select source,destination,Distance from (
Select source,destination,Distance,ROW_NUMBER() over(Partition by combine_loc order by combine_loc) as Row_Num 
from CTE) A where Row_Num = 1

------------------------

select * from prod1
select * from Warehouse
-----cummulative sum

Create table Employee_1 (srno int, emp_name varchar(25) , Salary int)
insert into Employee_1 (srno,emp_name, Salary) values (1,'ram', 100)
insert into Employee_1 (srno,emp_name, Salary) values (2,'jack', 400)
insert into Employee_1 (srno,emp_name, Salary) values (3,'john', 600)
insert into Employee_1 (srno,emp_name, Salary) values (4,'don', 300)
insert into Employee_1 (srno,emp_name, Salary) values (5,'jeff', 200)
select * from Employee_1

select a.srno,a.emp_name,sum(b.salary) as cum_sum
from Employee_1 a join Employee_1 b
on a.srno >= b.srno
group by a.srno,a.emp_name
order by a.srno


select a.srno,a.emp_name,sum(b.salary) as cum_sum
from Employee_1 a join Employee_1 b
on a.srno >= b.srno
group by a.srno,a.emp_name
order by a.srno

----Running total https://codingsight.com/calculating-running-total-with-over-clause-and-partition-by-clause-in-sql-server/

-------------------------
https://www.glassdoor.com/Interview/products-sales-produc-QTN_3759155.htm

select brand_name from product_sales group by brand_name
having count(brand_name)>=2 and avg(price)>3

1 - calculate total number trxn 
2 - total number of trxn where promo has applied 
3- calculate percenatge point2/point1 * 100

Create table tab_prod_promo (trxn_id int,promo_id varchar(10));
insert into tab_prod_promo values (001,'p1')
insert into tab_prod_promo values (002,'p2');
insert into tab_prod_promo values (003,'p3');
insert into tab_prod_promo values (004,null);
insert into tab_prod_promo values (005,null);
select * from tab_prod_promo;

select sum(trxn_with_promo)*100/(sum(a.trxn_without_promo)+sum(a.trxn_with_promo)

from (
select case when promo_id is null then count(trxn_id) end as trxn_without_promo,
	   case when promo_id is not null then count(trxn_id) end as trxn_with_promo
from tab_prod_promo
group by promo_id) a

select count(trxn_id) from tab where promo_id is null

use [leetcode_db]
select * from [dbo].[trxn00]

/*creat table*/
drop table transaction_tbl
Create table transaction_tbl (trxn_dt varchar(25),trxn_id integer, cust_id integer,amt float);
insert into transaction_tbl (trxn_dt,trxn_id,cust_id, amt) values ('2020-05-12',20001,1001,10000);
insert into transaction_tbl (trxn_dt,trxn_id,cust_id, amt) values ('2020-05-13',20002,1001,15000);
insert into transaction_tbl (trxn_dt,trxn_id,cust_id, amt) values ('2020-05-14',20003,1001,80000);
insert into transaction_tbl (trxn_dt,trxn_id,cust_id, amt) values ('2020-05-11',20004,1001,20000);
insert into transaction_tbl (trxn_dt,trxn_id,cust_id, amt) values ('2020-05-10',30001,1002,7000);
insert into transaction_tbl (trxn_dt,trxn_id,cust_id, amt) values ('2020-05-09',30002,1002,15000);
insert into transaction_tbl (trxn_dt,trxn_id,cust_id, amt) values ('2020-05-01',30003,1002,22000);
select * from  transaction_tbl

select
		cust_id
	,	trxn_id
	,	trxn_dt
	,	amt
	,	trxn_dt
	,	max(amt) over(partition by cust_id) as max_amt
	,	amt/max(amt) over(partition by cust_id) as ratio
from transaction_tbl
-- altername solution - https://www.youtube.com/watch?v=5F3Oa7nky64&list=PLt_np4tyN7RO9XgsyKhr5YOXK8LA7X85-

-- concatename all email with departid

Create table conn_email (email varchar(25), dept integer);
insert into conn_email (email,dept) values ('h@gmail.com',100);
insert into conn_email (email,dept) values ('hello@gmail.com',300);
insert into conn_email (email,dept) values ('kkkkk@gmail.com',100);
insert into conn_email (email,dept) values ('jkdgh@gmail.com',300);
insert into conn_email (email,dept) values ('koihk@gmail.com',200);
select * from  conn_email

--- reference https://en.dirceuresende.com/blog/sql-server-como-concatenar-linhas-agrupando-os-dados-por-uma-coluna-grouped-concatenation/

use leetcode_db
select * from [dbo].[Products]

------------calculate perc
drop table sales01
Create table sales01 (store_id integer, expance_cost float, sales_cost float);
insert into sales01 (store_id,expance_cost,sales_cost) values (001,100,120);
insert into sales01 (store_id,expance_cost,sales_cost) values (002,150,200);
insert into sales01 (store_id,expance_cost,sales_cost) values (003,120,170);
insert into sales01 (store_id,expance_cost,sales_cost) values (004,100,160);
insert into sales01 (store_id,expance_cost,sales_cost) values (001,50,100);
select * from sales01
drop table state_details
Create table state_details (store_id integer, state_name varchar(10));
insert into state_details (store_id,state_name) values (001,'CA');
insert into state_details (store_id,state_name) values (002,'VA');
insert into state_details (store_id,state_name) values (003,'DC');
insert into state_details (store_id,state_name) values (004,'DE');
select * from state_details
--method 1 - 
with summary as (
select store_id, sum(sales_cost) as total_sales,sum(expance_cost) as total_expance from sales01
group by store_id)
--select * from summary

select sd.state_name,s.total_sales,s.total_expance,sd.store_id
,		(s.total_sales-s.total_expance)/s.total_expance * 100 as percentage_prfoit
from summary s join state_details sd  on s.store_id = sd.store_id
use leetcode_db
--method 2
select x.state_name,x.percentage_growth from (
select s.store_id,sd.state_name,sum(s.sales_cost) as total_cost,sum(s.expance_cost) as total_expance,
(sum(s.sales_cost)-sum(s.expance_cost))/sum(s.expance_cost) * 100 as percentage_growth
from sales01 s left join state_details sd  on s.store_id = sd.store_id
group by s.store_id,sd.state_name)x

select * from sales01


--------example for case statemets 
-- https://www.youtube.com/watch?v=W_IERUwElkg (third example is a good example)
use leetcode_db
---------
select
sales_cost,rank() over(order by sales_cost desc) as rnk
from sales01 

Create table air (amenities varchar(25));
insert into air (amenities) values('hello, hi,hhhh,kkkk');
select (amenities , ',' )   from air


--- identify manager with biggest team
Create table Emp11 (emp_Id int, Name varchar(255),ManagerId int)

insert into Emp11 (emp_Id, Name, ManagerId) values (101, 'John',102)
insert into Emp11 (emp_Id, Name, ManagerId) values (102, 'Jaya',104)
insert into Emp11 (emp_Id, Name,ManagerId) values (103, 'Ram',102)
insert into Emp11 (emp_Id, Name, ManagerId) values (104, 'Rahul',null)
insert into Emp11 (emp_Id, Name, ManagerId) values (105, 'Amit',101)
select * from emp11

-- method 1
with cte as (
select top 1 managerid, count(emp_id) as number_of_direct_reports
from emp11
group by ManagerId
order by count(*) desc)

select e.name
from cte c join emp11 e on c.managerid = e.emp_Id

---method 2
with CTE  as(
select e.ManagerId, row_number() over (order by count(emp_id) desc) as direct_report_cnt
from emp11 e
where ManagerId is not null
group by e.ManagerId)

select e.name
from CTE c join emp11 e on c.managerid = e.emp_Id
where C.direct_report_cnt =1


SELECT 
    EOMONTH('2019-02-15') eomonth_next_2_months;


SELECT ADD_MONTHS(current_date - EXTRACT(DAY FROM current_date)+1, +1) -1

use leetcode_db

-- fill null value with last not null value in amt field
--lag and lead
Create table prod100 (pname varchar(25), amt integer);
insert into prod100 (pname, amt) values('prod1',100);
insert into prod100 (pname, amt) values('prod2',200);
insert into prod100 (pname, amt) values('prod1',null);
insert into prod100 (pname, amt) values('prod1',null);
insert into prod100 (pname, amt) values('prod2',null);

select pname, 
amt,
max(amt) over(order by amt null last) 
from prod100

select * from prod100

select * from prod100

select pname,amt,
--lead(amt) over(order by amt),
lag (amt) over(partition by pname order by pname)
from prod100

rank() over(partition by pname order by amt desc) from prod100

--------------select product where product price is greather then average product price in same product category
Create table produdt_0 (p_name varchar(25),p_category varchar(25), price integer);
insert into produdt_0 (p_name, p_category,price) values('laptop','electronics',800);
insert into produdt_0 (p_name, p_category,price) values('mobile','electronics',500);
insert into produdt_0 (p_name, p_category,price) values('tire','auto',400);
insert into produdt_0 (p_name, p_category,price) values('whindsield','auto',300);
insert into produdt_0 (p_name, p_category,price) values('string','auto',700);
insert into produdt_0 (p_name, p_category,price) values('break','auto',200);
insert into produdt_0 (p_name, p_category,price) values('chair','office',100);
insert into produdt_0 (p_name, p_category,price) values('table','office',150);
insert into produdt_0 (p_name, p_category,price) values('rount table','office',300);
insert into produdt_0 (p_name, p_category,price) values('printer','office',150);
insert into produdt_0 (p_name, p_category,price) values('ball','sports',20);
insert into produdt_0 (p_name, p_category,price) values('cricket bat','sports',70);
insert into produdt_0 (p_name, p_category,price) values('stump','sports',30);

select * from produdt_0

select a.* from (
select p_name, p_category, price, avg(price) over(partition by p_category order by p_category ASC) as avg_price
from produdt_0) a
 where a.price<a.avg_price

 ---running sum
 select p_name, p_category, price, sum(price) over(order by p_name asc) as running_sum from produdt_0

 ---------------------
 hello SOurabh testing!!
































































































































