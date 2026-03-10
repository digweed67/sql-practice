/*
Scenario 5: When to Denormalize
You have a normalized database with tables for Customers, Orders, and Products.
In reporting, joining these tables takes too long for frequent queries.
Tasks:
- Explain what denormalization is and why it might be helpful here.
Denormalization is the process of joining separate normalized tables into one or adding redundant data to reduce expensive joins and to speed up querying.  

- Suggest an example of denormalization you might apply.
For example, we might join orders and products to see most sold products,  or orders and customers to see highest spending customers, etc. 

- Discuss trade-offs involved in denormalizing.
Denormalization improves query performance by reducing joins, but it introduces redundant data, which can lead to potential data inconsistencies and complicate data maintenance.

*/



CREATE TABLE denormalized_order_details (
    order_id INT,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(100),
    product_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10, 2),
    total_amount NUMERIC(12, 2)
);





