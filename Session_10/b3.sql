use social_network_pro;

EXPLAIN ANALYZE
select * from users u 
where u.hometown = 'Hà Nội';

create index idx_hometown
on users(hometown);

EXPLAIN ANALYZE
select * from users u 
where u.hometown = 'Hà Nội';

-- Chi phí ước lượng giảm nhiều nhưng thời gian chạy có lâu hơn một chút k đáng kể

drop index idx_hometown on users;
