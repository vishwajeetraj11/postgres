/*
Timestamps and Extract 
PostgreSQL can hold date and time information.
TIME - Contains only time
DATE - Contains only date
TIMESTAMP - Contains date and time
TIMESTAMPTZ - Contains date, time, and timezone.

Careful considerations should be made when designing a table and database and choosing a time data type.

Depending on the situation you may or may not need the full level of TIMESTAMPTZ

Remember, you can always remove historical information, but you can't add it!
*/

SHOW ALL;

SHOW TIMEZONE;

-- Timestamp information for right now. 
SELECT NOW();

SELECT TIMEOFDAY();

SELECT CURRENT_TIME;
SELECT CURRENT_DATE;

/*
Extracting information from a time based data type using.
EXTRACT()
AGE()
TO_CHAR()

EXTRACT()
Allows you to extract or obtain a sub-component of a date value.
YEAR
MONTH
DAY
WEEK
QUARTER

Usage:-
EXTRACT(YEAR FROM date_col)

AGE()
Calculate and returns the current age given a timestamp.

Usage:-
AGE(date_col)
Returns
13 years 1 mon 5 days 01:34:13.003423

TO_CHAR()
General function to convert data types to text
Useful for timestamp formatting

Usage:-
TO_CHAR(date_col, 'mm-dd-yyyy')
*/

SELECT * FROM payment;

SELECT *, EXTRACT(YEAR FROM payment_date) AS "Payment Year" FROM payment;

SELECT *, EXTRACT(MONTH FROM payment_date) AS "Payment Month" FROM payment;

-- Quarter of year.
SELECT *, EXTRACT(QUARTER FROM payment_date) AS "Payment Year" FROM payment;


-- AGE
SELECT AGE(payment_date) FROM payment;

-- TO_CHAR
SELECT TO_CHAR(payment_date, 'MONTH-YYYY') FROM payment;
SELECT TO_CHAR(payment_date, 'MONTH  YYYY') FROM payment;
SELECT TO_CHAR(payment_date, 'mon/dd/YYYY') FROM payment;

/*
Challange:- 
1. During which months did payments occur?
Format your answer to return back the full month name.
*/
SELECT TO_CHAR(payment_date, 'MONTH') FROM payment GROUP BY TO_CHAR(payment_date, 'MONTH');
-- OR
SELECT DISTINCT(TO_CHAR(payment_date, 'MONTH')) FROM payment;

/*
How many payments occurred on a Monday? 

My Way
*/
SELECT 
COUNT(TRIM(TO_CHAR(payment_date, 'DAY')))
FROM payment 
WHERE 
TRIM(TO_CHAR(payment_date, 'DAY'))='MONDAY';

-- Instructor's Way
SELECT 
COUNT(*)
FROM payment
WHERE EXTRACT(dow FROM payment_date) = 1;














