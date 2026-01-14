create database Ss13_1;
use Ss13_1;

-- Create users table
create table users (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL UNIQUE,
	email VARCHAR(100) NOT NULL UNIQUE,
	created_at DATE,
	follower_count INT DEFAULT 0,
	post_count INT DEFAULT 0
);

-- Create posts table
create table posts (
	post_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	content TEXT,
	created_at DATETIME,
	like_count INT DEFAULT 0,
	CONSTRAINT fk_posts_user
		FOREIGN KEY (user_id) REFERENCES users(user_id)
		ON DELETE CASCADE
);

-- Sample data
insert into users (username, email, created_at) VALUES
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

-- Trigger AFTER INSERT trên posts: Khi thêm bài đăng mới, tăng post_count của người dùng tương ứng lên 1.
delimiter ~~
create trigger after_insert_post
after insert on posts
for each row
begin
	update users 
    set post_count = post_count + 1
    where user_id = new.user_id;
end~~
delimiter ;

-- Trigger AFTER DELETE trên posts: Khi xóa bài đăng, giảm post_count của người dùng tương ứng đi 1.
delimiter ~~
create trigger after_delete_post
after delete on posts
for each row
begin
	update users 
    set post_count = case when post_count > 0 then post_count - 1
    else 0
    end
    where user_id = old.user_id;
end~~
delimiter ;

select * from users;

insert into posts (user_id, content, created_at) VALUES

(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),

(1, 'Second post by Alice', '2025-01-10 12:00:00'),

(2, 'Bob first post', '2025-01-11 09:00:00'),

(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

select * from users;

delete from posts where post_id = 2;
select * from users;
