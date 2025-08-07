#1. Who is Senior most employee based on job title
select * from employee order by levels desc limit 1;

#2 Which contries have the most invoices
select billing_country, count(*) from invoice
group by billing_country order by count(*) desc limit 1;

#3 What are top 3 values of total invoice
select total from invoice order by total desc limit 3;

#4 Which city has best customers
select billing_city, sum(total) from invoice 
group by billing_city
order by sum(total) desc limit 1;


#5 Who is the best customer
select customer.first_name, customer.last_name from customer where customer.customer_id in (select customer.customer_id from customer join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by invoice.total desc)   limit 1;

#5 Return email, first name, last name , genere of all rock music listeners, ordered alphabetically by email starting with A
select distinctrow customer.first_name, customer.last_name, customer.email, Genre.name
from customer join Invoice on customer.customer_id = Invoice.customer_id
join invoice_line on invoice_line.Invoice_Id = Invoice.Invoice_Id
join Track on track.track_Id = invoice_line.track_Id
join Genre on Genre.Genre_Id = Track.Genre_Id
where Genre.name like "%rock%"
order by customer.email asc
;

#7 return artist name, and total track count of top 10 rock bands
select artist.name, count(track.track_id)
from artist join album on artist.artist_id = album.artist_id
join track on track.album_id  = album.album_id
join Genre on Genre.Genre_Id = Track.Genre_Id
where Genre.name like "%rock%"
group  by artist.name
order by count(track.track_id) desc limit 10;

#8 Return all track names that have song length longer than average song length. Return name and milliseconds for each track
# order by song length with the longest songs listed first

select name, milliseconds from track where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc


#9 How much amount spent by each customer on the best selling artist
with best_Selling_artist as (select artist.artist_id, artist.name as artist_name, sum(invoice_line.unit_price * invoice_line.quantity) as total_sales 
from invoice_line join invoice on invoice.invoice_id = invoice_line.invoice_id
join track on track.track_id = invoice_line.track_id
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
group by artist.artist_id, artist.name
order by total_sales desc limit 1)

select customer.customer_id, customer.first_name, customer.last_name, best_Selling_artist.artist_name,
sum(invoice_line.unit_price * invoice_line.quantity) as amount_spent
from invoice join customer on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on track.track_id = invoice_line.track_id
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join best_Selling_artist on best_Selling_artist.artist_id = album.artist_id
group by customer.customer_id, customer.first_name, customer.last_name, best_Selling_artist.artist_name
order by amount_spent desc;


#10 Find most popular genre for each country
# Return each country along with top genre with maximum number of purchases, if mulitple genre
# return multiple genre

with cte1 as (
select customer.country, genre.genre_id, genre.name , count(invoice_line.quantity) as totals from
customer join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on track.track_id = invoice_line.track_id
join genre on track.genre_id = genre.genre_id
group by customer.country, genre.genre_id, genre.name),

cte2 as 
(select country, name, cte1.totals , rank() over (partition by country order by totals desc) as rowno from cte1)

select cte2.country, cte2.name, cte2.totals, cte2.rowno from cte2 where rowno = 1;

#11 customer who spent most in each country

with cte1 as 
(select customer.country, customer.customer_id, sum(invoice.total) as totals,
rank() over (partition by customer.country order by sum(invoice.total) desc) as rowno
from customer join invoice
on customer.customer_id = invoice.customer_id
group by 1,2 order by customer.country asc, totals desc
)
select * from cte1 where rowno = 1
