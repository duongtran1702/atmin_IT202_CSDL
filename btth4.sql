create database social_network;

use social_network;

create table users(
    user_id int primary key auto_increment,
    username varchar(50) unique not null,
    password varchar(255) not null,
    email varchar(100) not null unique,
    created_at datetime default current_timestamp
);

create table posts(
    post_id int primary key auto_increment,
    user_id int not null,
    foreign key(user_id) references users(user_id) on delete cascade,
    content text not null,
    created_at datetime default current_timestamp
);

create table comments(
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    foreign key(post_id) references posts(post_id) on delete cascade,
    foreign key (user_id) references users(user_id) on delete cascade,
    content text not null,
    created_at datetime default current_timestamp
);

create table likes(
    user_id int not null,
    post_id int not null,
    created_at datetime default current_timestamp,
    primary key (user_id, post_id),
    foreign key(post_id) references posts(post_id) on delete cascade,
    foreign key (user_id) references users(user_id) on delete cascade
);

create table friends(
    user_id int not null,
    foreign key (user_id) references users(user_id) on delete cascade,
    friend_id int not null,
    foreign key (friend_id) references users(user_id) on delete cascade,
    status varchar(20) check (status in ('pending', 'accepted')) default 'pending',
    primary key(friend_id, user_id)
);

-- Bai 1
-- Tạo bảng user_log (log_id, user_id, action, log_time).
create table user_log(
	log_id int auto_increment primary key,
	user_id int not null,
	foreign key (user_id) references users(user_id),
    action text not null,
    log_time datetime default current_timestamp
);
-- Stored Procedure sp_register_user(p_username, p_password, p_email) với kiểm tra trùng → SIGNAL lỗi.

delimiter ~~
create procedure sp_register_user(p_username varchar(50), p_password varchar(255), p_email varchar(100))
begin
	if exists (select 1 from users where username = p_username) then
    signal sqlstate '45000' set message_text = 'duplicate username';
    elseif exists (select 1 from users where email = P_email) then
    signal sqlstate '45000' set message_text = 'duplicate email';
    end if;
    
	insert into users(username,password,email)
    values(p_username, p_password, p_email);
end ~~
delimiter ;

-- Trigger AFTER INSERT trên Users ghi vào user_log.

delimiter ~~
create trigger after_insert_user
after insert on users
for each row
begin
insert into user_log(user_id,action)
values(new.user_id,concat('insert user ',new.username));
end ~~
delimiter ;

-- Đăng ký 3-4 user thành công → SELECT Users và user_log.
call sp_register_user('duong', '123456', 'duong@gmail.com');
call sp_register_user('lam', '123456', 'lam@gmail.com');
call sp_register_user('minh', '123456', 'minh@gmail.com');
call sp_register_user('hoa', '123456', 'hoa@gmail.com');

select * from users;
select * from user_log;

-- Đăng ký trùng username/email → kiểm tra lỗi SIGNAL và bảng không thêm bản ghi.
call sp_register_user('duong', 'abcdef', 'duong2@gmail.com');
call sp_register_user('duong1', 'abcdef', 'duong@gmail.com');

-- Bai 2
-- Stored Procedure sp_create_post(p_user_id, p_content) kiểm tra content không rỗng.
delimiter ~~
create procedure sp_create_post(p_user_id int, p_content text)
begin
	if p_content is null or trim(p_content) = '' then 
	signal sqlstate '45000' set message_text = 'content is empty';
    end if;
	
    insert into posts(user_id,content)
    values(p_user_id, p_content);
    
end ~~
delimiter ;

-- Tạo bảng post_log nếu cần.
create table post_log(
	log_id int auto_increment primary key,
	post_id int not null,
	foreign key (post_id) references posts(post_id),
    action text not null,
    log_time datetime default current_timestamp
);

-- Trigger AFTER INSERT trên Posts ghi log.
delimiter ~~
create trigger after_insert_post
after insert on posts
for each row
begin
insert into post_log(post_id,action)
values(new.post_id,concat('insert post ',new.post_id));
end ~~
delimiter ;

-- Đăng 5-6 bài viết → SELECT Posts và log.
call sp_create_post(1, 'bai viet so 1');
call sp_create_post(1, 'bai viet so 2');
call sp_create_post(2, 'hello world');
call sp_create_post(2, 'mysql trigger test');
call sp_create_post(3, 'hoc stored procedure');

select * from posts;
select * from post_log;

-- Đăng bài với content rỗng → kiểm tra lỗi.

call sp_create_post(1, null);
call sp_create_post(1, '');
call sp_create_post(1, '   ');

-- Bai 3
alter table posts
add column like_count int default 0;

