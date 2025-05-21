# Database Performance Monitoring and Optimization Report

## Objective

To monitor and refine database performance by analyzing query execution plans and adjusting the schema as needed.

## Tools Used

- `EXPLAIN ANALYZE` (PostgreSQL)
- `SHOW PROFILE` (MySQL — note: only works if profiling is enabled)

---

## Step 1: Analyzed Queries

### Query 1: Bookings with User Info

```sql
EXPLAIN ANALYZE
SELECT * 
FROM bookings
JOIN users ON bookings.user_id = users.user_id
WHERE bookings.start_date BETWEEN '2024-01-01' AND '2024-03-01';
