-- Quizas sea necesario cambiar la ip del host si es que el contenedor al que te quieres conectar es diferente

-- En este caso es del contenedor B a A

CREATE DATABASE LINK db_link_B_to_A
CONNECT TO TEST IDENTIFIED BY test
USING '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.23.0.2)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=XE)))';

-- SELECT * FROM dept@db_link_B_to_A;

-- DROP DATABASE LINK db_link_B_to_A;