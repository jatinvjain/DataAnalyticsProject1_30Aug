-- Querying the Data

select * from employees order by 1 asc;

select * from employees where department = 'Marketing';

select * from employees where department != 'Marketing';

-- Using Alias name 

select
	emp_id,
	name as emp_name
from employees;

-- Arithmetic Expressions in Query

select 
	emp_id,
	name,
	salary as monthly_salary,
	salary * 12 as annual_salary
from employees;

--Q: Retrieve employees name, their monthly salary, and a 10% bonus fo the salary.

select 
	name,
	salary as monthly_salary,
	salary * 0.10 as bonus
from employees;

--FIltering the data with Where Clause

--Q: Retrieve employees in IT dept with a salary greater than 20000.

select * from employees where department = 'IT' and salary > 20000;

--Q: Retrieve employees in IT dept or salary greater than 25000.

select * from employees where department = 'IT' or salary > 25000;

--Q: salary BETWEEN 30000 and 60000

select * from employees where salary BETWEEN 30000 and 60000;

selec

--Using 'IN' in Where condition

select * from employees where department IN ('IT','Finance');

--NOT IN

select * from employees where department NOT IN ('IT','Finance');

-- Using LIKE 

--%<letter> ending of the word
--%<letter>% anywhere in the word
--<letter>% Starting of the word

select 
	name,
	department,
	salary
from employees
where name like '%e%';

select 
	name,
	department,
	salary
from employees
where name like 'G%';

select 
	name,
	department,
	salary
from employees
where name like '%e';

--NOT Like

select 
	name,
	department,
	salary
from employees
where name not like '%e%';

-- Sorting data

select * from employees 
order by emp_id asc;

select * from employees 
order by emp_id desc;

--Sorting with multiple columns

select * from employees
order by department asc, salary desc;

select * from employees
order by department desc, salary asc;


select 
	emp_id as employees_id
from employees
where employees_id > 5;

select * from departments;

-- Joins

-- 1) inner join: Returns only rows where there is a match in both tables

-- SYNTAX
-- select * from <table_1>
-- inner join <table_2> ON table_2.col = table_1.col

select * from employees
inner join departments on departments.dept_name = employees.department
order by emp_id;

select * from employees a
inner join departments b on b.dept_name = a.department
order by emp_id;

select 
	employees.emp_id,
	employees.name,
	employees.department,
	departments.dept_id
from employees
inner join departments on departments.dept_name = employees.department
order by emp_id;

select 
	a.emp_id,
	a.name,
	a.department,
	b.dept_id
from employees a
inner join departments b on b.dept_name = a.department
order by a.emp_id;

-- left join 

select 
	a.emp_id,
	a.name,
	a.department,
	b.dept_id,
	b.dept_name
from employees a
left join departments b on b.dept_name = a.department
order by emp_id;

select 
	b.emp_id,
	b.name,
	b.department,
	a.dept_id,
	a.dept_name
from departments a
left join employees b on b.department = a.dept_name
order by emp_id;

-- Right join

select 
	a.emp_id,
	a.name,
	a.department,
	b.dept_id,
	b.dept_name
from employees a
right join departments b on b.dept_name = a.department
order by emp_id;

-- Full Outer join

select 
	a.emp_id,
	a.name,
	a.department,
	b.dept_id,
	b.dept_name
from employees a
full outer join departments b on b.dept_name = a.department
order by emp_id;

-- Aggregating and Grouping 

--	COUNT, SUM, AVG, MAX, MIN


select * from employees;

select * from departments;

select count(*) from departments;

select count(emp_id) from employees;

select count(department) from employees;

select count (distinct department)  from employees;

select distinct department from employees;

select 
sum(salary) as Total_salary
from employees;

select 
	avg(salary) as Avg_salary
from employees;

select 
	Round(avg(salary),3) as Avg_salary
from employees;

Select 
Min(age) as min_age
from employees;

Select 
Max(age) as min_age
from employees;

-- Group By

select 
	department, 
	count(*)
from employees
group by department;

select 
	hire_date,count(*)
from employees
group by hire_date
order by hire_date;

select 
	department, 
	sum(salary) as total_salary
from employees
group by department;

select 
	department, 
	Round(Avg(salary),2) as avg_salary
from employees
group by department;

select 
	department, 
	Min(age) as min_age
from employees
group by department;

select 
	department, 
	MAx(age) as max_age
from employees
group by department;


--1

select
	department,
	count(*)
from employees
Group by department;

--2

select
	MIN(SALARY) as min_salary,
	max(salary) as max_salary
from employees
where department = 'Sales';

--3

select 
	department,
	round(avg(salary),2) as avg_salary
from employees
where age >= 25
group by department
order by department

select 
	department,
	hire_date,
	count(*)
