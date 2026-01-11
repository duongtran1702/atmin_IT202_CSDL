drop database if exists hakathon_db;

create database hakathon_db;

use hakathon_db;

create table creators(
    creator_id varchar(5) primary key,
    creator_name VARCHAR(100) not null unique,
    creator_email VARCHAR(100) not null unique,
    creator_phone VARCHAR(15) not null,
    creator_platform VARCHAR(50) not null
);

create table studios (
    studio_id VARCHAR(5) PRIMARY KEY,
    studio_name VARCHAR(100) NOT NULL,
    studio_location VARCHAR(100) NOT NULL,
    hourly_price DECIMAL(10, 2) NOT NULL,
    studio_status VARCHAR(20) NOT NULL
);

create table livesessions(
    session_id INT auto_increment primary key,
    creator_id VARCHAR(5),
    studio_id VARCHAR(5),
    session_date DATE,
    duration_hours INT,
    foreign key (creator_id) references creators(creator_id),
    foreign key (studio_id) references studios(studio_id)
);

create table payments(
    payment_id INT auto_increment primary key,
    session_id INT,
    payment_method VARCHAR(50),
    payment_amount DECIMAL(10, 2),
    payment_date DATE,
    foreign key (session_id) references livesessions(session_id)
);

insert into
    creators (
        creator_id,
        creator_name,
        creator_email,
        creator_phone,
        creator_platform
    )
values
    (
        'CR01',
        'Nguyen Van A',
        'a@live.com',
        '0901111111',
        'Tiktok'
    ),
    (
        'CR02',
        'Tran Thi B',
        'b@live.com',
        '0902222222',
        'Youtube'
    ),
    (
        'CR03',
        'Le Minh C',
        'c@live.com',
        '0903333333',
        'Facebook'
    ),
    (
        'CR04',
        'Pham Thi D',
        'd@live.com',
        '0904444444',
        'Tiktok'
    ),
    (
        'CR05',
        'Vu Hoang E',
        'e@live.com',
        '0905555555',
        'Shopee live'
    );

insert into
    studios(
        studio_id,
        studio_name,
        studio_location,
        hourly_price,
        studio_status
    )
values
    ('ST01', 'Studio A', 'Ha Noi', 20.00, 'available'),
    ('ST02', 'Studio B', 'HCM', 25.00, 'available'),
    ('ST03', 'Studio C', 'Da Nang', 30.00, 'booked'),
    ('ST04', 'Studio D', 'Ha Noi', 22.00, 'available'),
    (
        'ST05',
        'Studio E',
        'Can Tho',
        18.00,
        'maintenance'
    );

insert into
    livesessions(
        creator_id,
        studio_id,
        session_date,
        duration_hours
    )
values
    ('CR01', 'ST01', '2025-05-01', 3),
    ('CR02', 'ST02', '2025-05-02', 4),
    ('CR03', 'ST03', '2025-05-03', 2),
    ('CR01', 'ST04', '2025-05-04', 5);

select
    *
from
    livesessions;

insert into
    payments (
        session_id,
        payment_method,
        payment_amount,
        payment_date
    )
values
    (1, 'Cash', 60.00, '2025-05-01'),
    (2, 'Credit Card', 100.00, '2025-05-02'),
    (3, 'Bank Transfer', 60.00, '2025-05-03'),
    (4, 'Credit Card', 110.00, '2025-05-04');

-- Cập nhật creator_platform của creator CR03 thành "YouTube"
update
    creators
set
    creator_platform = "YouTube"
where
    creator_id = 'CR03';

-- Do studio ST05 hoạt động trở lại, cập nhật studio_status = 'Available' và giảm hourly_price 10%
update
    studios
set
    studio_status = 'available'
where
    studio_id = 'ST05';

update
    studios
set
    hourly_price = hourly_price * 0.9
where
    studio_id = 'ST05';

-- Xóa các payment có payment_method = 'Cash' và payment_date trước ngày 2025-05-03
select
    *
from
    payments;

delete from
    payments
where
    payment_method = 'Cash'
    and payment_date < ' 2025-05-03';

select
    *
from
    payments;

-- p2
-- Liệt kê studio có studio_status = 'Available' và hourly_price > 20
select
    *
from
    studios
where
    studio_status = 'available'
    and hourly_price > 20;

-- Lấy thông tin creator (creator_name, creator_phone) có nền tảng là TikTok
select
    creator_name,
    creator_phone
from
    creators
where
    creator_platform = 'Tiktok';

-- Hiển thị danh sách studio gồm studio_id, studio_name, hourly_price sắp xếp theo giá thuê giảm dần
select
    studio_id,
    studio_name,
    hourly_price
from
    studios
order by
    hourly_price desc;

-- Lấy 3 payment đầu tiên có payment_method = 'Credit Card'
select
    *
from
    payments
where
    payment_method = 'Credit Card'
limit
    3;

-- Hiển thị danh sách creator gồm creator_id, creator_name bỏ qua 2 bản ghi đầu và lấy 2 bản ghi tiếp theo
select
    creator_id,
    creator_name
from
    creators
limit
    2 offset 2;

-- p3
-- Hiển thị danh sách livestream gồm: session_id, creator_name, studio_name, duration_hours, payment_amount
select
    l.session_id,
    c.creator_name,
    st.studio_name,
    l.duration_hours,
    p.payment_amount
from
    livesessions l
    join creators c on c.creator_id = l.creator_id
    join payments p on p.session_id = l.session_id
    join studios st on st.studio_id = l.studio_id;

-- Liệt kê tất cả studio và số lần được sử dụng (kể cả studio chưa từng được thuê)
select
    st.studio_id,
    st.studio_name,
    count(l.session_id) AS usage_count
from
    studios st
    left join livesessions l ON st.studio_id = l.studio_id
group by
    st.studio_id,
    st.studio_name;

-- Tính tổng doanh thu theo từng payment_method
select
    payment_method,
    sum(payment_amount) AS total_revenue
from
    payments
group by
    payment_method;

-- Thống kê số session của mỗi creator chỉ hiển thị creator có từ 2 session trở lên
select
    c.creator_id,
    c.creator_name,
    count(l.session_id) as count_session
from
    creators c
    join livesessions l on l.creator_id = c.creator_id
group by
    c.creator_id
having
    count(l.session_id) >= 2;

-- Lấy studio có hourly_price cao hơn mức trung bình của tất cả studio
select
    st.studio_id,
    st.studio_name,
    st.hourly_price
from
    studios st
where
    st.hourly_price >=(
        select
            avg(st1.hourly_price)
        from
            studios st1
    );

-- Hiển thị creator_name, creator_email của những creator đã từng livestream tại Studio B
select
    distinct c.creator_name,
    c.creator_email
from
    creators c
    join livesessions l on c.creator_id = l.creator_id
    join studios st on l.studio_id = st.studio_id
where
    st.studio_name = 'Studio B';

-- Hiển thị báo cáo tổng hợp gồm: session_id, creator_name, studio_name, payment_method, payment_amount
select
    l.session_id,
    c.creator_name,
    st.studio_name,
    p.payment_method,
    p.payment_amount
from
    livesessions l
    join creators c on l.creator_id = c.creator_id
    join studios st on l.studio_id = st.studio_id
    left join payments p on p.session_id = l.session_id;