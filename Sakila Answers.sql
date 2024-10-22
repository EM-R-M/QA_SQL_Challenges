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
                        
SELECT first_name, last_name FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY film_actor.actor_id
ORDER BY COUNT(film_actor.actor_id) DESC
LIMIT 1;

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
SELECT * FROM film
WHERE description LIKE "%robot%";

-- Q18: How many movies were released in 2010?
SELECT COUNT(*) FROM film
WHERE release_year = 2010;

-- Q19: Find the titles of all the horror movies.
SELECT title FROM film 
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Horror";

-- Q20: List the full name of the staff member with the ID of 2.
SELECT first_name, last_name FROM staff
WHERE staff_id LIKE "%2%";

-- Q21: List all the movies that Fred Costner has appeared in.
SELECT title FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE first_name = "Fred" AND last_name = "Costner";

-- Q22: How many distinct countries are there?
SELECT DISTINCT country FROM country;

-- Q23: List the name of every language in reverse-alphabetical order.
SELECT name FROM language
ORDER BY name DESC;

-- Q24: List the full names of every actor whose surname ends with '-son' in 
--      alphabetical order by their forename.
SELECT first_name, last_name FROM actor
WHERE last_name LIKE "%son"
ORDER BY first_name ASC;

-- Q25: Which category contains the most films?
SELECT name FROM category
WHERE category_id = (SELECT category_id FROM film
						INNER JOIN film_category ON film.film_id = film_category.film_id
						GROUP BY category_id
						ORDER BY COUNT(category_id) DESC
						LIMIT 1);