-- Crear tabla DEPT con clave primaria
CREATE TABLE dept (
  deptno NUMBER(2,0),
  dname VARCHAR2(14),
  loc VARCHAR2(13),
  CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

-- Insertar datos en la tabla DEPT
INSERT INTO dept (deptno, dname, loc) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');