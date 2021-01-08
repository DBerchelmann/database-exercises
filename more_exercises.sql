use easley_1264;
create temporary table depts_avg_sal as (
select ewd.dept_no, avg(salary) as dept_avg
from employees.employees_with_departments as ewd
join employees.salaries using(emp_no)
join employees.employees using (emp_no)
where employees.salaries.to_date > curdate()
group by ewd.dept_no);
select *
from depts_avg_sal;

create temporary table manager_salary as 
(select dept_no, salary
from employees.dept_manager
join employees.salaries using(emp_no)
where salaries.to_date > curdate()
and dept_manager.to_date > curdate());
select *
from manager_salary;

create temporary table manager_vs_dept as(
select *
from depts_avg_sal
join manager_salary using (dept_no));
select *
from manager_vs_dept;

# How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

use employees;

# find average manager salary by using dept_manager (emp_no) and joining it with salaries and then join employees tab with emp_no, group by dept.









use world;
# What languages are spoken in Santa Monica?

select language
from countrylanguage
join city using (countrycode)
where city.name = (select name from city where name = 'Santa Monica');

# How many different countries are in each region?

select region, count(name) as countries
from country
group by region;

# What is the population for each region?

select region, sum(population) as total_population
from country
group by region DESC
order by total_population DESC;

# What is the population for each continent?

select distinct continent, sum(population) as total_population
from country
group by continent
order by total_population desc;

