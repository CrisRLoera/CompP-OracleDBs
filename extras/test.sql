-- Algunas consultas de prueba

SELECT * FROM dept@db_link_B_to_A;  -- Consulta de la tabla dept en la base A desde la base B

INSERT INTO emp@db_link_B_to_A (empno, ename, job, mgr, hiredate, sal, comm, deptno)
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp;  -- Inserta los datos de la tabla emp de la base A en la base B

UPDATE emp@db_link_B_to_A
SET sal = sal * 1.10
WHERE empno = 7839;

DELETE FROM emp@db_link_B_to_A
WHERE empno = 7369;

CREATE OR REPLACE PROCEDURE actualizar_salario (
    p_empno IN NUMBER,
    p_new_sal IN NUMBER
)
IS
BEGIN
    UPDATE emp
    SET sal = p_new_sal
    WHERE empno = p_empno;

    COMMIT;
END actualizar_salario;

EXEC actualizar_salario@db_link_B_to_A(7839, 6500);


