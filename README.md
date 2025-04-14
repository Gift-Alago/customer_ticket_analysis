# 📊 Customer Support Ticket Analysis

Welcome to a deep dive into the world of **customer support tickets**!  
This project explores **high-priority tickets**, **customer age groups**, and **behavioral characteristics** to uncover patterns and improve customer service experience.

> 📂 Check out the SQL queries here: [Project_sql folder](/Project_sql/)

---

## 🔍 Background

Driven by a mission to **advocate for customers more efficiently and effectively**, this project aims to uncover the root causes of issues and their frequency. By identifying which issues recur, how long they take to resolve, and the demographics behind them, we can enhance customer satisfaction and improve long-term retention.

---

## ❓ Project Questions

Here are the questions I aimed to answer with SQL:

1. ⏱️ What is the **average time** to resolve a ticket based on ticket type?
2. 📢 Which **channels** receive the most **high-priority (critical)** tickets?
3. 🔁 Which **customers sent multiple tickets** for the same issue?
4. 👥 Which **age group submits** the most support tickets?
5. 🚨 Which **age group has the most "Critical" priority** tickets?

---

## 🛠️ Tools Used

| Tool              | Purpose                                                                 |
|------------------|-------------------------------------------------------------------------|
| **SQL**          | For querying and analyzing the ticket data                              |
| **PostgreSQL**   | Database management system for handling the dataset                     |
| **Visual Studio Code** | For executing queries and database management                    |
| **Git & GitHub** | Version control and project documentation                               |

---

## 📈 The Analysis

**Each query investigates a specific customer support behavior. Here's a breakdown of how each was approached:**

---

### 1. ⏳ Average Time to Resolution by Ticket Type

This query calculates the average time it takes to resolve a ticket after the first response, also known as **Mean Time to Resolution (MTTR)**.

```sql
SELECT  
     ticket_type,
     AVG("time_to_resolution" - "first_response_time") AS avg_resolution_time
FROM 
     customer_support_3
WHERE
     time_to_resolution IS NOT NULL
GROUP BY
     ticket_type
ORDER BY
     avg_resolution_time DESC;
```

#### 📊 Average Resolution Time by Ticket Type:

| Ticket Type          | Avg Resolution Time (hh:mm) |
|----------------------|---------------------------|
| Refund request      | 08:07                      |
| Cancellation request | 07:41                      |
| Product inquiry     | 07:40                      |
| Technical issue     | 07:21                      |
| Billing inquiry     | 07:36                      |

#### 🔍 Insights:

- **Refund requests** take the longest to resolve (8 hours, 7 minutes). 
This could be due to approval processes or additional verification steps.
- **Technical issues** takes about (7 hours, 21 minutes). This suggests an efficient troubleshooting process or well-documented solutions.
- **Cancellation and product inquiries** have nearly identical resolution times (around 7 hours, 40-41 minutes), indicating similar complexity and processes
- **Billing inquiries** are resolved slightly faster than cancellation and product inquiries but still take over 7 hours, likely due to verification needs like; subscription bundles,type of subscription,date of subscription and much more.

---

### 2. 📣 Channels with Most High-Priority Tickets
To identify which support channels receive the highest number of critical tickets, I queried customer support data by counting ticket entries and categorizing them by ticket channel. This query retrieves the support channels(email, phone, chat and social)that handle most of high-priority (critical) tickets. Additionally, by filtering tickets by ticket-type:
I can determine the top 10 most frequent urgent issues that require escalation.

```sql
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
```
#### 🧾 Top 10 Channels with Most Critical Tickets:

| Ticket Channel | Ticket Type        | Total Critical Tickets |
|---------------|--------------------|------------------------|
| Email        | Refund request      | 241                    |
| Email        | Cancellation request | 237                    |
| Social media | Technical issue     | 236                    |
| Social media | Refund request      | 232                    |
| Chat         | Technical issue     | 223                    |
| Chat         | Refund request      | 219                    |
| Chat         | Billing inquiry     | 214                    |
| Phone        | Product inquiry     | 214                    |
| Email        | Product inquiry     | 213                    |
| Email        | Technical issue     | 211                    |

#### 📌 Insights:

- Email is the top channel for critical issues.
- Refund and technical issues dominate across all platforms.
- Real-time channels like chat are key for resolving billing and refund concerns quickly.
- support is limited, possibly due to cost or complexity.

