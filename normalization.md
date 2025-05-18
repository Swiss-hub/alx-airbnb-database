# Normalization Steps – Airbnb Database

## Objective
To ensure the Airbnb database design is efficient, non-redundant, and scalable by applying the principles of database normalization up to the Third Normal Form (3NF).

---

## First Normal Form (1NF)

- All tables use atomic column values.
- There are no repeating groups or multivalued fields.
- Each record has a unique identifier (UUID primary key).
✅ **The database satisfies 1NF.**

---

## Second Normal Form (2NF)

- The schema is in 1NF.
- No table uses composite primary keys.
- All non-key attributes depend on the entire primary key.
✅ **The database satisfies 2NF.**

---

## Third Normal Form (3NF)

- The schema is in 2NF.
- All non-key attributes are dependent solely on the primary key.
- No transitive dependencies exist in any of the tables.
✅ **The database satisfies 3NF.**

---

## Final Remark

All entities were reviewed and confirmed to adhere to 3NF. No further decomposition is necessary at this stage.
