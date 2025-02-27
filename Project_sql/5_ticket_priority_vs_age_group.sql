/* Find priority of ticket by age group
--Identify which age group has the highest ticket_priority "Critical"
BONUS:Identify the TOP 10 different ticket_type in these tickets
Why? --Identify if priority vary with age,do older cutsomers submit more critical  tickets due to technical issues
*/

SELECT
COUNT(*) AS tickets_count,
ticket_type,
CASE
    WHEN customer_age BETWEEN 18 
AND 25 THEN 'Young Adults'
    WHEN customer_age BETWEEN 26 
AND 35 THEN 'Early Career'
    WHEN customer_age BETWEEN 36 
AND 50 THEN 'Mid Career'
    WHEN customer_age BETWEEN 51 
AND 65 THEN 'Near Retirement'
    ELSE 'Seniors'
    END As age_group
FROM customer_support_3
WHERE ticket_priority ='Critical'
GROUP BY age_group,ticket_type
ORDER BY tickets_count DESC
 LIMIT 10

/*
RESULT
=====
-Here is the breakdown of the insights:Mid_Career (319)and(317)Near Retirement users report the most critical issues, the most common issues was  they face more technical issues compared to younger users.Seniors(102) have the lowest number of critical tickets,this could be due to lower usage rate.

[
  {
    "tickets_count": "83",
    "ticket_type": "Technical issue",
    "age_group": "Mid Career"
  },
  {
    "tickets_count": "70",
    "ticket_type": "Billing inquiry",
    "age_group": "Mid Career"
  },
  {
    "tickets_count": "67",
    "ticket_type": "Technical issue",
    "age_group": "Near Retirement"
  },
  {
    "tickets_count": "65",
    "ticket_type": "Refund request",
    "age_group": "Near Retirement"
  },
  {
    "tickets_count": "65",
    "ticket_type": "Cancellation request",
    "age_group": "Near Retirement"
  },
  {
    "tickets_count": "64",
    "ticket_type": "Billing inquiry",
    "age_group": "Near Retirement"
  },
  {
    "tickets_count": "58",
    "ticket_type": "Product inquiry",
    "age_group": "Mid Career"
  },
  {
    "tickets_count": "56",
    "ticket_type": "Cancellation request",
    "age_group": "Mid Career"
  },
  {
    "tickets_count": "56",
    "ticket_type": "Product inquiry",
    "age_group": "Near Retirement"
  },
  {
    "tickets_count": "52",
    "ticket_type": "Refund request",
    "age_group": "Mid Career"
  }
]


*/