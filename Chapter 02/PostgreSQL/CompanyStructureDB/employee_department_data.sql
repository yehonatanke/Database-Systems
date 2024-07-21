-- Insert data into department table
INSERT INTO department (did, dname, dfloor, head) VALUES
(1, 'A', 3, 54321),
(2, 'B', 3, 12345),
(3, 'C', 4, 34567);

-- Insert data into employee table
INSERT INTO employee (eid, ename, salary, did, classification) VALUES
(12345, 'maya', 15000, 1, 5),
(23456, 'ben', 17000, 1, 3),
(34567, 'dan', 11000, 2, 2),
(45678, 'orit', 10000, 1, 3),
(56789, 'eyal', 10000, 3, 5);

-- Insert data into budget table
INSERT INTO budget (did, byear, budget) VALUES
(1, 2014, 250000),
(1, 2015, 300000),
(1, 2016, 10000),
(1, 2017, 20000),
(1, 2018, 250000),
(1, 2019, 400000),
(2, 2014, 300000),
(2, 2015, 400000),
(2, 2016, 1000000),
(2, 2017, 2000000),
(2, 2018, 50000),
(2, 2019, 700000);

-- Insert data into project table
INSERT INTO project (pid, pname, did, budget, duedate) VALUES
(444, 'search', 1, 15000000, '2019-08-30'),
(111, 'proj1', 2, 700000, '2019-09-15'),
(222, 'proj2', 3, 350000, '2020-01-01'),
(333, 'proj3', 1, 400000, '2019-10-25');

-- Insert data into onproject table
INSERT INTO onproject (pid, eid, fdate) VALUES
(444, 23456, '2019-07-15'),
(444, 34567, '2019-07-15'),
(444, 45678, '2019-07-10'),
(111, 12345, '2019-07-01'),
(111, 56789, '2019-07-01'),
(222, 23456, '2019-07-01'),
(222, 34567, '2019-07-02'),
(333, 23456, '2019-06-25');
