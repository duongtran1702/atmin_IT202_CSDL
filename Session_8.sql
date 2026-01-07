create database if not exists Session_8_db;

use Session_8_db;

create table customer(
    customer_id int auto_increment primary key,
    customer_name varchar(100) not null,
    email varchar(100) unique,
    phone varchar(15) unique
);

create table categories(
    category_id int auto_increment primary key,
    category_name varchar(100) not null
);

create table products(
    product_id int auto_increment primary key,
    product_name varchar(100) not null,
    category_id int not null,
    price decimal(10, 2) not null,
    foreign key (category_id) references categories(category_id)
);

create table orders(
    order_id int auto_increment primary key,
    customer_id int not null,
    order_date datetime default current_timestamp(),
    status enum('pending', 'completed', 'cancelled') default 'pending',
    foreign key (customer_id) references customer(customer_id)
);

create table order_items(
    order_item_id int auto_increment primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

-- Sample data
insert into
    customer (customer_name, email, phone)
values
    (
        'Nguyen Van A',
        'a.nguyen@example.com',
        '0901000001'
    ),
    ('Tran Thi B', 'b.tran@example.com', '0901000002'),
    ('Le Van C', 'c.le@example.com', '0901000003');

insert into
    categories (category_name)
values
    ('Electronics'),
    ('Books'),
    ('Clothing');

insert into
    products (product_name, category_id, price)
values
    ('Smartphone X', 1, 899.00),
    ('Laptop Pro', 1, 1499.00),
    ('Novel ABC', 2, 199.00),
    ('T-Shirt White', 3, 149.00),
    ('Jeans Blue', 3, 399.00);

insert into
    orders (customer_id, order_date, status)
values
    (1, '2026-01-05 10:15:00', 'completed'),
    (2, '2026-01-06 14:30:00', 'pending'),
    (3, '2026-01-07 09:00:00', 'completed');

insert into
    order_items (order_id, product_id, quantity)
values
    (1, 1, 1),
    (1, 3, 2),
    (2, 2, 1),
    (2, 4, 3),
    (3, 5, 1);

-- Lấy danh sách khách hàng, sản phẩm, đơn hàng
select
    *
from
    customer;

select
    *
from
    products;

select
    *
from
    orders;

-- Thống kê số lượng đơn hàng
select
    customer_id,
    count(*) as total_orders
from
    orders
group by
    customer_id;

-- Thống kê số lượng sản phẩm bán ra
select
    product_id,
    sum(quantity) as total_sold
from
    order_items
group by
    product_id;

-- Tìm sản phẩm có giá cao nhất, thấp nhất, trung bình
select
    *
from
    products
where
    price >= all(
        select
            price
        from
            products
    );

select
    *
from
    products
where
    price <= all(
        select
            price
        from
            products
    );

select
    *
from
    products
order by
    abs(
        price - (
            select
                avg(price)
            from
                products
        )
    )
limit
    1;

-- Tìm khách hàng mua nhiều đơn hàng
select
    customer_id,
    count(order_id) as total_orders
from
    orders
group by
    customer_id
having
    count(order_id) >= 2;

-- Truy vấn dữ liệu bằng Subquery