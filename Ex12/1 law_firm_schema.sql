-- 1 --

-- Drop existing tables if they exist
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS lawyer CASCADE;
DROP TABLE IF EXISTS cases CASCADE;
DROP TABLE IF EXISTS documents CASCADE;
DROP TABLE IF EXISTS billing CASCADE;
DROP TABLE IF EXISTS onCase CASCADE;


-- Create clients table 
CREATE TABLE client (
    cname VARCHAR(20) PRIMARY KEY,
    address VARCHAR(50),
    phone CHAR(11),
    email VARCHAR(50)
);

-- Create lawyers table 
CREATE TABLE lawyer (
    lname VARCHAR(20) PRIMARY KEY,
    specialization VARCHAR(20),
    ophone CHAR(11),
    email VARCHAR(50),
    office INT,
    hbilling INT,
    partner DATE NULL
);

-- Create cases table 
CREATE TABLE cases (
    cid INT PRIMARY KEY,
    title VARCHAR(20),
    description VARCHAR(150),
    status DATE,
    lname VARCHAR(20),
    cname VARCHAR(20),
    FOREIGN KEY (lname) REFERENCES lawyer(lname),
    FOREIGN KEY (cname) REFERENCES client(cname)
);

-- Create documents table 
CREATE TABLE documents (
    cid INT,
    dname VARCHAR(20),
    dtype VARCHAR(20),
    PRIMARY KEY (cid, dname),
    FOREIGN KEY (cid) REFERENCES cases(cid)
);

-- Create billing table
CREATE TABLE billing (
    bdate DATE,
    lname VARCHAR(20),
    cid INT,
    hours INT,
    description VARCHAR(150),
    amount INT,
    PRIMARY KEY (bdate, lname),
    FOREIGN KEY (lname) REFERENCES lawyer(lname)
);

-- Create table for additional lawyers on a case 
CREATE TABLE onCase (
    cid INT,
    lname VARCHAR(20),
    role VARCHAR(20),
    PRIMARY KEY (cid, lname),
    FOREIGN KEY (cid) REFERENCES cases(cid),
    FOREIGN KEY (lname) REFERENCES lawyer(lname)
);


