use social_network_pro;

select
    *
from
    users;

create view view_user_activity_status as
select
    u.user_id,
    u.username,
    u.gender,
    u.created_at,
    case
        when count(p.user_id) >= 1 then "active"
        else "inactive"
    end as status
from
    users u
    left join posts p ON u.user_id = p.user_id
group by
    u.user_id,
    u.username,
    u.gender,
    u.created_at;

select
    *
from
    view_user_activity_status;

select
    v.status,
    count(v.user_id) as count_acc
from
    view_user_activity_status v
group by
    v.status
order by
    count_acc desc;