create database Session3_bai2;
use Session3_bai2;

create table Student(
	student_id int auto_increment primary key,
	fullname varchar(50) not null,
	dob date default (current_date()),
	email varchar(50) not null unique
);

insert into Student (fullname,dob,email) VALUES 
('alice','2006-02-17','alice@gmail.com'),
('bob','2006-02-17','bob@gmail.com'),
('mynato','2006-02-17','mynato@gmail.com'),
('charlie','2005-05-12','charlie@gmail.com'),
('diana','2005-08-23','diana@gmail.com'),
('emma','2006-03-15','emma@gmail.com'),
('frank','2005-11-08','frank@gmail.com'),
('grace','2006-01-20','grace@gmail.com'),
('henry','2005-06-30','henry@gmail.com'),
('isabella','2006-04-12','isabella@gmail.com');

-- select * from Student;
-- select student_id,fullname from Student;

update Student set email ='atmin@gmail.com' where student_id=3;
update Student set dob ='2005-02-17' where student_id=2;
