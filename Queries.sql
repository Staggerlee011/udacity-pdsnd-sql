/*

What are the most popular movie genres

*/

select category.name, count(*) as film_count
from film_category
join category on film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY film_count DESC

/*

What is the average rental length for each movie

*/

select category.name, sum(rental.return_date - rental.rental_date) as avg_rental_length
from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name, film.title
order by avg_rental_length desc
limit 100

/*

What is the relationship between movie rating and rental count

*/

select film.rating, count(*) as rental_count
from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
group by film.rating
order by rental_count desc

/*

What is the relationship between movie rating and rental count
grouped by catogory

*/

select category.name, film.rating, count(*) as rental_count
from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name, film.rating
