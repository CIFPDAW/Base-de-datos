-- 1- Elimine las tablas, si existen:
if object_id('clientes') is not null drop table clientes;
if object_id('ciudades') is not null drop table ciudades;

-- 2- Cree las tablas:
create table ciudades(
    codigo tinyint identity,
    nombre varchar(20),
    constraint PK_ciudades primary key (codigo)
);
create table clientes(
    nombre varchar(20),
    apellido varchar(20),
    documento char(8),
    domicilio varchar(30),
    codigociudad tinyint constraint FK_clientes_ciudad
        foreign key (codigociudad) references ciudades(codigo) on update cascade
);

-- 3- Ingrese algunos registros:
insert into ciudades values('La Laguna');
insert into ciudades values('Tegueste');
insert into ciudades values('Güímar');
insert into ciudades values('Fasnia');

insert into clientes values('Juan','Perez','22222222','San Tenderete 3',1);
insert into clientes values('Carmen','López','23333333','San Martin 72',2);
insert into clientes values('Luís','García','24444444','San Sebastián 45',1);
insert into clientes values('Marcos','González','25555555','San Antonio 58',3);
insert into clientes values('Noelia','Torres','26666666','San Jorge 57',1);
insert into clientes values('Oscar','Lemus','27777777','San Martín 86',4);

-- 4- Elimine la vista "vi_clientes", si existe:
if object_id('vi_clientes') is not null drop view vi_clientes;

-- 5- Cree la vista "vi_clientes":
create view vi_clientes as
select c.nombre, c.apellido, c.documento, c.domicilio, ci.codigo, ci.nombre as nombre_ciudad
from clientes c
join ciudades ci on c.codigociudad = ci.codigo
where ci.nombre = 'La Laguna'
with check option;

-- 6- Consulte la vista:
select * from vi_clientes;

-- 7- Actualice el apellido de un cliente a través de la vista:
update vi_clientes
set apellido = 'Martínez'
where documento = '22222222';

-- 8- Verifique que la modificación se realizó en la tabla:
select * from clientes;

-- 9- Intente cambiar la ciudad de algún registro. 
-- Mensaje de error: El nombre de columna 'codigociudad' no es válido.
update vi_clientes
set codigociudad = 2
where documento = '22222222';
