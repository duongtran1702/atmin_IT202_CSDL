use session_7;
select * from customer;
select * from orders;
select * from product;
select * from order_items;

-- ver 1.1 
select
    u.name,
    sum(o.total_amount) as revenue
from
    customer u
    join orders o on u.customer_id = o.customer_id
group by
    u.customer_id,
    u.name
having
    sum(o.total_amount) >= all(
        select
            sum(o.total_amount) as revenue
        from
            orders o
        group by
            o.customer_id
    );
-- ver 1.2 
select
    u.name,
    sum(o.total_amount) as revenue
from
    customer u
    join orders o on u.customer_id = o.customer_id
group by
    u.customer_id,
    u.name
having
    sum(o.total_amount) >= (
        select
            max(revenue)
        from
            (
                select
                    sum(o.total_amount) as revenue
                from
                    orders o
                group by
                    o.customer_id
            ) as revenue_table
    );