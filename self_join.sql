/*
A self-join is a query in which a table is joined to itself.

Self-joins are useful for comparing values in a column of rows within the same table.

The self join can be viewed as a join of two copies of the same table.

The table is not actually copied, but SQL performs the command as though it were.

There is no special keyword for a self join, its simply standard JOIN syntax with the same table in both parts.

Syntax:-
SELECT tableA.col, tableB.col
FROM table AS tabelA
JOIN table AS tableB 
ON tableA.some_col = tableB.other_col
*/


-- Find all the pairs of films that have the same length 
SELECT f1.title, f2.title, f1.length
FROM film AS f1
INNER JOIN film AS f2 
ON f1.film_id != f2.film_id
AND f1.length = f2.length;









