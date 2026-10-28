USE InternshipDB;

-- Run each test separately. Each statement is EXPECTED to fail.
-- Test 1: duplicate student email (expected duplicate-key error)
INSERT INTO Students (name, email, department)
VALUES ('Test Student', 'rahul@example.com', 'MCA');

-- Test 2: duplicate company email (expected duplicate-key error)
INSERT INTO Companies (name, email)
VALUES ('Duplicate Company', 'hr@techsolutions.example');

-- Test 3: nonexistent student (expected foreign-key error)
INSERT INTO Applications (student_id, internship_id, status)
VALUES (999, 1, 'APPLIED');

-- Test 4: duplicate application (expected duplicate-key error)
INSERT INTO Applications (student_id, internship_id, status)
VALUES (1, 1, 'APPLIED');

-- Test 5: offer for an unselected application (expected trigger error)
INSERT INTO Offers (application_id, status)
VALUES (2, 'ISSUED');

-- Test 6: zero internship seats (expected CHECK constraint error)
INSERT INTO Internships (company_id, title, seats, status)
VALUES (1, 'Invalid Internship', 0, 'OPEN');
