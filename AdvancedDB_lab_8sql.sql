use ITI
--1
alter view student_details as
select concat(s.St_Fname ,' ', s.St_Lname ) as full_name, c.Crs_Name ,sc.Grade 
from student s join Stud_Course sc
on s.St_Id = sc.St_Id join Course c on sc.Crs_Id = c.Crs_Id
where sc.Grade>50

select *from student_details

--2
alter view  man_topic  with encryption as
select i.Ins_Name , t.Top_Name from Instructor i join Department d 
on i.Ins_Id = d.Dept_Manager join Ins_Course ic on ic.Ins_Id = i.Ins_Id 
join Course c on c.Crs_Id = ic.Crs_Id join Topic t on t.Top_Id =c.Top_Id
 
select *from man_topic

--3
create view dep_details as 
select i.Ins_Name ,d.Dept_Name from Instructor i 
join Department d on i.Dept_Id = d.Dept_Id 
where d.Dept_Name in('SD','Java')

select *from dep_details

--4
alter view student_details2 as 
select *from Student s where s.St_Address in ('Alex','Cairo')
with check option 

select *from student_details2

--5
use [compay db]
create view pro_details as
select p.pname , COUNT(e.ssn) as num_of_emp  from employee e join works_on w 
on e.ssn = w.Empssn join project p on p.pnumber =w.projnum group by p.pname

select *from pro_details

--6
-- we notice is created non unique non cluster index
create index index1 on department(mangerstardate)

--7
use ITI
-- error because it duplicated 
create unique index index2 on student(St_Age)

--8
create table daily_transaction (id int , amount int ) 
create table last_transaction (id int ,amount int )

insert into daily_transaction values(1,1000),(2,2000),(3,1000)
insert into last_transaction values(1,4000),(4,2000),(2,1000)



merge into [dbo].[last_transaction] as l
using [dbo].[daily_transaction] as d​
on l.id = d.id​
when matched and (l.id !=d.id or l.amount != d.amount)​
then update  set l.id = d.id ,l.amount = d.amount ​
when not matched then insert values (d.id, d.amount)​
;​
select *from last_transaction

--9
select  
	   lAG(concat(s.St_Fname , ' ' , s.St_Lname)) OVER(ORDER BY sc.grade)  lagg,
	   LEAD(concat(s.St_Fname , ' ' , s.St_Lname)) OVER(ORDER BY sc.grade)  leadd,
	   concat(s.St_Fname , ' ' , s.St_Lname) as full_name, c.Crs_Name  , sc.Grade
	   from Student s join Stud_Course sc 
       on s.St_Id = sc.St_Id join Course c 
	   on c.Crs_Id = sc.Crs_Id

 



































--djwshdnjsdmsiejfhnudfkjdmnf