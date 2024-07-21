-- PostgreSQL schema for Employee and Department Database

-- Drop existing tables if they exist
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS budget CASCADE;
DROP TABLE IF EXISTS project CASCADE;
DROP TABLE IF EXISTS onproject CASCADE;

-- Department table
CREATE TABLE department (
    did NUMERIC(3,0) PRIMARY KEY,
    dname VARCHAR(30),
    dfloor INT,
    head NUMERIC(5,0)
);

-- Employee table
CREATE TABLE employee (
    eid NUMERIC(5,0) PRIMARY KEY,
    ename VARCHAR(30),
    salary INT,
    did NUMERIC(3,0),
    classification INTEGER,
    FOREIGN KEY (did) REFERENCES department,
    CHECK (salary >= 0)
);

-- Budget table
CREATE TABLE budget (
    did NUMERIC(3,0),
    byear NUMERIC(4,0),
    budget INT,
    PRIMARY KEY (did, byear),
    FOREIGN KEY (did) REFERENCES department,
    CHECK (budget >= 0)
);

-- Project table
CREATE TABLE project (
    pid NUMERIC(3,0) PRIMARY KEY,
    pname VARCHAR(30),
    did NUMERIC(3,0),
    budget INT,
    duedate DATE,
    FOREIGN KEY (did) REFERENCES department,
    CHECK (budget >= 0)
);

-- OnProject table (junction table for Employee-Project relationship)
CREATE TABLE onproject (
    pid NUMERIC(3,0),
    eid NUMERIC(5,0),
    fdate DATE,
    PRIMARY KEY (pid, eid),
    FOREIGN KEY (eid) REFERENCES employee
);
