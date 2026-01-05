drop database if exists Ss6_1;

create database Ss6_1;

use Ss6_1;

create table Customer(
    customer_id int auto_increment primary key,
    customer_name varchar(100),
    city varchar(100) not null
);

insert into
    Customer(customer_name, city)
values
    ('Alice', 'New York'),
    ('Bob', 'Los Angeles'),
    ('Charlie', 'New York'),
    ('David', 'Chicago'),
    ('Eve', 'Los Angeles');

create table Orders(
    order_id int auto_increment primary key,
    customer_id int,
    order_date date,
    status enum('pending', 'completed', 'cancelled'),
    foreign key (customer_id) references Customer(customer_id)
);

insert into
    Orders(customer_id, order_date, status)
values
    (1, '2023-01-10', 'completed'),
    (2, '2023-01-11', 'pending'),
    (1, '2023-01-12', 'completed'),
    (3, '2023-01-13', 'cancelled'),
    (4, '2023-01-14', 'completed'),
    (3, '2023-01-15', 'pending'),
    (2, '2023-01-16', 'completed'),
    (5, '2023-01-17', 'completed'),
    (4, '2023-01-18', 'cancelled'),
    (5, '2023-01-19', 'pending'),
    (1, '2023-01-20', 'completed');

select
    o.order_id,
    u.customer_name,
    o.order_date,
    o.status
from
    Orders o
    join Customer u on u.customer_id = o.customer_id;

select
    c.customer_id,
    c.customer_name,
    (count(o.order_id)) as total_orders
from
    Customer c
    left join Orders o on c.customer_id = o.customer_id
group by
    c.customer_id,
    c.customer_name;

select
    c.customer_id,
    c.customer_name,
    (count(o.order_id)) as total_orders
from
    Customer c
    join Orders o on c.customer_id = o.customer_id
group by
    c.customer_id,
    c.customer_name;