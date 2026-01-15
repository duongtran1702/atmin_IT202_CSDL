create database if not exists Ss14_2;
use Ss14_2;

create table products (
    product_id int primary key auto_increment,
    product_name varchar(50),
    price decimal(10,2),
    stock int not null
);

create table orders (
    order_id int primary key auto_increment,
    product_id int,
    quantity int not null,
    total_price decimal(10,2),
    foreign key (product_id) references products(product_id)
);

insert into products (product_name, price, stock) values
('laptop dell', 1500.00, 10),
('iphone 13', 1200.00, 8),
('samsung tv', 800.00, 5),
('airpods pro', 250.00, 20),
('macbook air', 1300.00, 7);

delimiter ~~
create procedure handle_order(p_product_id int, p_quantity int)
begin
	declare stock_temp int;
    start transaction;
    select stock into stock_temp from products where product_id = p_product_id for update;
    
    if stock_temp > p_quantity then 
		insert into orders(product_id,quantity,total_price)
        values (p_product_id, p_quantity, p_quantity * (select price from products where product_id = p_product_id));
        
        update products
        set stock = stock - p_quantity
        where product_id = p_product_id;
        commit;
    else 
		rollback;
    end if;
end ~~
delimiter ;

select * from orders;
select * from products;
call handle_order(1, 2);
select * from orders;
select * from products;
