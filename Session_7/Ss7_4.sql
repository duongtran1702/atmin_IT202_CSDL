use session_7;

select
    customer_id,
    name,
    (
        select
            count(customer_id)
        from
            orders o
        where
            u.customer_id = o.customer_id
    ) as total_orders
from
    customer u;