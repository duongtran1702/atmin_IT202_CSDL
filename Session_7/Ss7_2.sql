use session_7;

create table product (
    product_id int auto_increment primary key,
    name varchar(100) not null,
    price decimal(10, 2) check (price >= 0)
);

create table order_items(
    order_id int not null,
    product_id int not null,
    quantity int not null check (quantity > 0),
    foreign key (order_id) references orders(id),
    foreign key (product_id) references product(product_id)
);

insert into
    product(name, price)
values
    ('Chuột không dây Logitech', 350000.00),
    ('Bàn phím cơ DareU', 950000.00),
    ('Màn hình LG 24 inch', 3500000.00),
    ('Tai nghe Bluetooth Sony', 1700000.00),
    ('Ổ cứng SSD 512GB', 1200000.00),
    ('USB 32GB Kingston', 120000.00),
    ('Loa Bluetooth JBL', 1900000.00),
    ('Sạc dự phòng 10.000mAh', 500000.00),
    ('Webcam Full HD', 800000.00),
    ('Ghế gaming E-Dra', 2800000.00);

insert into
    order_items(order_id, product_id, quantity)
values
    (1, 1, 2),
    (1, 6, 1),
    (2, 2, 1),
    (3, 3, 1),
    (4, 4, 1),
    (5, 5, 1),
    (6, 7, 2),
    (7, 8, 1),
    (8, 9, 1),
    (10, 10, 1),
    (10, 1, 1);

select
    *
from
    product
where
    product_id in (
        select
            distinct product_id
        from
            order_items
    )