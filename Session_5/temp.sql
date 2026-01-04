-- Sample data setup (for local testing)
if object_id('Weather', 'U') is not null drop table Weather;

create table Weather(   
	id int primary key,
	recordDate date,
	temperature int
);

insert into Weather(id, recordDate, temperature) values
 (1, '2015-01-01', 10),
 (2, '2015-01-02', 25),
 (3, '2015-01-03', 20),
 (4, '2015-01-04', 30);

-- Rising Temperature solution (SQL Server)
select w1.id
from Weather w1
join Weather w2
	on w1.recordDate = dateadd(day, 1, w2.recordDate)
 where w1.temperature > w2.temperature;
