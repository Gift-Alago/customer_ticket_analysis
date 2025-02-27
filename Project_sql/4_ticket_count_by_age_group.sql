/* category customers into different  age groups
. 18-25: Young adults
. 26-35: Early career
. 36-50: Mid career
. 51-65: Near retirement
. 65+: Seniors
--which age group submit the most support tickets?
--are they gaps in user support?if most customers are from a certain age group,high ticket counts could be expected
why?--Helps identify how support can be improved among age groups
*/

SELECT
COUNT(*) AS tickets_count,
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
GROUP BY age_group
ORDER BY tickets_count DESC

/* Here is the breakdown of age groups that submit the most ,higer ticket for Near etirement(1229 tickets) and Mid Career(1211 tickets) are the top contributors.These users may struggle with evovling technology or require more indept assistance . 
--Tech support could offer personalized guides,live chat with freal agents,or phone support for 35+ users 


[
  {
    "tickets_count": "1229",
    "age_group": "Near Retirement"
  },
  {
    "tickets_count": "1211",
    "age_group": "Mid Career"
  },
  {
    "tickets_count": "835",
    "age_group": "Early Career"
  },
  {
    "tickets_count": "621",
    "age_group": "Young Adults"
  },
  {
    "tickets_count": "389",
    "age_group": "Seniors"
  }
]
*/
