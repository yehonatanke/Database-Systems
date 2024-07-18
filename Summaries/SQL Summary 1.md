# SQL Cheatsheet and Language Summary

## Table of Contents
1. [Data Definition Language (DDL)](#data-definition-language-ddl)
2. [Data Manipulation Language (DML)](#data-manipulation-language-dml)
3. [Data Query Language (DQL)](#data-query-language-dql)
4. [Data Control Language (DCL)](#data-control-language-dcl)
5. [Transaction Control Language (TCL)](#transaction-control-language-tcl)
6. [Constraints](#constraints)
7. [Joins](#joins)
8. [Aggregate Functions](#aggregate-functions)
9. [Subqueries](#subqueries)
10. [Views](#views)
11. [Indexes](#indexes)
12. [Best Practices](#best-practices)

## Data Definition Language (DDL)

DDL commands are used to define, modify, and delete database objects.

### CREATE TABLE
```sql
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
);
```

### ALTER TABLE
```sql
ALTER TABLE table_name
ADD column_name datatype;

ALTER TABLE table_name
DROP COLUMN column_name;

ALTER TABLE table_name
MODIFY COLUMN column_name datatype;
```

### DROP TABLE
```sql
DROP TABLE table_name;
```

## Data Manipulation Language (DML)

DML commands are used to manipulate data within database objects.

### INSERT
```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

### UPDATE
```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

### DELETE
```sql
DELETE FROM table_name
WHERE condition;
```

## Data Query Language (DQL)

DQL commands are used to retrieve data from the database.

### SELECT
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
GROUP BY column_name
HAVING condition
ORDER BY column_name ASC/DESC
LIMIT number;
```

## Data Control Language (DCL)

DCL commands are used to control access to data within the database.

### GRANT
```sql
GRANT privilege_name
ON object_name
TO user_name;
```

### REVOKE
```sql
REVOKE privilege_name
ON object_name
FROM user_name;
```

## Transaction Control Language (TCL)

TCL commands are used to manage transactions within the database.

### COMMIT
```sql
COMMIT;
```

### ROLLBACK
```sql
ROLLBACK;
```

### SAVEPOINT
```sql
SAVEPOINT savepoint_name;
```

## Constraints

Constraints are used to specify rules for data in a table.

- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NOT NULL
- CHECK
- DEFAULT

Example:
```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
```

## Joins

Joins are used to combine rows from two or more tables based on a related column between them.

### INNER JOIN
```sql
SELECT *
FROM table1
INNER JOIN table2 ON table1.column_name = table2.column_name;
```

### LEFT JOIN
```sql
SELECT *
FROM table1
LEFT JOIN table2 ON table1.column_name = table2.column_name;
```

### RIGHT JOIN
```sql
SELECT *
FROM table1
RIGHT JOIN table2 ON table1.column_name = table2.column_name;
```

### FULL OUTER JOIN
```sql
SELECT *
FROM table1
FULL OUTER JOIN table2 ON table1.column_name = table2.column_name;
```

## Aggregate Functions

Aggregate functions perform calculations on a set of values and return a single result.

- COUNT()
- SUM()
- AVG()
- MAX()
- MIN()

Example:
```sql
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department;
```

## Subqueries

A subquery is a query nested inside another query.

Example:
```sql
SELECT name
FROM employees
WHERE department_id IN (SELECT id FROM departments WHERE location = 'New York');
```

## Views

A view is a virtual table based on the result of a SELECT statement.

```sql
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

## Indexes

Indexes are used to speed up the retrieval of rows from a table.

```sql
CREATE INDEX index_name
ON table_name (column1, column2, ...);
```


