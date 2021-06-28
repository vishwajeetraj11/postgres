/*
GROUP BY will allow us to aggregate data and
apply functions to better understand how data is distributed per category.

SQL provides a variety of aggregate functions.

The main idea behind an aggregate function is to take multiple inputs and return a single output.

Most Common Aggregate Functions - AVG, COUNT, MAX, MIN, SUM

Aggregate functions calls happen only in the SELECT clause or the HAVING clause.

Special Notes
AVG() returns a floating point value many decimal places (eg. 2.342418...)
- You can use ROUND() to specify precision after the decimal.

COUNT() simply returns the number of rows, which means by convention we just use COUNT(*)
*/

SELECT MIN(replacement_cost) FROM film;

-- SELECT MIN(replacement_cost), first_name FROM film;
/*
Keep in Mind if we were to try to call something else like first_name column for some reason, that doesn't really make sense, (ERROR) and the reason for that is, we are just actually calling an aggregate function on a column which means MAX(replacement_cost) just returns a single value it doesn't really make sense to call another column like this in order to call another columns try GROUP BY statement.
*/ 

SELECT MIN(replacement_cost), MAX(replacement_cost) FROM film;

/*
This works because both of them are returning single values.
*/

SELECT ROUND(AVG(replacement_cost),3) FROM film;
SELECT SUM(replacement_cost) FROM film;

/*
GROUP BY 
SELECT category_col, AGG(data_col) FROM table GROUP BY category_col;
AGG -> Placeholder for some aggregate function.

GROUP BY clause must appear right after a FROM or WHERE statement.
Ex - 
SELECT category_col, AGG(data_col) 
FROM table
WHERE category_col != 'A'
GROUP BY category_col

*/

-- Find out DISTINCT customer_id from payment table using GROUP BY
SELECT customer_id FROM payment GROUP BY customer_id; 

-- Arrange in ASC ORDER the above result.
SELECT customer_id FROM payment GROUP BY customer_id ORDER BY customer_id ASC; 

--  Find out the no. of payments each customer has made.
SELECT customer_id, COUNT(*) FROM payment GROUP BY customer_id;

-- Find out which customer spend most money. 
-- Ans the one that appears on top because its in descending order.
SELECT 
p.customer_id AS "Customer ID", 
CONCAT(c.first_name, ' ', c.last_name) AS "Full Name",
SUM(p.amount) AS "Total Spending"
FROM payment p
INNER JOIN customer c
ON p.customer_id=c.customer_id
GROUP BY p.customer_id, c.first_name, c.last_name 
ORDER BY SUM(p.amount) 
DESC;

-- Count the no. of transactions they are having. 
SELECT 
p.customer_id AS "Customer ID", 
CONCAT(c.first_name, ' ', c.last_name) AS "Full Name",
COUNT(p.amount) AS "Total No. of Transactions"
FROM payment p
INNER JOIN customer c
ON p.customer_id=c.customer_id
GROUP BY p.customer_id, c.first_name, c.last_name 
ORDER BY COUNT(p.amount) 
DESC;

-- Multiple Column GROUP BY
SELECT customer_id, staff_id, SUM(amount) FROM payment GROUP BY customer_id,staff_id ORDER BY customer_id ASC;

-- GET the date from timestamp
-- Date function is extracting the date portion from the timestamp.
SELECT DATE(payment_date) FROM payment;

-- GET DISTINCT DATES
SELECT DATE(payment_date) FROM payment GROUP BY payment_date;

-- GET TRANSACTION PER DAY
SELECT DATE(payment_date), SUM(amount)
FROM payment
GROUP BY DATE(payment_date) 
ORDER BY SUM(amount) DESC;

-- Challenges
/*
We have two staff members, with Staff IDs 1 & 2. We want to give a bonus to the staff member  that handled the most payments. (Most in terms of number of payments processed, not total dollar amount).

How many payments did each staff member handled and who gets the bonus.
*/
SELECT 
payment.staff_id AS "Staff ID",
CONCAT(staff.first_name, ' ', staff.last_name) AS "Full Name",
COUNT(amount) AS "Total No. of Transactions"
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY payment.staff_id, CONCAT(staff.first_name, ' ', staff.last_name);

/*
Corporate HQ is conducting a study on the relationship between replacement cost and a movie MPAA rating (e.g. G,PG,R, etc).
What is the average replacement cost per MPAA rating.
*/

SELECT rating, ROUND(AVG(replacement_cost), 2) FROM film GROUP BY rating;

/*
We are running a promotion to reward our top 5 customers with coupons.
What are the customer ids of the top 5 customers by total spend?
*/

SELECT 
customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

/*
The HAVING clause allows us to filter after an aggregation has already taken place.
*/

SELECT customer_id,SUM(amount)
FROM payment
GROUP BY customer_id;

-- Exclude a few customer IDS
-- But you cannot filter on the WHERE statement of SUM(amount) > 100. because this SUM aggregation has not happened untill GROUP BY has happened.
SELECT customer_id,SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100
ORDER BY SUM(amount) 
;

-- No. of customers visited per store.
SELECT store_id, COUNT(customer_id) FROM customer GROUP BY store_id;
SELECT store_id, COUNT(*) FROM customer GROUP BY store_id;
-- Both are same because we are only counting rows. ||^^;

SELECT store_id, COUNT(customer_id) FROM customer GROUP BY store_id HAVING COUNT(customer_id)>300;

/*
Challenge:-
We are launching a platinum service for our most loyal customers. We will assign platinum status to customers that have had 40 or more transaction payments.
What customer _ids are eligible for platinum status?
*/
SELECT customer_id, COUNT(amount) FROM payment GROUP BY customer_id HAVING COUNT(amount) >= 40;

/*
Challenge:-
What are the customer ids of customers who have spent more than $100 in payment transaction with our staff_id member 2?
*/

SELECT 
customer_id,
SUM(amount) 
FROM payment
WHERE staff_id != 1
GROUP BY customer_id
HAVING SUM(amount) > 100;










