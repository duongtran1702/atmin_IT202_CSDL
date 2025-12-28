drop database if exists Ss2_bai1;
create database Ss2_bai1;
use Ss2_bai1;

CREATE TABLE Class (
    classId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    year varchar(30) NOT NULL
);

CREATE TABLE Student (
    studentId INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(50) NOT NULL,
    dob date NOT NULL,
    classId INT NOT NULL,
    CONSTRAINT fk_student_class FOREIGN KEY (classId)
        REFERENCES Class (classId)
);

INSERT INTO Class (name, year)
VALUES ('CNTT K17', '2024-2025');

INSERT INTO Student (fullname, dob, classId)
VALUES ('Nguyen Van A', '2004-05-12', 1);
