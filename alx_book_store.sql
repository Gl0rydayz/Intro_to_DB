-- MySQL Database Schema for ALX Book Store
-- Online Bookstore Database

-- Create the database
CREATE DATABASE IF NOT EXISTS alx_book_store;
USE alx_book_store;

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Customers;

-- Create Authors table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(215) NOT NULL
);

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) NOT NULL UNIQUE,
    address TEXT NOT NULL
);

-- Create Books table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(130) NOT NULL,
    author_id INT NOT NULL,
    price DOUBLE NOT NULL,
    publication_date DATE NOT NULL,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- Create Order_Details table
CREATE TABLE Order_Details (
    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Insert sample data into Authors table
INSERT INTO Authors (author_name) VALUES
('J.K. Rowling'),
('George R.R. Martin'),
('Stephen King'),
('Agatha Christie'),
('J.R.R. Tolkien'),
('Harper Lee'),
('F. Scott Fitzgerald'),
('Jane Austen'),
('Charles Dickens'),
('Mark Twain');

-- Insert sample data into Customers table
INSERT INTO Customers (customer_name, email, address) VALUES
('John Smith', 'john.smith@email.com', '123 Main Street, New York, NY 10001'),
('Sarah Johnson', 'sarah.j@email.com', '456 Oak Avenue, Los Angeles, CA 90210'),
('Michael Brown', 'mike.brown@email.com', '789 Pine Road, Chicago, IL 60601'),
('Emily Davis', 'emily.davis@email.com', '321 Elm Street, Houston, TX 77001'),
('David Wilson', 'david.w@email.com', '654 Maple Drive, Phoenix, AZ 85001'),
('Lisa Anderson', 'lisa.a@email.com', '987 Cedar Lane, Philadelphia, PA 19101'),
('Robert Taylor', 'rob.taylor@email.com', '147 Birch Court, San Antonio, TX 78201'),
('Jennifer Martinez', 'jen.martinez@email.com', '258 Spruce Way, San Diego, CA 92101'),
('William Garcia', 'will.garcia@email.com', '369 Willow Path, Dallas, TX 75201'),
('Amanda Rodriguez', 'amanda.r@email.com', '741 Aspen Circle, San Jose, CA 95101');

-- Insert sample data into Books table
INSERT INTO Books (title, author_id, price, publication_date) VALUES
('Harry Potter and the Philosopher''s Stone', 1, 24.99, '1997-06-26'),
('Harry Potter and the Chamber of Secrets', 1, 26.99, '1998-07-02'),
('A Game of Thrones', 2, 29.99, '1996-08-01'),
('A Clash of Kings', 2, 31.99, '1998-11-16'),
('The Shining', 3, 19.99, '1977-01-28'),
('It', 3, 22.99, '1986-09-15'),
('Murder on the Orient Express', 4, 16.99, '1934-01-01'),
('And Then There Were None', 4, 18.99, '1939-11-06'),
('The Hobbit', 5, 21.99, '1937-09-21'),
('The Lord of the Rings: The Fellowship of the Ring', 5, 27.99, '1954-07-29'),
('To Kill a Mockingbird', 6, 20.99, '1960-07-11'),
('The Great Gatsby', 7, 17.99, '1925-04-10'),
('Pride and Prejudice', 8, 15.99, '1813-01-28'),
('Oliver Twist', 9, 18.99, '1838-01-01'),
('The Adventures of Tom Sawyer', 10, 16.99, '1876-06-01');

-- Insert sample data into Orders table
INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-01-15'),
(2, '2024-01-16'),
(3, '2024-01-17'),
(4, '2024-01-18'),
(5, '2024-01-19'),
(1, '2024-01-20'),
(6, '2024-01-21'),
(7, '2024-01-22'),
(8, '2024-01-23'),
(9, '2024-01-24');

-- Insert sample data into Order_Details table
INSERT INTO Order_Details (order_id, book_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 5, 1),
(2, 7, 1),
(3, 9, 1),
(3, 11, 2),
(4, 13, 1),
(4, 15, 1),
(5, 2, 1),
(5, 4, 1),
(6, 6, 1),
(6, 8, 1),
(7, 10, 1),
(7, 12, 1),
(8, 14, 1),
(8, 1, 1),
(9, 3, 1),
(9, 5, 1),
(10, 7, 1),
(10, 9, 1);

-- Create indexes for better performance
CREATE INDEX idx_books_author_id ON Books(author_id);
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_orderdetails_order_id ON Order_Details(order_id);
CREATE INDEX idx_orderdetails_book_id ON Order_Details(book_id);
CREATE INDEX idx_customers_email ON Customers(email);

-- Display table information
SELECT 'Authors' AS table_name, COUNT(*) AS record_count FROM Authors
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Books', COUNT(*) FROM Books
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'Order_Details', COUNT(*) FROM Order_Details;

-- Sample queries to demonstrate the database
-- 1. Find all books by a specific author
SELECT b.title, b.price, b.publication_date 
FROM Books b 
JOIN Authors a ON b.author_id = a.author_id 
WHERE a.author_name = 'J.K. Rowling';

-- 2. Find total sales by customer
SELECT c.customer_name, COUNT(o.order_id) as total_orders, SUM(od.quantity * b.price) as total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Books b ON od.book_id = b.book_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- 3. Find most popular books
SELECT b.title, a.author_name, SUM(od.quantity) as total_sold
FROM Books b
JOIN Authors a ON b.author_id = a.author_id
JOIN Order_Details od ON b.book_id = od.book_id
GROUP BY b.book_id, b.title, a.author_name
ORDER BY total_sold DESC
LIMIT 5;
