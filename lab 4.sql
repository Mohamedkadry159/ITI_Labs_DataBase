--cross join 
/*display all possible combinations of student names and department names */
select St_Fname,Dept_Name
from Student,Department


select St_Fname,Dept_Name
from Student cross join Department

--inner join 
/* retrieve the student names and their addresses and their department names*/
select St_Fname,St_Address,Dept_Name
from Student ,Department 
where Department.Dept_Id=Student.Dept_Id and St_Address='alex'

select St_Fname,Dept_Name,student.Dept_Id
from Student inner join Department 
on Department.Dept_Id=Student.Dept_Id
and  St_Address='alex'
order by student.Dept_Id ,St_Fname

--outer join 
--students have department or not 
select St_Fname,Dept_Name
from student s left  outer join Department d
on d.Dept_Id=s.Dept_Id

select St_Fname,Dept_Name
from Department d right  outer join Student s
on d.Dept_Id=s.Dept_Id


--departments have students or not 
select St_Fname,Dept_Name
from Student s right outer join  Department d
on d.Dept_Id=s.Dept_Id

--retrieve student names  and department names ensuring that all students and departments
--included even if there is no matching records in the other table 
select St_Fname,Dept_Name
from Student s full outer join  Department d
on d.Dept_Id=s.Dept_Id

--self join 

select s.St_Fname,Sup.*
from Student s inner join Student Sup
on Sup.St_Id=s.St_super

--join multiple tables 
select St_Fname,Crs_Name,Grade
from Student s,Stud_Course sc,Course c 
where s.St_Id = sc.St_Id
and c.Crs_Id=sc.Crs_Id

select St_Fname,Grade,Crs_Name,dept_name
from Student s inner join Stud_Course sc
on s.St_Id = sc.St_Id
inner join Course c 
on c.Crs_Id=sc.Crs_Id
inner join Department d 
on d.Dept_Id=s.Dept_Id
--joins + update 
--update all grade of student 10 and address cairo
update sc
set grade+=10
from Stud_Course sc ,Student s
where s.St_Id=sc.St_Id and St_Address='cairo'