from employees
group by department, hire_date
order by department asc ,hire_date desc;

--having clause

select 
	department,
	round(avg(salary),2) as avg_salary
from employees
group by department
having avg(salary) > 20000

	-- select 
	-- 	<col_1>,
	-- 	<col_2>,
	--	<col_3>
	-- from <table_name>
	-- where <condition> and <cond_2> and <cond_3> or <cond_4>
	-- group by <col_1>,<col_2>
	-- having <condition>
	-- order by <col_1>,<col_2>


--Q: Find departments with more than 2 employee.

select 
	department,
	count(emp_id)
from employees
group by department
having count(emp_id) > 2 

--Q: Find departments where the total salary expenditure is greater than 50000.

select 
	department,
	sum(salary)
from employees
group by department
having sum(salary) > 50000

--Q: Find departments where:The average salary is greater than 30000, 
--and The number of employees is greater than 1 of employees age >=25.


(select 
	department,
	avg(salary) as avg_salary,
	count(emp_id) as emp_count
from employees
where age >= 25
group by department
having avg(salary) > 30000
and count(emp_id) > 1
)

select* from employees; 

--Subqueries

select * from 
(select * from employees)

select * from 
(select 
	a.emp_id,
	a.name,
	a.department,
	b.dept_id,
	b.dept_name
from employees a
right join departments b on b.dept_name = a.department
order by emp_id)
where emp_id is null

--Q: Find employees whose salary is greater than the average salary

select *
from employees
where salary > (select avg(salary) from employees);

--Q: Retrieve the employee name, salary, and the difference between their salary and the average salary.

select 
	name,
	salary,
	salary - (select avg(salary) from employees) as salary_difference
from employees;

select 
	name,
	salary,
	round(salary - (select avg(salary) from employees),2) as salary_difference
from employees;


--Write a query to retrieve employees whose salary is greater than the highest salary in the "Finance" department. [HINT: Use subquery in where condition]
	select name, salary
	from employees e
	where salary > (
    select max(salary)
    from employees
    where department = 'Finance'
	)

--Write a query to retrieve dept_id that have more than 2 employees.[HINT: joins and having]

	select d.dept_name, count(e.emp_id) as employee_count
	from departments d
	left join employees e on d.dept_name = e.department
	group by d.dept_name
	having count(e.emp_id) > 2

--updating a specific record

Syntax

-- update <table_name>
-- set <col_1> = <value>
-- where condition

update employees
set salary = 10500
where emp_id = 2;

update employees
set department = 'Markerting'
where emp_id = 1;

--Alter a column name

Syntax

-- alter table <table_name>
-- rename <col_1> to <new_col_name>;

alter table employees
rename name to emp_name;


--Alter a column data type

syntax

-- alter table <table_name>
-- alter <col_name> type <new_data_type>;

alter table employees
alter emp_name type varchar(50);

--Alter a table name

Syntax

-- Alter table <table_name>
-- rename to <new_table_name>;

alter table department
rename to departments;


-------------------------------------------------------------

--transaction

--works when using DML

Begin;

update employees
set department = 'Sales'
where emp_id = 7;

update employees
set department = 'IT'
where emp_id = 1;

commit;

rollback;

select * from employees
order by 1;

----------------------------------------

begin;

alter table departments
rename to department;

commit;

--------------------------------------

DDL : Data Definition Language

CREATE - Creates a database object (table, schema)

ALTER - Modifies the database object (column names, data types, table structure)

DROP - DELETING A TABLE 
--
	--DROP TABLE employees;
--

TRUNCATE - Removing the data inside a table

	Truncate table employees;


--------------------------------------------------------------------------------------

DML: Data Manipulation Language

INSERT - Adds new data into a table

UPDATE - Modifies existing data

DELETE - Removes data

--
Syntax

--DELETE FROM <TABLE_NAME> WHERE condition;

DELETE FROM employees WHERE department = 'Games'

----------------------------------------------------

DQL: Data Query Language

SELECT: Retrieves data

----------------------------------------------------

TCL: Transaction Control Language

BEGIN - Starts a transaction

COMMIT - Saves changes

ROLLBACK - Reverts changes

SAVEPOINT - Sets a point to roll back to


Begin;

update employees
set department = 'Marketing'
where emp_id = 7;

update employees
set department = 'IT'
where emp_id = 1;

SAVEPOINT day1;

update employees
set department = 'Finance'
where emp_id = 10;

update employees
set department = 'IT'
where emp_id = 8;

rollback to day1;

commit;

select * from employees
order by 1;


------------------------------------------------------------------------

--inner join

select * from employees inner join department on department = dept_name;

select * from employees a inner join department b on a.department = b.dept_name;

--left join 

