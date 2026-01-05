use Ss6_1;

insert into
    order_items(order_id, product_id, quantity)
values
    (10, 1, 2),
    (10, 3, 1),
    (11, 2, 1),
    (11, 4, 2),
    (12, 5, 1),
    (12, 6, 1),
    (13, 7, 2),
    (13, 8, 1),
    (14, 1, 1),
    (14, 2, 2),
    (15, 3, 1),
    (15, 5, 2);

select
    p.product_name,
    sum(oi.quantity) as total_items_sold,
    sum(oi.quantity * p.price) as total_revenue,
    round(sum(oi.quantity * p.price) / sum(oi.quantity), 2) as average_revenue_per_order
from
    order_items oi
    join product p on p.product_id = oi.product_id
group by
    oi.product_id,
    p.product_name
having
    sum(oi.quantity) >= 3
order by
    sum(oi.quantity * p.price) desc
limit
    5;