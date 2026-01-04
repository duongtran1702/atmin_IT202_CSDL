drop database if exists Ss5_2;
create database if not exists Ss5_2;

use Ss5_2;

create table Customer(
    customer_id int auto_increment primary key,
    full_name varchar(100) not null,
    email varchar(100) not null unique,
    city varchar(100) not null,
    status enum('active', 'inactive')
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

select
    *
from
    Customer;

select
    *
from
    Customer
where
    city = 'New York';

select
    *
from
    Customer
where
    status = 'active' and city = 'Houston';

select
    *
from
    Customer
where
    status = 'active'
order by
    full_name asc;

