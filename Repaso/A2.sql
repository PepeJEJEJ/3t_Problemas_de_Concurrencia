USE RepasoTransacciones;

select * from productos;

start transaction;
update productos set stock = 0 where id=1;
commit;

SELECT * FROM productos WHERE id = 2;

update productos set stock = 10 where id=2;