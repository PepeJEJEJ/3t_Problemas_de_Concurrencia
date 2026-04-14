USE banco_PC128;
SET SQL_SAFE_UPDATES = 0;

-- Inicia una transacción.
Start Transaction;
savepoint inicio; -- POR SI ACASO
-- Resta 200 € a la cuenta 1.
select * from cuentas where id_cuenta = 1 for update;
update cuentas set saldo = saldo - 200.00 where id_cuenta = 1;
select * from cuentas where id_cuenta = 1 for update;
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