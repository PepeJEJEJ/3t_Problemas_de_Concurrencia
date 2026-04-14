USE banco_PC128;
SET SQL_SAFE_UPDATES = 1;

select * from cuentas;
select * from movimientos;

-- Intenta actualizar esa misma fila.
update cuentas set saldo = saldo - 200.00 where id_cuenta = 1;
-- Realiza también una lectura con bloqueo compartido sobre esa misma fila.
select * from cuentas where id_cuenta = 2 lock in share mode;

-- Después intenta modificarla.
update cuentas set saldo = saldo - 1.0 where id_cuenta = 2;

-- Intenta ejecutar un SELECT.
SELECT * FROM cuentas;
-- Intenta ejecutar un UPDATE.
UPDATE cuentas SET saldo = saldo - 1.0;
-- Observa qué operaciones se bloquean.
