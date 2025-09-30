# Task 6 – Subqueries and Nested Queries  

## Objective  
- Use subqueries in SELECT, WHERE, and FROM clauses  
- Understand scalar subqueries, correlated subqueries, and derived tables  
- Practice SQL queries with nested logic  

##  Tools  
- MySQL Workbench  

---

##  Sample Tables  

### Departments  
```sql
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Sales');
```

### Employees
```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO employees VALUES
(101, 'Alice', 60000, 1, NULL),
(102, 'Bob', 55000, 2, 101),
(103, 'Charlie', 70000, 3, 101),
(104, 'David', 45000, 2, 102),
(105, 'Eve', 80000, 3, 103),
(106, 'Frank', 30000, 4, 102);
```

## Queries & Subqueries

### 1.Subquery in where
```sql
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

### 2.Subquery in select
```sql
SELECT name,
       (SELECT department_name 
        FROM departments d 
        WHERE d.department_id = e.department_id) AS department
FROM employees e;
```

### 3.Subquery in from
```sql
SELECT dept_id, avg_salary
FROM (SELECT department_id AS dept_id, AVG(salary) AS avg_salary
      FROM employees
      GROUP BY department_id) AS dept_avg
WHERE avg_salary > 50000;
```

### 4.Using exists
```sql
SELECT department_name
FROM departments d
WHERE EXISTS (SELECT 1 
              FROM employees e 
              WHERE e.department_id = d.department_id);
```

### 5.Correlated subquery
```sql
SELECT name, salary
FROM employees e1
WHERE salary > (SELECT AVG(salary) 
                FROM employees e2 
                WHERE e2.department_id = e1.department_id);
```
