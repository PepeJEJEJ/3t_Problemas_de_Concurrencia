drop database if exists repaso;
create database repaso;
use repaso;
SET SQL_SAFE_UPDATES = 0;

create table personas(
	id int primary key,
	nombre varchar(50),
    sueldo decimal(10,2)
);

insert into personas values (1,'Jose', 100.00);
insert into personas values (2,'Juan', 200.00);


-- create user 'prueba'@'localhost' identified by '123';
-- grant all privileges on repaso.* to 'prueba'@'localhost';

start transaction;
savepoint inicio;
savepoint pt1;
select * from personas where id = 1;
update personas set sueldo = sueldo - 20.00;
select * from personas where id = 1;
update personas set sueldo = sueldo + 30.00;
select * from personas where id = 1;
rollback to pt1;
select * from personas where id = 1;
rollback to inicio;
commit;

start transaction;
SELECT * FROM personas WHERE id = 1 FOR UPDATE;
UPDATE personas SET sueldo = sueldo - 1 WHERE id = 1;

start transaction;
lock tables personas write; 
SELECT * FROM personas;
UNLOCK TABLES;
COMMIT;

START TRANSACTION;
SELECT * FROM personas 
WHERE id = 1 
LOCK IN SHARE MODE;