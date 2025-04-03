-- CHAR(13) -> Salto de línea


-- 1- Elimine el procedimiento llamado "pa_departamento" si existe:
 if object_id('pa_departamento') is not null
  drop procedure pa_departamento;
-- 2- Cree un procedimiento almacenado llamado "pa_ departamento " al cual le enviamos el nombre de un departamento y que nos retorne el promedio de sueldos de todos los empleados de ese departamento y el valor mayor de sueldo (de ese departamento)
insert into empleados 
	values('22111111', 'Lorena', 'Trujillo', 1100, 0,'Contabilidad'),
		  ('22777777', 'Lorenzo', 'Torres', 1800, 3,'Sistemas'),
		  ('22888888', 'César', 'Santos', 1950, 3,'Sistemas');

create or alter proc pa_departamento
	@dpto varchar(20),
	@media decimal(6,2) output,
	@maximo decimal(6,2) output
	as 
		begin
			SELECT @media=AVG(e.sueldo)
			FROM empleados e
			WHERE e.departamento LIKE @dpto
			SELECT @maximo=MAX(e.sueldo)
			FROM empleados e
			WHERE e.departamento LIKE @dpto
		end;
-- 3- Ejecute el procedimiento creado anteriormente con distintos valores. 
declare @me decimal(6,2), @ma decimal(6,2)
exec pa_departamento 'Sistemas', @me out, @ma out
print @me
print @ma;

declare @me decimal(6,2), @ma decimal(6,2)
exec pa_departamento 'Contabilidad', @me out, @ma out
print @me
print @ma;

-- 4- Ejecute el procedimiento "pa_ departamento " sin pasar valor para el parámetro " departamento ". Luego muestre los valores devueltos por el procedimiento. Calcula sobre todos los registros porque toma el valor por defecto.

declare @me decimal(6,2), @ma decimal(6,2)
exec pa_departamento '%', @me out, @ma out
print @me
print @ma;

-- 5-Haciendo uso de la función CAST que realiza conversiones de tipos, mostrar la salida de la siguiente forma: ‘El departamento de Secretaría tiene un sueldo medio de 1600.00 €, y el sueldo mayor es de 1800.00 €’, por ejemplo.

create or alter proc pa_departamento
	@dpto varchar(20),
	@media decimal(6,2) output,
	@maximo decimal(6,2) output,
	@dpt varchar(20) output
	as 
		begin
			SELECT @media=AVG(e.sueldo)
			FROM empleados e
			WHERE e.departamento LIKE @dpto
			SELECT @maximo=MAX(e.sueldo)
			FROM empleados e
			WHERE e.departamento LIKE @dpto
			SELECT @dpt = @dpto
		end;

declare @me decimal(6,2), @ma decimal(6,2), @dt varchar(20)
exec pa_departamento 'Sistemas', @me out, @ma out, @dt out
print 'El departamento de ' + @dt + ' tiene un sueldo medio de ' + CAST(@me AS varchar(10)) + ' €, y el sueldo mayor es de ' + CAST(@ma AS varchar(10)) + ' €.';


-- 6-   Elimine   el   procedimiento   almacenado   "pa_sueldototal",   si  existe   y  cree   un procedimiento con ese nombre que reciba el documento de un empleado y retorne el sueldo total, resultado de la suma del Sueldo y salario por hijo, que es 200 si el sueldo es menor a 1500 y 100 si es mayor o igual, con el siguiente formato: ‘El empleado con documento 222222222 tiene un sueldo total de 1900.00 € y tiene 2 hijos y un sueldo de 1500.00€’, por ejemplo.


if object_id('pa_sueldototal') is not null
  drop procedure pa_sueldototal;


create or alter proc pa_sueldototal
	@dni char(8),
	@sueldoT decimal(6,2) output,
	@hijos tinyint out,
	@salario decimal(6,2) out,
    @ind char(8) out
	as
      select @hijos = e.nhijos, @salario = e.sueldo, @ind = @dni, @sueldoT =
          case 
              when e.sueldo < 1500 then e.sueldo + (nhijos * 200)
              when e.sueldo >= 1500 then e.sueldo + (nhijos * 100)
          end
      from empleados e
      where e.documento LIKE @dni;

-- 7- Ejecute el procedimiento anterior enviando un documento existente.

declare @total decimal(6,2), @nh tinyint, @s decimal(6,2), @documento char(8)

exec pa_sueldototal '22222222', @total out, @nh out, @s out, @documento out

print 'El empleado con documento ' + CAST(@documento as varchar(10)) + ' tiene un sueldo total de ' + CAST(@total as varchar(10)) + ' € y tiene ' + CAST(@nh as varchar(2)) + ' hijos y un sueldo de ' + CAST(@s as varchar(10)) + ' €.';

-- 8- Ejecute el procedimiento anterior enviando un documento inexistente. Retorna "null".

declare @total decimal(6,2), @nh tinyint, @s decimal(6,2), @documento char(8)

exec pa_sueldototal '22222223', @total out, @nh out, @s out, @documento out

print 'El empleado con documento ' + CAST(@documento as varchar(10)) + ' tiene un sueldo total de ' + CAST(@total as varchar(10)) + ' € y tiene ' + CAST(@nh as varchar(2)) + ' hijos y un sueldo de ' + CAST(@s as varchar(10)) + ' €.';

-- 9- Ejecute el procedimiento anterior enviando el documento de un empleado en cuyo campo "sueldo" contenga "null". Retorna "null".
-- 10- Ejecute el procedimiento anterior sin enviar valor para el parámetro "documento". Retorna el valor calculado del último registro.