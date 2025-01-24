
--PART 11111
--1
declare t_cur cursor
	for select e.SSN,e.Fname,e.Salary from Employee e
	for update

declare @id int
declare @name nvarchar(50)
declare @s int
open t_cur 
fetch t_cur into @id,@name,@s
begin
	While @@fetch_status=0
	begin
		if @s<3000
			begin
				update Employee	set Salary= @s*1.10 
				where current of t_cur 
		fetch t_cur into @id,@name,@s
			end
	   else
			begin
				  update Employee
				  set Salary = Salary * 1.20
				 where Employee.SSN = @id;
			end

	end
end
close t_cur
deallocate t_cur

--2
use iti
--select *from Department
--select *from Instructor
declare dep_cur cursor
	for select i.Ins_Name,d.Dept_Name from Department d join Instructor i on i.Ins_Id = d.Dept_Id  
	for read only  --update


declare @manger_name varchar(50)
declare @dep_name nvarchar(50)
open dep_cur 
fetch dep_cur into @manger_name,@dep_name
begin
	While @@fetch_status=0  --returns 0 success -- 1 failed  --2 no more rows to fetch
	begin
		select @manger_name,@dep_name 
		fetch dep_cur into @manger_name,@dep_name
	end
end
close dep_cur
deallocate dep_cur

---3
use ITI
go
declare StudentCursor cursor for
select St_Fname
from Student

declare @StudentNames varchar(MAX)
declare @FirstName varchar(100)
set @StudentNames = ''

open StudentCursor
fetch next from StudentCursor into @FirstName
while @@FETCH_STATUS = 0
begin
    SET @StudentNames = @StudentNames + @FirstName + ', '
    fetch next from StudentCursor INTO @FirstName
end
close StudentCursor
deallocate StudentCursor
set @StudentNames = LEFT(@StudentNames, LEN(@StudentNames) - 2)
print @StudentNames

---4
-- Create a full backup of the database
backup database ITI
to disk = 'C:\Users\Dell\Desktop\ITI_ITI_ITI'
with format, 
     name = 'full_bacup',
     description = 'full',
     init, 
     stats = 10
-- Create a differential backup of the database
backup database ITI
to disk = 'C:\Users\Dell\Desktop\ITI_ITI_ITI'
with differential, 
	 name = 'Diff_bacup',
     description = 'differential backup',
     init, 
     stats = 10
-----------PART 22222
/*
1. Batch, Script, and Transaction
Batch:A group of one or more T-SQL statements sent to SQL Server for execution at once.
It is executed as a single unit, but each statement is parsed and compiled independently.

Script:A collection of T-SQL statements stored in a file or editor and executed as a set.
Can include multiple batches and transactions.

Transaction:A sequence of operations performed as a single logical unit of work.
Follows the ACID properties (Atomicity, Consistency, Isolation, Durability).

2.Trigger and Stored Procedure
Trigger:A special type of stored procedure that automatically executes in response to certain database events (e.g., INSERT, UPDATE, DELETE).
Cannot be called explicitly.

Stored Procedure:A reusable set of T-SQL statements that can be explicitly called to perform a specific task.
Can accept parameters and return values.

3. Stored Procedure and Functions
Stored Procedure:Can perform actions like modifying data and managing transactions.
May or may not return a value.

Function:Returns a single value or a table.
Cannot modify data or manage transactions.

4. DROP, TRUNCATE, and DELETE Statement
DROP:Removes the table (or other objects) completely from the database.

TRUNCATE:Deletes all rows from a table without logging individual row deletions.
Resets identity columns.
Cannot be rolled back if outside a transaction.

DELETE:Deletes specific rows based on a condition.
Logs each deletion, so it can be rolled back.

5. SELECT and SELECT INTO Statement
SELECT:Retrieves data from a table.

SELECT INTO:Retrieves data and creates a new table with the result.

6. Local and Global Variables
Local Variables:Declared with DECLARE and scoped to a single batch or stored procedure.

Global Variables:Predefined by SQL Server and available system-wide.

7. CONVERT and CAST Statements
CONVERT:Used to explicitly convert data types with additional style options for formats.

CAST:Standard SQL method to convert data types.

8. DDL, DML, DCL, DQL, and TCL
DDL (Data Definition Language): Defines database structures (e.g., CREATE, ALTER, DROP).
DML (Data Manipulation Language): Manipulates data (e.g., INSERT, UPDATE, DELETE).
DCL (Data Control Language): Controls access (e.g., GRANT, REVOKE).
DQL (Data Query Language): Queries data (e.g., SELECT).
TCL (Transaction Control Language): Manages transactions (e.g., COMMIT, ROLLBACK).

9. FOR XML RAW and FOR XML AUTO
FOR XML RAW:Returns data in raw XML format with each row as a <row> element.

FOR XML AUTO:Automatically creates nested XML based on table relationships.

10. Table-Valued and Multi-Statement Functions
Table-Valued Function:Returns a table from a single query.

Multi-Statement Function:Returns a table but allows multiple statements to define the result.
Can store up to 2 GB of data.

12. DATETIME(3), DATETIME2(7), and DATETIMEOFFSET(7)

DATETIME(3): -- Precision up to 3 fractional seconds.
Example:--  YYYY-MM-DD hh:mm:ss.mmm.
DATETIME2(7):-- Precision up to 7 fractional seconds and larger range.
Example: -- YYYY-MM-DD hh:mm:ss.nnnnnnn.
DATETIMEOFFSET(7):-- Includes time zone offset.
Example:--  YYYY-MM-DD hh:mm:ss.nnnnnnn ±hh:mm.

13. Default Instance and Named Instance
Default Instance:The default SQL Server instance accessed using just the server name.
Example: ServerName.

Named Instance:Additional instances with unique names accessed using ServerName\InstanceName.
Example: ServerName\MyInstance.

14. SQL and Windows Authentication

SQL Authentication:Requires a username and password created within SQL Server.
Windows Authentication:Uses the Windows user credentials to authenticate.
*/