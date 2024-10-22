USE world;

-- Q01: Using COUNT, get the number of cities in the USA.
SELECT COUNT(Name) FROM city;

-- Q02: Find out the population and life expectancy for people in Argentina.
SELECT Population, LifeExpectancy FROM country
WHERE Name = "Argentina";

-- Q03: Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT Name FROM country
WHERE LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy DESC
LIMIT 1;

-- Q04: Using JOIN ... ON, find the capital city of Spain.
SELECT city.Name FROM city
JOIN country ON city.ID = country.Capital
WHERE country.Name = "Spain";

-- Q05: Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT countrylanguage.Language FROM countrylanguage
JOIN country ON countrylanguage.CountryCode = country.Code
WHERE country.region = "Southeast Asia";

-- Q06: Using a single query, list 25 cities around the world that start with the letter F.
SELECT Name FROM city
WHERE Name LIKE "F%"
LIMIT 25;

-- Q07: Using COUNT and JOIN ... ON, get the number of cities in China.
SELECT COUNT(city.Name) FROM city
JOIN country ON city.CountryCode = country.Code
WHERE country.Name = "China";

-- Q08: Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? 
-- 		Discard non-zero populations.
SELECT Name FROM country
WHERE Population IS NOT NULL AND Population != 0
ORDER BY Population ASC
LIMIT 1;

-- Q09: Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(*) FROM country;

-- Q10: What are the top ten largest countries by area?
SELECT Name FROM country
ORDER BY SurfaceArea DESC
LIMIT 10;





