create database Clothing_Store;

use Clothing_Store;

CREATE TABLE shirt_description (
    shirt_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(50) NOT NULL,
    color VARCHAR(30) NOT NULL,
    shirt_size VARCHAR(5) NOT NULL,
    last_worn_days INT NOT NULL
);

INSERT INTO shirt_description (article, color, shirt_size, last_worn_days)
VALUES ('T-shirt', 'Blue', 'M', 7),
	   ('T-shirt', 'White', 'S', 10),
       ('T-shirt', 'Green', 'S', 200),
       ('Polo-Shirt', 'Black', 'M', 50),
       ('Tank-Top', 'Blue', 'S', 0),
       ('T-shirt', 'Pink', 'S', 0),
       ('Polo-shirt', 'Red', 'M', 5),
       ('Tank-Top', 'White', 'S', 200),
       ('Tank-Top', 'Blue', 'M', 15);
       
INSERT INTO shirt_description (article, color, shirt_size, last_worn_days)
Values ('Polo-Shirt','Purple','M','50');

# Select all t-shirts and print article and color
Select article as ClothType, color as ClothColor
from shirt_description
where article  = "T-shirt";

# Select all medium shirts print out everything except shirt_id
Select article, color, shirt_size, last_worn_days
from shirt_description
where shirt_size = "M";

# Disable safe mode for updates
SET SQL_SAFE_UPDATES = 0;

# Update all polo shirts to L size
UPDATE shirt_description
SET shirt_size = 'L'
WHERE article = 'Polo-Shirt';

# Update the shirt last worn 15 days ago change it to zero(0)
UPDATE shirt_description
SET  last_worn_days = 15
WHERE last_worn_days = 0 ;

# Update all white t-shirts, change color to "off white" and size to XS
UPDATE shirt_description
SET  shirt_size ='XS' , color= "off white" 
WHERE article = 'T-shirt' ;

# Delete all T-shirts that are worn more than 200 days ago
Delete from shirt_description
where last_worn_days > 200;

# The customer tastes has change delete all tank tops
Delete from shirt_description
where article = 'Tank-Top';

# Display all data
Select *
from shirt_description;

# Re- enable safe mode for updates
SET SQL_SAFE_UPDATES = 1;

