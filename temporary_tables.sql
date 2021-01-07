use easley_1264;


# 1 Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

select *
from employees_with_departments;


# (a) Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

ALTER TABLE employees_with_departments ADD COLUMN full_name VARCHAR(31);

# (b) Update the table so that full name column contains the correct data

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, " ", last_name);

select *
from employees_with_departments;

# (c) Remove the first_name and last_name columns from the table

ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

select * 
from employees_with_departments;

# (d) What is another way you could have ended up with this same table?

CREATE TEMPORARY TABLE ewd AS
SELECT emp_no, dept_no, dept_name, concat(first_name, " ", last_name) as "full_name"
FROM employees.employees_with_departments
LIMIT 100;

select *
from ewd;

# (2) Create a temporary table based on the payment table from the sakila database.


DROP TEMPORARY TABLE payment8;


select *
from sakila.payment;

CREATE TEMPORARY TABLE new_payment1 AS (
		SELECT *
		FROM sakila.payment);

select *
from new_payment1;

# Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
# For example, 1.99 should become 199.

Alter table new_payment1 
modify AMOUNT DECIMAL(10, 4);

UPDATE new_payment1
SET AMOUNT = AMOUNT * 100;

Alter table new_payment1 
modify AMOUNT INT;

select *
from new_payment1;
 # (3) Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
 
use employees;

select dept_name, round(avg(salary), 2) as "average historical salary"
from employees_with_departments as ewd 
join salaries using (emp_no)
where to_date < curdate()
group by dept_name;

select dept_name, round(avg(salary), 2) as "average current salary"
from employees_with_departments as ewd 
join salaries using (emp_no)
where salaries.to_date > curdate()
group by dept_name;


