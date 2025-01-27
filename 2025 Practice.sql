-- using the world schema
USE world;
SELECT * FROM country;
SELECT * FROM city;

-- dropping the population category
DROP TABLE population_category;

-- creating the population category again
CREATE TABLE population_category AS(
SELECT ID, Name, District,
CASE 
WHEN Population <=50000 THEN "Low"
WHEN population <=1000000 THEN "Medium"
ELSE "High" 
END AS "Population_Category"
FROM city
ORDER BY District ASC);

SELECT * FROM population_category;

-- Sorting the population per district in descending order
SELECT * FROM city
ORDER BY population DESC;

-- Finding the top 5  most densely populated disctircts in descending order
SELECT * FROM city
ORDER BY population DESC
LIMIT 5;

-- Explain (Shows how the query will be executed)
USE sakila;
EXPLAIN SELECT * FROM actor;

-- describe
DESCRIBE category;

-- Exists (checks whether one value is in another table)
-- e.g 1. cities with an address
SELECT * FROM city WHERE EXISTS(
SELECT * FROM address WHERE address.city_id = city_id);

-- e.g 2. cities without an address
SELECT * FROM city WHERE NOT EXISTS(
SELECT * FROM address WHERE address.city_id = city_id);

-- JOINS
-- 1. Self Join (Joining a table on itself)
SELECT * FROM actor a
JOIN actor b 
ON a.actor_id = b.actor_id;
 
SELECT * FROM film f
JOIN film g
ON f.film_id= g.language_id;

-- 2. Inner join
SELECT a.first_name, a.last_name, f.description, f.title, f.length
FROM actor a
INNER JOIN film f
ON a.actor_id = f.film_id;

-- 3. LEFT JOIN
SELECT f.title, f.description, c.name, f.release_year
FROM film f
LEFT JOIN category c
ON f.film_id = c.category_id;

SELECT f.title, f.description, c.name, f.release_year
FROM film f
LEFT JOIN category c
ON f.film_id = c.category_id
WHERE f.film_id IS NOT NULL;

-- 4. RIGHT JOIN
SELECT f.title, f.description, l.name, f.length
FROM film f
RIGHT JOIN language l
ON f.language_id = l.language_id;

-- 5. FULL OUTER JOIN
SELECT c.first_name, c.email, p.payment_date, p.amount 
FROM customer c
FULL OUTER JOIN payment p
ON c.customer_id = p.payment_id
WHERE c.payment_id IS NULL;