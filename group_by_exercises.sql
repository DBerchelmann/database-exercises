 #1 Create a new file named group_by_exercises.sql

#2 In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.

select distinct title 
from titles;

# there have been 7 unique titles

#3 Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT last_name
FROM employees
WHERE last_name like "E%E"
GROUP BY last_name;

# There are 5 results, Eldridge, Erbe, Erde, Erie, & Etalle

#4 Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT concat(last_name, ' ', first_name) as full_name, count(*)
FROM employees
WHERE last_name like "E%E"
GROUP BY full_name
ORDER BY count(*) DESC;


#5 Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT concat(last_name, ' ', first_name) as full_name, count(*)
FROM employees
WHERE last_name like "%q%"
AND NOT 
last_name like "%qu%"
GROUP BY full_name;

#Chleq, Lindqvist, Qiwen

#6 Add a COUNT() to your results (the query above) and use ORDER BY to make it easier to find employees whose unusual name is shared with others.

SELECT concat(last_name, ' ', first_name) as full_name, count(*)
FROM employees
WHERE last_name like "%q%"
AND NOT 
last_name like "%qu%"
GROUP BY full_name
ORDER BY count(*) DESC;


#7 Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, count(*), gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
AND (gender = 'M'
OR gender = 'F')
GROUP BY first_name, gender;



#8 Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?


SELECT lower(concat(
	   substr(first_name,1,1),
	   substr(last_name,1,4),
	    "_",
	   substr(birth_date, 6, 2),
	   substr(birth_date, 3, 2))
	    ) AS username, count(*)
FROM employees
GROUP BY username
ORDER BY count(*) DESC;

#below is my code to figure out the bonus. Not working yet but getting there.

SELECT lower(concat(
	   substr(first_name,1,1),
	   substr(last_name,1,4),
	    "_",
	   substr(birth_date, 6, 2),
	   substr(birth_date, 3, 2))
	    ) AS username, count(*)
FROM employees
WHERE sum(count) IN (
	SELECT count(*)
	FROM employees
	HAVING username > 1)
GROUP BY username
ORDER BY count(*) DESC;