#1 Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

--------------------------
#1 Create a file named where_exercises.sql. Make sure to use the employees database.
USE employees;

SHOW tables;

#2 Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

# Number of records returned was 709



#3 Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?

SELECT *
FROM employees
WHERE first_name = 'Irena' OR 
	  first_name = 'Vidya' OR 
	  first_name = 'Maya';
	
# Number of records returned was still 709, yes it matched.

#4 Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE (first_name = 'Irena' OR 
	  first_name = 'Vidya' OR 
	  first_name = 'Maya')
AND gender = 'M';

# Records returned is 441

#5 Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.

SELECT *
FROM employees
WHERE last_name LIKE "E%";

# Number of employees with Last name beginning with "E" is 7330



#6 Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?

SELECT *
FROM employees
WHERE last_name LIKE "%E" 
OR 
last_name LIKE "E%";

SELECT *
FROM employees
WHERE last_name LIKE "%E" 
AND NOT 
last_name LIKE "E%";

# 30,723 employees have a name that starts or ends with "E".  23,393 employees have a name that ends with "E" but not starts with "E"

#7 Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees last names end with E, regardless of whether they start with E?

SELECT *
FROM employees
WHERE last_name LIKE "%E" 
AND 
last_name LIKE "E%";

SELECT *
FROM employees
WHERE last_name LIKE "%E";


# 899 employees have a name that begins and ends with an "E" 
# 24,292 employees have a name that ends with "E" regardless if it begins with an "E"

#8 Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE hire_date LIKE "199%-%-%";

# Number of employees returned is 135,214


#9 Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE birth_date LIKE "%-12-25";

# 842 employees born on Christmas day

#10 Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE hire_date LIKE "199%-%-%"
AND
birth_date LIKE "%-12-25";

# 362 employees born on Christmas Day and hired in the 1990s


#11 Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE last_name LIKE "%Q%";

# 1,873 employees have a last name with the letter "Q" somewhere within it

#12 Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

SELECT *
FROM employees
WHERE last_name LIKE "%Q%"
AND NOT
last_name LIKE "%QU%";

# There are 547 employees with a "Q" in their last but not a "QU" 


--------------------------------------


#2 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

# The name in the first row is Irena Reutenauer and the name in the last row is Vidya Simmen



#3 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;


# The name in the first row is Irena Acton and the name in the last row is Vidya Zweizig


#4 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?


SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

# The name in the first row is Irena Acton and the name in the last row is Maya Zyda

#5 Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

SELECT *
FROM employees
WHERE (last_name LIKE "%E" 
AND 
last_name LIKE "E%")
ORDER BY  emp_no;

# 899 employes returned. The first emp_no is 10021 with a name of Ramzi Erder and the last emp_no is 499648 with a name of Tadahiro Erde


#6 Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.


SELECT *
FROM employees
WHERE (last_name LIKE "%E" 
AND 
last_name LIKE "E%")
ORDER BY  hire_date DESC;

# 899 employes returned. The newest employee is Teiji Eldridge and the oldest employee is Sergi Erde.

#7 Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.


SELECT *
FROM employees
WHERE (hire_date LIKE "199%-%-%"
AND
birth_date LIKE "%-12-25")
ORDER BY hire_date DESC, birth_date DESC;

# 362 employees returned. The name of the oldest employee hired last is Khun Bernini and the youngest employee hired first is Alselm Cappello