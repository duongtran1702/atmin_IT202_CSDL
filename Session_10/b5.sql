use social_network_pro;

create index idx_hometown on users(hometown);

select
    u.user_id,
    u.full_name
from
    users u
where
    u.hometown = 'Hà Nội';

select
    u.user_id,
    u.username,
    p.post_id,
    p.content
from
    users u
    join posts p on p.user_id = u.user_id
where
    u.hometown = 'Hà Nội'
    order by username desc;