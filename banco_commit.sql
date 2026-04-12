drop database if exists banco;
create database banco;
use banco;
-- CREAR LA BD
create table cuentas(
	id int primary key,
	titular varchar(50),
    saldo decimal(10,2)
);
-- CREAR LA TABLA
insert into cuentas values (1,'Ana', 100.00);
insert into cuentas values (1,'Luis', 200.00);
-- PONERLE DATOS

grant all privileges on banco.* to 'block_prueba'@'localhost';
-- PRIVILEGIOS AL USUARIO
start transaction;
-- INICIAR TRANSACCION
select * from cuentas;
update cuentas set saldo = saldo - 100 where id = 1;
-- MENOS SALDO
update cuentas set saldo = saldo + 100 where id = 1;
-- MAS SALDO
start transaction;
-- EMPEZAR OTRA TRANSACCION
update cuentas set saldo = 2000;
-- ALTERAR EL VALOR DEL SALDO
select * from cuentas;
-- VER LOS DATOS
savepoint sp1;-- PUNTO DE GUARDADO
update cuentas set saldo = saldo - 100 where id = 1;
-- Actualizar pa ir al savepoint



rollback;

