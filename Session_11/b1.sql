use social_network_pro;

delimiter ~~ create procedure getUserById(id_in int) begin
select
    post_id,
    content,
    created_at
from
    posts
where
    user_id = id_in;

end ~~ delimiter;

call getUserById(1);

drop procedure getUserById;