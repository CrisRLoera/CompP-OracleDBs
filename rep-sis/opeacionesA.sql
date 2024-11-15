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

insert into sucursal	values ('S0001', 'Downtown',		'Brooklyn',	 	900000, 'A');
insert into sucursal	values ('S0002', 'Redwood',		'Palo Alto',	2100000, 'A');
insert into sucursal	values ('S0003', 'Perryridge',	'Horseneck',	1700000, 'A');
insert into sucursal	values ('S0004', 'Mianus',		'Horseneck',	 400200, 'A' );

insert into prestamo	values ('L-17',		'S0001',	1000);
insert into prestamo	values ('L-23',		'S0002',	2000);
insert into prestamo	values ('L-15',		'S0003',	1500);
insert into prestamo	values ('L-14',		'S0001',	1500);
insert into prestamo	values ('L-93',		'S0004',	500);
insert into prestamo	values ('L-16',		'S0003',	1300);

-- Operación 3

CREATE DATABASE LINK db_link_A_to_C
CONNECT TO TEST IDENTIFIED BY test
USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.23.0.3)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=XE)))';

CREATE DATABASE LINK db_link_A_to_B
CONNECT TO TEST IDENTIFIED BY test
USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.23.0.2)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=XE)))';

-- Operación 4 

CREATE TABLE branch_region_a AS 
SELECT * FROM sucursal WHERE region = 'A';

CREATE TABLE loan_region_a AS 
SELECT * FROM prestamo 
WHERE idsucursal IN (SELECT idsucursal FROM branch_region_a);

-- Operación 6

CREATE VIEW global_branch AS 
SELECT * FROM branch_region_a
UNION ALL 
SELECT * FROM branch_region_b@db_link_A_to_B;

CREATE VIEW global_loan AS 
SELECT * FROM loan_region_a
UNION ALL 
SELECT * FROM loan_region_b@db_link_A_to_B;

-- Operación 7

CREATE SYNONYM branch_b FOR branch_region_b@db_link_A_to_B;
CREATE SYNONYM loan_b FOR loan_region_b@db_link_A_to_B;

-- Operación 8

CREATE OR REPLACE PROCEDURE add_branch (idsucursal VARCHAR, nombresucursal VARCHAR, ciudadsucursal VARCHAR, activos NUMBER, region CHAR) AS
BEGIN
    IF region = 'A' THEN
        INSERT INTO branch_region_a VALUES (idsucursal, nombresucursal, ciudadsucursal, activos, region);
    ELSE
        INSERT INTO branch_region_b@db_link_A_to_B VALUES (idsucursal, nombresucursal, ciudadsucursal, activos, region);
    END IF;
END;

-- Operación 9

CREATE OR REPLACE PROCEDURE add_loan (noprestamo VARCHAR, idsucursal VARCHAR, cantidad NUMBER) AS
    branch_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO branch_exists
    FROM branch_region_a
    WHERE idsucursal = add_loan.idsucursal;

    IF branch_exists > 0 THEN
        INSERT INTO loan_region_a VALUES (noprestamo, idsucursal, cantidad);
    ELSE
        INSERT INTO loan_region_b@db_link_A_to_B VALUES (noprestamo, idsucursal, cantidad);
    END IF;
END;

-- Operación 10

CREATE OR REPLACE TRIGGER branch_replication
AFTER INSERT ON branch_region_a
FOR EACH ROW
BEGIN
    INSERT INTO branch_region_a@db_link_A_to_C VALUES (:new.idsucursal, :new.nombresucursal, :new.ciudadsucursal, :new.activos, :new.region);
END;

-- Operación 11

CREATE MATERIALIZED VIEW branch_global_view
REFRESH COMPLETE ON DEMAND
AS SELECT * FROM global_branch;

-- Operación 13

CREATE VIEW total_loan_per_branch AS 
SELECT idsucursal, SUM(cantidad) AS total_loan
FROM global_loan
GROUP BY idsucursal;

-- Test

BEGIN
    add_branch('S0010', 'East Side', 'Manhattan', 500000, 'A');
    add_branch('S0011', 'West End', 'Los Angeles', 800000, 'B');
    add_loan('L-30', 'S0001', 2000);
    add_loan('L-31', 'S0007', 1500);
END;

