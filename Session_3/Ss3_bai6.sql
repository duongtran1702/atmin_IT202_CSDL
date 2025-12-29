drop database if exists Session3_bai6;

create database Session3_bai6;

use Session3_bai6;

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

create table Score(
    student_id int not null,
    subject_id int not null,
    mid_score decimal(4, 2) not null check (
        mid_score >= 0
        and mid_score <= 10
    ),
    final_score decimal(4, 2) not null check (
        final_score >= 0
        and final_score <= 10
    ),
    primary key(student_id, subject_id),
    foreign key (student_id) references Student(student_id),
    foreign key(subject_id) references Subject (subject_id)
);

insert into
    Score (student_id, subject_id, mid_score, final_score)
values
    (1, 1, 8.25, 7.75),
    (1, 2, 9.00, 8.50),
    (2, 3, 6.50, 7.00),
    (2, 4, 7.25, 6.75),
    (3, 5, 8.00, 8.25),
    (4, 1, 7.50, 8.00),
    (5, 2, 9.50, 9.75);

update
    Score
set
    final_score = 9
where
    student_id = 5
    and subject_id = 2;

delete from
    Enrollment
where
    student_id >= 5;

select
    row_number() over(order by final_score) as STT,
    s.fullname,
    sub.subject_name,
    p.mid_score,
    p.final_score
from
    Score p
    join Student s on s.student_id = p.student_id
    join Subject sub on sub.subject_id = p.subject_id
