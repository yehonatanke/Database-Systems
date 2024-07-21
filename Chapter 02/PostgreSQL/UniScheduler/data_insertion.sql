-- Populate room table
INSERT INTO room (rno, bno, function, capacity) VALUES
(111, 1, 'lect', 50),
(222, 1, 'lect', 100),
(333, 1, 'lect', 80),
(111, 2, 'lect', 150),
(222, 2, 'lab', 20),
(222, 3, 'lab', 30),
(333, 3, 'meet', 10),
(444, 3, 'meet', 5);

-- Populate semester table
INSERT INTO semester (sid, sdate, edate) VALUES
('winter', '2021-10-17', '2022-01-21'),
('spring', '2022-02-27', '2022-06-10'),
('summer', '2022-07-03', '2022-09-02');

-- Populate revent table
INSERT INTO revent (reid, cno, sid, dayofweek, stime, duration, reg) VALUES
(11, '20277', 'winter', 'sunday', '17:00', '10800', 45),
(12, '20433', 'winter', 'sunday', '20:00', '72000', 25),
(13, '20471', 'summer', 'monday', '14:00', '10800', 70),
(14, '20595', 'spring', 'wednesday', '17:00', '72000', 30);

-- Populate sevent table
INSERT INTO sevent (seid, ename, edate, stime, duration, reg) VALUES
(1571, 'salary meeting', '2021-10-10', '17:00', '3600', 10),
(1572, 'salary meeting', '2021-11-10', '17:00', '3600', 10),
(1585, 'staff meeting', '2021-10-10', '17:00', '3600', 5),
(1586, 'staff meeting', '2021-10-10', '17:00', '3600', 5);

-- Populate schedule table
INSERT INTO schedule (sdate, stime, rno, bno, eid, duration) VALUES
('2021-10-10', '17:00', 333, 3, 1571, '3600'),
('2021-11-10', '17:00', 333, 3, 1572, '3600'),
('2021-10-10', '17:00', 444, 3, 1585, '3600'),
('2021-10-10', '17:00', 222, 2, 1586, '3600'),
('2021-10-10', '18:00', 333, 3, 1572, '3600');
--('2021-10-10', '18:00', 333, 2, 1572, '3600');
