CREATE SYNONYM dept FOR dept@db_link_B_to_A;


SELECT * FROM dept;  -- Ahora la tabla dept se refiere a la base de datos A sin especificar el link

CREATE VIEW emp_view AS
SELECT empno, ename, job, hiredate, sal, deptno
FROM emp@db_link_B_to_A;

SELECT * FROM emp_view;  -- Consultar la vista para ver los datos de la tabla emp remota


CREATE OR REPLACE PROCEDURE insert_emp (
  p_empno IN NUMBER,
  p_ename IN VARCHAR2,
  p_job IN VARCHAR2,
  p_mgr IN NUMBER,
  p_hiredate IN DATE,
  p_sal IN NUMBER,
  p_comm IN NUMBER,
  p_deptno IN NUMBER
) AS
BEGIN
  INSERT INTO emp@db_link_B_to_A (empno, ename, job, mgr, hiredate, sal, comm, deptno)
  VALUES (p_empno, p_ename, p_job, p_mgr, p_hiredate, p_sal, p_comm, p_deptno);
END;


EXEC insert_emp(8000, 'NEWT', 'CLERK', NULL, TO_DATE('10/12/24', 'DD/MM/RR'), 1500, NULL, 10);
