drop database if exists Ss5_5;

create database if not exists Ss5_5;

use Ss5_5;

create table Orders (
    id int auto_increment primary key,
    order_date date default (current_date()),
    customer_name varchar(100) not null,
    total_amount decimal(10, 2) check (total_amount >= 0),
    status enum('pending', 'completed', 'canceled') default 'pending'
);

insert into
    Orders (order_date, customer_name, total_amount, status)
values
    (
        '2024-01-05',
        'Alice Nguyen',
        120.50,
        'completed'
    ),
    ('2024-01-06', 'Bao Tran', 85.00, 'pending'),
    ('2024-01-07', 'Chi Le', 43.75, 'completed'),
    ('2024-01-08', 'Duy Pham', 210.99, 'completed'),
    ('2024-01-09', 'Emma Vo', 15.00, 'canceled'),
    ('2024-01-10', 'Frankie Lam', 340.10, 'pending'),
    ('2024-01-11', 'Giang Phan', 99.99, 'completed'),
    ('2024-01-12', 'Hoa Bui', 58.60, 'pending'),
    ('2024-01-13', 'Ivan Truong', 440.00, 'completed'),
    ('2024-01-14', 'Jolie Phung', 12.50, 'canceled'),
    ('2024-01-15', 'Khanh Do', 75.45, 'pending'),
    ('2024-01-16', 'Linh Ho', 180.30, 'completed'),
    ('2024-01-17', 'Minh Dang', 220.00, 'completed'),
    ('2024-01-18', 'Nhi Chau', 34.20, 'pending'),
    ('2024-01-19', 'Oanh Nguyen', 510.75, 'completed'),
    ('2024-01-20', 'Phuc Vo', 68.00, 'pending'),
    ('2024-01-21', 'Quynh Ha', 145.90, 'completed'),
    ('2024-01-22', 'Robin Vu', 5.99, 'canceled'),
    ('2024-01-23', 'Son Le', 300.00, 'completed'),
    ('2024-01-24', 'Tina Ngo', 27.40, 'pending');

select * from Orders where status <> 'canceled' order by order_date desc limit 5 offset 0;
select * from Orders where status <> 'canceled' order by order_date desc limit 5 offset 5;
select * from Orders where status <> 'canceled' order by order_date desc limit 5 offset 10;
