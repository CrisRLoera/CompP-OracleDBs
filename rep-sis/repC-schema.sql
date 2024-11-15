CREATE TABLE emp (
  empno NUMBER(4,0),
  ename VARCHAR2(10),
  job VARCHAR2(9),
  mgr NUMBER(4,0),
  hiredate DATE,
  sal NUMBER(7,2),
  comm NUMBER(7,2),
  deptno NUMBER(2,0),
  CONSTRAINT pk_emp PRIMARY KEY (empno)
);

CREATE TABLE dept (
  deptno NUMBER(2,0),
  dname VARCHAR2(14),
  loc VARCHAR2(13),
  CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

