-- Creating a new database
create schema friends;
USE friends;

-- Creating a new table inside the database
CREATE Table friends(
friend_id INT NOT NULL AUTO_INCREMENT,
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
residence VARCHAR(30) NOT NULL,
net_worth INT,
PRIMARY KEY (friend_id)
);

-- Using the following DML command to make sure the table remains the same
COMMIT;

-- Renaming the table
RENAME TABLE friends TO friends_info;

-- Adding columns in the above table
ALTER TABLE friends_info ADD COLUMN (age INT);

-- Checking the table
SELECT * FROM friends_info;

-- Inserting values into the friends_info table
INSERT INTO friends_info(friend_id, first_name, last_name, residence, net_worth, age) VALUES(1, "Martin", "Luther", "New York", 25000 , 30);
INSERT INTO friends_info(friend_id, first_name, last_name, residence, net_worth, age) VALUES(2, "Kelvin", "Macharia", "Rongai", 30000, 26);
INSERT INTO friends_info(friend_id, first_name, last_name, residence, net_worth, age) VALUES(3, "Ruth", "Princess", "South B", 70000, 22);
INSERT INTO friends_info(friend_id, first_name, last_name, residence, net_worth, age) VALUES(4, "Steve", "Kariuki", "Dagoretti", 80000, 28);
INSERT INTO friends_info(friend_id, first_name, last_name, residence, net_worth, age) VALUES(5, "Ryan", "Ochieng", "Uthiru", 25000, 22);
INSERT INTO friends_info(friend_id, first_name, last_name, residence, net_worth, age) VALUES(6, "Sophie", "Wambui", "Bangkok", 30000, 26);
INSERT INTO friends_info(first_name, last_name, residence, net_worth, age) VALUES("Kelvin", "Maestro", "Rongai", 80000, 26);

-- Checking the table
SELECT * FROM friends_info;

-- Selecting columns with the first name ending with n
SELECT * FROM friends_info
WHERE first_name LIKE "%n";

-- Selecting the first 4 friends who have a networth of more than 30,000
SELECT * FROM friends_info
WHERE net_worth >=30000
LIMIT 4;

-- Sakila Database
USE sakila;

-- Like and IN
SELECT * from actor
WHERE first_name Like "%a%";

SELECT * FROM address
WHERE address LIKE "_______a%";

SELECT * FROM address
WHERE city_id IN (30, 60, 90, 100, 103);

-- Having
SELECT first_name, last_name, email, customer_id, COUNT(store_id) AS store_id FROM customer
WHERE first_name LIKE "%a" AND last_name LIKE "%s"
GROUP BY customer_id
HAVING COUNT(store_id) <= 4
LIMIT 10;

-- SKIP TAKE / LIMIT
SELECT * FROM country LIMIT 20;

-- UNION (joins two tables of the same structure while removing duplicates)
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id <= 20
UNION
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id <= 30;

-- UNION ALL (joins both tables but keeps duplicates)
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id <= 20
UNION ALL
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id <= 30;

-- N/B:
/* To use the above two columns both SELECT statement should have same number of columns with same data type in
same order, but the length of column can be different. */

-- EXPLAIN 
EXPLAIN SELECT * FROM actor a
LEFT JOIN language l
ON a.actor_id = l.language_id;

-- DESCRIBE 
DESCRIBE film_actor;

-- JOINS 
SELECT a.actor_id,
a.first_name,
a.last_name,
r.rental_date,
r.return_date,
r.last_update
FROM actor a
JOIN rental r
ON a.actor_id = r.rental_id
WHERE a.first_name LIKE "%a";


USE Sakila;

-- EXISTS 
SELECT * FROM actor 
WHERE  EXISTS (
SELECT * FROM country WHERE country.last_update = last_update);

/* the above query shows the countries with a last update column */

-- NOT EXISTS (opposite of exists)
SELECT *  FROM city
WHERE NOT EXISTS (
SELECT * FROM country WHERE country.last_update = last_update);

-- JOINS 
-- INNER JOIN 
SELECT * FROM actor a
INNER JOIN country c
ON a.last_update = c.last_update;

-- SELF JOIN
SELECT * FROM film f
JOIN film m
ON f.film_id = m.film_id;

-- LEFT JOIN
CREATE TABLE payment_inventory AS (
SELECT i.film_id, i.store_id, p.payment_id, p.amount, p.customer_id FROM inventory i
LEFT JOIN payment p
ON i.inventory_id = p.payment_id);

-- RIGHT JOIN
SELECT * FROM store s
RIGHT JOIN inventory i
USING (store_id);

-- FULL OUTER JOIN
SELECT * FROM payment_inventory py
JOIN rental r
USING(customer_id);

-- These joins are the same as the ones found in Python and Power BI.

-- Stored Procedures
CREATE PROCEDURE GetCustomers()
BEGIN
SELECT * FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
END;

-- CASE statement (Like IF in excel and SWITCH in DAX Power BI)
USE world;
SELECT * FROM city;

SELECT Name, District, Population, CountryCode,
CASE
WHEN Population >=1000000 THEN "Overpopulated"
WHEN Population BETWEEN 500000 AND 1000000 THEN "Evenly Populated"
WHEN Population BETWEEN 200000 AND 500000 THEN "Slightly Evenly Populated"
ELSE "Underpopulated"
END AS "Population Category"
FROM city
ORDER BY CountryCode DESC
LIMIT 20;




