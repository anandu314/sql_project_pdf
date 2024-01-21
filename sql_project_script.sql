-- Create the library database
CREATE DATABASE IF NOT EXISTS library;
USE library;

-- Branch Table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(100),
    Contact_no VARCHAR(12));
    
-- Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));

-- Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(30),
    Customer_address VARCHAR(100),
    Reg_date DATE);

-- Books table
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(250),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10,2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100));
    
-- IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN));
    
-- ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));


-- Modify the INSERT statements for better distinction
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
    (1, 101, 'Karukachal_Branch', '8877400001'),
    (2, 102, 'Nedumkunnam_Branch', '8877400002'),
    (3, 103, 'Mulayamveli_Branch', '8877400003'),
    (4, 104, 'Punnavely_Branch', '8877400004');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
    (1, 'John Smith', 'Manager', 60000, 1),
    (2, 'Alice Johnson', 'Clerk', 45000, 1),
    (3, 'Robert Brown', 'Manager', 70000, 2),
    (4, 'Emily Davis', 'Staff', 70000, 1),
    (5, 'Daniel Wilson', 'Clerk', 45000, 1),
    (6, 'Olivia Miller', 'Clerk', 45000, 1),
    (7, 'William Jones', 'Clerk', 55000, 1);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
    (1, 'Michael Clark', 'Pampady_Branch', '2021-12-15'),
    (2, 'Sophia Lee', 'Kangazha_Branch', '2022-02-20'),
    (3, 'Emma White', 'Punnavely_Branch', '2021-11-01'),
    (4, 'David Martin', 'Mallappally_Branch', '2021-09-01');

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
    (101, 'Data Science', 'Science & Tech', 550, 'yes', 'ABC', 'XYZ'),
    (102, 'Technology', 'Fiction', 450, 'yes', 'ABCD', 'XYZA'),
    (103, 'Story', 'Drama', 650, 'yes', 'GABC', 'TXYZ'),
    (104, 'Scene of Dreams', 'Noval', 550, 'no', 'YYABC', 'YYXYZ'),
    (105, 'Untold Legends', 'History', 350, 'yes', 'LYYABC', 'LYYXYZ');

-- IssueStatus table
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
    (1, 1, 'Data Science', '2022-01-10', 101),
    (2, 2, 'Technology', '2023-06-06', 102),
    (3, 3, 'Story', '2023-04-06', 103);

-- ReturnStatus table
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
    (1, 1, 'Data Science', '2022-02-05', 101),
    (2, 2, 'Story', '2022-04-15', 103);

    
--  Retrieve the book title, category, and rental price of all available books.
SELECT Book_title,Category,Rental_Price
FROM Books
WHERE Status='yes';

-- List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name,Salary
FROM Employee
ORDER BY Salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus 
JOIN Books ON IssueStatus.Isbn_book=Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust=Customer.Customer_Id;

-- Display the total count of books in each category.
SELECT Category,COUNT(*) AS BookCount
FROM Books 
GROUP BY Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name,Position,Salary 
FROM Employee
WHERE Salary>50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);


-- Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS E_Count
FROM Employee
GROUP BY Branch_no;

-- Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT Customer.Customer_name
FROM IssueStatus
JOIN Customer  ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE MONTH(IssueStatus.Issue_date)=6 AND YEAR(IssueStatus.Issue_date)=2023;

-- Retrieve book_title from book table containing history.
SELECT Book_title
FROM Books
WHERE Category ='History';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT Branch_no, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Branch_no
HAVING Employee_Count > 5;


    
    