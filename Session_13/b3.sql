use Ss13_1;

-- BEFORE INSERT: Kiểm tra không cho phép user like bài đăng của chính mình (nếu user_id = user_id của post thì RAISE ERROR).
delimiter ~~
create trigger before_insert_like
before insert on likes
for each row 
begin 
	if new.user_id = (select user_id from posts where post_id = new.post_id)
    then signal sqlstate '45000'
		set message_text = 'Khong duoc like bai viet chinh minh';
	end if;
end ~~
delimiter ;
-- AFTER INSERT/DELETE/UPDATE: Cập nhật like_count trong posts tương ứng (tăng/giảm khi thêm/xóa, điều chỉnh khi UPDATE post_id).

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

delimiter ~~
create trigger after_update_like
after update on likes
for each row
begin
    if old.post_id <> new.post_id then
        update posts
        set like_count = like_count - 1
        where post_id = old.post_id;

        update posts
        set like_count = like_count + 1
        where post_id = new.post_id;
    end if;
end ~~
delimiter ;

insert into likes (user_id, post_id)
values (1, 1);

insert into likes (user_id, post_id)
values (2, 1);

select post_id, like_count
from posts
where post_id = 1;

update likes
set post_id = 3
where user_id = 2 and post_id = 1;

select post_id, like_count
from posts
where post_id in (1, 3);

delete from likes
where user_id = 2 and post_id = 3;

select post_id, like_count
from posts
where post_id = 3;

select * from posts;
select * from user_statistics;

