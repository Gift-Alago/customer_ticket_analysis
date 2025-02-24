/*
Find channels with critical tickets
--which channels receive the hightest number of critical tickets?
--what are the top 10 ticket types that appears frequently within those high prioity "critical" tickets
WHY?
    -identify which support channels(email,phone,chat,etc) receive the most tickets,providing insight for tech support to identify which channel and ticket type urgent issues are escalated through.
   
*/

with critical_tickets as(
SELECT
    ticket_channel  ,
    count(*) as total_critical_tickets
FROM 
     customer_support_3 
WHERE 
     ticket_priority = 'Critical'
GROUP BY 
     ticket_channel
)
SELECT 
    ct.ticket_channel,
    cst.ticket_type,
    count(*) as total_critical_tickets
FROM
    critical_tickets as ct
JOIN 
    customer_support_3 as cst on 
    ct.ticket_channel = cst.ticket_channel
GROUP BY 
    ct.ticket_channel,cst.ticket_type
ORDER BY
    total_critical_tickets DESC
LIMIT 10

/*
RESULTS
=======

[
  {
    "ticket_channel": "Email",
    "ticket_type": "Refund request",
    "total_critical_tickets": "241"
  },
  {
    "ticket_channel": "Email",
    "ticket_type": "Cancellation request",
    "total_critical_tickets": "237"
  },
  {
    "ticket_channel": "Social media",
    "ticket_type": "Technical issue",
    "total_critical_tickets": "236"
  },
  {
    "ticket_channel": "Social media",
    "ticket_type": "Refund request",
    "total_critical_tickets": "232"
  },
  {
    "ticket_channel": "Chat",
    "ticket_type": "Technical issue",
    "total_critical_tickets": "223"
  },
  {
    "ticket_channel": "Chat",
    "ticket_type": "Refund request",
    "total_critical_tickets": "219"
  },
  {
    "ticket_channel": "Chat",
    "ticket_type": "Billing inquiry",
    "total_critical_tickets": "214"
  },
  {
    "ticket_channel": "Phone",
    "ticket_type": "Product inquiry",
    "total_critical_tickets": "214"
  },
  {
    "ticket_channel": "Email",
    "ticket_type": "Product inquiry",
    "total_critical_tickets": "213"
  },
  {
    "ticket_channel": "Email",
    "ticket_type": "Technical issue",
    "total_critical_tickets": "211"
  }
]
*/

