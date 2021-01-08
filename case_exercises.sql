# (1) Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that 
# is a 1 if the employee is still with the company and 0 if not.


use employees;

select emp_no, dept_no, hire_date, to_date,
	IF (to_date > curdate(), true, false) AS is_current_employee
from employees
join dept_emp using (emp_no);

# 2 Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

select first_name, last_name,
	CASE
		WHEN LEFT(last_name, 1) >= 'A' AND LEFT(last_name, 1) <= 'H' THEN 'A-H'
		WHEN LEFT(last_name, 1) >= 'I' AND LEFT(last_name, 1) <= 'Q' THEN 'I-Q'
		ELSE 'R-Z'
	END as alpha_group
from employees
group by first_name, last_name;


# 3 How many employees (current or previous) were born in each decade?

select count(birth_date) as number_of_employees,
	CASE
		WHEN birth_date like '195%' THEN '50s'
		ELSE '60s'
		END AS decade_of_birth
FROM employees
GROUP BY decade_of_birth;



# BONUS What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?


SELECT
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
			 WHEN dept_name IN ('Finance', 'HR') THEN 'Finance & HR'
            ELSE dept_name
            END AS dept_group, 
        concat("$", round(avg(salary), 2)) as average_salary
FROM employees.salaries
JOIN employees_with_departments USING (emp_no)
WHERE salaries.to_date > curdate()
GROUP BY dept_group;

