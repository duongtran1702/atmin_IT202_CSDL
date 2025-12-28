drop database if exists Ss2_bai3;
create database Ss2_bai3;
use Ss2_bai3;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    fullName VARCHAR(100) NOT NULL
);

CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subjectName VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0)
);

CREATE TABLE Enrollment (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    registration_date DATE NOT NULL,
    PRIMARY KEY (student_id , subject_id),
    FOREIGN KEY (subject_id)
        REFERENCES Subject (subject_id),
    FOREIGN KEY (student_id)
        REFERENCES Student (student_id)
);
