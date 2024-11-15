CREATE DATABASE LINK db_link_A_to_C
CONNECT TO TEST IDENTIFIED BY test
USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.23.0.3)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=XE)))';

CREATE SYNONYM rdept FOR dept@db_link_A_to_C;

create or replace trigger rdept_A_to_C
after insert or delete or update on dept
for each row
begin
if inserting then
insert into rdept values(:new.deptno, :new.dname, :new.loc);
elsif deleting then
delete from rdept
where deptno = :old.deptno and dname = :old.dname;
else
update rdept
set dname = :new.dname,
loc = :new.loc
where deptno = :old.deptno;
end if;
end;

INSERT INTO dept (deptno, dname, loc) VALUES (41, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept (deptno, dname, loc) VALUES (42, 'RESEARCH', 'DALLAS');
INSERT INTO dept (deptno, dname, loc) VALUES (43, 'SALES', 'CHICAGO');
INSERT INTO dept (deptno, dname, loc) VALUES (44, 'OPERATIONS', 'BOSTON');
INSERT INTO dept (deptno, dname, loc) VALUES (45, 'HR', 'SAN FRANCISCO');
INSERT INTO dept (deptno, dname, loc) VALUES (46, 'IT', 'SEATTLE');
INSERT INTO dept (deptno, dname, loc) VALUES (47, 'MARKETING', 'DENVER');
INSERT INTO dept (deptno, dname, loc) VALUES (48, 'FINANCE', 'MIAMI');
INSERT INTO dept (deptno, dname, loc) VALUES (49, 'LEGAL', 'AUSTIN');
INSERT INTO dept (deptno, dname, loc) VALUES (50, 'PROCUREMENT', 'PHOENIX');

DELETE FROM dept WHERE deptno = 48;
DELETE FROM dept WHERE deptno = 50;

UPDATE dept SET loc = 'LOS ANGELES' WHERE deptno = 42;
UPDATE dept SET dname = 'BUSINESS DEV' WHERE deptno = 43;
UPDATE dept SET loc = 'SAN DIEGO' WHERE deptno = 46;

create materialized view resumen_sal
build immediate
refresh complete on demand
as
select deptno NoDepto, sum(sal) Nomina
from emp
group by deptno;