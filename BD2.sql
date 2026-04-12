drop database if exists Banco;
create database Banco;
use Banco;

create table cuentas(
	id int primary key,
    titular varchar(100),
    saldo decimal(10,2)
);

insert into cuentas values (1,'Ana',1000.00);
insert into cuentas values (2,'Luis',500.00);

start transaction;
select * from cuentas;
update cuentas set saldo = saldo - 100 where id = 1;
-- MENOS SALDO
update cuentas set saldo = saldo + 100 where id = 2;
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
ROLLBACK TO sp1;
-- IR AL SAVEPOINT
