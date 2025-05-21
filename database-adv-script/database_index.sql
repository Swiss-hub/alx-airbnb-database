-- USERS TABLE
CREATE TABLE users (
    user_id TEXT PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

-- PROPERTIES TABLE
CREATE TABLE properties (
    property_id TEXT PRIMARY KEY,
    host_id CHAR(36) NOT NULL,
    name TEXT NOT NULL,
    description TEXT
   -- location VARCHAR(255) NOT NULL,
);

-- BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id TEXT PRIMARY KEY,
    user_id TEXT,
    property_id TEXT,
    start_date TEXT,
    end_date TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)

);

-- REVIEWS TABLE
CREATE TABLE reviews (
    review_id TEXT PRIMARY KEY,
    property_id TEXT,
    rating INTEGER,
    comment TEXT,
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

-- SAMPLE DATA

-- Users
INSERT INTO users (user_id, first_name, last_name, email) VALUES
('u1', 'Alice', 'Anderson', 'alice@example.com'),
('u2', 'Bob', 'Brown', 'bob@example.com'),
('u3', 'Charlie', 'Clark', 'charlie@example.com');

-- Properties
INSERT INTO properties (property_id, name, description) VALUES
('p1', 'Cozy Cabin', 'A small cozy cabin in the woods'),
('p2', 'Modern Apartment', 'Downtown high-rise apartment'),
('p3', 'Beach House', 'House near the ocean');

-- Bookings
INSERT INTO bookings (booking_id, user_id, property_id, start_date, end_date) VALUES
('b1', 'u1', 'p1', '2024-06-01', '2024-06-05'),
('b2', 'u2', 'p2', '2024-06-10', '2024-06-15');

-- Reviews
INSERT INTO reviews (review_id, property_id, rating, comment) VALUES
('r1', 'p1', 5, 'Amazing stay!'),
('r2', 'p2', 4, 'Very nice'),
('r3', 'p2', 3, 'Okay experience');

-- 1. INNER JOIN: All bookings and the users who made them
SELECT
    bookings.booking_id,
    users.first_name,
    users.email,
    bookings.property_id,
    bookings.start_date,
    bookings.end_date
FROM bookings
INNER JOIN users ON bookings.user_id = users.user_id
ORDER BY bookings.start_date;

-- 2. LEFT JOIN: All properties and their reviews, including those with no reviews
SELECT
    properties.property_id,
    properties.name,
    reviews.review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews ON properties.property_id = reviews.property_id
ORDER BY properties.name;

-- 3. FULL OUTER JOIN simulation using UNION
SELECT
    users.user_id,
    users.first_name,
    bookings.booking_id,
    bookings.property_id
FROM users
LEFT JOIN bookings ON users.user_id = bookings.user_id

UNION

SELECT
    users.user_id,
    users.first_name,
    bookings.booking_id,
    bookings.property_id
FROM bookings
LEFT JOIN users ON users.user_id = bookings.user_id
ORDER BY user_id;


-- Non-Correlated Subquery
-- Get properties with an average review rating greater than 4.0
SELECT *
FROM properties
WHERE property_id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
)
ORDER BY property_id;


-- Correlated Subquery
-- Find users who have made more than 3 bookings
SELECT *
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY user_id;


--AGGREGATIONS_AND_WINDOW_FUNCTIONS.SQL
-- 1. Total number of bookings made by each user
SELECT 
    user_id,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id
ORDER BY total_bookings DESC;

-- 2. Rank properties based on total bookings using RANK()
SELECT 
    property_id,
    COUNT(*) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_rank
FROM bookings
GROUP BY property_id;

-- 3. Row number of properties based on total bookings using ROW_NUMBER()
SELECT 
    property_id,
    COUNT(*) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS booking_row_number
FROM bookings
GROUP BY property_id;



ALTER TABLE properties ADD COLUMN location VARCHAR(255);



--database_index.sql – Create Indexes
-- Create index on bookings.user_id to speed up joins with users
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Create index on bookings.property_id to speed up joins with properties
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Create index on users.email for quick lookup
CREATE INDEX idx_users_email ON users(email);

-- Create index on properties.location for location-based filtering
CREATE INDEX idx_properties_location ON properties(location);

-- Create composite index on bookings (start_date, end_date) for date-range filtering
CREATE INDEX idx_bookings_date_range ON bookings(start_date, end_date);

-- Create indexes on commonly queried fields
--CREATE INDEX idx_bookings_user_id ON bookings(user_id);
--CREATE INDEX idx_bookings_property_id ON bookings(property_id);
--CREATE INDEX idx_users_email ON users(email);
--CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);

-- Use EXPLAIN ANALYZE to measure performance of typical queries

EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE user_id = 'u1';  -- Replace 'u1' with a real user_id from your data

EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE property_id = 'p1';  -- Replace 'p1' with a real property_id

EXPLAIN ANALYZE
SELECT * FROM users
WHERE email = 'johndoe@example.com';  -- Replace with existing email

