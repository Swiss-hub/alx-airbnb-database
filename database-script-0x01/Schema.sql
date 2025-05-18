CREATE TABLE `users` (
  `user_id` char(36) PRIMARY KEY,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) UNIQUE NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone_number` varchar(20),
  `role` enum(guest,host,admin) NOT NULL,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `properties` (
  `property_id` char(36) PRIMARY KEY,
  `host_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `pricepernight` decimal(10,2) NOT NULL,
  `created_at` timestamptz NOT NULL DEFAULT (now()),
  `updated_at` timestamp NOT NULL DEFAULT (now())
);

CREATE TABLE `bookings` (
  `booking_id` char(36) PRIMARY KEY,
  `property_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum(pending,confirmed,canceled) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (now())
);

CREATE TABLE `payments` (
  `payment_id` char(36) PRIMARY KEY,
  `booking_id` char(36) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` timestamp DEFAULT (now()),
  `payment_method` enum(credit_card,paypal,stripe) NOT NULL
);

CREATE TABLE `reviews` (
  `review_id` char(36) PRIMARY KEY,
  `property_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `rating` int NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `messages` (
  `message_id` char(36) PRIMARY KEY,
  `sender_id` char(36) NOT NULL,
  `receiver_id` char(36) NOT NULL,
  `content` text NOT NULL,
  `sent_at` timestamp DEFAULT (now())
);

CREATE INDEX `users_index_0` ON `users` (`email`);

CREATE INDEX `properties_index_1` ON `properties` (`property_id`);

CREATE INDEX `bookings_index_2` ON `bookings` (`property_id`);

CREATE INDEX `bookings_index_3` ON `bookings` (`booking_id`);

CREATE INDEX `payments_index_4` ON `payments` (`booking_id`);

ALTER TABLE `properties` ADD FOREIGN KEY (`host_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `bookings` ADD FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`);

ALTER TABLE `bookings` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `messages` ADD FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `messages` ADD FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`);
