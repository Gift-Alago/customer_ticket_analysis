--Data cleaning is used to fix issues in th raw data,to make data useful 

--create new table for staging,basically copying all the data from the raw table to the staging table

CREATE TABLE
  customer_support_3 AS SELECT *
FROM
  customer_support;

--INSERT INTO THE NEW TABLE

INSERT customer_support_3
SELECT *
FROM customer_support


--check for deplicates and remove if any!

 with duplicte_cte as(
SELECT *,
    ROW_NUMBER() OVER(PARTITION BY
    ticket_id,customer_age,customer_gender,product_purchased,date_of_purchase,ticket_type,ticket_subject,ticket_status,ticket_priority,ticket_channel) as row_num
 FROM customer_support_3
 )
 SELECT * FROM duplicte_cte
 WHERE row_num > 1 ;

--RESULT

--NO DUPLICTES, so it will be left like that

