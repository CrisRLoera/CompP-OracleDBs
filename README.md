# Oracle Datalinks


## Descripción

Este es un proyecto desarrollado para una clase de Computo Paralelo, con el objetivo de conectar varios contenedores con bases de datos y crear una capa de transparencia entre ellas.

## Requisitos

Debes de descargar docker y docker compose de acuerdo a las especificaciones de tu sistema

Crear una red personalisada llamada **ora-net**

```
sudo docker network create ora-net
```


## Uso

Una vez en la ruta del docker-compose se ejecuta el siguiente comando


```
sudo docker-compose up -d
```

### Entrar a el contenedor

```
sudo docker exec -it nombre-del-contenedor bash
```

Ejemplo:
```
sudo docker exec -it oracle-xe-2-DB-B bash
```

### Crear un usuario para conectarse

Ejecuta el comando para entrar a el contenedor.
A continuación entra a la base de datos como SYSDBA

```
sqlplus / as sysdba
```

Ejecuta el siguiente comando dentro de SQLPLUS

```
@/container-entrypoint-initdb.d/init-users.sql
```

Una vez creado el usuario es TEST y la contraseña test

## Utils

Ver las especificaciones del contenedor Oracle, dentro del contenedor

```
lsnrctl status
```

Ver la IP del contenedor para el datalink de host

```
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nombre-del-contenedor
```

Ejemplo:
```
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' oracle-xe-3-DB-C
```

by @CrisRLoera