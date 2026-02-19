DROP TABLE IF EXISTS user_stats;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS api_keys;
DROP TABLE IF EXISTS employee_salaries;

CREATE TABLE user_stats (
    user_id INT PRIMARY KEY,
    total_logins INT DEFAULT 0,
    last_login TIMESTAMP,
    highest_score INT DEFAULT 0
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE inventory (
    product_id INT PRIMARY KEY REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity >= 0)
);

CREATE TABLE api_keys (
    api_key TEXT PRIMARY KEY,
    user_id INT NOT NULL,
    revoked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employee_salaries (
    employee_id INT PRIMARY KEY,
    salary NUMERIC(10,2) NOT NULL CHECK (salary > 0),
    updated_at TIMESTAMP NOT NULL
);

-- Seed Data

INSERT INTO user_stats VALUES
(1, 5, '2024-01-01 10:00:00', 100);

INSERT INTO products VALUES
(10, 'Keyboard', 50.00, '2024-01-01'),
(20, 'Mouse', 25.00, '2024-01-01');

INSERT INTO inventory VALUES
(10, 5),
(20, 10);

INSERT INTO api_keys (api_key, user_id) VALUES
('abc123', 1);

INSERT INTO employee_salaries VALUES
(1, 50000, '2024-01-01');
