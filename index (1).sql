-- An index is a database structure that improves the speed of data retrieval operations on a table at the cost of slower
--  writes (INSERT/UPDATE/DELETE) and extra storage
-- You have a users table and frequently search by the email column.
-- Applicable on table and view to speed up the query

create database indexdemo;
use indexdemo;
drop table users;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
INSERT INTO users (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Lee', 'charlie@example.com'),
('Diana Prince', 'diana@example.com'),
('Evan Turner', 'evan@example.com'),
('Fiona Davis', 'fiona@example.com'),
('George Brown', 'george@example.com'),
('Hannah Wilson', 'hannah@example.com'),
('Ian Clark', 'ian@example.com'),
('Jenna White', 'jenna@example.com'),
('Kyle Adams', 'kyle@example.com'),
('Laura Scott', 'laura@example.com'),
('Mike Harris', 'mike@example.com'),
('Nina Brooks', 'nina@example.com'),
('Oscar Reed', 'oscar@example.com'),
('Paula Green', 'paula@example.com'),
('Quinn Hayes', 'quinn@example.com'),
('Rachel Wood', 'rachel@example.com'),
('Steve Young', 'steve@example.com'),
('Tina Hall', 'tina@example.com');
select * from users;
SELECT * FROM users WHERE email = 'paula@example.com';

explain SELECT * FROM users WHERE email = 'paula@example.com';

-- check only "type"
-- const	    Single row found using PK/unique	🟢 Excellent
-- ref	         Index used to find multiple rows	🟢 Good
-- range	     Index range scan (e.g. BETWEEN or >)	🟡 Okay
-- ALL	         Full table scan	🔴 Bad (usually)

CREATE INDEX idx_email3 ON users(name);

-- sql sever just jump into the index insted of scanning full table

explain SELECT * FROM users WHERE email = 'paula@example.com';

explain SELECT * FROM users WHERE name='Evan Turner';


CREATE INDEX idx_id ON users(id);

-- way to drop index
DROP INDEX idx_email1 ON users;


-- other example multiple index

CREATE INDEX idx_email1 ON users(email);

CREATE INDEX idx_customer_date ON orders(customer_id, order_date);

-- DIFFERENT EXAMPLE 

SELECT * FROM orders
WHERE customer_id = 101 AND order_date = '2025-10-01';
create index r1 on orders (customer_id,order_date);


SELECT * FROM orders
WHERE order_date = '2025-10-01';


-- WHERE customer_id = 101 
-- WHERE customer_id = 101 AND order_date = '2025-10-01'
-- WHERE order_date = '2025-10-01'


-- HOW TO CHOOSE THE RIGHT COLUMNS TO INDEX

-- the column frequently use  in WHERE filters   (WHERE status = 'active')
-- column used in JOIN conditions      (ON users.id = orders.user_id)
-- column used in ORDER BY or GROUP BY  (ORDER BY created_at DESC)
-- the column with many unique values   (email,username)

-- ❌ Don't use index.

-- Columns with less category (e.g., gender: M/F)
-- Functions on indexed columns
CREATE INDEX idx_name ON users(name);
(SELECT * FROM users WHERE UPPER(name) = 'JOHN');

-- LIKE with wildcard at the start
CREATE INDEX idx_name ON users(name);

-- ❌ Index is not used efficiently
SELECT * FROM users WHERE name LIKE '%john';


