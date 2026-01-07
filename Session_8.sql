drop database if exists Session_8_db;
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
    ('Le Van C', 'c.le@example.com', '0901000003'),
    ('Pham Thi D', 'd.pham@example.com', '0901000004'),
    (
        'Hoang Van E',
        'e.hoang@example.com',
        '0901000005'
    ),
    ('Do Thi F', 'f.do@example.com', '0901000006'),
    ('Bui Van G', 'g.bui@example.com', '0901000007'),
    ('Phan Thi H', 'h.phan@example.com', '0901000008'),
    ('Vu Van I', 'i.vu@example.com', '0901000009'),
    ('Dang Thi J', 'j.dang@example.com', '0901000010');

insert into
    categories (category_name)
values
    ('Electronics'),
    ('Books'),
    ('Clothing'),
    ('Home & Kitchen'),
    ('Sports'),
    ('Beauty'),
    ('Toys'),
    ('Groceries'),
    ('Furniture'),
    ('Automotive');

insert into
    products (product_name, category_id, price)
values
    ('Smartphone X', 1, 899.00),
    ('Laptop Pro', 1, 1499.00),
    ('Headphones Z', 1, 299.00),
    ('Novel ABC', 2, 199.00),
    ('Textbook XYZ', 2, 399.00),
    ('T-Shirt White', 3, 149.00),
    ('Jeans Blue', 3, 399.00),
    ('Running Shoes', 5, 799.00),
    ('Sofa 3-Seat', 9, 5999.00),
    ('Coffee Beans 1kg', 8, 249.00);

insert into
    orders (customer_id, order_date, status)
values
    (1, '2026-01-01 09:00:00', 'completed'),
    (2, '2026-01-02 10:15:00', 'pending'),
    (3, '2026-01-03 11:30:00', 'completed'),
    (4, '2026-01-04 14:45:00', 'cancelled'),
    (5, '2026-01-05 16:00:00', 'completed'),
    (6, '2026-01-06 18:20:00', 'pending'),
    (7, '2026-01-07 08:10:00', 'completed'),
    (8, '2026-01-07 09:30:00', 'pending'),
    (9, '2026-01-07 10:45:00', 'completed'),
    (10, '2026-01-07 11:55:00', 'cancelled');

insert into
    order_items (order_id, product_id, quantity)
values
    (1, 1, 1),
    (1, 4, 2),
    (2, 2, 1),
    (3, 3, 1),
    (4, 5, 2),
    (5, 6, 3),
    (6, 7, 1),
    (7, 8, 2),
    (8, 9, 1),
    (9, 10, 4);

-- PHẦN A - TRUY VẤN DỮ LIỆU CƠ BẢN
-- Lấy danh sách tất cả danh mục sản phẩm trong hệ thống.
select
    *
from
    categories;

-- Lấy danh sách đơn hàng có trạng thái là COMPLETED
select
    *
from
    orders
where
    status = 'completed';

-- Lấy danh sách sản phẩm và sắp xếp theo giá giảm dần
select
    *
from
    products
order by
    price desc;

-- Lấy 5 sản phẩm có giá cao nhất, bỏ qua 2 sản phẩm đầu tiên
select
    *
from
    products
order by
    price desc
limit
    5 offset 2;

-- PHẦN B - TRUY VẤN NÂNG CAO
-- Lấy danh sách sản phẩm kèm tên danh mục
select
    p.product_id,
    p.product_name,
    c.category_name
from
    products p
    join categories c on p.category_id = c.category_id;

-- Lấy danh sách đơn hàng gồm:
-- order_id
-- order_date
-- customer_name
-- status
select
    o.order_id,
    o.order_date,
    u.customer_name,
    o.status
from
    orders o
    join customer u on o.customer_id = u.customer_id;

-- Tính tổng số lượng sản phẩm trong từng đơn hàng
select
    oi.order_id,
    sum(oi.quantity) as total_quantity
from
    order_items oi
group by
    oi.order_id;

-- Thống kê số đơn hàng của mỗi khách hàng
select
    o.customer_id,
    count(o.order_id) as total_orders
from
    orders o
group by
    o.customer_id;

-- Lấy danh sách khách hàng có tổng số đơn hàng ≥ 2
select
    o.customer_id,
    count(o.order_id) as total_orders
from
    orders o
group by
    o.customer_id
having
    count(o.order_id) >= 2;

-- Thống kê giá trung bình, thấp nhất và cao nhất của sản phẩm theo danh mục
select
    c.category_name,
    avg(p.price) as avg_price,
    min(p.price) as min_price,
    max(p.price) as max_price
from
    categories c
    join products p on c.category_id = p.category_id
group by
    c.category_name,
    c.category_id;

-- PHẦN C - TRUY VẤN LỒNG (SUBQUERY)
-- Lấy danh sách sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm
select
    *
from
    products
where
    price > (
        select
            avg(price)
        from
            products
    );

-- Lấy danh sách khách hàng đã từng đặt ít nhất một đơn hàng
select
    u.*,
    count(o.order_id) as total_orders
from
    customer u
    join orders o on u.customer_id = o.customer_id
group by
    u.customer_id;

-- Lấy đơn hàng có tổng số lượng sản phẩm lớn nhất.
select
    oi.order_id,
    sum(oi.quantity) as total_quantity
from
    order_items oi
group by
    oi.order_id
having
    sum(oi.quantity) >= all(
        select
            sum(oi.quantity)
        from
            order_items oi
        group by
            oi.order_id
    );

-- Lấy tên khách hàng đã mua sản phẩm thuộc danh mục có giá trung bình cao nhất
select
    distinct u.customer_name,
    c.category_name,
    (
        select
            avg(p.price)
        from
            products p
        where
            p.category_id = c.category_id
    ) as avg_category_price
from
    categories c
    join customer u on (
        u.customer_id in (
            select
                o.customer_id
            from
                orders o
                join order_items oi on o.order_id = oi.order_id
                join products p on oi.product_id = p.product_id
            where
                p.category_id = c.category_id
        )
    )
where
    category_id in (
        select
            p.category_id
        from
            products p
        group by
            p.category_id
        having
            avg(p.price) >= all(
                select
                    avg(p2.price)
                from
                    products p2
                group by
                    p2.category_id
            )
    );

-- Từ bảng tạm (subquery), thống kê tổng số lượng sản phẩm đã mua của từng khách hàng
select
    t.customer_id,
    u.customer_name,
    sum(t.total_quantity) as total_products_purchased
from
    (
        select
            o.customer_id,
            sum(oi.quantity) as total_quantity
        from
            orders o
            join order_items oi on o.order_id = oi.order_id
        group by
            o.customer_id
    ) t
    join customer u on t.customer_id = u.customer_id
group by
    t.customer_id,
    u.customer_name;

-- Viết lại truy vấn lấy sản phẩm có giá cao nhất, đảm bảo:
-- Subquery chỉ trả về một giá trị
-- Không gây lỗi “Subquery returns more than 1 row”
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