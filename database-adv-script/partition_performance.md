# Partitioning Performance Report

## Objective

We partitioned the `bookings` table by `start_date` to improve performance when querying large date-based datasets.

## Partition Strategy

Used **range partitioning** by month (e.g., Jan, Feb, Mar 2024). Each partition handles a month's worth of data.

## Observations

### Before Partitioning

Query:

```sql
SELECT * FROM bookings WHERE start_date BETWEEN '2024-02-01' AND '2024-02-28';
