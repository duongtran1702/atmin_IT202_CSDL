use social_network_pro;

-- 2) Tạo một view tên view_user_post hiển thị danh sách các User với các cột: user_id(mã người dùng) và total_user_post (Tổng số bài viết mà từng người dùng đã đăng).
create view view_user_post as
select
    u.user_id,
    count(p.post_id) as total_user_post
from
    users u
    join posts p on u.user_id = p.user_id
group by
    u.user_id;

-- 3) Tiến hành hiển thị lại view_user_post để kiểm chứng
select
    *
from
    view_user_post;

-- 4) Kết hợp view view_user_post với bảng users để hiển thị các cột: full_name(họ tên) và  total_user_post (Tổng số bài viết mà từng người dùng đã đăng).
select
    u.full_name,
    v_p.total_user_post
from
    users u
    join view_user_post v_p on u.user_id = v_p.user_id;