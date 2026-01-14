use Ss13_1;

create table likes (
    like_id int auto_increment primary key,
    user_id int,
    post_id int,
    liked_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (post_id) references posts(post_id) on delete cascade
);

delimiter ~~
create trigger after_insert_like
after insert on likes
for each row 
begin 
	update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end ~~
delimiter ;

delimiter ~~
create trigger after_delete_like
after delete on likes
for each row 
begin 
	update posts
    set like_count = case when like_count > 0 then like_count - 1
    else 0 end
    where post_id = old.post_id;
end ~~
delimiter ;

select * from posts;
insert into likes (user_id, post_id, liked_at) values
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');

select * from posts;

-- Tạo một View tên user_statistics hiển thị: user_id, username, post_count, total_likes (tổng like_count của tất cả bài đăng của người dùng đó).
create or replace view user_statistics as
select u.user_id, u.username, u.post_count,
    ifnull(sum(p.like_count), 0) as total_likes
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.post_count;

select * from posts where post_id = 4;

insert into likes (user_id, post_id, liked_at)
values (2, 4, now());

select * from posts where post_id = 4;

select * from user_statistics;

delete from likes where like_id = 2;
select * from posts where post_id = 1;
select * from user_statistics;