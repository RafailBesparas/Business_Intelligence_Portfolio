create database BookStore;

use BookStore;

CREATE TABLE books 
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);


-- Concat - Concatanation - Combining String Together

-- Combine the First and Last name of authors
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS FullName,
    title,
    released_year,
    stock_quantity,
    pages
FROM books;

-- Extracting the Year from a Full Date
SELECT 
    SUBSTRING(released_year, 1, 4) AS Year,
    title
FROM books;

-- Select All titles that have stories word
select title
from books
where title like "%stories%";

-- Find the longest book
select title, max(pages) as Number_Of_Pages
from books
group by title
order by max(pages) desc
limit 1 ;

-- Print as summary containing title and year for the 3 most recent books
SELECT title, released_year AS year 
FROM books
ORDER BY  released_year DESC
LIMIT 3;

-- Print all books where author names have space
SELECT title, author_fname, author_lname
FROM books
WHERE author_fname LIKE '% %'OR author_lname LIKE '% %';

-- Find the books with the lowest stock only print the 3 ones , title, released_year, stock_quality
Select title, released_year,stock_quantity
FROM books
order by stock_quantity asc
limit 3;

-- Print the total number of books in the database
select count(book_id) as Total_Number_Of_Books
from books;

-- Print the number of books released each year
select released_year, count(book_id) as Total_Number_Of_Books
from books
group by released_year;

-- Print the total number of books that are in stock
select sum(book_id) as Total_Number_Of_Books
from books
where stock_quantity > 0;

-- Average released year per author
select avg(released_year) as Average_Released_Year, CONCAT(author_fname, ' ', author_lname) AS author_name
from books
group by author_lname, author_fname;

-- Full Name of author who wrote the longest book
select max(pages) as Longest_Book, CONCAT(author_fname, ' ', author_lname) AS author_name
from books
group by author_lname, author_fname
order by max(pages) desc
limit 1;

-- For each year the number of books and average number of pages
SELECT released_year, COUNT(*) AS num_books, AVG(pages) AS avg_pages
FROM books
GROUP BY released_year
ORDER BY released_year;

-- Determine if a book is in stock
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity > 0 THEN 'We Could Sell '
        ELSE 'Out of Stock'
    END AS stock_status
FROM books;

-- Check type of story
SELECT title, author_lname,
CASE
    WHEN title LIKE '%stories%' THEN 'Short Stories'
    WHEN title = 'Just Kids' THEN 'Memoir' 
    WHEN title = 'A Heartbreaking Work of Staggering Genius' THEN 'Memior'
    ELSE 'Novel'
END AS type
FROM books;