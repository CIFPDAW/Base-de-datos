-- Procedimientos almacenados
--  Indicando el departamento, devuelve el número de empleados en ese departamento

CREATE OR ALTER proc pa_empleadosDto
	@dpto varchar(20),
    @numEmpleados int output
	as
		SELECT @numEmpleados = COUNT(e.documento)
		FROM empleados e
		WHERE @dpto LIKE e.departamento
		GROUP BY e.departamento;

declare @num int
exec pa_empleadosDto 'Sistemas', @num out;
print 'El departamento tiene '+ cast(@num as varchar) +' empleados';


-- 1- Elimine el procedimiento llamado "pa_empleados_departamento", si existe:
if object_id('pa_empleados_ departamento ') is not null
 drop procedure pa_empleados_ departamento;
-- 2- Cree un procedimiento que muestre todos los empleados de un departamento determinado que se pase como parámetro. Si no se pone un valor, o se coloca "null", se muestra un mensaje y se sale del procedimiento.
CREATE or ALTER proc pa_empleados_departamento
	@dpto varchar(20)
	as 
		if @dpto = null or @dpto = ''
		begin
			print('Valor invalido')
			return
		end
		else RETURN(SELECT COUNT(e.documento)
		FROM empleados e
		WHERE @dpto LIKE e.departamento
		GROUP BY e.departamento)

-- 3- Ejecute el procedimiento enviándole un valor para el parámetro.
declare @n varchar(MAX);
exec @n = pa_empleados_departamento '';
print 'El departamento tiene '+ cast(@n as varchar) +' empleados';


-- 4- Ejecute el procedimiento sin parámetro.
exec pa_empleados_departamento '';

-- 5- Elimine el procedimiento "pa_actualizarhijos", si existe:
if object_id('pa_actualizarhijos') is not null
 drop procedure pa_actualizarhijos;
-- 6- Cree un procedimiento almacenado que permita modificar la cantidad de hijos indicando el documento de un empleado y la cantidad de hijos nueva. Ambos parámetros DEBEN ponerse con un valor distinto de "null". El procedimiento retorna "1" si la actualización se realiza (si se insertan valores para ambos parámetros) y "0", en caso que uno o ambos parámetros no se insertan o son nulos. Se deberá actualizar la cantidad de hijos incrementando el valor anterior y el nuevo.
-- 7- Declare una variable en la cual se almacenará el valor devuelto por el procedimiento, ejecute el procedimiento enviando los dos parámetros y vea el contenido de la variable. El procedimiento retorna "1", con lo cual indica que fue actualizado.
-- 8- Verifique la actualización consultando la tabla.
-- 9- Ejecute los mismos pasos, pero esta vez envíe solamente un valor para el parámetro "documento". Retorna "0", lo que indica que el registro no fue actualizado.
-- 10- Verifique que el registro no se actualizó consultando la tabla.
-- 11- Emplee un "if" para controlar el valor de la variable de retorno. Enviando al procedimiento valores para los parámetros. Retorna 1.
-- 12- Verifique la actualización consultando la tabla
-- 13- Emplee nuevamente un "if" y envíe solamente valor para el parámetro "hijos". Retorna 0.