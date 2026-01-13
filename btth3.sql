drop database if exists miniprojectss12;

create database miniprojectss12;
use miniprojectss12;
-- tạo bảng dữ liệu
create table users(
	user_id int primary key auto_increment,
    username varchar(50) not null unique,
    password varchar(255) not null,
    email varchar(100) not null unique,
    created_at datetime default current_timestamp
);

create table posts(
	post_id int primary key auto_increment,
    user_id int,
    foreign key(user_id) references users(user_id),
    content text not null,
    created_at datetime default current_timestamp
);

create table comments (
    comment_id int primary key auto_increment,
    post_id int,
    user_id int,
    foreign key (user_id)
        references users (user_id),
    foreign key (post_id)
        references posts (post_id),
    content text not null,
    created_at datetime default current_timestamp
);

create table friends (
    friend_id int,
    user_id int,
    foreign key (user_id)
        references users (user_id),
    foreign key (friend_id)
        references users (user_id),
    status varchar(20) check (status in ('pending' , 'accepted'))
);

create table likes(
	user_id int,
    post_id int,
    foreign key (user_id)
        references users (user_id),
    foreign key (post_id)
        references posts (post_id)
);

-- bài 1. quản lý người dùng
insert into users (username, password, email) values
('anhtuan', '123', 'anhtuan@gmail.com'),
('minhan', '123', 'minhan@gmail.com'),
('thanhdat', '123', 'thanhdat@gmail.com'),
('hoangan', '123', 'hoangan@gmail.com'),
('linhchi', '123', 'linhchi@gmail.com'),
('phuongnam', '123', 'phuongnam@gmail.com'),
('quocbao', '123', 'quocbao@gmail.com'),
('myhanh', '123', 'myhanh@gmail.com'),
('tuananh', '123', 'tuananh@gmail.com'),
('anhthu', '123', 'anhthu@gmail.com'),
('vietanh', '123', 'vietanh@gmail.com'),
('hoanglong', '123', 'hoanglong@gmail.com'),
('kimngan', '123', 'kimngan@gmail.com'),
('ngocanh', '123', 'ngocanh@gmail.com'),
('thanhson', '123', 'thanhson@gmail.com'),
('phuongthao', '123', 'phuongthao@gmail.com'),
('ducthinh', '123', 'ducthinh@gmail.com'),
('baotram', '123', 'baotram@gmail.com'),
('huyhoang', '123', 'huyhoang@gmail.com'),
('quynhanh', '123', 'quynhanh@gmail.com');

select user_id,username,password,email,created_at
from users;


insert into posts (user_id, content) values
(1, 'hôm nay học database rất thú vị'),
(2, 'mysql giúp quản lý dữ liệu hiệu quả'),
(3, 'mình đang học stored procedure'),
(4, 'lập trình backend thật sự cuốn'),
(5, 'cuối tuần học sql cùng bạn bè'),
(6, 'index giúp truy vấn nhanh hơn'),
(7, 'view giúp bảo mật dữ liệu'),
(8, 'hôm nay trời mưa nhẹ'),
(9, 'tối ưu database rất quan trọng'),
(10, 'học database để làm backend'),
(11, 'procedure giúp tái sử dụng code'),
(12, 'mạng xã hội mini bằng sql'),
(13, 'thích nhất là phần join table'),
(14, 'thực hành sql mỗi ngày'),
(15, 'cơ sở dữ liệu quan hệ'),
(16, 'foreign key rất quan trọng'),
(17, 'composite index tăng hiệu suất'),
(18, 'database design quyết định hiệu năng'),
(19, 'sql không khó nếu chăm học'),
(20, 'backend developer cần giỏi database');


insert into comments (post_id, user_id, content) values
(1,2,'chuẩn luôn'),
(1,3,'mình cũng thấy vậy'),
(2,4,'mysql rất mạnh'),
(3,5,'procedure hơi khó'),
(4,6,'backend rất thú vị'),
(5,7,'cuối tuần học là hợp lý'),
(6,8,'index quan trọng thật'),
(7,9,'view rất hay'),
(8,10,'thời tiết dễ ngủ'),
(9,11,'tối ưu là bắt buộc'),
(10,12,'backend cần sql'),
(11,13,'procedure dùng nhiều'),
(12,14,'mini project hay'),
(13,15,'join là nền tảng'),
(14,16,'ngày nào cũng nên học'),
(15,17,'csdl rất quan trọng'),
(16,18,'fk giúp tránh lỗi'),
(17,19,'index tăng tốc'),
(18,20,'thiết kế chuẩn rất quan trọng'),
(19,1,'sql dễ mà'),
(20,2,'backend không thể thiếu db');


insert into friends (user_id, friend_id, status) values
(1,2,'accepted'),
(1,3,'accepted'),
(1,4,'pending'),
(2,5,'accepted'),
(2,6,'pending'),
(3,7,'accepted'),
(3,8,'accepted'),
(4,9,'pending'),
(5,10,'accepted'),
(6,11,'accepted'),
(7,12,'pending'),
(8,13,'accepted'),
(9,14,'accepted'),
(10,15,'pending'),
(11,16,'accepted'),
(12,17,'accepted'),
(13,18,'pending'),
(14,19,'accepted'),
(15,20,'accepted'),
(16,1,'pending');


insert into likes (user_id, post_id) values
(1,1),
(2,1),
(3,1),
(4,1),
(5,2),
(6,2),
(7,2),
(8,3),
(9,3),
(10,3),
(11,4),
(12,4),
(13,5),
(14,5),
(15,6),
(16,7),
(17,8),
(18,9),
(19,10),
(20,10);

