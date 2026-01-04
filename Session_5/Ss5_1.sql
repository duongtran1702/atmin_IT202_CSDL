drop database if exists Ss5_1;

create database Ss5_1;

use Ss5_1;

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
    ('Laptop', 1500000.00, 10, 'active'),
    ('Smartphone', 1200000.00, 25, 'active'),
    ('Tablet', 800000.00, 15, 'inactive'),
    ('Headphones', 120000.00, 50, 'active'),
    ('Smartwatch', 500000.00, 30, 'active'),
    ('Camera', 250000.00, 5, 'inactive'),
    ('Printer', 350000.00, 8, 'active'),
    ('Monitor', 500000.00, 12, 'active'),
    ('Keyboard', 200000.00, 40, 'active'),
    ('Mouse', 80000.00, 60, 'active');

select
    *
from
    Product;

select
    *
from
    Product
where
    status = 'active';

select
    *
from
    Product
where
    price > 1000000;

select
    *
from
    Product
where
    status = 'active'
order by
    price asc;