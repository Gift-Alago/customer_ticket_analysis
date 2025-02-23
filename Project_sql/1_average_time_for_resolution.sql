
/*
What is the average time for a ticket to be resolved per ticket type
-Identify the average time a ticket is been resloved per ticket type
-Focuses on ticket with specific resolution time (remove nulls)
Why? -Helps to identify which ticket type takes the longest to resolve
     -Identify how long it takes to resolve a ticket after the first response
*/

SELECT  
     ticket_type ,
     AVG("time_to_resolution" - "first_response_time" ) as avg_resolution_time
FROM 
     customer_support_3
WHERE
     time_to_resolution IS NOT NULL
GROUP BY
     ticket_type
ORDER BY
     avg_resolution_time DESC


/* 
RESULTS
=====

[
  {
    "ticket_type": "Refund request",
    "avg_resolution_time": {
      "hours": 8,
      "minutes": 7,
      "seconds": 4,
      "milliseconds": 144.737
    }
  },
  {
    "ticket_type": "Cancellation request",
    "avg_resolution_time": {
      "hours": 7,
      "minutes": 41,
      "seconds": 35,
      "milliseconds": 94.34
    }
  },
  {
    "ticket_type": "Product inquiry",
    "avg_resolution_time": {
      "hours": 7,
      "minutes": 40,
      "seconds": 33,
      "milliseconds": 852.14
    }
  },
  {
    "ticket_type": "Technical issue",
    "avg_resolution_time": {
      "hours": 7,
      "minutes": 21,
      "seconds": 54,
      "milliseconds": 688.525
    }
  },
  {
    "ticket_type": "Billing inquiry",
    "avg_resolution_time": {
      "hours": 7,
      "seconds": 36,
      "milliseconds": 923.077
    }
  }
]
*/