-- Trigger AFTER INSERT trên Likes: tăng like_count +1.
delimiter ~~
create trigger after_insert_like
after insert on likes
for each row
begin
	update posts 
    set like_count = like_count + 1
    where post_id = new.post_id;
    
     if exists (select 1 from posts where post_id = new.post_id) then
        insert into post_log(post_id, action)
        values (new.post_id, concat('like post ', new.post_id));
    end if;
end ~~
delimiter ;

-- Trigger AFTER DELETE trên Likes: giảm like_count -1.
delimiter ~~
create trigger after_delete_like
after delete on likes
for each row
begin
	update posts 
    set like_count = case when like_count > 0 then like_count - 1
    else 0 end
    where post_id = old.post_id;
    
    if exists (select 1 from posts where post_id = old.post_id) then
        insert into post_log(post_id, action)
        values (old.post_id, concat('unlike post ', old.post_id));
    end if;
end ~~
delimiter ;

-- Ghi log hành động like/unlike.
-- Like vài bài → kiểm tra like_count tăng.
insert into likes(user_id, post_id) values (1, 3);
insert into likes(user_id, post_id) values (2, 3);

select * from posts;
-- Unlike → kiểm tra giảm.
delete from likes where user_id = 1 and post_id = 3;
select * from posts;
-- Like trùng → PRIMARY KEY ngăn chặn.
insert into likes(user_id, post_id) values (2, 3);

-- Bai 4
-- Stored Procedure sp_send_friend_request(p_sender_id, p_receiver_id) với kiểm tra → SIGNAL lỗi nếu không hợp lệ.
delimiter ~~
create procedure sp_send_friend_request(p_sender_id int, p_receiver_id int)
atmin: begin

    -- không tự gửi
    if p_sender_id = p_receiver_id then
        signal sqlstate '45000'
        set message_text = 'unable to send it to myself';
    end if;

    -- trùng cùng chiều
    if exists (
        select 1 from friends
        where user_id = p_sender_id
          and friend_id = p_receiver_id
    ) then
        signal sqlstate '45000'
        set message_text = 'request was sent';
    end if;

    -- ngược chiều → accept luôn
    if exists (
        select 1 from friends
        where user_id = p_receiver_id
          and friend_id = p_sender_id
          and status = 'pending'
    ) then
        update friends
        set status = 'accepted'
        where user_id = p_receiver_id
          and friend_id = p_sender_id;
          
		insert into user_log(user_id,action)
		values (p_sender_id,'Request was accepted');

        leave atmin;  -- thoát luôn
    end if;

    -- gửi request mới
    insert into friends(user_id, friend_id)
    values (p_sender_id, p_receiver_id);

end ~~
delimiter ;

-- Trigger AFTER INSERT trên Friends ghi log.
delimiter ~~
create trigger after_insert_friend
after insert on friends
for each row
begin
    insert into user_log(user_id,action)
	values(new.user_id,concat('user ',new.user_id,' sent friend request to user ',new.friend_id));
end ~~
delimiter ;

-- Gửi vài lời mời hợp lệ → SELECT Friends.
call sp_send_friend_request(1, 2);
call sp_send_friend_request(1, 3);
call sp_send_friend_request(2, 3);

select * from friends;
-- Gửi không hợp lệ (tự gửi, trùng) → kiểm tra lỗi.
call sp_send_friend_request(1, 1);
call sp_send_friend_request(2,3);

-- Bai 5
-- Stored Procedure hoặc Trigger AFTER UPDATE trên Friends: nếu status thành 'accepted' thì INSERT bản ghi ngược.
delimiter ~~
create procedure accept_request_friend(p_sender_id int, p_receiver_id int)
begin
	-- accepted
	update friends set status = 'accepted' 
    where user_id = p_sender_id and friend_id = p_receiver_id and status = 'pending';
    
    if row_count() = 0 then 
    signal sqlstate '45000' set message_text = 'No pending friend request found';
    end if;
    
    -- insert chiều ngược
    if not exists (
        select 1 from friends
        where user_id = p_receiver_id
          and friend_id = p_sender_id
    ) then
        insert into friends(user_id, friend_id, status)
        values (p_receiver_id, p_sender_id, 'accepted');
    end if;
    
    insert into user_log(user_id,action)
    values (p_receiver_id,'Request was accepted');
end ~~
delimiter ;


-- Gửi lời mời → chấp nhận → kiểm tra cả hai chiều đều 'accepted'.
call sp_send_friend_request(4,3);
call accept_request_friend(4,3);

select * from friends;


-- Bài 6: Quản Lý Mối Quan Hệ Bạn Bè
-- Stored Procedure với START TRANSACTION … COMMIT/ROLLBACK khi cập nhật/xóa cả hai chiều.
alter table friends
drop check friends_chk_1;

alter table friends
add constraint friends_chk_1
check (status in ('pending','accepted','blocked'));


