create database companycd;
use companycd;
 CREATE TABLE department(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO department (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Sales');

 CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

INSERT INTO employees (employee_id, name, salary, department_id, manager_id) VALUES
(101, 'Alice', 60000, 1, NULL),
(102, 'Bob', 55000, 2, 101),
(103, 'Charlie', 70000, 3, 101),
(104, 'David', 45000, 2, 102),
(105, 'Eve', 80000, 3, 103),
(106, 'Frank', 30000, 4, 102);

-- 1.Subquery in where
select name,salary
from employees
where salary> (select avg(salary) from employees);

-- 2.Subquery in select
select name,
(select department_name 
from department d
where d.department_id=e.department_id)
as department
from employees e ;

-- 3.Subquery in from
select dept_id,avg_salary
from(select department_id 
as dept_id,
avg(salary) as avg_salary
from employees 
group by department_id)
as dept_avg
where avg_salary>50000;

-- 4.Using exists
select department_name
from department d
where exists(select 1
from employees e
where
e.department_id=d.department_id);

-- 5.Correlated subquery
SELECT name, salary
FROM employees e1
WHERE salary > (SELECT AVG(salary) 
                FROM employees e2 
                WHERE e2.department_id = e1.department_id);