DROP DATABASE IF EXISTS RepasoTransacciones;
CREATE DATABASE RepasoTransacciones;
USE RepasoTransacciones;

CREATE TABLE productos (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    stock INT
);

INSERT INTO productos VALUES (1, 'Portátil', 10), (2, 'Ratón', 50);
COMMIT;

grant all privileges on RepasoTransacciones.* to 'Consola1'@'localhost';
grant all privileges on RepasoTransacciones.* to 'Consola2'@'localhost';

Start transaction;
select * from productos;
update productos set stock = 8 where id=1;
select * from productos;
savepoint h1;
select * from productos;
update productos set stock = 40 where id=2;
select * from productos;
rollback to h1;
commit;