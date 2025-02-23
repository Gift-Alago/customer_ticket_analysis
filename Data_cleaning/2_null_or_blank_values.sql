--Delete null values, null values in both first_response_time and time_of_resolution are really not useful

SELECT * FROM customer_support_3
WHERE
    first_response_time IS NULL
AND 
    time_to_resolution IS NULL 


--Delete the null values

DELETE FROM customer_support_3
WHERE
    first_response_time IS NULL
AND 
    time_to_resolution IS NULL 




