drop database if exists Ss5_6;

create database Ss5_6;

use Ss5_6;

create table Product(
    product_id int auto_increment primary key,
    product_name varchar(100) not null,
    price decimal(10, 2) check (price >= 0),
    stock int check (stock >= 0),
    status enum('active', 'inactive')
);

INSERT into
    Product(product_name, price, stock, status)
values
    ('Laptop', 4500000.00, 10, 'active'),
    ('Smartphone', 3200000.00, 25, 'active'),
    ('Tablet', 2800000.00, 15, 'inactive'),
    ('Headphones', 1200000.00, 50, 'active'),
    ('Smartwatch', 2500000.00, 30, 'active'),
    ('Camera', 3500000.00, 5, 'inactive'),
    ('Printer', 1800000.00, 8, 'active'),
    ('Monitor', 2200000.00, 12, 'active'),
    ('Keyboard', 1100000.00, 40, 'active'),
    ('Mouse', 1000000.00, 60, 'active'),
    ('Speaker', 1500000.00, 35, 'active'),
    ('Router', 1300000.00, 20, 'active'),
    ('SSD Drive', 2100000.00, 18, 'active'),
    ('Webcam', 1400000.00, 22, 'inactive'),
    ('Microphone', 1800000.00, 15, 'active'),
    ('Gaming Chair', 3800000.00, 7, 'active'),
    ('Desk Lamp', 1200000.00, 45, 'active'),
    ('USB Hub', 1100000.00, 50, 'active'),
    ('External HDD', 2600000.00, 12, 'inactive'),
    ('Power Bank', 1000000.00, 80, 'active');

select
    *
from
    Product
where
    status = 'active'
    and price between 1000000
    and 3000000
order by
    price asc;

select
    *
from
    Product
order by
    price asc
limit
    10 offset 0;

select
    *
from
    Product
order by
    price asc
limit
    10 offset 10;