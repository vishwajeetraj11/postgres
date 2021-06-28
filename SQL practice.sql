
-- We want to reward our 1st 10 paying customers,
-- What are the customer ids of the 1st 10 customers who created a payment.
SELECT * FROM payment WHERE amount != 0.00 ORDER BY payment_date DESC LIMIT 10;

-- A customer wants to quickly rent a video to watch over their short lunch break.
-- What are the titles of 5 shortest (in length of runtime) movies?
SELECT 
title AS "Movie Name",
length AS "Runtime"
FROM film
ORDER BY length ASC
LIMIT 5
;

-- If the customer can watch any movie that is 50 mins or less in runtime, how many opyions does she have?
SELECT 
title AS "Movie Name",
length AS "Runtime"
FROM film
WHERE length<=50
ORDER BY length ASC
;

-- Get the count for the above question.
SELECT 
COUNT(title) AS "Movie Name"
FROM film
WHERE length<=50
;

-- Getting the details of customers for reward the 1st 10 paying customers;
-- Using Inner Joins
SELECT
p.customer_id AS "Customer ID (payment)",
c.customer_id AS "Customer ID (customer)",
CONCAT(c.first_name,' ', c.last_name) AS "Full Name",
c.email,
p.amount,
p.payment_date 
FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
WHERE amount != 0.00 
ORDER BY payment_date ASC LIMIT 10;

-- Practice with Between Operator
SELECT * FROM film WHERE film_id BETWEEN 100 AND 200;

SELECT * FROM film WHERE film_id NOT BETWEEN 100 AND 200;

SELECT * FROM payment WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

-- The IN Operator
SELECT * FROM customer WHERE first_name IN ('Jake', 'John', 'Nancy');

-- The like Operator - THe like operator allows us to perform pattern matching against
-- string data with the use of WildCard characters.
-- % (percent) Matches any sequence of character
-- _ (underscore) Matches any single character
-- All names that begin with an 'A' -- WHERE name LIKE 'A%';
-- All names that end with an 'A' -- WHERE name LIKE '%A';
-- All names that contain 'irp' -- WHERE name LIKE '%irp%';
-- Notice that LIKE is 
SELECT * FROM film WHERE title ILIKE '%T'; -- case-sensitive
SELECT * FROM film WHERE title LIKE '%T'; -- not case-sensitive
SELECT * FROM film WHERE title LIKE '%irp%';

-- Using the underscore allows us to replace just a single character
-- Get all Mission Impossible films
-- WHERE title LIKE 'Mission Impossible _'
SELECT * FROM customer WHERE first_name LIKE '_her%';















