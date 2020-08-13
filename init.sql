-- PRACTICE JOINS
-- #1
SELECT *
FROM invoice
    JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price > .99

-- #2
SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total
FROM invoice
    JOIN customer ON invoice.customer_id = customer.customer_id;

-- #3
SELECT customer.first_name, customer.last_name, employee.first_name, employee.last_name
FROM customer
    JOIN employee ON customer.support_rep_id = employee.employee_id;

-- #4
SELECT album.title, artist.name
FROM artist
    JOIN album ON artist.artist_id = album.artist_id;

-- #5 
SELECT track_id
FROM playlist_track pt
    JOIN playlist p ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';

-- #6
SELECT t.name
FROM track t
    JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

--#7
SELECT t.name, p.name
FROM track t
    JOIN playlist_track pt ON pt.track_id = t.track_id
    JOIN playlist p ON p.playlist_id = pt.playlist_id;

-- #8
SELECT t.name, a.title
FROM track t
    JOIN album a ON a.album_id = t.album_id
    JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

--Black DIamond
SELECT t.name, g.name, al.title, ar.name
FROM track t
    JOIN genre g ON g.genre_id = t.genre_id
    JOIN album al ON al.album_id = t.album_id
    JOIN artist ar ON ar.artist_id = al.artist_id
    JOIN playlist_track pt ON pt.track_id = t.track_id
    JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

-- PRACTICE NESTED QUERIES
-- #1
SELECT *
FROM invoice
WHERE invoice_id IN(SELECT invoice_id
FROM invoice_line
WHERE unit_price > .99);

-- #2
SELECT * FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');

-- #3
SELECT name from track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5);

-- #4
SELECT * FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy');

-- #5
SELECT * FROM track
WHERE album_id IN ( SELECT album_id FROM album WHERE title = 'Fireball' );

-- #6
SELECT * FROM track
WHERE album_id IN ( SELECT album_id from album WHERE artist_id IN(
  SELECT artist_id FROM artist WHERE name = 'Queen'));

-- PRACTICE UPDATING ROWS
-- #1
UPDATE customer
SET fax = null
WHERE fax IS NOT null;

-- #2
UPDATE customer
SET company = 'Self'
WHERE company IS null;

-- #3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- #4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- #5
UPDATE track
SET composer = 'The Darkness Around Us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null;

-- GROUP BY
-- #1
SELECT count(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

-- #2
SELECT count(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name IN ('Pop', 'Rock')
GROUP BY g.name;

-- #3
SELECT a.name, COUNT(*)
FROM album al
JOIN artist a ON a.artist_id = al.artist_id
GROUP BY a.name;

-- USE DISTINCT
-- #1
SELECT DISTINCT composer
FROM track;

-- #2
SELECT DISTINCT billing_postal_code
FROM invoice;

-- #3
SELECT DISTINCT company
FROM customer;

-- DELETE ROWS
-- #1
-- Table created 

-- #2
DELETE FROM practice_delete
WHERE type = 'bronze';

-- #3
DELETE FROM practice_delete
WHERE type = 'silver';

-- #4
DELETE FROM practice_delete
WHERE value = 150;

-- eCommerce Simulation
CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(50),
    user_email VARCHAR(75)
);

CREATE TABLE products(
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(30),
    price NUMERIC
);

CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    order_number INTEGER,
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER
);

INSERT INTO users
(user_name, user_email)
VALUES
('Bob Ross', 'painterExtroidinare@iteach.you'),
('Ferris Beuler', 'who_me@igotawaywith.it'),
('Happy Gilmore', 'hockey4life@golfis.ok');

INSERT INTO products
(product_name, price)
VALUES
('Paint Ball Gun', 59.95),
('Lucky Rabbits Foot', 7.00),
('Beach Ball', 3.50);

INSERT INTO orders
(order_number, product_id, quantity)
VALUES
(001, 1, 5),
(001, 3, 2),
(002, 2, 12),
(002, 1, 1),
(002, 3, 5),
(003, 3, 100);

SELECT p.product_name FROM products p 
JOIN orders o ON o.product_id = p.product_id
WHERE o.order_number = 001;

SELECT * FROM orders;

SELECT SUM(o.quantity * p.price)
FROM orders o 
JOIN products p ON p.product_id = o.product_id
WHERE o.order_number = 002;

ALTER TABLE users
ADD COLUMN order_id INTEGER REFERENCES orders(order_id);