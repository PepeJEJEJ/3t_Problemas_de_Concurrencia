use repaso;

select * from personas where id = 1;
update personas set sueldo = sueldo - 20.00 where id = 1;
update personas set sueldo = sueldo - 1.0 where id = 2;
select * from personas where id = 1;
select * from personas where id = 2;
update personas set sueldo = sueldo + 1.0 where id = 2;
UPDATE personas SET sueldo = sueldo - 1 WHERE id = 1;