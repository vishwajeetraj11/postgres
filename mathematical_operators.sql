-- What percentage of repacement cost is rental rate?
SELECT ROUND(rental_rate/replacement_cost,4)*100 AS "Percent Cost" FROM film;