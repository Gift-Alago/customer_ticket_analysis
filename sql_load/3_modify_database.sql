--load data from csv file into table created

\copy customer_support FROM
 'C:/Users/HP/OneDrive/Desktop/customerr_support_ticket_analysis/customer_support_tickets.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');




