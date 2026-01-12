use social_network_pro;

delimiter ##
create procedure CalculateUserActivityScore(p_user_id int,out activity_score int, out activity_level varchar(50))
begin
	declare total_posts int;
    declare total_likes int;
    declare total_comments int;
	select 
		count(distinct p.post_id),
		count(distinct l.user_id),
		count(distinct c.comment_id)  
	into total_posts, total_likes, total_comments
    from posts p 
		left join likes l on l.post_id = p.post_id 
		left join comments c on c.post_id = p. post_id
    where p.user_id = p_user_id
    group by p.user_id;
    
    set activity_score = total_posts * 10 + total_likes * 3 + total_comments * 5;
    if activity_score > 500 then set  activity_level = 'Rất tích cực';
    elseif activity_score >200 then set activity_level = 'Tích cực';
    else set activity_level = 'Bình thường';
    end if;
end ##
delimiter ;

call CalculateUserActivityScore(3, @score, @level);
select @score, @level;

drop procedure if exists CalculateUserActivityScore;
 
