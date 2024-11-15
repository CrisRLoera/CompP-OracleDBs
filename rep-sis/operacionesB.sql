-- Operación 0

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

insert into sucursal	values ('S0005', 'Round Hill',	'Horseneck',	8000000, 'B');
insert into sucursal	values ('S0006', 'Pownal',		'Bennington',	 400000, 'B');
insert into sucursal	values ('S0007', 'North Town',	'Rye',		3700000, 'B');
insert into sucursal	values ('S0008', 'Brighton',		'Brooklyn',		7000000, 'B');
insert into sucursal	values ('S0009', 'Central',		'Rye',		 400280, 'B');

insert into prestamo	values ('L-11',		'S0005',	900);
insert into prestamo	values ('L-20',		'S0007',	7500);
insert into prestamo	values ('L-21',		'S0009',	570);

-- Operación 3
CREATE DATABASE LINK db_link_B_to_A
CONNECT TO TEST IDENTIFIED BY test
USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.23.0.4)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=XE)))';

CREATE DATABASE LINK db_link_B_to_C
CONNECT TO TEST IDENTIFIED BY test
USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.23.0.3)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=XE)))';

-- Operación 4

CREATE TABLE branch_region_b AS 
SELECT * FROM sucursal WHERE region = 'B';

CREATE TABLE loan_region_b AS 
SELECT * FROM prestamo 
WHERE idsucursal IN (SELECT idsucursal FROM branch_region_b);

-- Operación 6

CREATE VIEW global_branch AS 
SELECT * FROM branch_region_a@db_link_B_to_A
UNION ALL 
SELECT * FROM branch_region_b;

CREATE VIEW global_loan AS 
SELECT * FROM loan_region_a@db_link_B_to_A
UNION ALL 
SELECT * FROM loan_region_b;

-- Operación 7

CREATE SYNONYM branch_a FOR branch_region_a@db_link_B_to_A;
CREATE SYNONYM loan_a FOR loan_region_a@db_link_B_to_A;

-- Operación 8

CREATE OR REPLACE PROCEDURE add_branch (idsucursal VARCHAR, nombresucursal VARCHAR, ciudadsucursal VARCHAR, activos NUMBER, region CHAR) AS
BEGIN
    IF region = 'A' THEN
        INSERT INTO branch_region_a@db_link_B_to_A VALUES (idsucursal, nombresucursal, ciudadsucursal, activos, region);
    ELSE
        INSERT INTO branch_region_b VALUES (idsucursal, nombresucursal, ciudadsucursal, activos, region);
    END IF;
END;

-- Operación 9

CREATE OR REPLACE PROCEDURE add_loan (noprestamo VARCHAR, idsucursal VARCHAR, cantidad NUMBER) AS
    branch_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO branch_exists
    FROM branch_region_b
    WHERE idsucursal = add_loan.idsucursal;

    IF branch_exists > 0 THEN
        INSERT INTO loan_region_a@db_link_B_to_A VALUES (noprestamo, idsucursal, cantidad);
    ELSE
        INSERT INTO loan_region_b VALUES (noprestamo, idsucursal, cantidad);
    END IF;
END;

-- Operación 10

CREATE OR REPLACE TRIGGER branch_replication
AFTER INSERT ON branch_region_b
FOR EACH ROW
BEGIN
    INSERT INTO branch_region_b@db_link_B_to_C VALUES (:new.idsucursal, :new.nombresucursal, :new.ciudadsucursal, :new.activos, :new.region);
END;

-- Operación 12

CREATE MATERIALIZED VIEW loan_global_view
REFRESH COMPLETE ON DEMAND
AS SELECT * FROM global_loan;




