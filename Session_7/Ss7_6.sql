use session_7;

select
    u.name,
    sum(o.total_amount) as total_revenue
from
    customer u,
    orders o
where
    u.customer_id = o.customer_id
group by
    u.name,
    u.customer_id
having
    sum(o.total_amount) > (
        select
            avg(temp)
        from
            (
                select
                    sum(o1.total_amount) as temp
                from
                    orders o1
                group by
                    o1.customer_id
            ) as average_table
    );