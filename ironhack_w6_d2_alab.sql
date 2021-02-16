/*
Instructions
Write the SQL queries to answer the following questions:

1. Select the first name, last name, and email address of all the customers who have rented a movie.

2. What is the average payment made by each customer (display the customer id, customer name (concatenated), 
and the average payment made).

3. Select the name and email address of all the customers who have rented the "Action" movies.
- Write the query using multiple join statements
- Write the query using sub queries with multiple WHERE clause and IN condition
- Verify if the above two queries produce the same results or not

4. Use the case statement to create a new column classifying existing columns as either or high value transactions
 based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is 
 between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
*/
Use sakila;
/*
1. Select the first name, last name, and email address of all the customers who have rented a movie.
*/
SELECT DISTINCT r.customer_id, c.first_name, c.last_name, c.email
FROM rental r
LEFT JOIN customer c
ON r.customer_id = c.customer_id;

/*
2. What is the average payment made by each customer (display the customer id, customer name (concatenated), 
and the average payment made).
*/
SELECT p.customer_id, CONCAT(c.first_name,' ',c.last_name) AS customer_name, AVG(p.amount)
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY 1,2;

/*
3. Select the name and email address of all the customers who have rented the "Action" movies.
*/
SELECT CONCAT(c.first_name,' ', c.last_name) AS customer_name, c.email
FROM film f
JOIN film_category fc
ON fc.film_id = f.film_id
JOIN inventory i
ON i.film_id = fc.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
JOIN customer c
ON c.customer_id = r.customer_id
WHERE fc.category_id IN (SELECT category_id FROM category WHERE name = 'Action');

/*
4. Use the case statement to create a new column classifying existing columns as 
either or high value transactions based on the amount of payment. 
If the amount is between 0 and 2, label should be low and if the amount is 
between 2 and 4, the label should be medium, and if it is more than 4, 
then it should be high.
*/
SELECT *,CASE 
		WHEN amount <= 2 THEN 'low' 
		WHEN amount <= 4 THEN 'medium' 
        ELSE 'high' END AS classifying
FROM payment;
