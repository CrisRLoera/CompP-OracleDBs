-- Crear tabla EMP con clave primaria y clave foránea que referencia a la tabla DEPT
CREATE TABLE emp (
  empno NUMBER(4,0),
  ename VARCHAR2(10),
  job VARCHAR2(9),
  mgr NUMBER(4,0),
  hiredate DATE,
  sal NUMBER(7,2),
  comm NUMBER(7,2),
  deptno NUMBER(2,0),
  CONSTRAINT pk_emp PRIMARY KEY (empno),
);

-- Insertar datos en la tabla EMP
INSERT INTO emp VALUES (7839, 'KING', 'PRESIDENT', NULL, TO_DATE('17-11-1981', 'dd-mm-yyyy'), 5000, NULL, 10);
INSERT INTO emp VALUES (7698, 'BLAKE', 'MANAGER', 7839, TO_DATE('1-5-1981', 'dd-mm-yyyy'), 2850, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK', 'MANAGER', 7839, TO_DATE('9-6-1981', 'dd-mm-yyyy'), 2450, NULL, 10);
INSERT INTO emp VALUES (7566, 'JONES', 'MANAGER', 7839, TO_DATE('2-4-1981', 'dd-mm-yyyy'), 2975, NULL, 20);
INSERT INTO emp VALUES (7788, 'SCOTT', 'ANALYST', 7566, TO_DATE('13-JUL-87', 'dd-mm-rr') - 85, 3000, NULL, 20);
INSERT INTO emp VALUES (7902, 'FORD', 'ANALYST', 7566, TO_DATE('3-12-1981', 'dd-mm-yyyy'), 3000, NULL, 20);
INSERT INTO emp VALUES (7369, 'SMITH', 'CLERK', 7902, TO_DATE('17-12-1980', 'dd-mm-yyyy'), 800, NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN', 'SALESMAN', 7698, TO_DATE('20-2-1981', 'dd-mm-yyyy'), 1600, 300, 30);
INSERT INTO emp VALUES (7521, 'WARD', 'SALESMAN', 7698, TO_DATE('22-2-1981', 'dd-mm-yyyy'), 1250, 500, 30);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN', 7698, TO_DATE('28-9-1981', 'dd-mm-yyyy'), 1250, 1400, 30);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN', 7698, TO_DATE('8-9-1981', 'dd-mm-yyyy'), 1500, 0, 30);
INSERT INTO emp VALUES (7876, 'ADAMS', 'CLERK', 7788, TO_DATE('13-JUL-87', 'dd-mm-rr') - 51, 1100, NULL, 20);
INSERT INTO emp VALUES (7900, 'JAMES', 'CLERK', 7698, TO_DATE('3-12-1981', 'dd-mm-yyyy'), 950, NULL, 30);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK', 7782, TO_DATE('23-1-1982', 'dd-mm-yyyy'), 1300, NULL, 10);