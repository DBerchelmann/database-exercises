# practice problem from ryan below

select * 
from employees
where emp_no in (
	select emp_no
	from dept_manager
	where to_date > curdate()
	)
AND gender = "F";


# (1) Find all the current employees with the same hire date as employee 101010 using a sub-query.

# need to use the employees table to gather hire date and employee number
# need to join the employees table with dept_emp to get the current employees using the to_date
# use a subquery to get hire date column to match hire date for employee 101010

select * 
from employees
join dept_emp ON dept_emp.emp_no = employees.emp_no
where hire_date = (
	select hire_date
	from employees
	where emp_no = 101010) AND
to_date > curdate();

# Find all the titles ever held by all current employees with the first name Aamod.

# will need to access employees table to get name
# will need to link employees to titles to get all titles ever held by linking with emp_no
# to_date can be found in titles column
select title
from employees
join titles ON titles.emp_no = employees.emp_no
where first_name IN (select first_name
from employees
where first_name = "Aamod") AND
titles.to_date > curdate()
group by title;

# 3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

# will need to use employee table and dept_emp to link up to_dates

select count(emp_no)
from employees
JOIN dept_emp using (emp_no)
WHERE to_date IN (
	SELECT to_date
	FROM dept_emp
	WHERE to_date < curdate()
);

# 4 Find all the current department managers that are female. List their names in a comment in your code.

# need to link employee number and dep_manger number using emp_no and also to_date

select first_name, last_name, gender
from employees
join dept_manager using (emp_no)
where gender IN (
	select gender
	from employees
	where gender = "F") AND 
to_date > curdate();

# 5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.

# Need salaries table
# need average of all salaries (not just current)
# subquery will be a WHERE emp_no > (select avg(salaries) from salaries)
# will also need a current to_date which can be found in salaries

select first_name, last_name, salary
from employees
join salaries using (emp_no)
where salary > (
	select avg(salary)
	from salaries) AND
salaries.to_date > curdate()
ORDER BY salary DESC;

select avg(salary)
from salaries;