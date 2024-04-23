-- 1. Who is the senior most employee based on job title?
SELECT first_name ,title, levels FROM employee as me
order by Levels desc limit 1



-- 2. Which countries have the most Invoices?
select billing_country,count(invoice_id) as Invoice_count FROM MusicStore.invoice
group by (billing_country)
order by (Invoice_count) desc 



-- 3. What are top 3 values of total invoice?
select * from invoice
order by (total) desc limit 3



-- Which city has the best customers? We would like to throw a promotional Music
-- Festival in the city we made the most money. Write a query that returns one city that
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
select billing_city, sum(total) as sum_invoice from invoice
group by (billing_city)
order by sum_invoice desc limit 1



-- Who is the best customer? The customer who has spent the most money will be
-- declared the best customer. Write a query that returns the person who has spent the
-- most money
select customer.customer_id, customer.first_name, customer.last_name, sum(total) from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id, customer.first_name, customer.last_name
order by  sum(total) desc limit 1



-- Write query to return the email, first name, last name, & Genre of all Rock Music
-- listeners. Return your list ordered alphabetically by email starting with A
SELECT distinct c.first_name, c.last_name, c.email  FROM genre as g
join track as t on t.genre_id = g.genre_id
join invoice_line as il on t.track_id = il.track_id
join invoice as i on i.invoice_id = il.invoice_id
join customer as c on c.customer_id = i.customer_id
where g.name like 'rock'
order by email



-- Let's invite the artists who have written the most rock music in our dataset. Write a
-- query that returns the Artist name and total track count of the top 10 rock bands
select a.name, count(t.name) as  total_track_count from artist as a
join album as ab on a.artist_id = ab.artist_id
join track as t on t.album_id = ab.album_id
join genre as g on g.genre_id = t.genre_id

where g.name like 'rock'
group by (a.name)
order by (total_track_count ) desc 
limit 10; 



-- Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the
-- longest songs listed first
select t.name, t.milliseconds from track as t
where t.milliseconds > (select avg(t.milliseconds) from track as t)
order by t.milliseconds desc



-- Find how much amount spent by each customer on artists? Write a query to return
-- customer name, artist name and total spent

select 
c.customer_id, c.first_name,c.last_name,
a.artist_id,a.name, sum(il.quantity* il.unit_price) as total_spent_on_artist
from customer as c
join invoice as i on c.customer_id = i.customer_id
join invoice_line as il on i.invoice_id = il.invoice_id
join track as t on t.track_id = il.track_id
join album as ab on ab.album_id = t.album_id
join artist as a on a.artist_id = ab.artist_id
where c.customer_id = 22
group by c.customer_id, c.first_name,c.last_name,
a.artist_id,a.name



-- 
