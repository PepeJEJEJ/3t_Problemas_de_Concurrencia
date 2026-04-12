drop database if exists tienda_bloqueo;
create database tienda_bloqueo;
use tienda_bloqueo;

create table productos(
	id int primary key,
    nombre varchar(100),
    stock int
);

insert into productos values
(1,'Teclado',10),
(2,'Raton',20),
(3,'Teclado',5);

-- nivel 1 de bloqueo (tabla)
-- SI UNA SCONSOLA BLOQUEA UNA TABLA, LA OTRA NO SE PUEDE TRABAJAR HASTA QUE SE LIBERE

start transaction;
lock tables productos write;
select * from productos;
unlock tables;
select * from productos;

update productos set stock = stock - 1 where id = 1;

-- 2. nivel 2 bloqueo de fila
-- LA BD NO SE BLOQUEA DEL TODO, SOLO UNA FILA,  SI BLOQUEAS 1 FILA, NO SE PUEDE ALTERAR, PERO LA OTRA SI SE PUEDE ALTERAR
start transaction;
update productos set stock= stock - 1 WHERE id = 2;
commit;

-- 3  nivel 3 bloqueo compartido
-- BLOQUEA UNA FILA PARA LECTURA, LAS DEMAS LINEAS SI PUEDEN LEER LA LINEA BLOQUEADA, PERO LA BLOQUEADA, NO PUEDE SER MODIFICADA
START TRANSACTION;
SELECT * FROM productos 
WHERE id = 1 
LOCK IN SHARE MODE;
COMMIT;
