use Ss6_1;

select
    u.customer_name,
    count(o.order_id) as total_orders,
    sum(o.total_amount) as total_revenue,
    round(avg(o.total_amount), 2) as average_order_value
from
    Orders o
    join Customer u on u.customer_id = o.customer_id
group by
    u.customer_id,
    u.customer_name;

select
    u.customer_name,
    count(o.order_id) as total_orders,
    sum(o.total_amount) as total_revenue,
    round(avg(o.total_amount), 2) as average_order_value
from
    Orders o
    join Customer u on u.customer_id = o.customer_id
group by
    u.customer_id,
    u.customer_name
having
    sum(o.total_amount) > 5000000
    and count(o.order_id) >= 3;

select
    u.customer_name,
    count(o.order_id) as total_orders,
    sum(o.total_amount) as total_revenue,
    round(avg(o.total_amount), 2) as average_order_value
from
    Orders o
    join Customer u on u.customer_id = o.customer_id
group by
    u.customer_id,
    u.customer_name
having
    sum(o.total_amount) > 5000000
    and count(o.order_id) >= 3
order by
    sum(o.total_amount) desc;