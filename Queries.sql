/*
 What are the  top 10 most popular movie genres
 */

select
    category.name,
    count(*) as film_count
from film_category
    join category on film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY film_count DESC
LIMIT 10;

/*
 
 What is the average rental length for each movie
 and return only the top 100 results
 */

WITH rental_length AS (
        SELECT
            film.title,
            SUM(
                rental.return_date - rental.rental_date
            ) AS total_rental_length
        FROM rental
            JOIN inventory ON rental.inventory_id = inventory.inventory_id
            JOIN film ON inventory.film_id = film.film_id
        GROUP BY film.title
    )
SELECT
    title,
    AVG(total_rental_length) AS avg_rental_length
FROM rental_length
GROUP BY title
ORDER BY
    avg_rental_length DESC
LIMIT 100;

/*
 rannk customers by total sales
 */

WITH customer_sales AS (
        SELECT
            customer.first_name,
            customer.last_name,
            SUM(payment.amount) AS total_sales
        FROM customer
            JOIN payment ON customer.customer_id = payment.customer_id
        GROUP BY
            customer.customer_id
    )
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    total_sales,
    RANK() OVER (
        ORDER BY
            total_sales DESC
    ) AS sales_rank
FROM customer_sales
ORDER BY sales_rank ASC
LIMIT 10;