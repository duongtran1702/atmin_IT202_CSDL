use ss14_1_1;

create table if not exists friend_requests (
    request_id int primary key auto_increment,
    from_user_id int,
    to_user_id int,
    status enum('pending','accepted','rejected') default 'pending'
);

create table if not exists friends (
    user_id int,
    friend_id int,
    primary key (user_id, friend_id)
);

alter table users
add column friends_count int default 0;

delimiter $$
create procedure sp_accept_friend_request(
    in p_request_id int,
    in p_to_user_id int
)
begin
    declare v_from_user int;
    declare v_status varchar(10);
    declare v_count int default 0;

    declare exit handler for sqlexception
    begin
        rollback;
    end;

    set transaction isolation level repeatable read;
    start transaction;

    select from_user_id, status
    into v_from_user, v_status
    from friend_requests
    where request_id = p_request_id
      and to_user_id = p_to_user_id;

    if v_from_user is null or v_status <> 'pending' then
        rollback;
    else
        select count(*) into v_count
        from friends
        where user_id = p_to_user_id
          and friend_id = v_from_user;

        if v_count > 0 then
            rollback;
        else
            insert into friends(user_id, friend_id)
            values (p_to_user_id, v_from_user);

            insert into friends(user_id, friend_id)
            values (v_from_user, p_to_user_id);

            update users
            set friends_count = friends_count + 1
            where user_id in (p_to_user_id, v_from_user);

            update friend_requests
            set status = 'accepted'
            where request_id = p_request_id;

            commit;
        end if;
    end if;
end$$

delimiter ;

call sp_accept_friend_request(1, 2);
call sp_accept_friend_request(1, 2);
