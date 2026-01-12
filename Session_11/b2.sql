use social_network_pro;

delimiter ~~ create procedure CalculatePostLikes(p_post_id int, out total_likes int) begin
select
    count(l.user_id) into total_likes
from
    likes l
where
    post_id = p_post_id;

end ~~ delimiter;

call CalculatePostLikes(101, @total);

select
    @total;

drop procedure if exists CalculatePostLikes;