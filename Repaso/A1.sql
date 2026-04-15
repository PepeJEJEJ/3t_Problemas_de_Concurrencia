USE RepasoTransacciones;

select * from productos;

start transaction;
select * from productos where id=1 for update;
update productos set stock = 20 where id=1;
commit;

START TRANSACTION;
SELECT * FROM productos WHERE id = 2 LOCK IN SHARE MODE;
COMMIT;