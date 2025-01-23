----- Library Management System ------

--  Create a database named Library
CREATE DATABASE Library;
USE Library;

-- create table branch
CREATE TABLE Branch(
branch_no int primary key auto_increment,
Manager_id int,
Branch_address varchar(100),
contact_no varchar(15));

INSERT INTO Branch VALUES
(1,1001,'1234 Main st,City A','98765433988'),
(2,1002,'2134 Second st,City B','8766996875'),
(3,1003,'4565 Pine St,City D','4565687812'),
(4,1004,'768 Emma St,City E','5668778786'),
(5,1005,'1223 Oak St,City F','6655463276');

SELECT *FROM Branch;

-- create table Employee
CREATE TABLE Employee(
emp_id int primary key auto_increment,
emp_name varchar(20),
position varchar(20),
salary int,
branch_no int,
foreign key ( branch_no ) REFERENCES branch( branch_no ));


INSERT INTO Employee (emp_name,position,salary,branch_no) VALUES
('Will Smith','Manager',60000,1),
('John Honnai','Assistant',25000,2),
('Emily John','Librarian',45000,3),
('Davis Brown','Manager',60000,4),
('Michael Philip','Librarian',45000,5),
('John John','Librarian',60000,1),
('Honnai Honnai','Assistant',25000,1),
('Emily Emily','Librarian',45000,1),
('Brown Brown','Librarian',45000,1),
('Philip Philip','Librarian',45000,1);

SELECT *FROM Employee;

-- create table Books
-- with attributes Books ISBN - Set as PRIMARY KEY Book_title Category Rental_Price 
-- Status [Give yes if book available and no if book not available] Author Publisher
CREATE TABLE Books(
ISBN varchar(13) PRIMARY KEY,
Book_title varchar(200),
Category varchar(20), 
Rental_Price decimal(10,2),
Status varchar(3) check (Status in('yes','no')),
Author varchar(100),
Publisher varchar(100));

INSERT INTO Books VALUES 
('978-0-123456', 'History of the World', 'History', 30.00, 'yes', 'John Historian', 'History Press'),
('978-1-234567', 'Science for Kids', 'Science', 20.00, 'yes', 'Mary Scientist', 'Science World'),
('978-0-987654', 'Programming in Python', 'Technology', 25.00, 'no', 'James Developer', 'Tech Press'),
('978-0-654321', 'Art and Culture', 'Art', 15.00, 'yes', 'Sophia Artist', 'Art Publisher'),
('978-1-234555', 'Modern Literature', 'Literature', 40.00, 'yes', 'William Shakespeare', 'Literary Press');
SELECT *FROM Books;
-- create table  Customer 
-- with attributes Customer_Id - Set as PRIMARY KEY Customer_name Customer_address Reg_date
CREATE TABLE Customer(
Customer_id INT PRIMARY KEY auto_increment,
Customer_name varchar(100),
Customer_address VARCHAR(250),
Reg_date date);

INSERT INTO Customer( Customer_name,Customer_address,Reg_date) VALUES
('Serah John','293 Main st,City A','2020-01-01'),
('Stephen Hawkins','64 Emma St,City A','2018-05-03'),
('Hira Joseph','327 Oak St,City D','2024-02-12'),
('Renuka Williams','22 Second St,City D','2015-09-23'),
('Christina Jacob','192 Main St,City A','2020-01-02');

SELECT *FROM Customer;

-- Create table IssueStatus with attributes 
-- Issue_Id - Set as PRIMARY KEY Issued_cust – Set as FOREIGN KEY and it refer customer_id in CUSTOMER table 
-- Issued_book_name Issue_date 
-- Isbn_book – Set as FOREIGN KEY and it should refer isbn in BOOKS table 
CREATE TABLE IssueStatus(
Issue_id INT PRIMARY KEY,
Issued_cust int,
Issued_book_name VARCHAR(200),
issue_date date,
isbn_book VARCHAR(13),
foreign key ( Issued_cust ) references Customer (Customer_id),
foreign key ( isbn_book ) references Books (ISBN));


