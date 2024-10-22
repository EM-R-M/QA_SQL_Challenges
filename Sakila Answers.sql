USE sakila;

-- Q01: List all actors.
SELECT * FROM actor;

-- Q02: Find the surname of the actor with the forename 'John'.
SELECT last_name FROM actor
WHERE first_name = "John";

-- Q03: Find all actors with surname 'Neeson'.
SELECT * FROM actor 
WHERE last_name = "Neeson";

-- Q04: Find all actors with ID numbers divisible by 10.
SELECT * FROM actor
WHERE actor_id % 10 = 0;

-- Q05: What is the description of the movie with an ID of 100?
SELECT description FROM film
WHERE film_id = 100;

-- Q06: Find every R-rated movie.
SELECT * FROM film
WHERE rating = "R";

-- Q07: Find every non-R-rated movie.
SELECT * FROM film
WHERE rating != "R";

-- Q08: Find the ten shortest movies.
SELECT * FROM film
ORDER BY length ASC
LIMIT 10;

-- Q09: Find the movies with the longest runtime, without using LIMIT.
SELECT * FROM film
WHERE length = (SELECT MAX(length) FROM film);

-- Q10: Find all movies that have deleted scenes.
SELECT * FROM film
WHERE special_features LIKE "%Deleted Scenes%";

-- Q11: Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name FROM actor
GROUP BY last_name
HAVING count(last_name) = 1
ORDER BY last_name DESC;

-- Q12: Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name FROM actor
GROUP BY last_name
HAVING count(last_name) > 1
ORDER BY count(last_name) DESC;

-- Q13: Which actor has appeared in the most films?
SELECT first_name, last_name FROM actor
WHERE actor_id = (SELECT actor_id FROM film_actor
						GROUP BY actor_id
						ORDER BY COUNT(actor_id) DESC
						LIMIT 1);

-- Q14: When is 'Academy Dinosaur' due?
SELECT DATE_ADD(rental_date, INTERVAL rental_duration DAY)  AS due_date FROM rental
LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id
LEFT JOIN film ON inventory.film_id = film.film_id
WHERE film.title = "Academy Dinosaur" and return_date IS NULL;

-- Q15: What is the average runtime of all films?
SELECT AVG(length) AS average_runtime FROM film;

-- Q16: List the average runtime for every film category.
SELECT category.name, AVG(length) AS average_runtime FROM film 
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

-- Q17: List all movies featuring a robot.