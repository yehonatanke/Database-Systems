<div align="center">
  <img src="https://img.shields.io/badge/language-PostgreSQL-blue.svg?logo=postgresql">
  <img src="https://custom-icon-badges.demolab.com/badge/license-MIT-green.svg?logo=law">

# Law Firm Database Schema 
</div>

This document outlines the database schema for a law firm management system.

## Project Structure

The project consists of the following SQL files:

1. `law_firm_schema.sql`: Database Schema
2. `update_billing_rate_trigger.sql`: Trigger Function
3. `3 data_entry.sql`: Data Insertion
4. `open_cases_query.sql`: Active Cases Query
5. `one_case_client_query.sql`: Single Case Clients Query
6. `6 at_least_two_active_cases.sql`: Multiple Active Cases Query
7. `total_billing.sql`: Monthly Billing Report
8. `more_than_jessica.sql`: High-Workload Lawyers Query
9. `max_non_partners_lawyers_case.sql`: Maximum Lawyers on Case Query
10. `10 non-partner_assist.sql`: Non-Partner Lawyer Query

## File Descriptions

### 1. law_firm_schema.sql

This file contains the SQL commands to create the database schema. It includes:
- Dropping existing tables (if any)
- Creating tables for clients, lawyers, cases, documents, billing, and case assignments
- Defining primary and foreign key constraints

### 2. update_billing_rate_trigger.sql

This file defines a trigger function and a trigger that automatically calculates the billing amount based on the hours worked and the lawyer's hourly rate.

### 3. 3 data_entry.sql

This file contains INSERT statements to populate the database with sample data for all tables.

### 4. open_cases_query.sql

A query to retrieve information about all active cases, including the case number, title, responsible lawyer, and their specialization.

### 5. one_case_client_query.sql

A query to find clients who have only one case and are working with only one lawyer (the responsible lawyer for the case).

### 6. 6 at_least_two_active_cases.sql

This query identifies clients who have multiple active cases with the same partner lawyer.

### 7. total_billing.sql

A query that generates a monthly billing report, showing the total hours worked and the total amount billed for each lawyer and case combination.

### 8. more_than_jessica.sql

This query finds lawyers who have reported more than 7 hours of work and are working on more cases than Jessica (a specific lawyer in the firm).

### 9. max_non_partners_lawyers_case.sql

A complex query that identifies cases with the maximum number of assigned lawyers, excluding cases where a partner lawyer is involved.

### 10. non-partner_assist.sql

This query finds non-partner lawyers who are responsible for exactly one case and are involved in all but one case in the firm.

## Schema Overview

```
client (cname, address, phone, email)
lawyer (lname, specialization, ophone, email, office, hbilling, partner)
cases (cid, title, description, status, lname, cname)
documents (cid, dname, dtype)
billing (bdate, lname, cid, hours, description, amount)
onCase (cid, lname, role)
```

## Detailed Table Descriptions

### Client
- `cname`: Client name (Primary Key)
- `address`: Client address
- `phone`: Phone number
- `email`: Email address

*Note: Every client must have at least one case in the firm.*

### Lawyer
- `lname`: Lawyer name (Primary Key)
- `specialization`: Area of specialization
- `ophone`: Office phone number
- `email`: Email address
- `office`: Office number
- `hbilling`: Hourly billing rate
- `partner`: Partner status (Default: empty for non-partners, join date for partners)

### Cases
- `cid`: Case ID (Primary Key)
- `title`: Case title
- `description`: Case description
- `status`: Case status (Default: empty for active cases, closing date for closed cases)
- `lname`: Responsible lawyer's name (Foreign Key to Lawyer)
- `cname`: Client name (Foreign Key to Client)

*Note: Every case must have a client and a responsible lawyer.*

### Documents
- `cid`: Case ID (Foreign Key to Cases)
- `dname`: Document name
- `dtype`: Document type

### Billing
- `bdate`: Billing date
- `lname`: Lawyer name (Foreign Key to Lawyer)
- `cid`: Case ID (Foreign Key to Cases)
- `hours`: Hours worked
- `description`: Work description
- `amount`: Calculated amount to be paid (derived attribute)

### OnCase
- `cid`: Case ID (Foreign Key to Cases)
- `lname`: Lawyer name (Foreign Key to Lawyer)
- `role`: Lawyer's role on the case

## Relationships

- Each client must have at least one case.
- Each case has one responsible lawyer and one client.
- Multiple lawyers can work on a case (tracked in OnCase).
- Lawyers can bill hours worked on cases.
- Cases can have multiple associated documents.
