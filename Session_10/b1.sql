use social_network_pro;

select
    *
FROM
    users;

create view view_users_firstname as
select
    user_id,
    username,
    full_name,
    email,
    created_at
from
    users
where
    full_name like "Nguyễn%";

select
    *
FROM
    view_users_firstname;

insert into
    users(
        user_id,
        username,
        full_name,
        email,
        created_at,
        password
    )
values
    (
        101,
        'cao',
        'Nguyễn Văn Cao',
        'cao@gmail.com',
        '2024-06-10',
        'password123'
    );

select
    *
FROM
    view_users_firstname;

delete from
    users
where
    user_id = 101;

select
    *
FROM
    view_users_firstname;