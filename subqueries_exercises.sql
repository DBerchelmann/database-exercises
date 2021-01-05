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