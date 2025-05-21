# Optimization Report: Booking Query Performance

## Initial Query

We used a multi-join query to fetch all bookings with related user, property, and payment details. The original query selected many columns, some of which may not be required in all views.

## Performance Analysis

Using `EXPLAIN ANALYZE`, we identified:

- Full table scans on `bookings`, `users`, and `payments` due to missing indexes.
- Join conditions were valid but not efficient without indexes.
- Selecting unused fields increased memory usage.

## Optimizations Made

- Added indexes on `user_id`, `property_id`, and `booking_id` columns.
- Removed unnecessary columns from SELECT to reduce I/O.
- Simplified user name by combining `first_name` and `last_name`.

## Result

The optimized query runs faster and uses indexes for lookup, especially when filtering by user or property in future queries.

## Suggested Indexes

```sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
