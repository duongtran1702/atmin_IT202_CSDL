use social_network_pro;

delimiter @@ 
create procedure CreatePostWithValidation(p_user_id int, p_content varchar(255)) 
begin declare noti varchar(255);

if char_length(p_content) < 5 then
set
    noti = "Nội dung quá ngắn";

else
set
    noti = "Thêm bài viết thành công";

end if;

select
    noti;

end @@ 
delimiter ;

call CreatePostWithValidation(1, 'Hi');

call CreatePostWithValidation(1, 'Hello world');

drop procedure if exists CreatePostWithValidation;

