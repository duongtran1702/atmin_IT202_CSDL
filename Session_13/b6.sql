use Ss13_1;

-- 1)Tạo bảng friendships .
create table friendships (
    follower_id int,
    followee_id int,
    status enum('pending', 'accepted') default 'accepted',
    primary key (follower_id, followee_id),
    foreign key (follower_id) references users(user_id) on delete cascade,
    foreign key (followee_id) references users(user_id) on delete cascade
);

-- 2) Tạo trigger AFTER INSERT/DELETE trên friendships để cập nhật follower_count của followee.
delimiter $$
create trigger after_insert_friendship
after insert on friendships
for each row
begin
    if new.status = 'accepted' then
        update users
        set follower_count = follower_count + 1
        where user_id = new.followee_id;
    end if;
end$$
delimiter ;

delimiter $$
create trigger after_delete_friendship
after delete on friendships
for each row
begin
    if old.status = 'accepted' then
        update users
        set follower_count = follower_count - 1
        where user_id = old.followee_id;
    end if;
end$$
delimiter ;


-- 3) Tạo Procedure follow_user(follower_id, followee_id, status) xử lý logic (tránh tự follow, tránh trùng).
delimiter $$
create procedure follow_user(
    in p_follower_id int,
    in p_followee_id int,
    in p_status enum('pending', 'accepted')
)
begin
    -- khong cho tu follow
    if p_follower_id = p_followee_id then
        signal sqlstate '45000'
        set message_text = 'khong the tu follow chinh minh';
    end if;

    -- tranh follow trung
    if exists (
        select 1 from friendships
        where follower_id = p_follower_id
          and followee_id = p_followee_id
    ) then
        signal sqlstate '45000'
        set message_text = 'followed';
    end if;

    insert into friendships(follower_id, followee_id, status)
    values (p_follower_id, p_followee_id, p_status);
end$$
delimiter ;

-- 4) Tạo View user_profile chi tiết.
create view user_profile as
select
    u.user_id,
    u.username,
    u.email,
    u.follower_count,
    count(f.followee_id) as following_count
from users u
left join friendships f
    on u.user_id = f.follower_id
    and f.status = 'accepted'
group by u.user_id, u.username, u.email, u.follower_count;

-- 5) Thực hiện một số follow/unfollow và kiểm chứng follower_count, View.
call follow_user(1, 2, 'accepted');
select * from friendships;
call follow_user(3, 2, 'accepted');
select * from friendships;

delete from friendships
where follower_id = 1 and followee_id = 2;

select user_id, follower_count
from users
where user_id = 2;

select * from user_profile;

