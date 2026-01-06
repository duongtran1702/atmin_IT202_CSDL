drop database if exists session_7;
create database session_7;

use session_7;

create table customer (
    customer_id int auto_increment primary key,
    name varchar(100) not null,
    email varchar(100) not null
);

create table orders (
    id int auto_increment primary key,
    customer_id int not null,
    order_date date not null,
    total_amount decimal(10, 2) check (total_amount >= 0)
);

insert into
    customer(name, email)
values
    ('atmin', 'atmin@gmail.com'),
    ('mynato', 'mynato@gmail.com'),
    ('atmin1', 'atmin2@gmail.com'),
    ('atmin2', 'atmin2@gmail.com'),
    ('atmin3', 'atmin3@gmail.com'),
    ('atmin4', 'atmin4@gmail.com'),
    ('atmin5', 'atmin5@gmail.com');

insert into
    orders(customer_id, order_date, total_amount)
values
    (1, '2026-01-01', 1000000.00),
    (2, '2026-01-02', 1500000.50),
    (3, '2026-01-03', 2000000.00),
    (4, '2026-01-04', 2500000.75),
    (5, '2026-01-05', 3000000.00),
    (6, '2026-01-06', 3500000.25),
    (1, '2026-01-07', 4000000.00),
    (2, '2026-01-08', 4500000.50),
    (3, '2026-01-09', 5000000.00),
    (7, '2026-01-10', 3000000.00);

select
    *
from
    customer
where
    customer_id in (
        select
            distinct customer_id
        from
            orders
    );