INSERT INTO IssueStatus( Issue_id,Issued_cust,Issued_book_name,Issue_date,isbn_book)VALUES
(1,1, 'History of the World', '2024-01-15', '978-0-123456'),
(2,4, 'Programming in Python', '2024-01-18', '978-0-987654'),
(3,4, 'Science for Kids', '2024-12-10', '978-1-234567'),
(4,3, 'Modern Literature', '2023-06-12', '978-1-234555'),
(5,5, 'Art and Culture', '2025-01-20', '978-0-654321');

SELECT *FROM IssueStatus;


-- Create table ReturnStatus with attributes Return_Id - Set as PRIMARY KEY 
-- Return_cust Return_book_name Return_date 
-- Isbn_book2 - Set as FOREIGN KEY and it should refer isbn in BOOKS table

CREATE TABLE ReturnStatus(
Return_id INT PRIMARY KEY,
Return_cust VARCHAR(100),
Return_book_name VARCHAR(200),
Return_date date,
Isbn_book VARCHAR(13),
foreign key (Isbn_book ) references Books(ISBN));

INSERT INTO ReturnStatus
(Return_id,Return_cust,Return_book_name,Return_date,isbn_book)
VALUES
(1, 1, 'History of the World', '2025-01-20', '978-0-123456'),
(2, 4, 'Programming in Python', '2025-01-22', '978-0-987654'),
(3, 4, 'Science for Kids', '2025-01-15', '978-1-234567'),
(4, 3, 'Modern Literature', '2025-01-19', '978-1-234555'),
(5, 5, 'Art and Culture', '2025-01-14', '978-0-654321');
SELECT *FROM ReturnStatus;

-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT book_title,category,rental_price 
FROM Books WHERE status='yes';

-- 2. List the employee names and their respective salaries in descending order of salary. 
SELECT emp_name,salary 
FROM Employee
ORDER BY salary DESC;

--  3. Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT B.book_title,C.customer_name FROM Books B INNER JOIN IssueStatus I ON B.ISBN=I.ISBN_book 
JOIN Customer C ON I.Issued_cust=C.Customer_id;

-- 4. Display the total count of books in each category.
SELECT category,COUNT(*) AS Count_of_books FROM Books GROUP BY category;

-- 5. Retrieve the employee names and their positions for the employees
-- whose salaries are above Rs.50,000.
SELECT emp_name,position FROM Employee WHERE salary > 50000;

-- 6. List the customer names
-- who registered before 2022-01-01 and have not issued any books yet.
SELECT C.Customer_name FROM Customer C LEFT JOIN IssueStatus I ON C.Customer_id=I.issued_cust
WHERE C.reg_date<'2022-01-01' AND I.Issue_id IS NULL;

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT B.branch_no,count(E.emp_id) AS Count_of_employees 
FROM Branch B LEFT JOIN Employee E
ON B.branch_no=E.branch_no
GROUP BY B.branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.

SELECT C.Customer_name FROM Customer C JOIN IssueStatus I ON C.customer_id=I.Issued_cust
WHERE I.issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9. Retrieve book_title from book table containing history.
SELECT book_title FROM Books WHERE category='history';

-- 10.Retrieve the branch numbers along with the 
-- count of employees for branches having more than 5 employees

SELECT B.branch_no,count(E.emp_id) AS count_of_employees 
FROM Branch B JOIN Employee E ON B.branch_no= E.branch_no
GROUP BY B.branch_no
HAVING COUNT(E.emp_id)>5;

--  11. Retrieve the names of employees 
-- who manage branches and their respective branch addresses.
SELECT E.emp_name,B.branch_no,B.branch_address 
FROM employee E join branch B ON E.branch_no=B.branch_no
where E.position='Manager';

-- 12. Display the names of customers 
-- who have issued books with a rental price higher than Rs. 25.

SELECT C.customer_name FROM Customer C JOIN IssueStatus I 
ON C.customer_id=I.Issued_cust 
JOIN Books B ON I.isbn_book=B.ISBN
WHERE Rental_price>25;
















