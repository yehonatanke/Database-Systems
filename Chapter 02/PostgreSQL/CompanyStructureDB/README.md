# Company Structure DB

## Database Schema Overview

This script is a PostgreSQL-based relational database system designed to manage organizational structure, employee data, project information, and departmental budgets. The schema consists of five interconnected tables: 
* `department`
* `employee`
* `budget`
* `project`
* `onproject`

### Table Structures

#### 1. department

Stores information about organizational departments.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| did | NUMERIC(3,0) | PRIMARY KEY | Department ID |
| dname | VARCHAR(30) | | Department name |
| dfloor | INT | | Floor number of the department |
| head | NUMERIC(5,0) | | Employee ID of the department head |

#### 2. employee

Contains employee data with references to their respective departments.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| eid | NUMERIC(5,0) | PRIMARY KEY | Employee ID |
| ename | VARCHAR(30) | | Employee name |
| salary | INT | CHECK (salary >= 0) | Employee salary |
| did | NUMERIC(3,0) | FOREIGN KEY (department.did) | Department ID |
| classification | INTEGER | | Employee classification level |

#### 3. budget

Tracks departmental budgets over different fiscal years.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| did | NUMERIC(3,0) | FOREIGN KEY (department.did) | Department ID |
| byear | NUMERIC(4,0) | | Budget year |
| budget | INT | CHECK (budget >= 0) | Budget amount |
| | | PRIMARY KEY (did, byear) | Composite primary key |

#### 4. project

Manages project-related information.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| pid | NUMERIC(3,0) | PRIMARY KEY | Project ID |
| pname | VARCHAR(30) | | Project name |
| salary | INT | | Project-specific salary (purpose unclear, possibly for project lead) |
| did | NUMERIC(3,0) | FOREIGN KEY (department.did) | Department ID responsible for the project |
| budget | INT | CHECK (budget >= 0) | Project budget |
| duedate | DATE | | Project due date |

#### 5. onproject

Junction table representing the many-to-many relationship between employees and projects.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| pid | NUMERIC(3,0) | | Project ID |
| eid | NUMERIC(5,0) | FOREIGN KEY (employee.eid) | Employee ID |
| fdate | DATE | | Date the employee joined the project |
| | | PRIMARY KEY (pid, eid) | Composite primary key |

## Sample Data

Below are tables containing sample data for each table in the database schema. This data provides concrete examples of the information stored and the relationships between tables.

### department

| did | dname | dfloor | head |
|-----|-------|--------|------|
| 1   | A     | 3      | 54321|
| 2   | B     | 3      | 12345|
| 3   | C     | 4      | 34567|

### employee

| eid   | ename | salary | did | classification |
|-------|-------|--------|-----|----------------|
| 12345 | maya  | 15000  | 1   | 5              |
| 23456 | ben   | 17000  | 1   | 3              |
| 34567 | dan   | 11000  | 2   | 2              |
| 45678 | orit  | 10000  | 1   | 3              |
| 56789 | eyal  | 10000  | 3   | 5              |

### budget

| did | byear | budget  |
|-----|-------|---------|
| 1   | 2014  | 250000  |
| 1   | 2015  | 300000  |
| 1   | 2016  | 10000   |
| 1   | 2017  | 20000   |
| 1   | 2018  | 250000  |
| 1   | 2019  | 400000  |
| 2   | 2014  | 300000  |
| 2   | 2015  | 400000  |
| 2   | 2016  | 1000000 |
| 2   | 2017  | 2000000 |
| 2   | 2018  | 50000   |
| 2   | 2019  | 700000  |

### project

| pid | pname  | did | budget   | duedate    |
|-----|--------|-----|----------|------------|
| 444 | search | 1   | 15000000 | 2019-08-30 |
| 111 | proj1  | 2   | 700000   | 2019-09-15 |
| 222 | proj2  | 3   | 350000   | 2020-01-01 |
| 333 | proj3  | 1   | 400000   | 2019-10-25 |

### onproject

