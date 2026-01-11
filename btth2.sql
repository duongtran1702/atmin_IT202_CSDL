drop database if exists db_btth;

create database db_btth;

use db_btth;

create table guest(
    guest_id int auto_increment primary key,
    guest_name varchar(100) not null,
    phone varchar(15)
);

create table rooms(
    room_id int auto_increment primary key,
    room_type varchar(50),
    price_per_day decimal(10, 2) not null
);

create table bookings(
    booking_id int auto_increment primary key,
    guest_id int not null,
    room_id int not null,
    check_in date not null,
    check_out date not null,
    foreign key (guest_id) references guest(guest_id),
    foreign key (room_id) references rooms(room_id)
);

insert into
    guest (guest_name, phone)
VALUES
    ('Nguyễn Văn An', '0901111111'),
    ('Trần Thị Bình', '0902222222'),
    ('Lê Văn Cường', '0903333333'),
    ('Phạm Thị Dung', '0904444444'),
    ('Hoàng Văn Em', '0905555555');

insert into
    rooms (room_type, price_per_day)
VALUES
    ('Standard', 500000),
    ('Standard', 500000),
    ('Deluxe', 800000),
    ('Deluxe', 800000),
    ('VIP', 1500000),
    ('VIP', 2000000);

insert into
    bookings (guest_id, room_id, check_in, check_out)
VALUES
    (1, 1, '2024-01-10', '2024-01-12'),
    (1, 3, '2024-03-05', '2024-03-10'),
    (2, 2, '2024-02-01', '2024-02-03'),
    (2, 5, '2024-04-15', '2024-04-18'),
    (3, 4, '2023-12-20', '2023-12-25'),
    (3, 6, '2024-05-01', '2024-05-06'),
    (4, 1, '2024-06-10', '2024-06-11'),
    (5, 5, '2025-07-20', '2025-07-25'),
    (5, 3, '2025-08-15', '2025-08-20');

-- Phan I
-- Liệt kê tên khách và số điện thoại của tất cả khách hàng
select
    guest_name,
    phone
from
    guest;

-- Liệt kê các loại phòng khác nhau trong khách sạn
select
    room_type
from
    rooms
group by
    room_type;

-- Hiển thị loại phòng và giá thuê theo ngày, sắp xếp theo giá tăng dần
select
    room_type,
    price_per_day
from
    rooms
order by
    price_per_day asc;

-- Hiển thị các phòng có giá thuê lớn hơn 1.000.000
select
    room_id,
    room_type,
    price_per_day
from
    rooms
where
    price_per_day > 1000000;

-- Liệt kê các lần đặt phòng diễn ra trong năm 2024
select
    *
from
    bookings
where
    check_in between '2024-01-01'
    and '2024-12-31';

-- Cho biết số lượng phòng của từng loại phòng
select
    room_type,
    count(room_id) as quantity
from
    rooms
group by
    room_type;

-- PHẦN II - TRUY VẤN NÂNG CAO
-- Hãy liệt kê danh sách các lần đặt phòng, Với mỗi lần đặt phòng, hãy hiển thị:
-- Tên khách hàng
-- Loại phòng đã đặt
-- Ngày nhận phòng (check_in)
select
    g.guest_name,
    r.room_type,
    b.check_in
from
    bookings b
    join guest g on g.guest_id = b.guest_id
    join rooms r on r.room_id = b.room_id;

-- Cho biết mỗi khách đã đặt phòng bao nhiêu lần
select
    g.guest_name,
    count(b.booking_id) as times_booked
from
    bookings b
    join guest g on g.guest_id = b.guest_id
group by
    g.guest_id,
    g.guest_name;

-- Tính doanh thu của mỗi phòng, với công thức: “Doanh thu = số ngày ở x giá thuê theo ngày”
select
    r.room_id,
    r.room_type,
    sum(
        datediff(b.check_out, b.check_in) * r.price_per_day
    ) as revenue
from
    bookings b
    join rooms r on r.room_id = b.room_id
group by
    r.room_id,
    r.room_type;

-- Hiển thị tổng doanh thu của từng loại phòng
select
    r.room_type,
    sum(
        datediff(b.check_out, b.check_in) * r.price_per_day
    ) as total_revenue
from
    bookings b
    join rooms r on r.room_id = b.room_id
group by
    r.room_type;

-- Tìm những khách đã đặt phòng từ 2 lần trở lên
select
    g.guest_id,
    g.guest_name,
    count(b.booking_id) as times_booked
from
    bookings b
    join guest g on g.guest_id = b.guest_id
group by
    g.guest_id,
    g.guest_name
having
    count(b.booking_id) >= 2;

-- Tìm loại phòng có số lượt đặt phòng nhiều nhất
select
    r.room_type,
    count(b.booking_id) as booking_count
from
    bookings b
    join rooms r on r.room_id = b.room_id
group by
    r.room_type
having
    count(b.booking_id) = (
        select
            max(cnt)
        from
            (
                select
                    count(*) as cnt
                from
                    bookings b2
                    join rooms r2 on r2.room_id = b2.room_id
                group by
                    r2.room_type
            ) t
    );

-- Phan 3
-- Hiển thị những phòng có giá thuê cao hơn giá trung bình của tất cả các phòng
select
    r.room_id,
    r.room_type,
    r.price_per_day
from
    rooms r
where
    r.price_per_day >(
        select
            avg(r1.price_per_day)
        from
            rooms r1
    );

-- Hiển thị những khách chưa từng đặt phòng
-- Cách 1: dùng NOT IN để lấy những khách có guest_id
-- không xuất hiện trong bảng bookings
select
    *
from
    guest g
where
    g.guest_id not in (
        select
            distinct b.guest_id
        from
            bookings b
    );

-- Cách 2: dùng NOT EXISTS, kiểm tra với từng khách
-- xem có bản ghi bookings nào trùng guest_id hay không
-- Nếu không tồn tại (NOT EXISTS) thì khách đó chưa từng đặt phòng
select
    *
from
    guest g
where
    not exists (
        select
            1
        from
            bookings b
        where
            b.guest_id = g.guest_id
    );

-- Cách 3: dùng LEFT JOIN để lấy tất cả khách,
-- những khách không có booking sẽ có cột của bookings là NULL
select
    g.*
from
    guest g
    left join bookings b on g.guest_id = b.guest_id
where
    b.guest_id is null;

-- Tìm phòng được đặt nhiều lần nhất
select
    r.*,
    count(b.room_id) as booking_count
from
    rooms r
    join bookings b on b.room_id = r.room_id
group by
    r.room_id,
    r.room_type
having
    count(b.room_id) >= all (
        select
            max(cnt)
        from
            (
                select
                    count(b1.room_id) as cnt
                from
                    rooms r1
                    join bookings b1 on b1.room_id = r1.room_id
                group by
                    r1.room_id,
                    r1.room_type
            ) as table_cnt
    );