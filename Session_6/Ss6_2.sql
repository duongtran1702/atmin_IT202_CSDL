use Ss6_1;

alter table
    Orders
add
    column total_amount decimal(10, 2) check (total_amount >= 0);

update
    orders
set
    total_amount = case
        when status = 'completed' then floor(500000 + rand() * 1500000)
        when status = 'pending' then floor(100000 + rand() * 400000)
        when status = 'cancelled' then 0
        else 0
    end;

select
    u.customer_id,
    u.customer_name,
    (sum(total_amount)) as total_spent
from
    Orders o
    join Customer u on u.customer_id = o.customer_id
where
    o.status = 'completed'
group by
    u.customer_id,
    u.customer_name;

select
    u.customer_id,
    u.customer_name,
    o.total_amount as highest_order,
    o.order_date
from
    Orders o
    join Customer u on u.customer_id = o.customer_id
where
    o.status = 'completed'
    and o.total_amount = (
        select
            (max(total_amount))
        from
            Orders o1
        where
            o1.customer_id = u.customer_id
            and o1.status = 'completed'
    )
    
select
    u.customer_id,
    u.customer_name,
    (sum(total_amount)) as total_spent
from
    Orders o
    join Customer u on u.customer_id = o.customer_id
where
    o.status = 'completed'
group by
    u.customer_id,
    u.customer_name
order by
    total_spent desc;