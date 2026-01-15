use ss14_1_1;

create table  likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id),
    unique key unique_like (post_id, user_id)
);

alter table posts
add column likes_count int default 0;

delimiter $$
create procedure like_post(
    p_post_id int,
    p_user_id int
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;
    
    insert into likes (post_id, user_id)
    values (p_post_id, p_user_id);

    update posts
    set likes_count = likes_count + 1
    where post_id = p_post_id;

    commit;
end$$
delimiter ;

call like_post(1, 1);
select * from posts;
call like_post(1, 1);

