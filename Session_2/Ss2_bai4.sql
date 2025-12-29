drop database if exists Ss2_bai4;
create database Ss2_bai4;
use Ss2_bai4;

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
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

CREATE TABLE Teacher (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

alter table Subject
add teacher_id int not null;

alter table Subject
add constraint fk_subject_teacher
foreign key (teacher_id) references Teacher(teacher_id);
