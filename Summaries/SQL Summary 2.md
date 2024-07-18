# SQL Summary and Cheatsheet

## Introduction to SQL

SQL (Structured Query Language) is a standard programming language used for managing and manipulating relational databases. It allows users to create, read, update, and delete (CRUD) data within a database.

## SQL Syntax

### Basic Syntax

```sql
-- Select statement
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- Insert statement
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);

-- Update statement
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

-- Delete statement
DELETE FROM table_name
WHERE condition;
```

### Creating and Modifying Tables

```sql
-- Create table
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
);

-- Alter table
ALTER TABLE table_name
ADD column_name datatype constraints;

-- Drop table
DROP TABLE table_name;
```

### Data Types

- `INT` - Integer
- `VARCHAR(size)` - Variable length string
- `DATE` - Date value
- `FLOAT` - Floating point number
- `BOOLEAN` - True or False

## SQL Clauses

### SELECT

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
GROUP BY column
HAVING condition
ORDER BY column;
```

- **DISTINCT**: Removes duplicates
- **WHERE**: Filters records
- **GROUP BY**: Groups rows sharing a property
- **HAVING**: Filters groups
- **ORDER BY**: Sorts the result

### JOINs

```sql
-- Inner Join
SELECT columns
FROM table1
INNER JOIN table2 ON table1.common_column = table2.common_column;

-- Left Join
SELECT columns
FROM table1
LEFT JOIN table2 ON table1.common_column = table2.common_column;

-- Right Join
SELECT columns
FROM table1
RIGHT JOIN table2 ON table1.common_column = table2.common_column;

-- Full Join
SELECT columns
FROM table1
FULL OUTER JOIN table2 ON table1.common_column = table2.common_column;
```

### Subqueries

```sql
SELECT column1, column2, ...
FROM table_name
WHERE column_name = (SELECT column_name FROM another_table WHERE condition);
```

### Set Operations

```sql
-- UNION
SELECT column1, column2, ...
FROM table1
UNION
SELECT column1, column2, ...
FROM table2;

-- UNION ALL
SELECT column1, column2, ...
FROM table1
UNION ALL
SELECT column1, column2, ...
FROM table2;

-- INTERSECT
SELECT column1, column2, ...
FROM table1
INTERSECT
SELECT column1, column2, ...
FROM table2;

-- EXCEPT
SELECT column1, column2, ...
FROM table1
EXCEPT
SELECT column1, column2, ...
FROM table2;
```

## Functions

### Aggregate Functions

- `COUNT()`: Returns the number of rows
- `SUM()`: Returns the sum of values
- `AVG()`: Returns the average value
- `MIN()`: Returns the minimum value
- `MAX()`: Returns the maximum value

```sql
SELECT COUNT(column_name) FROM table_name;
SELECT SUM(column_name) FROM table_name;
SELECT AVG(column_name) FROM table_name;
SELECT MIN(column_name) FROM table_name;
SELECT MAX(column_name) FROM table_name;
```

### String Functions

- `LEN()`: Returns the length of a string
- `LOWER()`: Converts a string to lowercase
- `UPPER()`: Converts a string to uppercase
- `SUBSTRING()`: Extracts characters from a string

```sql
SELECT LEN(column_name) FROM table_name;
SELECT LOWER(column_name) FROM table_name;
SELECT UPPER(column_name) FROM table_name;
SELECT SUBSTRING(column_name, start, length) FROM table_name;
```

### Date Functions

- `GETDATE()`: Returns the current date and time
- `DATEPART()`: Returns a part of a date
- `DATEDIFF()`: Returns the difference between two dates

```sql
SELECT GETDATE();
SELECT DATEPART(year, column_name) FROM table_name;
SELECT DATEDIFF(day, start_date, end_date) FROM table_name;
```

## Constraints

### Types of Constraints

- `NOT NULL`: Ensures a column cannot have a NULL value
- `UNIQUE`: Ensures all values in a column are different
- `PRIMARY KEY`: A combination of `NOT NULL` and `UNIQUE`. Uniquely identifies each row in a table
- `FOREIGN KEY`: Uniquely identifies a row/record in another table
- `CHECK`: Ensures that all values in a column satisfy a specific condition
- `DEFAULT`: Sets a default value for a column if no value is specified

```sql
CREATE TABLE table_name (
    column1 datatype NOT NULL,
    column2 datatype UNIQUE,
    column3 datatype,
    PRIMARY KEY (column1),
    FOREIGN KEY (column3) REFERENCES another_table(column_name),
    CHECK (column3 > 0),
    DEFAULT 'default_value'
);
```

## Indexes

### Creating Indexes

```sql
-- Create index
CREATE INDEX index_name
ON table_name (column1, column2, ...);

-- Unique index
CREATE UNIQUE INDEX index_name
ON table_name (column1, column2, ...);

-- Drop index
DROP INDEX index_name;
```

### Views

### Creating and Managing Views

```sql
-- Create view
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- Drop view
DROP VIEW view_name;
```

## Transactions

### Transaction Control

```sql
-- Start transaction
START TRANSACTION;

-- Commit transaction
COMMIT;

-- Rollback transaction
ROLLBACK;
```

### Transaction Isolation Levels

- `READ UNCOMMITTED`
- `READ COMMITTED`
- `REPEATABLE READ`
- `SERIALIZABLE`

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

## Common Table Expressions (CTEs)

### Using CTEs

```sql
WITH CTE_Name AS (
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition
)
SELECT column1, column2, ...
FROM CTE_Name
WHERE condition;
```

## Window Functions

### Using Window Functions

```sql
SELECT column1,
       ROW_NUMBER() OVER (PARTITION BY column2 ORDER BY column3) AS row_num,
       RANK() OVER (PARTITION BY column2 ORDER BY column3) AS rank,
       DENSE_RANK() OVER (PARTITION BY column2 ORDER BY column3) AS dense_rank,
       NTILE(n) OVER (PARTITION BY column2 ORDER BY column3) AS ntile
FROM table_name;
```

## Advanced Topics

### Recursive CTEs

```sql
WITH RECURSIVE CTE_Name AS (
    SELECT column1, column2
    FROM table_name
    WHERE condition
    UNION ALL
    SELECT column1, column2
    FROM CTE_Name
    WHERE condition
)
SELECT column1, column2
FROM CTE_Name;
```

### JSON Functions (for databases that support JSON)

```sql
-- Parsing JSON
SELECT column_name->'$.property' AS property_value
FROM table_name;

-- Creating JSON
SELECT JSON_OBJECT('key1', value1, 'key2', value2);
```

### Full-Text Search

```sql
-- Create full-text index
CREATE FULLTEXT INDEX index_name
ON table_name (column1, column2, ...);

-- Perform full-text search
SELECT column1, column2
FROM table_name
WHERE MATCH(column1, column2) AGAINST ('search_term');
```
