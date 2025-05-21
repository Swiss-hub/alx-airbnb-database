# 📊 Index Performance Evaluation

This report documents the performance improvement observed after creating indexes on frequently used columns in the database.

---

## ✅ Indexes Created

| Table      | Column(s)                | Index Name                   |
|------------|--------------------------|------------------------------|
| bookings   | user_id                  | idx_bookings_user_id         |
| bookings   | property_id              | idx_bookings_property_id     |
| users      | email                    | idx_users_email              |
| properties | location                 | idx_properties_location      |
| bookings   | start_date, end_date     | idx_bookings_date_range      |

---

## 📈 Performance Comparison (Example)

### Query Before Index:

```sql
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE user_id = 'some-user-id';
