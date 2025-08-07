### MUSIC_STORE_ANALYSIS

### Project: Music Store SQL Analysis
This project analyzes a music store's sales and customer behavior using SQL.  
The database contains tables such as `customers`, `invoices`, `invoice_line`, `tracks`, `genres`, album, playlist, playlist_track and `artists`.

### Objective:
- Country having best customers
- Which country has the most invoices
- Rock music listeners, ordered alphabetically by email
- Track count of top 10 rock bands
- Track names that have song length longer than average song length
- Find best-selling artists
- Customer who spent most in each country
- Most popular genre for each country
- Amount spent by each customer on the best selling artist

### Skills Used
- JOINS
- GROUP BY and aggregations
- CTEs
- Window functions (RANK, ROW_NUMBER)

### Project Highlights
- Used CTEs and window functions to identify most popular genres by country.
- Aggregated customer revenue to understand buying behaviors.

###  Sample Output
Return email, first name, last name , genere of all rock music listeners, ordered alphabetically by email starting with A
[Query result] https://github.com/Rashmisharma0101/SQL-MUSIC_STORE_ANALYSIS/blob/main/Screenshot%20-%20Sample%20output.jpg

### How to Run
1. Load the database in MySQL Workbench
2. Open `queries.sql`
3. Run each block one by one
