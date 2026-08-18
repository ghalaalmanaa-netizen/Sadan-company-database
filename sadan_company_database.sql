-- Sadan Company Database
-- SQL / MySQL Project
-- All company, employee, job title, salary, contact, and other data
-- in this project are fictional and created solely for demonstration
-- and to showcase SQL, database design, and data analysis skills.

CREATE DATABASE IF NOT EXISTS sadan_company;
USE sadan_company;

-- =========================================================
-- 1. Company Table
-- =========================================================

CREATE TABLE company (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(100),
    founded_year YEAR,
    headquarters VARCHAR(100),
    capital DECIMAL(12,2),
    classification VARCHAR(50)
);

INSERT INTO company
(company_id, company_name, founded_year, headquarters, capital, classification)
VALUES
(1, 'sadan general contracting', 2020, 'jeddah', 120000.00, 'second');

SELECT * FROM company;

-- =========================================================
-- 2. Employees Table
-- =========================================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    job_title VARCHAR(100),
    department VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2),
    phone VARCHAR(20),
    email VARCHAR(150),
    company_id INT
);

INSERT INTO employees
(employee_id, employee_name, job_title, department, hire_date, salary, phone, email, company_id)
VALUES
(1, 'Sarah Mohammed', 'General Manager', 'Management', '2020-01-15', 18000.00, '0501234567', 'smohammed@sadan.com', 1),
(2, 'Nourah Saad', 'Financial Policies & Procurement Specialist', 'Finance & Procurement', '2023-03-20', 13000.00, '0502345778', 'nourah_saad@sadan.com', 1),
(3, 'Ghadah Fahad', 'Project Manager', 'Projects', '2021-08-28', 11000.00, '0553948761', 'ghadahf1996@sadan.com', 1),
(4, 'Ahmed Ali', 'Financial Analyst', 'Finance', '2023-05-10', 9500.00, '0541830564', 'ahmedali@sadan.com', 1),
(5, 'Ghala Almanaa', 'Payments Officer', 'Finance', '2024-11-24', 8700.00, '0558749184', 'almanaa315@sadan.com', 1),
(6, 'Rand Alghamdy', 'General Accountant', 'Accounting', '2023-01-12', 8900.00, '0551039548', 'alahmad@sadan.com', 1),
(7, 'Abeer Mohsen', 'General Accountant', 'Accounting', '2021-08-13', 9000.00, '0531942054', 'abeermohsen@sadan.com', 1),
(8, 'Deena Khaled', 'General Accountant', 'Accounting', '2024-12-19', 7800.00, '0551936583', 'deena.khaled@sadan.com', 1),
(9, 'Abdullmalek Alshehry', 'Internal Auditor & Accountant', 'Internal Audit & Accounting', '2022-01-31', 10600.00, '0553215927', 'alshehry95@sadan.com', 1),
(10, 'Layla Saleh', 'Warehouse Keeper & Financial Statements Officer', 'Warehouse & Finance', '2023-07-19', 7500.00, '0552056749', 'LaylaSaleh@sadan.com', 1);

SELECT * FROM employees;

-- =========================================================
-- 3. Basic Queries
-- =========================================================

SELECT *
FROM employees
WHERE employee_id = 5;

DESCRIBE employees;

SHOW TABLES;

DESCRIBE company;
DESCRIBE employees;

-- =========================================================
-- 4. Foreign Key Relationship
-- =========================================================

ALTER TABLE employees
ADD CONSTRAINT fk_employee_company
FOREIGN KEY (company_id)
REFERENCES company(company_id);

-- =========================================================
-- 5. JOIN: Employees and Company
-- =========================================================

SELECT
    employees.employee_name,
    employees.job_title,
    company.company_name
FROM employees
JOIN company
    ON employees.company_id = company.company_id;

-- =========================================================
-- 6. Average Salary by Department
-- =========================================================

SELECT
    department,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department;

-- =========================================================
-- 7. Employee Count and Average Salary by Department
-- =========================================================

SELECT
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department
ORDER BY average_salary DESC;

-- =========================================================
-- 8. Employees Earning Above the Overall Average Salary
-- =========================================================

SELECT
    employee_name,
    job_title,
    department,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;

-- =========================================================
-- 9. Highest Salary in Each Department
-- =========================================================

SELECT
    department,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department
ORDER BY highest_salary DESC;

-- =========================================================
-- 10. Employee with the Highest Salary in Each Department
-- =========================================================

SELECT
    e.department,
    e.employee_name,
    e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
)
ORDER BY e.salary DESC;

-- =========================================================
-- 11. Final Employee and Company Salary Overview
-- =========================================================

SELECT
    e.employee_name,
    e.job_title,
    e.department,
    e.salary,
    c.company_name
FROM employees e
JOIN company c
    ON e.company_id = c.company_id
ORDER BY e.salary DESC;
