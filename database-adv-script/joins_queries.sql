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
    name TEXT NOT NULL,
    description TEXT
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
INNER JOIN users ON bookings.user_id = users.user_id;

-- 2. LEFT JOIN: All properties and their reviews, including those with no reviews
SELECT
    properties.property_id,
    properties.name,
    reviews.review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews ON properties.property_id = reviews.property_id;

-- 3. FULL OUTER JOIN simulation using UNION (SQLite doesn't support full outer join directly)
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
LEFT JOIN users ON users.user_id = bookings.user_id;
