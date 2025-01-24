--
create database power
--1 
-- create and inserte into department table 
create table department 
(dept_no int primary key ,
dept_name varchar(50), 
location varchar(20) )
alter table department
add constraint ch check(location in('ny','kw','ds'))

insert into department values (1 , 'reaserching' ,'ny')
,(2 , 'accounting' ,'ds'),(3 , 'marketing' ,'kw')
select * from department

-- creating and inserting empolyee table
create table employee( emp_no int primary key , emp_fname varchar(50) not null,
emp_lname varchar(50) not null,salary int unique , dept_no int ,
constraint f_k foreign key (dept_no) references [department](dept_no) )

insert into employee values(1,'ali','mahmoud',4500,1),
(2,'ali','3000',5000,2),(3,'khaled','mahmoud',4000,1)
select *from employee  
--i added rule by altering table
alter table employee 
add constraint sallary check (salary <6000)
-- create and insert in project table 
create table project(pro_no int primary key , pro_name varchar(50) not null , budget int null)
insert into project values(1, 'project2', 50000),(2, 'project3', 50000),(3, 'project1', null)
select *from project
---create and insert works_on table
create table work_on
(emp_no int not null ,
pro_no int not null , 
jop varchar(50) null,
datee datetime default getdate() not null ,
constraint p_kk primary key(emp_no,pro_no),
constraint f_k3 foreign key(emp_no) references [employee](emp_no),
constraint f_k2 foreign key(pro_no) references project(pro_no))
--
insert into work_on values(1,1,'analyst',''),(1,2,'programer',''),(3,1,'backend','')
select *from work_on

--in above i create all tables and i added all constraint and i insert 3 row in each table

-- in this queruy error as id 11111 no exist in emppoyee which references of f_k
insert into work_on values(11111,1,'analyst','')
--no row updated because there is no emp_no 11111 in empolyee table
--zero row afeccted
update work_on set emp_no = 11111 where  emp_no = 10102

----no row updated because there is no emp_no 11111 in empolyee table
--zero row afeccted 
update employee set emp_no = 22222 where  emp_no = 10102

--delete  employee with id =10102 
delete from employee where emp_no = 10102

--- table modification 
alter table employee
add  tel_num varchar(50) 

alter table employee
drop column tel_num
-- i made digram 0 withdraw
--#########################################################
--2
--- create schemas 
CREATE SCHEMA company
CREATE SCHEMA hr
-- transfer into schemas
alter schema company 
transfer dbo.department 
alter schema company 
transfer dbo.project

alter schema hr 
transfer dbo.employee

--3
select CONSTRAINT_NAME , CONSTRAINT_TYPE , TABLE_NAME 
from information_schema.table_constraints 
where table_name = 'employee'
--4
create synonym emp for hr.employee
select *from employee -- ????? ????? ?? ???? ????????
select * from hr.employee -- ????? ?????? ????
select *from emp   -- ????? ?????? ???? 
select *from hr.emp -- ????? ???? ??????? ??????? ?? ????????

--5
--  ???? ???? ???? ??????? ??? ???? ????? ???? 
---6
--Change the name of the department for which
--the employee named James works.The new department name is Sales.
insert into emp values(4,'james','works',2700,1)
--
update company.department set dept_name ='sales'
from company.department c join emp e on c.dept_no = e.dept_no
where e.emp_fname = 'james' and e.emp_lname = 'works'

--7
update work_on  set datee = '2007-12-12'
where pro_no =1 
and emp_no in (select e.emp_no from company.department c
join emp e on e.dept_no = c.dept_no  where c.dept_name ='sales' )

--8
delete from work_on where emp_no =
( select emp_no from emp e 
join company.department d on e.dept_no = d.dept_no 
where d.location = 'kw') 
select *from emp



























































--emffrkfmrf