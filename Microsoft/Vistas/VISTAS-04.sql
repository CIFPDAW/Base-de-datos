-- 1- Elimine las tablas "inscritos", "socios" y "cursos", si existen:
if object_id('inscritos') is not null drop table inscritos;
if object_id('socios') is not null drop table socios;
if object_id('cursos') is not null drop table cursos;

-- 2- Cree las tablas:
create table socios(
    documento char(8) not null,
    nombre varchar(40),
    domicilio varchar(30),
    constraint PK_socios_documento primary key (documento)
);
create table cursos(
    numero tinyint identity,
    deporte varchar(20),
    dia varchar(15),
    constraint CK_cursos_dia check (dia in ('lunes','martes','miercoles','jueves','viernes','sabado')),
    profesor varchar(20),
    constraint PK_cursos_numero primary key (numero)
);
create table inscritos(
    documentosocio char(8) not null,
    numero tinyint not null,
    matricula char(1),
    constraint PK_inscritos_documento_numero primary key (documentosocio, numero),
    constraint FK_inscritos_documento foreign key (documentosocio) references socios(documento) on update cascade,
    constraint FK_inscritos_numero foreign key (numero) references cursos(numero) on update cascade
);

-- 3- Inserte algunos registros para todas las tablas:
insert into socios values('30000000','Francisco Fuentes','La Graciosa 7');
insert into socios values('31111111','Gerardo García','Lanzarote 65');
insert into socios values('32222222','Héctor Hernández','Fuerteventura 74');
insert into socios values('33333333','Inés Izquierdo','Gran Canaria 45');

insert into cursos values('tenis','lunes','Ana Acosta');
insert into cursos values('tenis','martes','Ana Acosta');
insert into cursos values('natación','miércoles','Ana Acosta');
insert into cursos values('natación','jueves','Carlos Cedres');
insert into cursos values('fútbol','sábado','Pedro Pérez');
insert into cursos values('fútbol','lunes','Pedro Pérez');
insert into cursos values('baloncesto','viernes','Pedro Pérez');

insert into inscritos values('30000000',1,'s');
insert into inscritos values('30000000',3,'n');
insert into inscritos values('30000000',6,null);
insert into inscritos values('31111111',1,'s');
insert into inscritos values('31111111',4,'s');
insert into inscritos values('32222222',1,'s');
insert into inscritos values('32222222',7,'s');

-- 4- Realice un join para mostrar todos los datos de todas las tablas, sin repetirlos:
select 
    s.documento, s.nombre as NombreSocio, s.domicilio,
    c.numero as NumeroCurso, c.deporte, c.dia, c.profesor,
    i.matricula
from inscritos i
join socios s on i.documentosocio = s.documento
join cursos c on i.numero = c.numero;

-- 5- Elimine la vista "vi_cursos" si existe:
if object_id('vi_cursos') is not null drop view vi_cursos;

-- 6- Cree la vista "vi_cursos" que muestre el número, deporte y día de todos los cursos:
create view vi_cursos as
select numero, deporte, dia
from cursos;

-- 7- Consulte la vista ordenada por deporte:
select * 
from vi_cursos
order by deporte;

-- 8- Inserte un registro en la vista "vi_cursos":
insert into cursos values('voleibol','lunes','Laura López');

-- 9- Actualice un registro sobre la vista "vi_cursos":
-- Error: Instrucción UPDATE en conflicto con la restricción CHECK 'CK_cursos_dia'. El conflicto ha aparecido en la base de datos 'Prueba', tabla 'dbo.cursos', column 'dia'.
update vi_cursos
set dia = 'domingo'
where numero = 1;

-- 10- Elimine un registro de la vista para el cual no haya inscritos:
-- Error Instrucción DELETE en conflicto con la restricción REFERENCE 'FK_inscritos_numero'. El conflicto ha aparecido en la base de datos 'Prueba', tabla 'dbo.inscritos', column 'numero'.
delete from cursos
where numero = 6;

-- 11- Intente eliminar un registro de la vista para el cual haya inscritos:
delete from cursos
where numero = 1;

-- 12- Elimine la vista "vi_inscritos" si existe:
if object_id('vi_inscritos') is not null drop view vi_inscritos;

-- 13- Cree la vista "vi_inscritos":
create view vi_inscritos as
select 
    s.documento, s.nombre as NombreSocio,
    c.numero as NumeroCurso, c.deporte, c.dia
from inscritos i
join socios s on i.documentosocio = s.documento
join cursos c on i.numero = c.numero;

-- 14- Intente insertar un registro en la vista:
insert into vi_inscritos values('33333333','baloncesto','lunes');

-- 15- Actualice un registro de la vista:
update vi_inscritos
set dia = 'miércoles'
where documento = '30000000';

-- 16- Vea si afectó a la tabla "socios":
select * 
from socios;

-- 17- Intente actualizar el documento de un socio:
update socios
set documento = '34444444'
where nombre = 'Francisco Fuentes';

-- 18- Intente eliminar un registro de la vista:
delete from vi_inscritos
where documento = '31111111';
