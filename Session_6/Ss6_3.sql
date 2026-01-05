use Ss6_1;

insert into
    Orders (customer_id, order_date, status, total_amount)
values
    -- 2023-01-10
    (1, '2023-01-10', 'completed', 1500000),
    (2, '2023-01-10', 'pending', 2100000),
    -- 2023-01-11
    (2, '2023-01-11', 'completed', 1800000),
    (3, '2023-01-11', 'completed', 2500000),
    -- 2023-01-12
    (1, '2023-01-12', 'completed', 3000000),
    (4, '2023-01-12', 'pending', 1200000),
    -- 2023-01-13
    (3, '2023-01-13', 'cancelled', 0),
    (5, '2023-01-13', 'completed', 1750000),
    -- 2023-01-14
    (4, '2023-01-14', 'completed', 2200000),
    (1, '2023-01-14', 'completed', 1950000),
    -- 2023-01-15
    (3, '2023-01-15', 'pending', 1300000),
    (2, '2023-01-15', 'completed', 2600000),
    -- 2023-01-16
    (2, '2023-01-16', 'completed', 3100000),
    (5, '2023-01-16', 'completed', 1450000),
    -- 2023-01-17
    (5, '2023-01-17', 'completed', 2000000),
    (4, '2023-01-17', 'completed', 2750000),
    -- 2023-01-18
    (4, '2023-01-18', 'cancelled', 0),
    (3, '2023-01-18', 'pending', 1250000),
    -- 2023-01-19
    (5, '2023-01-19', 'pending', 1350000),
    (1, '2023-01-19', 'completed', 2400000),
    -- 2023-01-20
    (1, '2023-01-20', 'completed', 3300000),
    (2, '2023-01-20', 'completed', 1900000);

-- select
--     *
-- from
--     Orders;
select
    o.order_date,
    sum(total_amount) as daily_revenue
from
    Orders o
group by
    o.order_date
order by
    o.order_date;

select
    o.order_date,
    count(order_id) as total_orders
from
    Orders o
group by
    o.order_date
order by
    o.order_date;

select
    o.order_date,
    sum(total_amount) as daily_revenue
from
    Orders o
group by
    o.order_date
having
    sum(total_amount) > 6000000
order by
    o.order_date;