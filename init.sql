-- Practice joins
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
SELECT track_id FROM playlist_track pt
JOIN playlist p ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';

-- #6
SELECT t.name FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

--#7
SELECT t.name, p.name FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
JOIN playlist p ON p.playlist_id = pt.playlist_id;

-- #8
SELECT t.name, a.title FROM track t
JOIN album a ON a.album_id = t.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

--Black DIamond
SELECT t.name, g.name, al.title, ar.name FROM track t
JOIN genre g ON g.genre_id = t.genre_id
JOIN album al ON al.album_id = t.album_id
JOIN artist ar ON ar.artist_id = al.artist_id
JOIN playlist_track pt ON pt.track_id = t.track_id
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';