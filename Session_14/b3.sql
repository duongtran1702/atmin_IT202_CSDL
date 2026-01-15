use ss14_1_1;

create table followers (
    follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id),
    foreign key (followed_id) references users(user_id)
);

create table follow_log (
    log_id int primary key auto_increment,
    follower_id int,
    followed_id int,
    message varchar(255),
    created_at datetime default current_timestamp
);


alter table users
add column  following_count int default 0,
add column  followers_count int default 0;

delimiter $$

create procedure sp_follow_user(
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare v_count int default 0;

    -- bat loi sql
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;

    select count(*) into v_count
    from users
    where user_id in (p_follower_id, p_followed_id);

    if v_count < 2 then
        insert into follow_log(follower_id, followed_id, message)
        values (p_follower_id, p_followed_id, 'user khong ton tai');
        rollback;
    else

        
        if p_follower_id = p_followed_id then
            insert into follow_log(follower_id, followed_id, message)
            values (p_follower_id, p_followed_id, 'tu follow chinh minh');
            rollback;
        else

            
            select count(*) into v_count
            from followers
            where follower_id = p_follower_id
              and followed_id = p_followed_id;

            if v_count > 0 then
                insert into follow_log(follower_id, followed_id, message)
                values (p_follower_id, p_followed_id, 'da follow truoc do');
                rollback;
            else

                -- 4. them follow
                insert into followers(follower_id, followed_id)
                values (p_follower_id, p_followed_id);

                update users
                set following_count = following_count + 1
                where user_id = p_follower_id;

                update users
                set followers_count = followers_count + 1
                where user_id = p_followed_id;

                commit;
            end if;
        end if;
    end if;
end$$

delimiter ;

call sp_follow_user(1, 2);
call sp_follow_user(1, 2);
call sp_follow_user(1, 1);
call sp_follow_user(1, 999);
