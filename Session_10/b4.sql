use social_network_pro;

EXPLAIN ANALYZE
select
    *
from
    posts
where
    created_at >= "2026-01-01"
    and created_at < "2027-01-01"
    and user_id = 1;

create index idx_created_at_user_id on posts(user_id, created_at);

EXPLAIN ANALYZE
select
    *
from
    posts
where
    created_at >= "2026-01-01"
    and created_at < "2027-01-01"
    and user_id = 1;

EXPLAIN ANALYZE
select
    u.user_id,
    u.username,
    u.email
from
    users u
where
    u.email = 'an@gmail.com';

create index idx_email on users(email);

EXPLAIN ANALYZE
select
    u.user_id,
    u.username,
    u.email
from
    users u
where
    u.email = 'an@gmail.com';

drop index idx_created_at_user_id on posts;

drop index idx_email on users;