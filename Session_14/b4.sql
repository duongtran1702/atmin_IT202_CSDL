use ss14_1_1;

create table if not exists comments (
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

alter table posts
add column comments_count int default 0;

delimiter $$

create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;

    insert into comments(post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    savepoint after_insert;

    update posts
    set comments_count = comments_count + 1
    where post_id = p_post_id;

    if row_count() = 0 then
        rollback to after_insert;
        commit;
    else
        commit;
    end if;
end$$

delimiter ;

call sp_post_comment(1, 1, 'comment thanh cong');
call sp_post_comment(999, 1, 'gay loi update');
