create database Session3_bai3;

use Session3_bai3;

CREATE TABLE Subject (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credits INT CHECK (credits > 0)
);

insert into
    Subject (subject_name, credits)
values
    ('Math', 3),
    ('ENG', 2),
    ('PHY', 4),
    ('CHEM', 3),
    ('BIO', 2);

UPDATE
    Subject
SET
    credits = 1
WHERE
    subject_id > 3;

UPDATE
    Subject
SET
    subject_name = 'Physical'
WHERE
    subject_name = 'PHY';

select
    *
from
    Subject;