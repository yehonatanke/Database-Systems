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