delimiter ~~
create procedure sp_update_status_friend(u1 int , u2 int)
begin
	declare cnt int;
	declare tmp_status varchar(15);
	start transaction;
    
    select count(*)
    into cnt
    from friends
    where (user_id = u1 and friend_id = u2)
       or (user_id = u2 and friend_id = u1);

    if cnt <> 2 then
        rollback;
        signal sqlstate '45000'
        set message_text = 'friend relationship must exist in two directions';
    end if;

    
    select status into tmp_status 
    from friends 
    where user_id = u1 and friend_id = u2 for update;
    
    if tmp_status = 'accepted' then 
    update friends set status = 'blocked' 
    where (user_id = u1 and friend_id = u2)
       or (user_id = u2 and friend_id = u1);
    else update friends set status = 'accepted' 
    where (user_id = u1 and friend_id = u2)
       or (user_id = u2 and friend_id = u1);
    end if;
    
    commit;
end ~~
delimiter ;

delimiter ~~
create procedure sp_delete_friend(u1 int, u2 int)
begin
	declare cnt int;
    start transaction;

    select count(*)
    into cnt
    from friends
    where (user_id = u1 and friend_id = u2)
       or (user_id = u2 and friend_id = u1);

    if cnt <> 2 then
        rollback;
        signal sqlstate '45000'
        set message_text = 'friend relationship must exist in two directions';
    end if;


    -- xóa 
    delete from friends
    where (user_id = u1 and friend_id = u2)
       or (user_id = u2 and friend_id = u1);

    commit;
end ~~
delimiter ;

-- Cập nhật/xóa mối quan hệ → kiểm tra dữ liệu nhất quán.

call sp_update_status_friend(3, 4);
select * from friends;

call sp_delete_friend(3,4);
-- Gây lỗi trong transaction → kiểm tra ROLLBACK.
call sp_update_status_friend(1, 4);
call sp_delete_friend(1, 4);

-- Bai 7
-- Stored Procedure sp_delete_post(p_post_id, p_user_id) kiểm tra quyền chủ + Transaction.
delimiter $$

create procedure sp_delete_post(
    in p_post_id int,
    in p_user_id int
)
begin
    start transaction;

    -- kiểm tra quyền chủ bài viết
    if not exists (
        select 1
        from posts
        where post_id = p_post_id
          and user_id = p_user_id
    ) then
        rollback;
        signal sqlstate '45000'
        set message_text = 'permission denied or post not found';
    end if;

    -- xóa bài viết
    delete from posts
    where post_id = p_post_id;

    commit;
end$$

delimiter ;

delimiter $$

create trigger trg_delete_post_log
after delete on posts
for each row
begin
    delete from post_log
    where post_id = old.post_id;
end$$

delimiter ;

-- Trigger BEFORE DELETE trên Posts xóa dữ liệu liên quan (hoặc dùng ON DELETE CASCADE).
-- Đã có on delete cascade

-- Tạo bài có like + comment → xóa → kiểm tra tất cả biến mất.
insert into posts(user_id, content)
values (1, 'Post test delete cascade');

insert into comments(post_id, user_id, content)
values (8, 2, 'Comment test delete');

insert into likes(user_id, post_id)
values (2, 8);

call sp_delete_post(8, 1);

select * from posts;
select * from comments where post_id = 8;
select * from likes where post_id = 8;

-- Gây lỗi → ROLLBACK.
insert into posts(user_id, content)
values (1, 'rollback test');

call sp_delete_post(31, 2);

-- Bài 8: Quản Lý Xóa Tài Khoản Người Dùng
-- Stored Procedure sp_delete_user(p_user_id) với Transaction, xóa theo thứ tự an toàn hoặc dùng ON DELETE CASCADE.
delimiter $$

create procedure sp_delete_user(
    in p_user_id int
)
begin
    start transaction;

    -- kiểm tra user tồn tại
    if not exists (
        select 1 from users where user_id = p_user_id
    ) then
        rollback;
        signal sqlstate '45000'
        set message_text = 'user not found';
    end if;

    -- xóa log của user (vì không cascade)
    delete from user_log
    where user_id = p_user_id;

    -- xóa user (cascade sẽ tự xóa posts, comments, likes, friends)
    delete from users
    where user_id = p_user_id;

    commit;
end$$

delimiter ;

-- Kiểm tra và demo:
-- Tạo user đầy đủ hoạt động → xóa → kiểm tra toàn bộ dữ liệu liên quan biến mất.

call sp_register_user('testuser', '123', 'testuser@gmail.com');

-- giả sử user_id = 5
call sp_create_post(5, 'Post cua testuser');

insert into comments(post_id, user_id, content)
values (1, 1, 'comment test');

insert into likes(user_id, post_id)
values (1, 1);

call sp_send_friend_request(5, 1);
call accept_request_friend(5, 1);
















