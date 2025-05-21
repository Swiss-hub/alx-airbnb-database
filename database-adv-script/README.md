# Advanced SQL Join Queries

This directory contains advanced SQL join queries written for the Airbnb Clone project.

## Files

- `joins_queries.sql`: Contains the following SQL JOIN operations:
  - **INNER JOIN**: Retrieves all bookings along with the users who made them.
  - **LEFT JOIN**: Retrieves all properties with their reviews, including properties without reviews.
  - **FULL OUTER JOIN**: Retrieves all users and bookings, including unmatched records on either side.

## Usage

To run the queries, connect to your PostgreSQL or MySQL database and execute:

```bash
psql -U your_username -d your_database -f joins_queries.sql

# Subqueries in SQL

This project demonstrates how to use **correlated** and **non-correlated** subqueries using the Airbnb database schema.

## Objective

- Practice writing complex SQL subqueries.
- Use subqueries to filter and analyze data from multiple related tables.

---

## Queries

### 1. Non-Correlated Subquery – Properties with High Ratings

Finds all properties where the average review rating is **greater than 4.0**.

```sql
SELECT *
FROM properties
WHERE property_id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

