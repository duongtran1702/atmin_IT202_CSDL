use social_network_pro;

-- 2)Tạo một index có tên idx_user_gender trên cột gender của bảng users:
create index idx_user_gender on users(gender);

-- 3) Tạo một view tên view_user_activity để hiển thị tổng số lượng bài viết và bình luận của mỗi người dùng. Các cột trong view bao gồm: user_id (Mã người dùng), total_posts (Tổng số bài viết), total_comments (Tổng số bình luận).
create or replace view view_user_activity as
select u.user_id, count(distinct p.post_id) as total_posts, count(distinct c.comment_id) as total_comments
from users u
left join posts p on p.user_id = u.user_id
left join comments c on c.user_id = u.user_id
group by u.user_id;

-- 4) Hiển thị lại view trên. 
select * from view_user_activity;

-- 5) Viết truy vấn kết hợp view_user_activity với bảng users để lấy thông tin người dùng:

-- - Điều kiện: total_posts > 5 và total_comments > 20.
-- - Sắp xếp theo total_comments (Tổng số bình luận) giảm dần.
-- - Giới hạn kết quả hiển thị 5 bản ghi đầu tiên.

select u.user_id, u.username, u.gender, v.total_posts, v.total_comments
from users u
join view_user_activity v on v.user_id = u.user_id
where v.total_posts > 5 and v.total_comments > 20
order by v.total_comments desc
limit 5;