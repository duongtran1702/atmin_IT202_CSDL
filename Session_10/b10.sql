use social_network_pro;

-- 2
create index idx_user_username on users(username);

-- 3
create or replace view view_user_activity_2 as
select u.user_id, count(distinct p.post_id) as total_posts, count(distinct f.friend_id) as total_friends
from users u
left join posts p on p.user_id = u.user_id
left join friends f on f.user_id = u.user_id and f.status = 'accepted'
group by u.user_id;

-- 4
select * from view_user_activity_2;

-- 5
select
    u.full_name,
    v.total_posts,
    v.total_friends,

    case
        when v.total_friends > 5 then 'Nhiều bạn bè'
        when v.total_friends between 2 and 5 then 'Vừa đủ bạn bè'
        else 'Ít bạn bè'
    end as friend_description,

    case
        when v.total_posts > 10 then v.total_posts * 1.1
        when v.total_posts between 5 and 10 then v.total_posts
        else v.total_posts * 0.9
    end as post_activity_score

from users u
join view_user_activity_2 v 
    on v.user_id = u.user_id
where v.total_posts > 0
order by v.total_posts desc;