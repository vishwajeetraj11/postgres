-- INNER JOIN
SELECT 
customer.customer_id,
payment.payment_id,
first_name
FROM payment 
INNER JOIN customer 
ON payment.customer_id = customer.customer_id;

/*
FULL OUTER JOIN (Grab Everything from both the tables.)

Syntax: 
SELECT * FROM TableA 
FULL OUTER JOIN TableB
ON TableA.col_match = TableB.col_match

if TableA and TableB are swapped then the output won't differ because we are getting everything from both the tables.

First comes common from both table
then ALL uncommon from Table A
next All uncommon from TableB

FULL OUTER JOIN with WHERE statement (Exact Opposite of INNER Join)
(Get rows unique to either table)
(rows not found in both tables)

SELECT * FROM TableA 
FULL OUTER JOIN TableB
ON TableA.col_match = TableB.col_match
WHERE TableA.id IS null OR
TableB.id IS null
*/

/*
Lets Imagine that some new privacy rules have been implemented and we want to make sure that we don't have any payment information that's not attached to customer or that we don't have some customer information.
Essentially we want to make sure that all the payment we have is associated with the current customer
*/

SELECT
* 
FROM payment
FULL OUTER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE 
payment.payment_id IS null
OR
customer.customer_id IS null
;


-- Empty Result meaning which means we are in compliance with this new privacy policy


/*
LEFT OUTER JOIN results in the set of records that are in the left table, if there is no match
with the right table, the results are null.

Get everything from left and right table with a match then all the records from left table that were unmatched(uncommon). 

SELECT * FROM TableA 
LEFT OUTER JOIN TableB
ON TableA.col_match = TableB.col_match

(Swaping TableA & TableB will change the output.)
(Get Everything from TableA)
TableA -> Left
TableB -> Right

GET ROWS UNIQUE TO TABLE A
SELECT * FROM TableA
LEFT OUTER JOIN TableB
ON TableA.col_match = TableB.col_match
WHERE TableB.id IS null
*/

SELECT 
film.film_id,
title,
inventory_id
FROM film
LEFT OUTER JOIN inventory
ON inventory.film_id = film.film_id
;

SELECT 
film.film_id,
title,
inventory_id
FROM film
LEFT OUTER JOIN inventory
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS null
;

/*
A RIGHT JOIN is essentially the same thing as a LEFT JOIN, except the tables are switched. 
This would be the same as switching the table order in a LEFT OUTER JOIN.

GET everything from TableB that is common with TableA,
next get everyting from TableB that was uncommon with TableA.

SELECT * FROM TableA
RIGHT OUTER JOIN TableB
ON TableA.col_match = Tableb.col_match

This is pretty much the exact same thing as a left join except you're switching those tables around.

GET unique rows that only exist in TableB

SELECT * FROM TableA 
RIGHT OUTER JOIN TableB
ON TableA.col_match = TableB.col_match
WHERE TableA.id IS null

*/

/*
UNION

The UNION operator is used to combine the result-set of two or more SELECT statements.
It basically serves to directly concatenate two results together essentially "pasting"
them together.

its like (stack)
results from table 1 (on top)
results from table 2 (on bottom)

SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;
*/

/*
JOIN CHALLANGE

1. Imagine that a California sales tax law has changed and we need to alert our customers to this through e-mail.

So the question is what are the e-mails of the customers who live in California
*/

SELECT
email, first_name, last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'California';

/*
2. A customer walks into the store and they're a huge fan of this actor Nick Walberg and they want to know which movies has Nick Wahlberg been in.

So your task is to basically get a list of all the movies.
Nick Wahlberg has been in.
*/

SELECT * from film;

SELECT 
*
FROM
actor
WHERE CONCAT(actor.first_name, ' ', actor.last_name) = 'Nick Wahlberg'
;

SELECT 
film.title,
CONCAT(actor.first_name, ' ', actor.last_name) AS "Actor Name"
FROM film_actor
INNER JOIN film
ON film.film_id = film_actor.film_id
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id
WHERE CONCAT(actor.first_name, ' ', actor.last_name) = 'Nick Wahlberg'
;








