use social_network_pro;

delimiter $$
create procedure CalculateBonusPoints(p_user_id int, inout p_bonus_points int) begin declare temp int;

select
    count(p.post_id) into temp
from
    posts p
where
    p.user_id = p_user_id;

if temp > 20 then
set
    p_bonus_points = p_bonus_points + 100;

elseif temp > 10 then
set
    p_bonus_points = p_bonus_points + 50;

end if;

end $$
delimiter ;

set
    @point = 100;

call CalculateBonusPoints(4, @point);

select
    @point;
    
drop procedure if exists CalculateBonusPoints;