---

### 3. 🔁 Repeated Tickets for the Same Issue
To identify customers who have submitted multiple tickets for the same issue, I counted the occurances and categorized it by "customer-email" and "ticket-subject". The (HAVING COUNT(*)>1) condition ensures that only repeated issues are included.

```sql
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
```
#### ♻️ Repeat Tickets by ticket Subject

| Customer Email             | Ticket Subject             | Repeat Tickets |
|----------------------------|---------------------------|---------------|
| bsmith@example.com        | Installation support      | 3             |
| rsparks@example.org       | Battery life              | 2             |
| jacksonadam@example.com   | Product recommendation    | 2             |
| ewhite@example.net        | Installation support      | 2             |
| tbutler@example.net       | Product setup             | 2             |

#### 🧠 Insights:

- Installation and setup issues are common recurring problems.
- Indicates a potential gap in onboarding or documentation.
- Product recommendation and battery life suggest dissatisfaction or confusion about product specs.

---

### 4. 👥 Ticket Volume by Age Group
Customers were grouped into the following age categories:

- 18–25: Young Adults
- 26–35: Early Career
- 36–50: Mid Career
- 51–65: Near Retirement
- 65+: Seniors

``` sql
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
```

#### 📊 Tickets by Age Group:

| Age Group         | Ticket Count |
|------------------|-------------|
| Near Retirement | 1,229       |
| Mid Career      | 1,211       |
| Early Career    | 835         |
| Young Adults    | 621         |
| Seniors        | 389         |

#### 🔍 Insights:
1. Near Retirement and Mid Career groups have the highest ticket volume. 
2. Younger users may rely more on self-service tools.
3. Seniors engage less, possibly due to lower product usage or comfort with tech.
4. **Customer Support  should focus more on the Near Retirement and Mid Career groups**, while ensuring Young Adults and Early Career users have self-service options.

---

### 5. 🚨 High-Priority Tickets by Age Group
This query shows the top 10 combinations of ticket types and age groups with the highest number of "Critical" priority tickets.

```sql
SELECT * from customer_support_3
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
 ```
 #### 🔥 Top 10 Critical Issues by Age Group  

| Tickets Count | Ticket Type          | Age Group        |
|--------------|----------------------|------------------|
| 83           | Technical issue      | Mid Career      |
| 70           | Billing inquiry      | Mid Career      |
| 67           | Technical issue      | Near Retirement |
| 65           | Refund request       | Near Retirement |
| 64           | Billing inquiry      | Near Retirement |
| 58           | Product inquiry      | Mid Career      |
| 56           | Cancellation request | Near Retirement |
| 56           | Product inquiry      | Near Retirement |
| 52           | Refund request       | Mid Career      |

#### 💡 Insights:

- Technical issues are the top concern among Mid Career and Near Retirement groups.
- Billing and refund concerns are consistent across both groups.
- Product and cancellation issues also emerge as pain points.

---
## What I Learned
🔥 Leveling Up My SQL Game! 🔥

I've been on an SQL adventure, unlocking new skills like a data-wielding superhero:

- 🧩 Query Mastery: Taming complex queries, and summoning WITH clauses for some serious SQL magic.
- 📊 Data Aggregation Wizardry: GROUP BY and aggregate functions (COUNT, AVG) are my sidekicks, helping me turn raw data 
  into meaningfull insights.
- 💡 Analytical Superpowers: Transforming real-world questions into SQL-powered answers that actually make sense!

---

## Conclusions
  From the analysis, several insights emerged:

  1. **Average Resolution Time by Ticket Type:** The highest average time for resolution was 8hours,7mins which is the Refund request ticket.
 
 2. **Channels with Most High-Priority Tickets:** Email Is the dominant support channel for critical tickets appearing in 4 out of the top 10 results.

 3. **Repeated Tickets for the Same Issue:** Installation support is the most frequently reported issue,appearing twice with different customers.

 4. **Tickets volume by age groups:** Near Retirement(1229 tickets) and Mid Career(1211 tickets) having the highest ticket volumes. Customer Support  should focus more on the Near Retirement and Mid Career groups, while ensuring Young Adults and Early Career users have self-service options.

 5. **High-Priority Tickets by Age Group:** Technical issues are the most common especially among mid-career users (35-50years).

