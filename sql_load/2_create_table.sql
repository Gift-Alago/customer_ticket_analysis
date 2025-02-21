--create customer_support table with primary key
customer_support_2

create table public.customer_support 
( 
  ticket_id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255),
  customer_email VARCHAR(255),
  customer_age INT,
  customer_gender VARCHAR(50),
  product_purchased VARCHAR(255),
  date_of_purchase DATE,
  ticket_type VARCHAR(100),
  ticket_subject VARCHAR(255),
  ticket_description TEXT,
  ticket_status VARCHAR(255),
  resolution TEXT,
  ticket_priority VARCHAR(50),
  ticket_channel VARCHAR (100),
  first_response_time TIMESTAMP,
  time_to_resolution TIMESTAMP,
  customer_satisfication_rating DECIMAL(2,1)
);
alter TABLE public.customer_support OWNER to postgres;

