use session_7;

select
    u.name,
    sum(o.total_amount) as revenue
from
    customer u,
    orders o
where
    u.customer_id = o.customer_id
group by
    u.customer_id,
    u.name
having
    sum(o.total_amount) >=(
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