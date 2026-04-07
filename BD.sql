 drop database if exists Cine;
 create database Cine;
 use Cine;
 
 -- create user 'block_prueba'@'localhost' identified by 'medac';
 -- grant all privileges on cine.* to 'block_prueba'@'localhost';
 
 create table sesiones (
 id int primary key,
 pelicula varchar(100),
 asientos_disponibles int
 );
 
 insert into sesiones values (1, 'Torrente', 10);