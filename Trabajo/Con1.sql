USE banco_PC128;
SET SQL_SAFE_UPDATES = 0;

-- 1

-- Inicia una transacción.
Start Transaction;
savepoint inicio; -- POR SI ACASO
-- Resta 200 € a la cuenta 1.
select * from cuentas where id_cuenta = 1 for update; -- PA VER ANTES
update cuentas set saldo = saldo - 200.00 where id_cuenta = 1;
select * from cuentas where id_cuenta = 1 for update; -- PA VER CON LOS CAMBIOS
-- Suma 200 € a la cuenta 2.
select * from cuentas where id_cuenta = 2 for update;
update cuentas set saldo = saldo + 200.00 where id_cuenta = 2;
select * from cuentas where id_cuenta = 2 for update;
-- Inserta dos movimientos.
INSERT INTO movimientos (id_cuenta, tipo, importe) VALUES (1, 'transferencia_salida', 200.00);
INSERT INTO movimientos (id_cuenta, tipo, importe) VALUES (2, 'transferencia_entrada', 200.00);
-- Consulta el estado de las tablas cuentas y movimientos antes del COMMIT.
select * from cuentas;
select * from movimientos;
commit;

-- 2

-- Inicia una transacción.
Start Transaction;
-- Resta 300 € a la cuenta 1.
select * from cuentas where id_cuenta = 1 for update;
update cuentas set saldo = saldo - 300.00 where id_cuenta = 1;
select * from cuentas where id_cuenta = 1 for update;
-- Suma 300 € a la cuenta 2.
select * from cuentas where id_cuenta = 2 for update;
update cuentas set saldo = saldo + 300.00 where id_cuenta = 2;
select * from cuentas where id_cuenta = 2 for update;
-- Inserta los movimientos correspondientes a la transferencia.
INSERT INTO movimientos (id_cuenta, tipo, importe) VALUES (1, 'transferencia_salida', 200.00);
INSERT INTO movimientos (id_cuenta, tipo, importe) VALUES (2, 'transferencia_entrada', 200.00);
-- Crea un SAVEPOINT.
savepoint s1;
-- Aplica una comisión de 20 € a la cuenta 1.
select * from cuentas where id_cuenta = 1 for update;
update cuentas set saldo = saldo - 20.00 where id_cuenta = 1;
select * from cuentas where id_cuenta = 1 for update;
-- Inserta el movimiento de comisión.
INSERT INTO movimientos (id_cuenta, tipo, importe) VALUES (1, 'comision', 20.00);
-- Consulta el estado de cuentas y movimientos.
SELECT * FROM cuentas;
SELECT * FROM movimientos;
-- Ejecuta ROLLBACK TO SAVEPOINT.
ROLLBACK TO SAVEPOINT s1;
commit;

-- 3

-- Inicia una transacción.
Start Transaction;
-- Bloquea la cuenta 1 para actualización mediante FOR UPDATE.
select * from cuentas where id_cuenta = 1 for update;
-- Ejecuta COMMIT
COMMIT;

-- 4

-- Inicia una transacción.
Start Transaction;
-- Realiza una lectura con bloqueo compartido sobre la cuenta 2.
select * from cuentas where id_cuenta = 2 lock in share mode;
-- Cierra la transacción.
commit;

-- 5

-- Inicia una transacción.
START TRANSACTION;
-- Bloquea la tabla cuentas completa para escritura.
LOCK TABLES cuentas read;
SELECT * FROM cuentas;
-- LIBERAR EL BLOQUEO
commit;

-- Inicia una transacción.
START TRANSACTION;
-- Bloquea la tabla cuentas completa para lectura.
LOCK TABLES cuentas read;
SELECT * FROM cuentas;
-- LIBERAR EL BLOQUEO
commit;