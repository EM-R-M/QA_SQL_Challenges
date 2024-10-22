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
                        HAVING AVG(rating) = MIN(AVG(rating))
                        ORDER BY AVG(rating) ASC)
                        GROUP BY title;
				

SELECT movie_id, AVG(rating) FROM ratings
GROUP BY movie_id
ORDER BY AVG(rating) ASC;

-- Q3: List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.

-- Q4: List the unique titles of each of the movies released on the most popular release day.
SELECT title FROM movies 
WHERE release_date = (SELECT release_date FROM movies 
					  GROUP BY release_date 
					  ORDER BY COUNT(release_date) DESC
                      LIMIT 1);
                      
-- Q5: Find the total number of movies in each genre; list the results in ascending numeric order.