CREATE DATABASE company;
USE company;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    ManagerID INT
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Position, Salary, HireDate, ManagerID) VALUES
(1, 'John', 'Doe', 'Sales', 'Manager', 75000, '2018-01-15', NULL),
(2, 'Jane', 'Smith', 'Sales', 'Sales Executive', 50000, '2019-03-22', 1),
(3, 'Jim', 'Beam', 'HR', 'HR Manager', 72000, '2020-07-01', NULL),
(4, 'Sara', 'Connor', 'IT', 'Developer', 85000, '2021-05-18', 5),
(5, 'Anna', 'Johnson', 'IT', 'Team Lead', 92000, '2019-12-12', NULL),
(6, 'Mike', 'Rogers', 'Marketing', 'Marketing Specialist', 55000, '2022-03-25', NULL),
(7, 'Tom', 'Hanks', 'HR', 'Recruiter', 48000, '2021-11-11', 3),
(8, 'Nina', 'Brown', 'Sales', 'Sales Executive', 51000, '2020-02-05', 1);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    ManagerID INT
);

INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID) VALUES
(1, 'Sales', 1),
(2, 'HR', 3),
(3, 'IT', 5),
(4, 'Marketing', 6);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(12, 2)
);

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, Budget) VALUES
(1, 'Website Redesign', '2023-01-10', '2023-06-30', 50000),
(2, 'HR System Upgrade', '2022-10-01', '2023-03-15', 30000),
(3, 'Marketing Campaign', '2023-04-01', '2023-09-30', 40000),
(4, 'CRM System Implementation', '2021-05-15', '2022-01-31', 75000);

CREATE TABLE Employee_Project (
    EmployeeID INT,
    ProjectID INT,
    Role VARCHAR(50),
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

INSERT INTO Employee_Project (EmployeeID, ProjectID, Role) VALUES
(2, 1, 'Developer'),
(4, 1, 'Developer'),
(5, 1, 'Team Lead'),
(6, 3, 'Marketing Specialist'),
(2, 4, 'Support'),
(3, 2, 'HR Manager');

SELECT * FROM employees
WHERE Department = 'IT';

SELECT * FROM employees
WHERE salary > 60000;

SELECT SUM(budget) AS Tottal_Budget
FROM projects;

SELECT CONCAT(FirstName, " ", LastName) AS FullName, p.projectName, ep.Role
FROM employees e 
JOIN employee_project ep ON e.EmployeeID = ep.EmployeeID
JOIN projects p ON ep.ProjectID = p.ProjectID;

SELECT * FROM employees
WHERE ManagerID = (SELECT 
EmployeeID FROM employees 
WHERE FirstName = 'john' AND LastName = 'Doe');

SELECT * FROM employees
ORDER BY salary DESC
 LIMIT 1 OFFSET 1;
 
 SELECT * FROM employees
 WHERE FirstName LIKE 'S%';
 
SELECT * FROM employees
WHERE Department IN ("HR" , "IT");

SELECT department, COUNT(EmployeeID) AS Totalemp
FROM employees
GROUP BY Department
HAVING Totalemp > 2;

SELECT * FROM employees
WHERE ManagerID IS NULL;

SELECT department, MAX(salary)
FROM employees
GROUP BY department;

SELECT FirstName, LastName, HireDate FROM  employees
WHERE HireDate > '2020-01-01';

SELECT FirstName, LastName, Salary 
FROM employees
WHERE Salary = ( SELECT MAX(salary) FROM employees);

SELECT department , AVG(Salary)
FROM employees
GROUP BY department;

SELECT FirstName, LastName
FROM employees e
WHERE EXISTS ( SELECT 1 FROM employee_project ep 
WHERE e.employeeID = ep.EmployeeID);

SELECT FirstName, LastName
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM Employee_Project ep
    WHERE e.EmployeeID = ep.EmployeeID
);

SELECT department, COUNT(employeeid)
FROM employees
GROUP BY Department;

SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentName = e.Department
GROUP BY d.DepartmentName;

SELECT e.FirstName, e.LastName
FROM Employees e
JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE m.FirstName = 'Anna' AND m.LastName = 'Johnson';

SELECT DISTINCT Department
FROM employees;

SELECT firstName, LastName, Salary
FROM employees
WHERE salary > ( SELECT AVG(salary) FROM employees);

SELECT e.FirstName, e.LastName
FROM Employees e
JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE e.Department = m.Department;

SELECT FirstName, LastName, Salary,
CASE
WHEN salary > 80000 THEN 'High'
WHEN salary BETWEEN 50000 AND 80000 THEN 'Medium'
ELSE 'Low'
END AS SalaryCategory
FROM employees;









































