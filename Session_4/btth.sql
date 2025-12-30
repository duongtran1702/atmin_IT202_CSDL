create database session04;
use session04;

create table student(
	student_id int auto_increment primary key,
    full_name varchar(100) not null,
    date_of_birth date not null,
    email varchar(100) not null unique
);

create table teacher(
	teacher_id int auto_increment primary key,
    full_name varchar(100) not null,
    email varchar(100) not null unique
);

create table course(
	course_id int auto_increment primary key,
    course_name varchar(100) not null,
    description text,
    sessions int check (sessions >= 0),
    teacher_id int not null,
    foreign key (teacher_id) references teacher(teacher_id)
);

create table enrollment(
	student_id int not null,
    course_id int not null,
    enroll_date date default (current_date()),
    unique(student_id, course_id),
    foreign key (student_id) references student(student_id),
    foreign key (course_id) references course(course_id)
);

create table score(
	student_id int not null,
    course_id int not null,
    mid_score decimal(4,2) check (mid_score >= 0 and mid_score <= 10),
    final_score decimal(4, 2) check (final_score >= 0 and final_score <= 10),
    unique(student_id, course_id),
    foreign key (student_id) references student(student_id),
    foreign key (course_id) references course(course_id)
);

insert into student(full_name, date_of_birth, email) values 
('Nguyễn Văn A','2006-01-01','nva@gmail.com'),
('Trần Văn B','2006-02-01','tvb@gmail.com'),
('Lê Thị C','2006-01-04','ltc@gmail.com'),
('Phan Văn D','2006-05-10','pvd@gmail.com'),
('Phạm Thị E','2005-01-12','pte@gmail.com');

insert into teacher(full_name, email) values 
('Nguyễn An','na@gmail.com'),
('Trần Bình','tb@gmail.com'),
('Lê Chi', 'lc@gmail.com'),
('Phan Dương', 'pd@gmail.com'),
('Phạm Hiếu', 'ph@gmail.com');

insert into course(course_name, description, sessions, teacher_id) values
('Lập trình C', 'Lập trình cơ bản với C', 10, 1),
('Lập trình Web cơ bản', 'Lập trình web cơ bản với HTML, CSS, JS', 15, 2),
('Lập trình Web nâng cao', 'Lập trình nâng cao với ReactJS', 20, 5),
('Cơ sở dữ liệu', 'Cơ sở dữ liệu MySQL', 16, 3),
('Lập trình Back End', 'Lập trình Back End với Java', 23, 4);

insert into enrollment(student_id, course_id, enroll_date) values
(1, 1, current_date()),
(2, 3, current_date()),
(3, 5, current_date()),
(4, 3, current_date()),
(5, 4, current_date());

insert into score(student_id, course_id, mid_score, final_score) values 
(1, 1, 7, 8),
(2, 3, 7, 7),
(3, 5, 4, 6),
(4, 3, 9, 9),
(5, 4, 7, 10);

update student set email = 'nva1@gmail.com' where student_id = 1;
update course set description = 'Lập trình cơ bản với ngôn ngữ C' where course_id = 1;
update score set final_score = 9 where student_id = 5;

delete from enrollment where student_id = 4;
delete from score where student_id = 4;

select * from student;
select * from teacher;
select * from course;
select * from enrollment;
select * from score;