create database ss14_1_1;
use ss14_1_1;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

insert into
    users (username)
values
    ('an'),
    ('binh');

delimiter ~~
create procedure post_article(p_user_id int, p_content varchar(255))
begin
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;

    -- them bai viet
    insert into posts (user_id, content)
    values (p_user_id, p_content);

    -- cap nhat so luong bai viet
    update users
    set posts_count = posts_count + 1
    where user_id = p_user_id;

    -- neu thanh cong
    commit;
end ~~
delimiter ;

call post_article(2, 'bai viet 2nd');

call post_article(999, 'bai viet bi loi');

select * from posts;
select * from users;