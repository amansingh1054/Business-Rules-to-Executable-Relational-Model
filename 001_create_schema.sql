CREATE DATABASE IF NOT EXISTS InternshipDB;
USE InternshipDB;

CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Internships (
    internship_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    seats INT NOT NULL,
    status ENUM('OPEN', 'CLOSED') NOT NULL DEFAULT 'OPEN',
    CONSTRAINT chk_internship_seats CHECK (seats > 0),
    CONSTRAINT fk_internship_company
        FOREIGN KEY (company_id) REFERENCES Companies(company_id)
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    internship_id INT NOT NULL,
    status ENUM('APPLIED', 'SHORTLISTED', 'SELECTED', 'REJECTED')
        NOT NULL DEFAULT 'APPLIED',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_student_internship UNIQUE (student_id, internship_id),
    CONSTRAINT fk_application_student
        FOREIGN KEY (student_id) REFERENCES Students(student_id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_application_internship
        FOREIGN KEY (internship_id) REFERENCES Internships(internship_id)
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Offers (
    offer_id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL UNIQUE,
    offered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ISSUED', 'ACCEPTED', 'DECLINED') NOT NULL DEFAULT 'ISSUED',
    CONSTRAINT fk_offer_application
        FOREIGN KEY (application_id) REFERENCES Applications(application_id)
        ON DELETE RESTRICT
);
