use Ss13_1;
-- 1)Tạo Stored Procedure add_user(username, email, created_at) thực hiện INSERT vào users.
delimiter //
create procedure add_user(
    in p_username varchar(50),
    in p_email varchar(100),
    in p_created_at datetime
)
begin
    insert into users(username, email, created_at)
    values (p_username, p_email, p_created_at);
end //
delimiter ;

-- 2) Tạo trigger BEFORE INSERT trên users:
-- Kiểm tra email chứa '@' và '.'.
-- Kiểm tra username chỉ chứa chữ cái, số và underscore.
-- Nếu không hợp lệ thì RAISE ERROR.

delimiter //
create trigger before_insert_user
before insert on users
for each row
begin
    -- kiểm tra email có @ và .
    if new.email not like '%@%.%' then
        signal sqlstate '45000'
        set message_text = 'email khong hop le';
    end if;

    -- kiểm tra username chỉ gồm chữ, số, _
    if new.username not regexp '^[a-zA-Z0-9_]+$' then
        signal sqlstate '45000'
        set message_text = 'username khong hop le';
    end if;
end //
delimiter ;

-- 3) Gọi procedure với dữ liệu hợp lệ và không hợp lệ để kiểm thử.
-- Gọi với dữ liệu hợp lệ
call add_user('user_2', 'user2@gmail.com', current_date());
-- Gọi với email không hợp lệ
call add_user('user_2', 'user2gmail.com', current_date());

-- 4) SELECT * FROM users để xem kết quả.
select * from users;