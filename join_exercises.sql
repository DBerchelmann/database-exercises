# Use the join_example_db. Select all the records from both the users and roles tables.

select *
from roles 
JOIN users;

# Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.


select *
from users
JOIN roles ON users.role_id=roles.id;



select *
from roles
LEFT JOIN users ON users.role_id=roles.id;

select *
from users
LEFT JOIN roles ON users.role_id=roles.id;

# Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.


select roles.name, count(users.d) as "Number of people in role"
from roles 
LEFT JOIN users ON users.role_id=roles.id
GROUP BY roles.name;

# Employees Database

# Use the employees database.

# Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

use employees;
show tables;

select departments.dept_name AS "Department Name", concat(first_name, " ", last_name) AS "Department Manager"
from employees_with_departments
JOIN dept_manager ON dept_manager.emp_no=employees_with_departments.emp_no
JOIN departments ON dept_manager.dept_no=departments.dept_no
WHERE dept_manager.to_date>curdate(); 

# Find the name of all departments currently managed by women.

select departments.dept_name AS "Department Name", 
       concat(employees_with_departments.first_name, " ", employees_with_departments.last_name) AS "Department Manager"
from employees_with_departments
JOIN dept_manager ON dept_manager.emp_no=employees_with_departments.emp_no
JOIN departments ON dept_manager.dept_no=departments.dept_no
JOIN employees ON employees.emp_no=employees_with_departments.emp_no
WHERE dept_manager.to_date>curdate() AND
      employees.gender = "F"
ORDER BY departments.dept_name; 
      
      
# Find the current titles of employees currently working in the Customer Service department.


select title AS "Title", COUNT(dept_emp.emp_no) AS "Count"
from dept_emp
JOIN titles ON titles.emp_no = dept_emp.emp_no
WHERE dept_no = 'd009' AND
      titles.to_date>curdate() AND
      dept_emp.to_date>curdate()
GROUP BY title; 

# Find the current salary of all current managers.

select departments.dept_name AS "Department Name", 
       concat(first_name, " ", last_name) AS "Name",
       salary
from employees_with_departments
JOIN dept_manager ON dept_manager.emp_no=employees_with_departments.emp_no
JOIN departments ON dept_manager.dept_no=departments.dept_no
JOIN salaries ON salaries.emp_no = employees_with_departments.emp_no
WHERE dept_manager.to_date>curdate() AND 
      salaries.to_date>curdate(); 
      
# Find the number of current employees in each department.

select departments.dept_no, dept_name, COUNT(*) AS "num_employees"
from departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date>curdate()
GROUP BY departments.dept_no, dept_name;

# Which department has the highest average salary? Hint: Use current not historic information.

SELECT dept_name, ROUND(avg(salary), 2) AS "average_salary"
FROM dept_emp
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE dept_emp.to_date>curdate() AND
      salaries.to_date>curdate()
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

# Who is the highest paid employee in the Marketing department?

SELECT first_name, last_name
FROM employees_with_departments
JOIN salaries ON employees_with_departments.emp_no = salaries.emp_no
WHERE dept_name = "Marketing"
ORDER BY salary DESC
LIMIT 1;

# Which current department manager has the highest salary?

select first_name,
       last_name,
       salary,
       dept_name
from dept_manager
JOIN employees_with_departments ON dept_manager.emp_no = employees_with_departments.emp_no
JOIN salaries ON dept_manager.emp_no = salaries.emp_no
where dept_manager.to_date > curdate()
ORDER BY salary DESC
LIMIT 1;

# Bonus Find the names of all current employees, their department name, and their current managers name.

select concat(employees.first_name, " ", employees.last_name) AS "Employee Name", 
       dept_name AS "Department Name",
       concat(employees_with_departments.first_name, " ", employees_with_departments.last_name) AS "Manager Name"
from employees_with_departments
JOIN dept_manager 
		ON dept_manager.emp_no = employees_with_departments.emp_no
JOIN dept_emp 
		ON dept_emp.dept_no = dept_manager.dept_no
JOIN employees
		ON employees.emp_no = dept_emp.emp_no
WHERE dept_manager.to_date > curdate() AND
      dept_emp.to_date > curdate()
ORDER BY dept_name, employees_with_departments.last_name, employees_with_departments.first_name;


# below is faster way to solve bonus problem 10

select concat(employees.first_name, " ", employees.last_name) as "employee_name", dept_name,
concat(managers.first_name, " ", managers.last_name) as "manager_name"
from employees
join dept_emp using(emp_no)
join departments using(dept_no)
join dept_manager using(dept_no)
join employees as managers on managers.emp_no = dept_manager.emp_no
where dept_manager.to_date > curdate()
and dept_emp.to_date > curdate();

# Bonus Who is the highest paid employee within each department.

select first_name, last_name, salary, dept_name
from employees
join salaries ON salaries.emp_no = employees.emp_no
join dept_emp ON dept_emp.emp_no = employees.emp_no
join departments ON departments.dept_no = dept_emp.dept_no
where salary in (

		select max(salary)
		from employees
		join salaries ON salaries.emp_no = employees.emp_no
		join dept_emp ON dept_emp.emp_no = employees.emp_no
		join departments ON departments.dept_no = dept_emp.dept_no
		group by dept_name
)
AND salaries.to_date > curdate() AND
dept_emp.to_date > curdate();