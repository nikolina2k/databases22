CREATE TABLE account (
    username VARCHAR(45) PRIMARY KEY,
    fullname VARCHAR(45),
    balance INT,
    group_id INT
);
 
INSERT INTO account (username, fullname, balance, group_id)
VALUES 
('jones', 'Alice Jones', 82, 1),
('bitdiddl', 'Ben Bitdiddle', 65, 1),
('mike', 'Michael Dole', 73, 2),
('alyssa', 'Alyssa P. Hacker', 79, 3),
('bbrown', 'Bob Brown', 100, 3 );


-- READ COMMITTED

-- transaction in the first session will not read `ajones` but `jones`
-- After the second step, the second terminal would wait until the first one commits changes and only then would consider the information

-- terminal 1
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT * FROM account;
SELECT * FROM account;
SELECT * FROM account;
UPDATE account SET balance = balance + 10 WHERE fullname = 'Alice Jones';   
COMMIT;                                                                     

-- terminal 2
BEGIN ISOLATION LEVEL READ COMMITTED; 
UPDATE account SET username = 'ajones' WHERE fullname = 'Alice Jones';
SELECT * FROM account;
COMMIT;

SELECT * FROM account;
BEGIN ISOLATION LEVEL READ COMMITTED;
UPDATE account SET balance = balance + 20 WHERE fullname = 'Alice Jones';
ROLLBACK;

 

-- REPEATABLE READ

-- Terminal 1 will not see changes. 
-- ERROR: could not serialize access due to concurrent update - such error tells us that the UPDATE statement was issued along with another UPDATE statement on the same row simultaneously.

-- terminal 1
BEGIN ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM account;
SELECT * FROM account;
SELECT * FROM account;
UPDATE account SET balance = balance + 10 WHERE fullname = 'Alice Jones';
COMMIT;

-- terminal 2 
BEGIN ISOLATION LEVEL REPEATABLE READ;
UPDATE account SET username = 'ajones' WHERE fullname = 'Alice Jones';
SELECT * FROM account;
COMMIT;
SELECT * FROM account;
BEGIN ISOLATION LEVEL REPEATABLE READ
UPDATE account SET balance = balance + 20 WHERE fullname = 'Alice Jones';
ROLLBACK;


-- part II

-- READ COMMIT

-- After both terminals commit, Mike's balance will increase by 15 and Bob's group will be changed to 2.
-- Bob's balance will not increase, since all updates were made before commit.

-- terminal 1
BEGIN ISOLATION LEVEL READ COMMITTED; 
SELECT * FROM account WHERE group_id = 2; 
SELECT * FROM account WHERE group_id = 2; 
UPDATE account SET balance = balance + 15 WHERE group_id = 2; 
COMMIT; 

-- terminal 2
BEGIN ISOLATION LEVEL READ COMMITTED;
UPDATE account SET group_id = 2 WHERE fullname = 'Bob Brown' 
COMMIT;

-- REPEATABLE READ

-- After both terminals commit, Mike's balance will increase by 15 and Bob's group will be changed to 2.
-- However,
-- Bob's balance will not increase even if terminal 2 is commited before update in terminal 1,
-- since the information cannot change with repeatable read isolation level is used.

-- terminal 1
BEGIN ISOLATION LEVEL REPEATABLE READ; 
SELECT * FROM account WHERE group_id = 2; 
SELECT * FROM account WHERE group_id = 2; 
UPDATE account SET balance = balance + 15 WHERE group_id = 2; 
commit;

-- terminal 2
BEGIN ISOLATION LEVEL REPEATABLE READ; 
UPDATE account SET group_id = 2 WHERE fullname = 'Bob Brown' 
COMMIT;