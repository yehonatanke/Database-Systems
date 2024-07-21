DROP TABLE IF EXISTS room CASCADE;
DROP TABLE IF EXISTS semester CASCADE;
DROP TABLE IF EXISTS revent CASCADE;
DROP TABLE IF EXISTS sevent CASCADE;
DROP TABLE IF EXISTS schedule CASCADE;

-- Room table
-- Stores information about university rooms
CREATE TABLE room (
    rno INTEGER,              -- Room number
    bno INTEGER,              -- Building number
    function VARCHAR(50) NOT NULL,  -- Room function (e.g., lecture hall, lab)
    capacity INTEGER NOT NULL,  -- Room capacity (number of people)
    PRIMARY KEY (rno, bno),   -- Composite primary key
    CHECK (rno > 0),
    CHECK (bno > 0),
    CHECK (capacity > 0)
);

-- Semester table
-- Stores information about academic semesters
CREATE TABLE semester (
    sid INTEGER PRIMARY KEY,  -- Semester ID
    sdate DATE NOT NULL,      -- Start date of the semester
    edate DATE NOT NULL,      -- End date of the semester
    CHECK (sdate < edate)
);

-- Revent (Regular Event) table
-- Stores information about regularly scheduled events (e.g., weekly classes)
CREATE TABLE revent (
    reid INTEGER PRIMARY KEY,  -- Regular event ID
    cno VARCHAR(10) NOT NULL,  -- Course number
    sid INTEGER NOT NULL,      -- Semester ID (foreign key)
    dayofweek INTEGER NOT NULL,  -- Day of the week (1-7)
    stime TIME NOT NULL,       -- Start time of the event
    duration INTEGER NOT NULL, -- Duration in minutes
    reg INTEGER NOT NULL,      -- Number of registrants
    FOREIGN KEY (sid) REFERENCES semester(sid),
    CHECK (dayofweek BETWEEN 1 AND 7),
    CHECK (duration > 0),
    CHECK (reg >= 0)
);

-- Sevent (Special Event) table
-- Stores information about one-time or special events
CREATE TABLE sevent (
    seid INTEGER PRIMARY KEY,  -- Special event ID
    ename VARCHAR(100) NOT NULL,  -- Event name
    edate DATE NOT NULL,       -- Event date
    stime TIME NOT NULL,       -- Start time of the event
    duration INTEGER NOT NULL, -- Duration in minutes
    reg INTEGER NOT NULL,      -- Number of registrants
    CHECK (duration > 0),
    CHECK (reg >= 0)
);

-- Schedule table
-- Links events to rooms, representing the actual scheduling
CREATE TABLE schedule (
    sdate DATE,       -- Date of the scheduled event
    stime TIME,       -- Start time of the scheduled event
    rno INTEGER,      -- Room number (part of foreign key to room)
    bno INTEGER,      -- Building number (part of foreign key to room)
    eid INTEGER,      -- Event ID (could be reid or seid)
    duration INTEGER, -- Duration of the scheduled event
    PRIMARY KEY (sdate, stime, rno, bno, eid),  -- Updated primary key including eid
    FOREIGN KEY (rno, bno) REFERENCES room(rno, bno),
    CHECK (duration > 0)
);

