--load data from csv file into table created

\copy customer_support FROM
 'C:/Users/HP/OneDrive/Desktop/customerr_support_ticket_analysis/customer_support_tickets.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- create new table like the first table to avoid modifying original data

CREATE TABLE
  customer_support_3 AS SELECT *
FROM
  customer_support;


--Remove unnecesaary columns not needed for analysis

ALTER TABLE customer_support_3
DROP 
  column customer_name,
DROP
   column ticket_description,
DROP
   column resolution,
DROP
   column  customer_satisfication_rating;

 