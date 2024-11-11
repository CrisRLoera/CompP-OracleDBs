-- Algunas consultas de prueba

SELECT * FROM dept@db_link_B_to_A;  -- Consulta de la tabla dept en la base A desde la base B

INSERT INTO emp@db_link_B_to_A (empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp;  -- Inserta los datos de la tabla emp de la base A en la base B
