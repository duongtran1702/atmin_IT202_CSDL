use ss14_1_1;

create table if not exists delete_log (
    log_id int primary key auto_increment,
    post_id int,
    deleted_by int,
    deleted_at datetime default current_timestamp
);

delimiter $$

create procedure sp_delete_post(
    in p_post_id int,
    in p_user_id int
)
begin
    declare v_count int default 0;

    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;

    select count(*) into v_count
    from posts
    where post_id = p_post_id
      and user_id = p_user_id;

    if v_count = 0 then
        rollback;
    else
        delete from likes
        where post_id = p_post_id;

        delete from comments
        where post_id = p_post_id;

        delete from posts
        where post_id = p_post_id;

        update users
        set posts_count = posts_count - 1
        where user_id = p_user_id;

        insert into delete_log(post_id, deleted_by)
        values (p_post_id, p_user_id);

        commit;
    end if;
end$$

delimiter ;

call sp_delete_post(1, 1);
call sp_delete_post(1, 2);
