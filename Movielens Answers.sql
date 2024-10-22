USE movielens;

-- Q1: List the titles and release dates of movies released between 1983-1993 in reverse 
-- 	   chronological order.
SELECT title, release_date FROM movies
WHERE release_date BETWEEN "1983-01-01" AND "1993-01-01"
ORDER BY release_date DESC;

-- Q2: Without using LIMIT, list the titles of the movies with the lowest average rating.
SELECT title FROM movies
INNER JOIN ratings ON movies.id = ratings.movie_id
WHERE ratings.movie_id IN (SELECT movie_id FROM ratings
						   GROUP BY movie_id
						   HAVING AVG(rating) = (SELECT MIN(avg_value) AS smallest_avg 
												 FROM(
													SELECT AVG(rating) AS avg_value 
													FROM ratings
													GROUP BY movie_id
													) AS wanted_average)
                           ORDER BY AVG(rating) ASC)
                           GROUP BY title;
			
-- Q3: List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT DISTINCT movies.title, genres.name, ratings.rating, users.age, users.gender FROM ratings
INNER JOIN users ON ratings.user_id = users.id
INNER JOIN movies ON ratings.movie_id = movies.id
INNER JOIN genres_movies ON genres_movies.movie_id = movies.id
INNER JOIN genres ON genres_movies.genre_id = genres.id
WHERE genres.name = "Sci-Fi" AND users.age = 24 AND users.gender = "M" and rating = 5;

-- Q4: List the unique titles of each of the movies released on the most popular release day.
SELECT title FROM movies 
WHERE release_date = (SELECT release_date FROM movies 
					  GROUP BY release_date 
					  ORDER BY COUNT(release_date) DESC
                      LIMIT 1);
                      
-- Q5: Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT genres.name, COUNT(genres_movies.movie_id) FROM genres
INNER JOIN genres_movies ON genres.id = genres_movies.genre_id
GROUP BY genres.name
ORDER BY COUNT(genres_movies.movie_id) ASC;






