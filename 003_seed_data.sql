USE InternshipDB;

INSERT INTO Students (name, email, department) VALUES
('Rahul Sharma', 'rahul@example.com', 'MCA'),
('Priya Verma', 'priya@example.com', 'MCA'),
('Amit Kumar', 'amit@example.com', 'BCA');

INSERT INTO Companies (name, email) VALUES
('Tech Solutions', 'hr@techsolutions.example'),
('Data Systems', 'jobs@datasystems.example');

INSERT INTO Internships (company_id, title, seats, status) VALUES
(1, 'Python Developer Intern', 3, 'OPEN'),
(1, 'Web Developer Intern', 2, 'OPEN'),
(2, 'SQL Developer Intern', 2, 'OPEN');

INSERT INTO Applications (student_id, internship_id, status) VALUES
(1, 1, 'SELECTED'),
(2, 1, 'APPLIED'),
(3, 2, 'SHORTLISTED');

INSERT INTO Offers (application_id, status) VALUES
(1, 'ISSUED');
