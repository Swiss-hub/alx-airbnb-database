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