-- bài 2. hiển thị thông tin công khai bằng view
create view vw_public_users as
select user_id,username,created_at
from users;

select *
from vw_public_users;

select user_id,username,created_at
from users;

-- bài 3. tối ưu tìm kiếm người dùng bằng index
create index idx_username on users(username);
drop index idx_username on users;

select *
from users
where username = 'anhtuan';

-- bài 4. quản lý bài viết bằng stored procedure
delimiter $$

create procedure sp_create_post(
    in p_user_id int,
    in p_content text
)
begin
    if exists (select 1 from users where user_id = p_user_id) then
        insert into posts(user_id, content)
        values (p_user_id, p_content);
    else
        signal sqlstate '45000'
        set message_text = 'user không tồn tại';
    end if;
end$$

call sp_create_post(1, 'bài viết mới từ stored procedure');

-- bài 5. hiển thị news feed bằng view
create view vw_recent_posts as
select p.post_id, u.username, p.content, p.created_at
from posts p
join users u on p.user_id = u.user_id
where p.created_at >= now() - interval 7 day;

select *
from vw_recent_posts
order by created_at desc;



-- bài 6. tối ưu truy vấn bài viết
create index idx_posts_user_id
on posts(user_id);

create index idx_posts_user_created
on posts(user_id, created_at);

select *
from posts
where user_id = 1
order by created_at desc;

-- vai trò của composite index.
	-- lọc nhanh theo user
	-- sắp xếp nhanh theo thời gian
	-- tránh sort tốn tài nguyên


-- bài 7. thống kê hoạt động bằng stored procedure
delimiter $$

create procedure sp_count_posts(
    in p_user_id int,
    out p_total int
)
begin
    select count(*) into p_total
    from posts
    where user_id = p_user_id;
end$$

call sp_count_posts(1, @total_posts);
select @total_posts as total_posts;


-- bài 8. kiểm soát dữ liệu bằng view with check option
create view vw_active_users as
select u.user_id, u.username, u.created_at
from users u
join posts p on u.user_id = p.user_id
with check option;


-- bài 9. quản lý kết bạn bằng stored procedure
delimiter $$

create procedure sp_add_friend(
    in p_user_id int,
    in p_friend_id int
)
begin
    if p_user_id = p_friend_id then
        signal sqlstate '45000'
        set message_text = 'không thể kết bạn với chính mình';
    else
        insert into friends(user_id, friend_id, status)
        values (p_user_id, p_friend_id, 'pending');
    end if;
end$$

call sp_add_friend(1,5);

delimiter $$
-- bài 10. gợi ý bạn bè bằng procedure nâng cao

create procedure sp_suggest_friends(
    in p_user_id int,
    inout p_limit int
)
begin
    declare counter int default 0;
    declare max_limit int default 10;

    if p_limit is null or p_limit <= 0 then
        set p_limit = 5;
    elseif p_limit > max_limit then
        set p_limit = max_limit;
    end if;

    while counter < p_limit do
        set counter = counter + 1;
    end while;

    select u.user_id, u.username
        from users u
        where u.user_id != p_user_id
          and u.user_id not in (
              select friend_id from friends where user_id = p_user_id
          )
        limit p_limit;
end$$
set @limit = 5;
call sp_suggest_friends(1,@limit);

-- bài 11. thống kê tương tác nâng cao
create index idx_likes_post_id
on likes(post_id);

create view vw_top_posts as
select p.post_id, p.content, count(l.post_id) as total_likes
from posts p
join likes l on p.post_id = l.post_id
group by p.post_id
order by total_likes desc
limit 5;

select * from vw_top_posts;


-- bài 12. quản lý bình luận
delimiter $$

create procedure sp_add_comment(
    in p_user_id int,
    in p_post_id int,
    in p_content text
)
begin
    declare v_user_exists int default 0;
    declare v_post_exists int default 0;

    select count(*) into v_user_exists from users where user_id = p_user_id;
    select count(*) into v_post_exists from posts where post_id = p_post_id;

    if v_user_exists = 0 then
        signal sqlstate '45000'
        set message_text = 'user không tồn tại';
    elseif v_post_exists = 0 then
        signal sqlstate '45000'
        set message_text = 'post không tồn tại';
    else
        insert into comments(user_id, post_id, content)
        values (p_user_id, p_post_id, p_content);
    end if;
end$$

call sp_add_comment(1,1,'hihi');

create view vw_post_comments as
select c.content, u.username, c.created_at
from comments c
join users u on c.user_id = u.user_id;

select *
from vw_post_comments;


-- bài 13. quản lý lượt thích
delimiter $$

create procedure sp_like_post(
    in p_user_id int,
    in p_post_id int
)
begin
    if exists (
        select 1 from likes
        where user_id = p_user_id and post_id = p_post_id
    ) then
        signal sqlstate '45000'
        set message_text = 'đã thích bài viết này';
    else
        insert into likes(user_id, post_id)
        values (p_user_id, p_post_id);
    end if;
end$$

call sp_like_post(1,2);

create view vw_post_likes as
select post_id, count(*) as total_likes
from likes
group by post_id;

select *
from vw_post_likes;


-- bài 14. tìm kiếm người dùng & bài viết
delimiter $$

create procedure sp_search_social(
    in p_option int,
    in p_keyword varchar(100)
)
begin
    if p_option = 1 then
        select user_id, username
        from users
        where username like concat('%', p_keyword, '%');
    elseif p_option = 2 then
        select post_id, content
        from posts
        where content like concat('%', p_keyword, '%');
    else
        signal sqlstate '45000'
        set message_text = 'option không hợp lệ';
    end if;
end$$

call sp_search_social(1, 'an');
call sp_search_social(2, 'database');


