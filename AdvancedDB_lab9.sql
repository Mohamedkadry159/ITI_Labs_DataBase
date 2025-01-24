use iti
go
--1
create proc num_student  as
begin 
select count(s.st_id) as num_of_student, d.dept_name from student s join department d
on s.dept_id = d.dept_id group by d.dept_name 
end

exec num_student
--2
use [compay db]
create proc check_employee  as
begin 
declare @check int 
set @check = (select COUNT(e.ssn) as count_of_emp_in_pro from employee e join works_on w 
on e.ssn = w.empssn join project p on p.pnumber = w.projnum  where p.pname like 'mohamed')
if @check >= 3
select ('the num of employee in proj more than 3 or equal')
else if @check <3 
begin
select 'the follwing employee is work for' 
select e.*  from employee e join works_on w on e.ssn = w.empssn join project p on p.pnumber =w.projnum  
end
end

exec check_employee

---3
use Company_SD
alter procedure old_new (@old_id int,@new_id int , @pnum int)
as
begin
update works_for set essn = @new_id  where essn =@old_id and Pno =@pnum
end


 exec old_new 512463 ,112233,500

--- 4 
alter table project 
add budgget int 
update Project
set Budgget = 9500 where Pnumber = '200' 
create table Audit_table (ProjectNo int ,UserName varchar(50),ModifiedDate datetime ,Budget_Old int,Budget_New int)

alter trigger trg1 ON [project]
after update as 
 begin  
	insert into Audit_table select  d.pnumber , d.pname  , GETDATE() ,d.budgget , p.budgget  
	from project p, deleted d where p.pnumber = d.pnumber
  end; 

  update project set budgget = 7000 where pnumber=100
  select *from Audit_table


---5
use iti

create trigger del_trig
on department
instead of delete
	as 
	select 'not allowed to delete '

delete from Department where Dept_Id =10  --> not allowed


--6
use Company_SD
alter trigger ins_trig
on employee
instead of insert 
	as 
	begin
    --declare @dat date 
    --set @dat= SELECT datename(month,'2025-01-01')
	if datename(month , getdate()) ='march'
		begin 
			select 'not allowd to insert in march'
			rollback transaction

		end
	else 
		begin 
			insert into employee select *from inserted 
		end
	end

insert into employee 
values ('Qadrri' , 'Qadri',1022775,'2000-10-10','m','farshout',5000,102672,20) 

--7
use iti
create table auditt(username varchar(50) , datee date, note varchar(100))

alter trigger stu on student
after insert as
begin 
declare @key int 
set @key =(select st_id from inserted )
--declare @user_name varchar(50)
--set @user_name =(select concat(st_fname , St_Lname) as full_name from student )
--declare @table_name 
insert into auditt 
values(@@SERVERNAME,getdate(), concat(suser_name(),'insert new row with key =', @key))
end

insert into Student values (15,'mohamed','hagag','al behyra',25,10,null)
select *from student order by st_id desc
select top(1)*from auditt

--8

alter trigger stu_Del on student
after delete as
begin 
declare @key int 
set @key =(select st_id from deleted )
--declare @user_name varchar(50)
--set @user_name =(select concat(st_fname , St_Lname) as full_name from student )
--declare @table_name 
insert into auditt 
values(@@SERVERNAME,getdate(), concat(suser_name(),'deleted  row with key =', @key))
end

delete from Student where st_id =13
select *from auditt












----