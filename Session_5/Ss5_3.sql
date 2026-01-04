drop database if exists Ss5_3;
create database if not exists Ss5_3;

use Ss5_3;

create table Customer(
    customer_id int auto_increment primary key,
    full_name varchar(100) not null,
    email varchar(100) not null unique,
    city varchar(100) not null,
    status enum('active', 'inactive')
);

create table Orders(
    order_id int auto_increment primary key,
    customer_id int not null,
    total_amount decimal(10, 2) check (total_amount >= 0),
    order_date date default (current_date()),
    status enum('pending', 'completed', 'canceled') default 'pending',
    foreign key (customer_id) references Customer(customer_id)
);

INSERT into
    Customer(full_name, email, city, status)
values
    (
        'Alice Johnson',
        'alice@gmail.com',
        'New York',
        'active'
    ),
    (
        'Bob Smith',
        'bob@gmail.com',
        'Los Angeles',
        'inactive'
    ),
    (
        'Charlie Brown',
        'charlie@gmail.com',
        'Chicago',
        'active'
    ),
    (
        'Diana Prince',
        'diana@gmail.com',
        'Houston',
        'active'
    ),
    (
        'Ethan Hunt',
        'ethan@gmail.com',
        'Phoenix',
        'inactive'
    ),
    (
        'Fiona Glenanne',
        'fiona@gmail.com',
        'Philadelphia',
        'active'
    );

insert into
    Orders(customer_id, total_amount, order_date, status)
values
    (1, 5000000.00, '2024-01-15', 'completed'),
    (2, 4800000.00, '2024-02-20', 'pending'),
    (3, 5200000.00, '2024-03-05', 'canceled'),
    (1, 5100000.00, '2024-04-10', 'completed'),
    (4, 4950000.00, '2024-05-12', 'pending'),
    (5, 5050000.00, '2024-06-18', 'completed'),
    (6, 4750000.00, '2024-07-22', 'canceled'),
    (1, 5300000.00, '2024-08-02', 'pending'),
    (2, 4900000.00, '2024-08-18', 'completed'),
    (3, 5150000.00, '2024-09-05', 'pending'),
    (4, 4850000.00, '2024-09-22', 'completed'),
    (5, 5250000.00, '2024-10-08', 'canceled'),
    (6, 5005000.00, '2024-10-25', 'completed'),
    (1, 4990000.00, '2024-11-11', 'pending'),
    (2, 5450000.00, '2024-12-01', 'completed');

select * from Orders;

select
    *
from
    Orders
where
    total_amount > 5000000;

select
    *
from
    Orders
order by
    order_date desc
limit
    5;

select
    *
from
    Orders
where
    status = 'completed'
order by
    total_amount desc;