| pid | eid   | fdate      |
|-----|-------|------------|
| 444 | 23456 | 2019-07-15 |
| 444 | 34567 | 2019-07-15 |
| 444 | 45678 | 2019-07-10 |
| 111 | 12345 | 2019-07-01 |
| 111 | 56789 | 2019-07-01 |
| 222 | 23456 | 2019-07-01 |
| 222 | 34567 | 2019-07-02 |
| 333 | 23456 | 2019-06-25 |

## Data Insights and Observations

1. **Department Structure**: 
   - There are three departments (A, B, and C) spread across two floors (3rd and 4th).
   - Each department has a head, who is also an employee in the system.

2. **Employee Distribution**:
   - Department A (did 1) has the most employees (3), followed by B and C with one each.
   - The highest-paid employee is Ben (eid 23456) with a salary of 17000.
   - Classification levels range from 2 to 5, with multiple employees at level 3 and 5.

3. **Budget Trends**:
   - Department budgets vary significantly year by year.
   - Department 2 had a notable budget increase in 2016 and 2017, followed by a sharp decrease in 2018.
   - Department 1's budget fluctuates but shows an overall increasing trend from 2016 to 2019.

4. **Project Allocation**:
   - The 'search' project (pid 444) has the largest budget by far at 15,000,000.
   - Projects are distributed across all three departments.
   - Project due dates span from August 2019 to January 2020.

5. **Employee Project Assignments**:
   - Some employees (e.g., 23456) are assigned to multiple projects.
   - The 'search' project (pid 444) has the most employees assigned to it (3).
   - Project assignments are clustered around early July 2019, with one earlier assignment in late June.

6. **Data Integrity Observations**:
   - All employees are assigned to existing departments.
   - All projects are assigned to existing departments.
   - The `onproject` table correctly references existing employees and projects.

These sample data tables and insights provide a concrete representation of the database structure and relationships, demonstrating how the various entities in the project system interact and relate to each other.

## Relationships

1. One department can have many employees (1:N)
2. One department can have many budgets over different years (1:N)
3. One department can be responsible for many projects (1:N)
4. Many employees can work on many projects (M:N), represented by the `onproject` table

## Technical Considerations

1. **Numeric Precision**: 
   - Department IDs use NUMERIC(3,0), allowing for up to 999 departments.
   - Employee IDs use NUMERIC(5,0), supporting up to 99,999 employees.

2. **Check Constraints**:
   - Salary and budget fields have CHECK constraints to ensure non-negative values.

3. **Composite Primary Keys**:
   - The `budget` table uses a composite primary key (did, byear) to uniquely identify budgets for each department-year combination.
   - The `onproject` table uses a composite primary key (pid, eid) to represent unique employee-project assignments.

4. **Date Handling**:
   - Project due dates and employee project assignment dates are stored as DATE types for efficient date-based operations and queries.

5. **Cascading Actions**:
   - The schema uses CASCADE for dropping tables to ensure referential integrity during schema modifications.

6. **Indexing Implications**:
   - Primary keys are automatically indexed by PostgreSQL.
   - Consider adding indexes on frequently queried columns like `employee.did` or `project.did` for performance optimization.

## Potential Query Optimizations

1. Indexing `employee.did` can improve JOIN performance with the `department` table.
2. Creating a composite index on `onproject (pid, fdate)` may enhance queries involving project staffing over time.
3. For range queries on `budget.byear`, consider a B-tree index on this column.

## Data Integrity Considerations

1. Ensure that the `department.head` always references a valid `employee.eid`.
2. Implement triggers or application-level logic to maintain consistency between `project.budget` and corresponding entries in the `budget` table.
3. Consider adding a trigger to update `department.head` when the referenced employee is deleted or transferred.

## Scalability Notes

1. The current schema supports up to 999 departments and 99,999 employees. For larger organizations, consider widening these fields.
2. For high-volume transaction processing, particularly involving the `onproject` table, consider partitioning strategies based on date ranges or project IDs.
