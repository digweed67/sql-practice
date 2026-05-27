DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS orders;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    last_login TIMESTAMP,
    login_count INT DEFAULT 0
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    product TEXT NOT NULL,
    quantity INT NOT NULL,
    status TEXT NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

-- Seed users
INSERT INTO users VALUES
(1, 'Alice', 'alice@email.com', '2024-01-01', 5),
(2, 'Bob', 'bob@email.com', '2024-01-05', 2);

-- Seed orders
INSERT INTO orders VALUES
(100, 1, 'Keyboard', 1, 'shipped', '2024-01-01'),
(101, 2, 'Mouse', 2, 'pending', '2024-01-03');
