-- 1. Eliminar la tabla si existe y crearla con la estructura definida
if object_id('alumnos') is not null
    drop table alumnos;
create table alumnos(
    cial char(5) not null,
    documento char(8) not null,
    apellido varchar(30),
    nombre varchar(30),
    notafinal decimal(4,2)
);

-- 2. Insertar algunos registros
insert into alumnos values ('A123','22222222','Pérez','Patricia',5.50);
insert into alumnos values ('A234','23333333','López','Ana',9);
insert into alumnos values ('A345','24444444','García','Carlos',8.5);
insert into alumnos values ('A348','25555555','Pérez','Daniela',7.85);
insert into alumnos values ('A457','26666666','Pérez','Fabián',3.2);
insert into alumnos values ('A589','27777777','Gómez','Gerardo',6.90);

-- 3. Intentar crear un índice agrupado único (esto fallará porque hay valores duplicados)
create unique clustered index in_alumnos_apellido on alumnos(apellido);

-- Error:
-- La instrucción CREATE UNIQUE INDEX terminó porque se encontró una clave duplicada para el nombre de objeto 'dbo.alumnos' y el nombre de índice 'in_alumnos_apellido'. El valor de la clave duplicada es (Pérez).

-- 4. Crear un índice agrupado no único para el campo "apellido"
create clustered index in_alumnos_apellido on alumnos(apellido);

-- 5. Intentar establecer una restricción "primary key" con un índice agrupado (esto fallará)
alter table alumnos add constraint pk_alumnos_cial primary key clustered (cial);

-- Error:
-- No se pueden crear varios índices clúster en tabla 'alumnos'. Quite el índice clúster existente 'in_alumnos_apellido' antes de crear otro.
-- No se pudo crear la restricción o el índice. Vea los errores anteriores.

-- 6. Crear la restricción "primary key" con un índice NO agrupado
alter table alumnos add constraint pk_alumnos_cial primary key nonclustered (cial);

-- 7. Ver los índices de la tabla "alumnos"
sp_helpindex alumnos;

-- 9. Crear un índice único no agrupado para el campo "documento"
create unique index in_alumnos_documento on alumnos(documento);

-- 10. Intentar insertar un alumno con documento duplicado (esto fallará)
insert into alumnos values ('A999','22222222','Torres','Miguel',6.75);

-- Error:
-- No se puede insertar una fila de clave duplicada en el objeto 'dbo.alumnos' con índice único 'in_alumnos_documento'. El valor de la clave duplicada es (22222222).

-- 11. Ver los índices de "alumnos"
sp_helpindex alumnos;

-- 12. Crear un índice compuesto para "apellido" y "nombre"
create index in_alumnos_apellido_nombre on alumnos(apellido, nombre);

-- 13. Consultar la tabla "sysindexes" para ver los nombres de los índices creados
select name from sysindexes where name like '%alumnos%';

-- 14. Crear una restricción única para el campo "documento"
alter table alumnos add constraint uq_alumnos_documento unique (documento);

-- 15. Ver la información de las restricciones
sp_helpconstraint alumnos;

-- 16. Ver los índices nuevamente
sp_helpindex alumnos;

-- 17. Consultar la tabla "sysindexes" para los índices relacionados con "alumnos"
select name from sysindexes where name like '%alumnos%';

-- 18. Consultar la tabla "sysindexes" para los índices creados manualmente
select name from sysindexes where name like 'in_%';
