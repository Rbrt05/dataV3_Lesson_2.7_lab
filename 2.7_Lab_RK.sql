USE sakila;

-- 1. How many films are there for each of the categories in the category table. 
-- Use appropriate join to write this query.

-- Can be done without join:

SELECT category_id, count(film_id) FROM sakila.film_category
GROUP BY category_id
ORDER BY category_id;

-- Solution with join:
SELECT fc.category_id, count(f.film_id) FROM sakila.film_category as fc
JOIN sakila.film as f
ON fc.film_id = f.film_id
GROUP BY category_id;

-- 2. Display the total amount rung up by each staff member in August of 2005.

SELECT staff_id, sum(amount) FROM sakila.payment as p
Where left(payment_date,7) = '2005-08'
GROUP BY staff_id;

-- 3. Which actor has appeared in the most films?

SELECT concat(a.first_name," ", a.last_name), count(fa.film_id) as count_of_movies FROM sakila.film_actor as fa
JOIN sakila.actor as a
ON fa.actor_id = a.actor_id
GROUP BY fa.actor_id
Order By count_of_movies DESC;

-- 4. Most active customer (the customer that has rented the most number of films)

SELECT 
	concat(c.first_name," ",c.last_name),
	count(r.rental_id)
FROM sakila.rental as r
JOIN sakila.customer as c
ON r.customer_id = c.customer_id
GROUP BY concat(c.first_name," ",c.last_name)
ORDER BY count(r.rental_id) DESC;


-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT 
	concat(s.first_name," ",s.last_name) as full_name, 
    ad.address as street,
    ct.city,
    ad.postal_code
FROM sakila.staff as s
LEFT JOIN sakila.address as ad
ON s.address_id = ad.address_id
LEFT JOIN sakila.city as ct
ON ad.city_id = ct.city_id;

-- 6. List each film and the number of actors who are listed for that film.

SELECT f.title, count(fa.actor_id) as number_of_actors FROM Sakila.film_actor as fa
JOIN sakila.film as f
ON fa.film_id = f.film_id
GROUP BY f.title
ORDER BY f.title;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT 
	c.last_name, 
    c.first_name,
    round(sum(amount),2) as total_paid
FROM sakila.payment as p
JOIN sakila.customer as c
ON p.customer_id = c.customer_id
GROUP BY p.customer_id
ORDER BY c.last_name;

-- 8. List number of films per category.

SELECT 	
	c.name,
    count(fc.film_id)
FROM film_category as fc
JOIN category as c
ON fc.category_id = c.category_id
GROUP BY c.name;
