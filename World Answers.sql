USE world;

-- Q01: Using COUNT, get the number of cities in the USA.
SELECT COUNT(city.Name) FROM city
INNER JOIN country ON city.CountryCode = country.Code
WHERE country.Name = "United States";

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

-- Q11: List the five largest cities by population in Japan.
SELECT city.Name FROM city
INNER JOIN country ON city.CountryCode = country.Code
WHERE country.Name = "Japan"
ORDER BY city.Population DESC
LIMIT 5;

-- Q12: List the names and country codes of every country with Elizabeth II as its Head of State. 
-- 		You will need to fix the mistake first!
UPDATE country 
SET HeadOfState = "Elizabeth II"
WHERE HeadofState = "Elisabeth II";
SELECT Name, Code FROM country
WHERE HeadOfState = "Elizabeth II";

-- Q13: List the top ten countries with the smallest population-to-area ratio. 
--  	Discard any countries with a ratio of 0.
SELECT Name FROM country
WHERE (Population / SurfaceArea) > 0
ORDER BY (Population / SurfaceArea) ASC
LIMIT 10;

-- Q14: List every unique world language.
SELECT DISTINCT language FROM countrylanguage;

-- Q15: List the names and GNP of the world's top 10 richest countries.
SELECT Name, GNP FROM country 
ORDER BY GNP DESC
LIMIT 10;

-- Q16: List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT country.Name, COUNT(countrylanguage.Language) as TotalLanguages FROM country
INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
GROUP BY country.Name
ORDER BY TotalLanguages DESC
LIMIT 10;

-- Q17: List every country where over 50% of its population can speak German.
SELECT country.Name FROM country
INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.Language = "German" AND Percentage > 50;

-- Q18: Which country has the worst life expectancy? Discard zero or null values.
SELECT Name FROM country
WHERE LifeExpectancy IS NOT NULL AND LifeExpectancy > 0
ORDER BY LifeExpectancy ASC
LIMIT 1;

-- Q19: List the top three most common government forms.
SELECT GovernmentForm FROM country
GROUP BY GovernmentForm
ORDER BY COUNT(GovernmentForm) DESC
LIMIT 3;

-- Q20: How many countries have gained independence since records began?
SELECT COUNT(IndepYear) FROM country
WHERE IndepYear IS NOT  NULL;













