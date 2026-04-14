DROP DATABASE IF EXISTS banco_PC128;
CREATE DATABASE banco_PC128;
USE banco_PC128;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE cuentas (
id_cuenta INT PRIMARY KEY,
titular VARCHAR(100) NOT NULL,
saldo DECIMAL(10,2) NOT NULL
) ;

CREATE TABLE movimientos (
id_mov INT AUTO_INCREMENT PRIMARY KEY,
id_cuenta INT NOT NULL,
tipo VARCHAR(30) NOT NULL,
importe DECIMAL(10,2) NOT NULL,
fecha_mov TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta)
) ;

INSERT INTO cuentas (id_cuenta, titular, saldo) VALUES
(1, 'PC128', 1000.00),
(2, 'Daniel', 1000.00),
(3, 'Carlos', 1500.00);

SELECT * FROM cuentas;

create user 'Consola1'@'localhost' identified by '1';
grant all privileges on banco_PC128.* to 'Consola1'@'localhost';
create user 'Consola2'@'localhost' identified by '1';
grant all privileges on banco_PC128.* to 'Consola2'@'localhost';