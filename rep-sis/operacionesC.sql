CREATE DATABASE LINK db_link_C_to_A
CONNECT TO TEST IDENTIFIED BY test
USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.23.0.4)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=XE)))';

create table sucursal
   (idsucursal		varchar(5),
    nombresucursal	varchar(15),
    ciudadsucursal     varchar(15),
    activos 		number,
    region varchar(2),
    primary key(idsucursal));


create table prestamo
   (noprestamo 	varchar(15),
    idsucursal	varchar(5),
    cantidad 	number,
    primary key(noprestamo));
    
CREATE TABLE branch_region_a AS 
SELECT * FROM sucursal;

CREATE TABLE loan_region_a AS 
SELECT * FROM prestamo;

CREATE TABLE branch_region_b AS 
SELECT * FROM sucursal;

CREATE TABLE loan_region_b AS 
SELECT * FROM prestamo;