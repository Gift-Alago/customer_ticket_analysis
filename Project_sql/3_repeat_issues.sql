/*
--identify customers who opened multiple tickets for the same issues
Why? --Helps in identifying recurring customer issues and improving long-term retention
*/

SELECT 
    customer_email,
    ticket_subject,
    count(*) as repeat_tickets
FROM
    customer_support_3
GROUP BY
    customer_email,ticket_subject
HAVING count(*) > 1
ORDER BY repeat_tickets DESC

/* Here's the breakdown of customers with reapted issues,
Installation support appears twice,meaning multiple customers faced installation-related issues more than once,if many customers repeatedly raise installation-related issues,the support team could improve installation guides,FAQs,or onboarding process.

[
  {
    "customer_email": "bsmith@example.com",
    "ticket_subject": "Installation support",
    "repeat_tickets": "3"
  },
  {
    "customer_email": "rsparks@example.org",
    "ticket_subject": "Battery life",
    "repeat_tickets": "2"
  },
  {
    "customer_email": "jacksonadam@example.com",
    "ticket_subject": "Product recommendation",
    "repeat_tickets": "2"
  },
  {
    "customer_email": "ewhite@example.net",
    "ticket_subject": "Installation support",
    "repeat_tickets": "2"
  },
  {
    "customer_email": "tbutler@example.net",
    "ticket_subject": "Product setup",
    "repeat_tickets": "2"
  }
]

*/




