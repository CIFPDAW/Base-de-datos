-- 1- Elimine la tabla "alumnos" si existe y créela:
if object_id('alumnos') is not null drop table alumnos;
create table alumnos (
    documento char(8),
    nombre varchar(40),
    nota decimal(4,2),
    primary key (documento)
);

-- 2- Inserte algunos registros en la tabla "alumnos":
insert into alumnos values ('22222222', 'Javier López', 5);
insert into alumnos values ('23333333', 'Ana Lopez', 4);
insert into alumnos values ('24444444', 'Maria Santana', 8);
insert into alumnos values ('25555555', 'Juan Garcia', 5.6);
insert into alumnos values ('26666666', 'Carlos Torres', 2);
insert into alumnos values ('27777777', 'Noelia Torres', 7.5);
insert into alumnos values ('28888888', 'Mariano Herreros', 3.5);

-- 3- Elimine la tabla "aprobados" si existe y créela:
if object_id('aprobados') is not null drop table aprobados;
create table aprobados (
    documento char(8),
    nombre varchar(40),
    nota decimal(4,2)
);

-- 4- Elimine la tabla "suspendidos" si existe y créela:
if object_id('suspendidos') is not null drop table suspendidos;
create table suspendidos (
    documento char(8),
    nombre varchar(40)
);

-- 5- Elimine el procedimiento "pa_aprobados" si existe:
if object_id('pa_aprobados') is not null drop procedure pa_aprobados;

-- 6- Cree el procedimiento "pa_aprobados" para seleccionar los alumnos cuya nota es igual o superior a 5:
create procedure pa_aprobados as
select * from alumnos where nota >= 5;

-- 7- Inserte en la tabla "aprobados" los resultados de "pa_aprobados":
insert into aprobados
exec pa_aprobados;

-- 8- Vea el contenido de la tabla "aprobados":
select * from aprobados;

-- 9- Elimine el procedimiento "pa_suspendidos" si existe:
if object_id('pa_suspendidos') is not null drop procedure pa_suspendidos;

-- 10- Cree el procedimiento "pa_suspendidos" para seleccionar los alumnos cuya nota es menor a 5:
create procedure pa_suspendidos as
select documento, nombre from alumnos where nota < 5;

-- 11- Inserte en la tabla "suspendidos" los resultados de "pa_suspendidos":
insert into suspendidos
exec pa_suspendidos;

-- 12- Vea el contenido de la tabla "suspendidos":
select * from suspendidos;
