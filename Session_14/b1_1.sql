create database if not exists Ss14_1;
use Ss14_1;


create table accounts(
	account_id int primary key auto_increment,
    account_name varchar(50) ,
    balance decimal(10,2)
);

insert into accounts (account_name, balance) values 
('Nguyễn Văn An', 1000.00),
('Trần Thị Bảy', 500.00);

delimiter ~~
create procedure transfer_money(from_account int,to_account int,amount int)
begin
	declare from_balance decimal(10,2);

    start transaction;

    select balance into from_balance
    FROM accounts
    where account_id = from_account
    for update;

    if from_balance >= amount then
        
        update accounts
        set balance = balance - amount
        where account_id = from_account;

        
        update accounts
        set balance = balance + amount
        where account_id = to_account;

        commit;
    else
        rollback;
	end if;
end~~
delimiter ;

select * from accounts;
call transfer_money(1,2,300);
select * from accounts;