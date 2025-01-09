-- Create the Department table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY AUTO_INCREMENT, -- Unique Identifier
    DeptName VARCHAR(100) UNIQUE NOT NULL, -- No two departments can have the same name
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Audit Column
);

-- Create the Employee table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY AUTO_INCREMENT, -- Unique Identifier
    EmpName VARCHAR(100) NOT NULL, -- Employee Name must not be null
    DeptID INT, -- Foreign key to reference Department
    Salary DECIMAL(10, 2) CHECK (Salary > 0), -- Salary must be a positive value
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Audit Column
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID) -- Ensures referential integrity
    ON DELETE CASCADE ON UPDATE CASCADE -- Cascades updates/deletes
);

-- Insert sample data into Department
INSERT INTO Department (DeptName) VALUES 
('Human Resources'),
('Engineering'),
('Marketing');

-- Insert sample data into Employee
INSERT INTO Employee (EmpName, DeptID, Salary) VALUES 
('John Doe', 1, 50000.00),
('Jane Smith', 2, 75000.00),
('Alice Johnson', 3, 60000.00);

-- Transaction example to ensure consistency
BEGIN;

-- Add a new employee and department atomically
INSERT INTO Department (DeptName) VALUES ('Finance');
INSERT INTO Employee (EmpName, DeptID, Salary) VALUES ('Robert Brown', LAST_INSERT_ID(), 70000.00);

-- Commit if all statements succeed
COMMIT;

-- Rollback if there's an error
ROLLBACK;

-- Ensure consistent data using a trigger (e.g., no employee can be assigned to a non-existent department)
DELIMITER $$

CREATE TRIGGER Ensure_Dept_Exists
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
    DECLARE DeptCount INT;
    SELECT COUNT(*) INTO DeptCount FROM Department WHERE DeptID = NEW.DeptID;
    IF DeptCount = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid DeptID: Department does not exist.';
    END IF;
END;
$$
DELIMITER ;

-- Query to check the current state of data
SELECT * FROM Department;
SELECT * FROM Employee;
