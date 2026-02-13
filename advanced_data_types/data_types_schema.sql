-- ENUM for order status
CREATE TYPE order_status AS ENUM ('pending','shipped','delivered');

-- Users table with JSONB preferences and array of skills
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    skills TEXT[],                          -- Array of skills
    preferences JSONB                        -- JSONB for flexible settings
);

-- Products table with tags (array) and attributes (JSONB)
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    tags TEXT[],                             -- Array of tags
    attributes JSONB                          -- JSONB for dynamic key-values (color, size, etc.)
);

-- Orders table with ENUM status and JSONB for optional metadata
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    product_ids INT[],                        -- Array of product IDs
    order_date TIMESTAMP NOT NULL DEFAULT NOW(),
    status order_status DEFAULT 'pending',    -- ENUM status
    metadata JSONB                             -- JSONB for optional details (gift wrap, coupon)
);



-- INSERTS 

INSERT INTO users (name, email, skills, preferences) VALUES
('Alice Johnson', 'alice@example.com',
 ARRAY['SQL','Python','Data Analysis'],
 '{"theme": "dark", "notifications": true, "language": "en", "newsletter": true}'
),
('Bob Smith', 'bob@example.com',
 ARRAY['JavaScript','React','Node.js'],
 '{"theme": "light", "notifications": false, "language": "en", "newsletter": false}'
),
('Charlie Brown', 'charlie@example.com',
 ARRAY['Java','Spring','Docker'],
 '{"theme": "dark", "notifications": true, "language": "fr"}'
),
('Diana Prince', 'diana@example.com',
 ARRAY['Python','SQL','Data Engineering'],
 '{"theme": "light", "newsletter": true}'
);


INSERT INTO products (name, tags, attributes) VALUES
('Laptop',
 ARRAY['electronics','computer','portable'],
 '{"brand": "Dell", "color": "silver", "ram": "16GB", "size": "L"}'
),
('T-Shirt',
 ARRAY['clothing','gift'],
 '{"color": "blue", "size": "L", "material": "cotton"}'
),
('Smartphone',
 ARRAY['electronics','mobile'],
 '{"brand": "Samsung", "color": "black", "storage": "128GB"}'
),
('Gift Card',
 ARRAY['gift','digital'],
 '{"value": "50", "color": "blue"}'
),
('Headphones',
 ARRAY['electronics','accessory'],
 '{"brand": "Sony", "color": "blue"}'
);


INSERT INTO orders (user_id, product_ids, order_date, status, metadata) VALUES
-- Recent order (last 7 days)
(2, ARRAY[1,3], NOW() - INTERVAL '3 days', 'pending',
 '{"gift_wrap": false}'
),

-- Delivered with blue product
(1, ARRAY[2], NOW() - INTERVAL '10 days', 'delivered',
 '{"gift_wrap": true}'
),

-- Pending gift order
(3, ARRAY[4], NOW() - INTERVAL '1 day', 'pending',
 '{"priority": "express"}'
),

-- Delivered blue electronics
(4, ARRAY[5], NOW() - INTERVAL '2 days', 'delivered',
 '{"rating": 5}'
),

-- Another delivered with blue gift
(1, ARRAY[4,2], NOW() - INTERVAL '5 days', 'delivered',
 '{"coupon_code": "WELCOME10"}'
);

