-- 3 --

-- Insert data into client table
INSERT INTO client (cname, address, phone, email) VALUES
('eric', '123 Main St', '555-1111', 'eric@client.com'),
('emily', '456 oak rd', '555-2222', 'emily@client.com'),
('robert', '789 elm st', '555-6789', 'robert@client.com'),
('amy', '654 pine ave', '555-5555', 'amy@client.com');

-- Insert data into lawyer table
INSERT INTO lawyer (lname, specialization, ophone, email, office, hbilling, partner) VALUES
('jessica', 'environmental', '555-0123', 'jessica@lawfirm.com', 1, 750, '2020-10-05'),
('sarah', 'employment', '555-2345', 'sarah@lawfirm.com', 5, 150, NULL),
('david', 'family', '555-5555', 'david@lawfirm.com', 12, 200, NULL);

-- Insert data into cases table
INSERT INTO cases (cid, title, description, status, lname, cname) VALUES
(1, 'eric vs. all', 'civil dispute over contract', NULL, 'sarah', 'eric'),
(2, 'divorce', 'family law case of divorce', NULL, 'david', 'robert'),
(3, 'marriage', 'contract before marriage', NULL, 'david', 'eric'),
(4, 'emily child custody', 'case of child custody', NULL, 'david', 'emily'),
(5, 'emily vs. plastic', 'environmental case', NULL, 'jessica', 'emily'),
(6, 'amy vs. gas', 'environmental case', NULL, 'jessica', 'amy'),
(7, 'eric new job', 'contract for new job', NULL, 'sarah', 'eric'),
(8, 'emily vs. NASA', 'environmental case', NULL, 'jessica', 'emily');

-- Insert data into documents table
INSERT INTO documents (cid, dname, dtype) VALUES
(1, 'doc1.pdf', 'legal document'),
(1, 'doc2.docx', 'legal document'),
(2, 'doc1.ppt', 'legal document');

-- Insert data into billing table
INSERT INTO billing (bdate, lname, cid, hours, description, amount) VALUES
('2024-07-25', 'jessica', 5, 3, 'something', NULL),
('2024-07-27', 'jessica', 5, 3, 'something important', NULL),
('2024-07-26', 'sarah', 5, 4, 'something else', NULL),
('2024-08-01', 'sarah', 1, 2, 'court appearance', NULL),
('2024-07-20', 'sarah', 1, 6, 'court appearance', NULL),
('2024-08-02', 'david', 2, 2, 'something', NULL),
('2024-07-30', 'david', 2, 5, 'client meeting', NULL),
('2024-07-30', 'jessica', 2, 3, 'court appearance', NULL);

-- Insert data into onCase table
INSERT INTO onCase (cid, lname, role) VALUES
(5, 'sarah', 'associate'),
(5, 'david', 'associate'),
(2, 'jessica', 'associate');
