--1
alter function date_fun(@date date) 
returns varchar(50)
as 
begin
--declare @res date  
declare @n varchar(50)
set @n = (select datename(month,@date))
return @n 
end 
--declare @x date = '2002-02-01'
select dbo.date_fun('2002-08-01')

--2 
alter FUNCTION bet_num (@num1 int , @num2 int )
RETURNS @resultt TABLE (bettween int)
AS
BEGIN;
declare @check1 int =0

if @num1 >@num2
begin
	set @check1 = @num1 -1
	while @check1 < @num1 and @check1 >@num2
	begin
		if @check1 <@num1 and @check1 > @num2
			insert into @resultt values (@check1) 
			set @check1 = @check1 - 1
	 end
end
else if @num1 <@num2
begin
	set @check1 = @num1 +1
	while @check1 < @num2 and @check1 >@num1
	begin
		if @check1 >@num1 and @check1 < @num2
			insert into @resultt values (@check1) 
			set @check1 = @check1 + 1
	end
end
RETURN;
END;
select *from bet_num(90,100)  -- desc
select *from bet_num(100,90)  --asc

--3
use ITI
create function st_details(@no int)
returns table 
as
return(select concat(s.St_Fname ,' ',  s.St_Lname) fullname from Department d join Student s
on d.Dept_Id = s.Dept_Id where s.St_Id = @no)

select * from dbo.st_details(5)

--4
alter function iff(@no int )
returns varchar(100)
as 
begin 
declare @check1 varchar(100)
declare @check2 varchar(100)
declare @printt varchar(100)
select @check1= s.St_Fname,@check2=St_Lname from Student s where s.St_Id = @no 
if @check1 is null and @check2 is null
	set @printt ='first_name&last_name is null'
else if @check1 is null  
	set @printt=' first name is null'
else if   @check2 is null 
	set @printt=' lastname name is null'
	
else if @check1 is not null and @check2 is not null
		set @printt=' fullname name is not null'
return @printt
end 

select dbo.iff(14)

--5
use ITI
alter function manger_details(@no int)
returns table 
as
return(select i.Ins_Name , d.Manager_hiredate, d.Dept_Manager,d.Dept_Name 
from Department d join Instructor i on d.Dept_Manager =i.Ins_Id where d.Dept_Manager =@no )

select *from dbo.manger_details(1)

--6
CREATE FUNCTION str_details (@strr varchar(50))
RETURNS @result TABLE (strr varchar(50))
AS
BEGIN;
if @strr = 'first_name'
	insert into @result select isnull(s.St_Fname, 'nan') from Student s
else if @strr = 'last name'
	insert into @result select isnull(s.St_Lname ,'nan') from Student s
else if @strr = 'full name'
	insert into @result select concat(isnull(s.St_Fname ,'nan') , isnull(s.St_Lname,'nan')) full_name from Student s
RETURN;
END;
-- (select s.St_Fname from Student s)
select *from str_details('full name')
select *from str_details('first name')
select *from str_details('last name')