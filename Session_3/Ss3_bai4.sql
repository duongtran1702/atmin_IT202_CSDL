drop database if exists Session3_bai4;

create database Session3_bai4;

use Session3_bai4;

create table Student (
    student_id int auto_increment primary key,
    fullname varchar(50) not null,
    dob date default (current_date()),
    email varchar(50) not null unique
);

insert into
    Student (fullname, dob, email)
VALUES
    ('alice', '2006-02-17', 'alice@gmail.com'),
    ('bob', '2006-02-17', 'bob@gmail.com'),
    ('mynato', '2006-02-17', 'mynato@gmail.com'),
    ('charlie', '2005-05-12', 'charlie@gmail.com'),
    ('diana', '2005-08-23', 'diana@gmail.com'),
    ('emma', '2006-03-15', 'emma@gmail.com'),
    ('frank', '2005-11-08', 'frank@gmail.com'),
    ('grace', '2006-01-20', 'grace@gmail.com'),
    ('henry', '2005-06-30', 'henry@gmail.com'),
    ('isabella', '2006-04-12', 'isabella@gmail.com');

CREATE TABLE Subject (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credits INT CHECK (credits > 0)
);

insert into
    Subject (subject_name, credits)
values
    ('Math', 3),
    ('ENG', 2),
    ('PHY', 4),
    ('CHEM', 3),
    ('BIO', 2),
    ('HIST', 3),
    ('GEO', 2);

create table Enrollment(
    student_id int not null,
    subject_id int not null,
    enroll_date date default (current_date()),
    primary key(student_id, subject_id),
    foreign key (student_id) references Student(student_id),
    foreign key(subject_id) references Subject (subject_id)
);

insert into
    Enrollment(student_id, subject_id)
values
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 5),
    (4, 1),
    (5, 2),
    (6, 3),
    (1, 4),
    (8, 5),
    (9, 1),
    (10, 2);

SELECT
    *
from
    Enrollment;

SELECT
    s.fullname,
    sub.subject_name,
    e.enroll_date
FROM
    Enrollment e
    JOIN Student s ON s.student_id = e.student_id
    JOIN Subject sub ON sub.subject_id = e.subject_id
WHERE
    e.student_id = 2;