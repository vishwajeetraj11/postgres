/*
A Sub query allows you to construct complex queries, essentially performing a query on the results of another query.

The syntax is straightforward and involves two SELECT statements.

Imagine a table consisting of student names and their test scores.

Standard Query
SELECT student, grade FROM test_scores

Standard Query to return average grade 
SELECT AVG(grade) FROM test_scores

How can we get a list of students who scored better than the average grade?

It looks like we need two steps, first get the average grade, then compare the rest of the table against it.

This is where a subquery can help us get the result in a "single" query request.
SELECT AVG(grade) FROM test_scores WHERE grade > (SELECT AVG(grade) FROM test_scores)

The subquery is performed first since it is inside the parenthesis.

We can also use the IN operator in conjuction with a subquery to check against multiple results returned.

Ex:- 
A subquery can operate on a separate table:-

SELECT 
student,grade 
FROM test_scores 
WHERE student IN (
SELECT student
FROM honor_roll_table
)

=> 
SELECT student,grade
FROM test_scores
WHERE student IN (('Zach','Chris','Larissa'))

The EXISTS operator is used to test for existence of rows in a subquery.
Typically a subquery is passed in the EXISTS() function to check if any rows are
returned with the subquery.

Typical Syntax:-
SELECT column_name
FROM table_name
WHERE EXISTS
(SELECT column_name FROM table_name WHERE condition);
*/

SELECT * FROM film;

-- Film that have rental_rate than the avg rental rate
SELECT * FROM film WHERE rental_rate > (SELECT ROUND(AVG(rental_rate),3) FROM film);

-- Films returned between 2005-05-29 AND 2005-05-30
SELECT 
inventory.film_id
FROM rental
INNER JOIN inventory 
ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date BETWEEN '2005-05-29' AND '2005-05-30'
;

SELECT 
film_id, title 
FROM film
WHERE film_id IN 
(
SELECT 
inventory.film_id
FROM rental
INNER JOIN inventory 
ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date BETWEEN '2005-05-29' AND '2005-05-30'
)
ORDER BY title;

-- EXIST Operator
-- We want to find customers who have atleast one payment whose amount is greater than 11 also grab their firstname and lastname

SELECT 
first_name, last_name
FROM 
customer c
WHERE EXISTS
(
SELECT * FROM payment p
	WHERE p.customer_id = c.customer_id
	AND
	amount > 11
);


/*
In the above example, for each customer in the customer table the subquery checks the payment table to find if the customer made at least one payment.

The opposite also exists.
*/


SELECT 
first_name, last_name
FROM 
customer c
WHERE NOT EXISTS
(
SELECT * FROM payment p
	WHERE p.customer_id = c.customer_id
	AND
	amount > 11
)


