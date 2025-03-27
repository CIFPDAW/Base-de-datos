-- 1- Elimine el procedimiento llamado "pa_empleados_sueldo" si existe:
if object_id('pa_empleados_sueldo') is not null 
    drop procedure pa_empleados_sueldo;

-- 2- Cree un procedimiento almacenado "pa_empleados_sueldo" para seleccionar nombres, apellidos y sueldos según un parámetro:
create procedure pa_empleados_sueldo (@sueldo decimal(6,2))
as
select nombre, apellidos, sueldo
from empleados
where sueldo >= @sueldo;

-- 3- Ejecute el procedimiento creado anteriormente con distintos valores:
exec pa_empleados_sueldo @sueldo = 1400;
exec pa_empleados_sueldo @sueldo = 1500;

-- 4- Ejecute el procedimiento "pa_empleados_sueldo" sin parámetros (mostrará un error):
exec pa_empleados_sueldo;

-- 5- Elimine el procedimiento "pa_empleados_actualizar_sueldo" si existe:
if object_id('pa_empleados_actualizar_sueldo') is not null 
    drop procedure pa_empleados_actualizar_sueldo;

-- 6- Cree un procedimiento almacenado "pa_empleados_actualizar_sueldo" para actualizar sueldos:
create procedure pa_empleados_actualizar_sueldo (@sueldoviejo decimal(6,2), @sueldonuevo decimal(6,2))
as
update empleados
set sueldo = @sueldonuevo
where sueldo = @sueldoviejo;

-- 7- Ejecute el procedimiento creado con sueldo 1300 -> 1350:
exec pa_empleados_actualizar_sueldo @sueldoviejo = 1300, @sueldonuevo = 1350;

-- 8- Intente ejecutar el procedimiento "pa_empleados_actualizar_sueldo" enviando un solo parámetro:
pa_empleados_actualizar_sueldo 1300;

-- 9- Ejecute el procedimiento usando parámetros por nombre (en orden invertido):
pa_empleados_actualizar_sueldo @sueldonuevo = 1400, @sueldoviejo = 1350;

-- 10- Verifique el cambio:
select * from empleados;

-- 11- Elimine el procedimiento "pa_sueldototal" si existe:
if object_id('pa_sueldototal') is not null 
    drop procedure pa_sueldototal;

-- 12- Cree un procedimiento llamado "pa_sueldototal" que reciba el documento de un empleado y muestre su nombre, apellido y el sueldo total (resultado de la suma delsueldo y salario por hijo, que es de 200 € si el sueldo es menor a 1500 € y 100 €, si el   sueldo   es   mayor   o   igual   a   1500€).   Coloque   como   valor   por   defecto   para   el parámetro el patrón "%"
create or alter proc pa_sueldototal
    @dni char(8) = '%'
    as
      select e.nombre, e.apellidos,
      sueldototal=
          case 
              when e.sueldo < 1500 then e.sueldo + (nhijos * 200)
              when e.sueldo >= 1500 then e.sueldo + (nhijos * 100)
          end
      from empleados e
      where e.documento LIKE @dni;

-- 13- Ejecute el procedimiento con diferentes valores:

pa_sueldototal '22333333';
pa_sueldototal '22444444';
pa_sueldototal '22555555';

-- 14- Ejecute el procedimiento sin enviar parámetro (tomará el valor por defecto):
pa_sueldototal;