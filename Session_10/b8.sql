use social_network_pro;

--  Tạo một index idx_user_gender trên cột gender của bảng users.
create index idx_user_gender on users(gender);

-- (sử dụng JOIN giữa posts, users, likes, comments; GROUP BY post_id).
create
or replace view view_popular_posts as
select
    p.post_id,
    u.username,
    p.content,
    count(distinct l.user_id) as total_likes,
    count(distinct c.comment_id) as total_comments
from
    posts p
    join users u on u.user_id = p.user_id
    left join likes l on l.post_id = p.post_id
    left join comments c on c.post_id = p.post_id
group by
    p.post_id,
    u.username,
    p.content;

select
    *
from
    view_popular_posts;

select
    *
from
    view_popular_posts v
where
    v.total_likes + v.total_comments > 10
order by
    v.total_likes + v.total_comments desc;