use Ss6_1;

create table Product(
    product_id int auto_increment primary key,
    product_name varchar(100),
    price decimal(10, 2) check (price >= 0)
);

create table Order_Items(
    order_id int not null,
    product_id int not null,
    quantity int check (quantity > 0),
    foreign key (order_id) references Orders(order_id),
    foreign key (product_id) references Product(product_id),
    primary key (order_id, product_id)
);

insert into
    Product(product_name, price)
values
    ('Laptop', 1200000),
    ('Smartphone', 800000),
    ('Tablet', 600000),
    ('Headphones', 150000),
    ('Smartwatch', 200000),
    ('Camera', 500000),
    ('Printer', 300000),
    ('Monitor', 400000);

insert into
    Order_Items(order_id, product_id, quantity)
values
    (1, 1, 1),
    (1, 4, 2),
    (2, 2, 1),
    (3, 3, 1),
    (4, 5, 1),
    (5, 6, 1),
    (6, 7, 2),
    (7, 8, 1),
    (8, 1, 1),
    (9, 2, 3);

select
    oi.product_id,
    p.product_name,
    sum(quantity) as total_items_sold
from
    Order_Items oi
    join Product p on p.product_id = oi.product_id
group by
    oi.product_id,
    p.product_name;

select
    oi.product_id,
    p.product_name,
    sum(oi.quantity * p.price) as total_revenue
from
    Order_Items oi
    join Product p on p.product_id = oi.product_id
group by
    oi.product_id,
    p.product_name;

select
    oi.product_id,
    p.product_name,
    sum(oi.quantity * p.price) as total_revenue
from
    Order_Items oi
    join Product p on p.product_id = oi.product_id
group by
    oi.product_id,
    p.product_name
having
    sum(oi.quantity * p.price) >= 500000
order by sum(oi.quantity * p.price) desc;