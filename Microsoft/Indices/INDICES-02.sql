-- 1. Elimine la tabla si existe y créela con la siguiente estructura:
if object_id('alumnos') is not null
    drop table alumnos;
create table alumnos(
    cial char(5) not null,
    documento char(8) not null,
    apellido varchar(30),
    nombre varchar(30),
    notafinal decimal(4,2)
);


-- 2. Cree un índice no agrupado para el campo "apellido":
create nonclustered index in_alumnos_apellido on alumnos(apellido);

-- 3. Vea la información de los índices de "alumnos":
exec sp_helpindex alumnos;

-- 4. Modifíquelo agregando el campo "nombre":
create nonclustered index in_alumnos_apellido_nombre on alumnos(apellido, nombre);

-- 5. Verifique que se modificó:
exec sp_helpindex alumnos;

-- 6. Establezca una restricción "unique" para el campo "documento":
alter table alumnos add constraint uq_alumnos_documento unique (documento);

-- 7. Vea la información que muestra "sp_helpindex":
exec sp_helpindex alumnos;

-- 8. Intente modificar con "drop_existing" alguna característica del índice que se creó automáticamente al agregar la restricción "unique":
create clustered index uq_alumnos_documento
on alumnos(documento)
with drop_existing;

-- Error:
-- No se puede crear otra vez el índice 'uq_alumnos_documento'. La nueva definición de índice no cumple con la restricción que se aplica al índice existente.

-- 9. Cree un índice no agrupado para el campo "cial":
create nonclustered index in_alumnos_cial on alumnos(cial);

-- 10. Muestre todos los índices:
exec sp_helpindex alumnos;

-- 11. Convierta el índice creado en el punto 9 a agrupado conservando las demás características:
create clustered index in_alumnos_cial on alumnos(cial) with drop_existing;

-- 12. Verifique que se modificó:
exec sp_helpindex alumnos;

-- 13. Intente convertir el índice "in_alumnos_cial" a no agrupado:
create nonclustered index in_alumnos_cial
on alumnos(cial)
with drop_existing;

-- Error:
-- No se puede convertir un índice clúster en no agrupado con la opción DROP_EXISTING. Para cambiar el tipo de índice clúster a no agrupado elimine el índice clúster y luego cree un índice no agrupado usando dos instrucciones independientes.

-- 14. Modifique el índice "in_alumnos_apellido" quitándole el campo "nombre":
create nonclustered index in_alumnos_apellido on alumnos(apellido) with drop_existing;

-- 15. Intente convertir el índice "in_alumnos_apellido" en agrupado:
create clustered index in_alumnos_apellido
on alumnos(apellido)
with drop_existing;

-- Error:
-- No se pueden crear varios índices clúster en tabla 'alumnos'. Quite el índice clúster existente 'in_alumnos_cial' antes de crear otro.

-- 16. Modifique el índice "in_alumnos_cial" para que sea único y conserve todas las demás características:
create unique clustered index in_alumnos_cial on alumnos(cial) with drop_existing;

-- 17. Verifique la modificación:
exec sp_helpindex alumnos;

-- 18. Modifique nuevamente el índice "in_alumnos_cial" para que no sea único y conserve las demás características:
create clustered index in_alumnos_cial on alumnos(cial) with drop_existing;

-- 19. Verifique la modificación:
exec sp_helpindex alumnos;
