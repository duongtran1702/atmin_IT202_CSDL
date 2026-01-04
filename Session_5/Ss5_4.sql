drop database if exists Ss5_4;
create database if not exists Ss5_4;

use Ss5_4;

create table Product(
    product_id int auto_increment primary key,
    product_name varchar(100) not null,
    price decimal(10, 2) check (price >= 0),
    stock int check (stock >= 0),
    status enum('active', 'inactive')
);

alter table
    Product
add
    column sold_quantity int default 0 check (sold_quantity >= 0);

insert into
    Product(
        product_name,
        price,
        stock,
        status,
        sold_quantity
    )
values
    ('Laptop', 2800000.00, 10, 'active', 5),
    ('Smartphone', 1650000.00, 25, 'active', 15),
    ('Tablet', 2200000.00, 15, 'inactive', 7),
    ('Headphones', 1400000.00, 50, 'active', 20),
    ('Smartwatch', 2450000.00, 30, 'active', 10),
    ('Camera', 1750000.00, 5, 'inactive', 2),
    ('Printer', 2100000.00, 8, 'active', 4),
    ('Monitor', 2600000.00, 12, 'active', 6),
    ('Keyboard', 1550000.00, 40, 'active', 18),
    ('Mouse', 1900000.00, 60, 'active', 25),
    ('Speaker', 2350000.00, 20, 'active', 12),
    ('Webcam', 1800000.00, 15, 'inactive', 8),
    ('Router', 2050000.00, 18, 'active', 14),
    ('Charger', 1500000.00, 35, 'active', 22),
    ('Hard Drive', 2700000.00, 10, 'inactive', 5);

select
    *
from
    Product
order by
    sold_quantity desc
limit
    10;

select
    *
from
    Product
order by
    sold_quantity desc
limit
    5 offset 10;

select
    *
from
    Product
where
    price < 2000000
order by
    sold_quantity desc;