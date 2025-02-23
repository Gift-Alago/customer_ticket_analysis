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
   