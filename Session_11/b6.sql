use social_network_pro;

delimiter ~~ 
create procedure NotifyFriendsOnNewPost(p_user_id int, p_content varchar(255)) 
begin

insert into
    posts(user_id, content)
values
    (p_user_id, p_content);

insert into notifications(user_id,type,content,is_read,created_at)
select case when f.user_id = p_user_id then f.friend_id
			else f.user_id
		end as user_id,
        'new_post',
        'Bạn của bạn vừa đăng bài mới',
        0,
        now()
    from friends f
    where f.status = 'accepted'
    and (f.user_id = p_user_id OR f.friend_id = p_user_id);
    
end ~~ delimiter ;

call NotifyFriendsOnNewPost(1, 'Hello mọi người');
drop procedure if exists NotifyFriendsOnNewPost;