select * from employees left join department on department = dept_name;

--Right join

select * from employees right join department on department = dept_name;

--Full Outer Join

select * from employees full outer join department on department = dept_name;

--Right join 

select * from department right join employees on department = dept_name;


select 
	d.dept_id,
	d.dept_name,
	e.emp_id,
	e.emp_name,
	e.age
from department d 
right join employees e on e.department = d.dept_name;

-------------------------------------------------------------------

--subqueries

--subqueries in select statement 

select 
	col_1,
	col_2,
	(subquery)
from <table>
where <condition>


--in where condition

select 
	col_1,
	col_2
from <table>
where <subquery>

--in from 

select 
	col_1,
	col_2
from <subquery>
where <condition>

--------------------------

--subquery in from

select emp_id, emp_name from
(
select 
	d.dept_id,
	d.dept_name,
	e.emp_id,
	e.emp_name,
	e.age
from department d 
right join employees e on e.department = d.dept_name
)

--Q: Find employees whose salary is greater than the average salary

select avg(salary) from employees

select * from employees where salary > (select avg(salary) from employees)


--in select 

--Q: Retrieve employees name, salary and the difference between their salary and average salary

select 
	emp_id,
	emp_name,
	salary,
	(select avg(salary) from employees) as salary_diff
from employees;

-----------------------------------------------------------------------------------


--having clause

--group the data and filter based on aggregate condition

select 
	department,
	count(emp_id)
from employees
group by department


--Q:Retrieve departments where the total salary is greater than 50000

select 
	department,
	sum(salary)
from employees
group by department
having sum(salary) > 50000

--Q: write a query to retrieve departments where the total salary is greater than the total salary of "Finance" department
--[HINT: Having and subquery]

select 
	department,
	sum(salary)
from employees
group by department
having sum(salary) >
	(select sum(salary) from employees where department = 'Finance');

--Q: write a query to retrieve departments where the average salary is greater than the total salary of "Finance" department
--[HINT: Having and subquery]

select 
	department,
	avg(salary)
from employees
group by department
having avg(salary) >
	(select sum(salary) from employees where department = 'Finance');

--

Begin;

update employees
set department = 'IT'
where emp_id = 7;

update employees
set department = 'Finance'
where emp_id = 1;

SAVEPOINT day1;

update employees
set department = 'Finance'
where emp_id = 10;

update employees
set department = 'IT'
where emp_id = 8;

SAVEPOINT day2;

update employees
set department = 'Marketing'
where emp_id = 2;

update employees
set department = 'IT'
where emp_id = 11;

SAVEPOINT day3;

rollback to day2;

commit;

----------------------------------------------------------------
select * from employees order by department asc, salary desc

select 
	department,
	sum(salary)
from employees
group by department

---------------------------------------------------------------

-- Window Function

-- Ranking Function
	-- ROW_NUMBER
	-- RANK
	-- DENSE_RANK
	-- NTILE

-- Aggregate Function
	-- SUM
	-- AVG
	-- COUNT

-- Value Function
	-- LAG
	-- LEAD
---------------------------
-- Ranking Function
	-- ROW_NUMBER

select 
	 *
	,row_number() over (partition by department) as row_num
from employees


select 
	 *
	,row_number() over (partition by department order by salary desc) as row_num
from employees

-----
--RANK

select 
	 *
	,rank() over (partition by department order by salary desc) as row_num
from employees

-----
--DENSE_RANK

select 
	 *
	,dense_rank() over (partition by department order by salary desc) as row_num
from employees

-----
--NTILE(n): Divides rows into N groups as evenly as possible

select 
	 *
	,ntile(4) over (order by salary desc) as split_group
from employees

-----------
--Aggregate Window Function
-- SUM()

select 
	 *
	,sum(salary) over (partition by department) as dept_total_salary
from employees

--AVG
select 
	 *
	,round((avg(salary) over (partition by department)),2) as dept_avg_salary
from employees

--COUNT
select 
	 *
	,count(*) over (partition by department) as dept_total_count
from employees

--Running Total(cumulative sum)

select
	emp_name
	,department
	,hire_Date
	,salary
	,sum(salary) over (order by hire_Date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
from employees

-------
--VALUE FUNCTION
-- LAG()


select
	 emp_name
	,department
	,hire_Date
	,salary
	,lag(salary) over (order by hire_date asc) as prev_salary
	,salary - lag(salary) over (order by hire_date asc) as salary_diff
from employees	

select
	 emp_name
	,department
	,hire_Date
	,salary
	,lag(salary) over (partition by department order by hire_date asc) as prev_salary
from employees	

--LEAD
select
	 emp_name
	,department
	,hire_Date
	,salary
	,lead(salary) over (order by hire_date) as prev_salary
from employees	









