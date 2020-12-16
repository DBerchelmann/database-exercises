# tables_exercises.sql
SHOW databases;

# use the employee database
USE employees;

# list all the tables in the database
SHOW tables;

# Explore the employees table. What different data types are present on this table?
INT, VARCHAR, DATE, CHAR, ENUM;

# Which table(s) do you think contain a numeric type column?
all tables contain a numeric type column except departments;

# Which table(s) do you think contain a string type column?
all tables contain a string type column except salaries;

# Which table(s) do you think contain a date type column?
all tables contain a date type column except departments and employees_with_departments;

# What is the relationship between the employees and the departments tables?
The information from both tables is used in the employees_with_departments (minus the gender and start date);

# Show the SQL that created the dept_manager table.
SHOW create table dept_manager;

# CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1