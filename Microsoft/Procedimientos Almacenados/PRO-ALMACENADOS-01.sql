-- 1- Elimine la tabla "empleados" si existe:
if object_id('empleados') is not null drop table empleados;

-- 2- Cree la tabla "empleados":
create table empleados (
    documento char(8),
    nombre varchar(20),
    apellidos varchar(20),
    sueldo decimal(6,2),
    nhijos tinyint,
    departamento varchar(20),
    primary key (documento)
);

-- 3- Inserte algunos registros en la tabla:
insert into empleados values('22222222', 'Juan', 'Perez', 1300, 2, 'Contabilidad');
insert into empleados values('22333333', 'Luís', 'López', 1300, 0, 'Contabilidad');
insert into empleados values('22444444', 'Marta', 'Perez', 1500, 1, 'Sistemas');
insert into empleados values('22555555', 'Susana', 'Garcia', 1400, 2, 'Secretaría');
insert into empleados values('22666666', 'Jose María', 'Morales', 1400, 3, 'Secretaría');

-- 4- Elimine el procedimiento "pa_empleados_sueldo" si existe:
if object_id('pa_empleados_sueldo') is not null drop procedure pa_empleados_sueldo;

-- 5- Cree un procedimiento almacenado "pa_empleados_sueldo" para obtener nombres, apellidos y sueldos:
create procedure pa_empleados_sueldo as
select nombre, apellidos, sueldo
from empleados;

-- 6- Ejecute el procedimiento creado anteriormente:
exec pa_empleados_sueldo;

-- 7- Elimine el procedimiento "pa_empleados_hijos" si existe:
if object_id('pa_empleados_hijos') is not null drop procedure pa_empleados_hijos;

-- 8- Cree un procedimiento almacenado "pa_empleados_hijos" para listar empleados con hijos:
create procedure pa_empleados_hijos as
select nombre, apellidos, nhijos
from empleados
where nhijos > 0;

-- 9- Ejecute el procedimiento creado anteriormente:
exec pa_empleados_hijos;

-- 10- Actualice la cantidad de hijos de un empleado sin hijos:
update empleados
set nhijos = 1
where documento = '22333333';

-- 11- Ejecute nuevamente el procedimiento para verificar la actualización:
exec pa_empleados_hijos;
