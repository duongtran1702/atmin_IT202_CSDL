drop database if exists ss2_bai2;
CREATE DATABASE Ss2_bai2;
USE Ss2_bai2;

CREATE TABLE Student (
    studentId INT PRIMARY KEY,
    fullName VARCHAR(100) NOT NULL
);

CREATE TABLE Subject (
    subjectId INT PRIMARY KEY,
    subjectName VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0)
);

