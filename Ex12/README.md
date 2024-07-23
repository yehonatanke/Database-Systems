# Law Firm Database Schema 

This document outlines the database schema for a law firm management system.

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
