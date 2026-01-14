use Ss13_1;

create table post_history (
    history_id int auto_increment primary key,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime default current_timestamp,
    changed_by_user_id int,
    foreign key (post_id) references posts(post_id) on delete cascade
);

-- BEFORE UPDATE trên posts: Nếu content thay đổi, INSERT bản ghi vào post_history với old_content (OLD.content), new_content (NEW.content), 
-- changed_at NOW(), và giả sử changed_by_user_id là user_id của post.
delimiter //

create trigger before_update_post
before update on posts
for each row
begin
    if old.content <> new.content then
        insert into post_history (
            post_id,
            old_content,
            new_content,
            changed_at,
            changed_by_user_id
        )
        values (
            old.post_id,
            old.content,
            new.content,
            now(),
            old.user_id
        );
    end if;
end;
//

delimiter ;

-- AFTER DELETE trên posts: Có thể ghi log hoặc để CASCADE.

delimiter //
create trigger after_delete_post
after delete on posts
for each row
begin
    insert into post_history (
        post_id,
        old_content,
        new_content,
        changed_at,
        changed_by_user_id
    )
    values (
        old.post_id,
        old.content,
        null,
        now(),
        old.user_id
    );
end //

delimiter ;


-- Thực hiện UPDATE nội dung một số bài đăng, sau đó SELECT từ post_history để xem lịch sử.
update posts
set content = 'noi dung da chinh sua lan 1'
where post_id = 1;

update posts
set content = 'noi dung da chinh sua lan 2'
where post_id = 1;

select *
from post_history
where post_id = 1;


-- Kiểm tra kết hợp với trigger like_count từ bài trước vẫn hoạt động khi UPDATE post.

select post_id, like_count
from posts
where post_id = 1;
