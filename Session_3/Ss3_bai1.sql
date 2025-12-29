-- drop database if exists Session3_bai1;

create database Session3_bai1;
use Session3_bai1;

create table Student(
	student_id int auto_increment primary key,
	fullname varchar(50) not null,
	dob date default (current_date()),
	email varchar(50) not null unique
);

insert into Student (fullname,dob,email) VALUES 
('alice','2006-02-17','alice@gmail.com'),
('bob','2006-02-17','bob@gmail.com') ,
('alice','2006-02-17','alice@gmail.com') ;
