-- 1- Elimine las tablas y créelas nuevamente:
if object_id('inscritos') is not null  
    drop table inscritos;
if object_id('socios') is not null  
    drop table socios;
if object_id('profesores') is not null  
    drop table profesores; 
if object_id('cursos') is not null  
    drop table cursos;

create table socios(
    documento char(8) not null,
    nombre varchar(40),
    domicilio varchar(30),
    constraint PK_socios_documento
        primary key (documento)
);
create table profesores(
    documento char(8) not null,
    nombre varchar(40),
    domicilio varchar(30),
    constraint PK_profesores_documento
        primary key (documento)
);
create table cursos(
    numero tinyint identity,
    deporte varchar(20),
    dia varchar(15),
    constraint CK_inscritos_dia check (dia in ('lunes','martes','miercoles','jueves','viernes','sabado')),
    documentoprofesor char(8),
    constraint PK_cursos_numero
        primary key (numero)
);
create table inscritos(
    documentosocio char(8) not null,
    numero tinyint not null,
    matricula char(1),
    constraint CK_inscritos_matricula check (matricula in ('s','n')),
    constraint PK_inscritos_documento_numero
        primary key (documentosocio, numero)
);

-- 2- Inserte algunos registros para todas las tablas:
insert into socios values('30000000','Francisco Fuentes','La Graciosa 7');
insert into socios values('31111111','Gerardo García','Lanzarote 65');
insert into socios values('32222222','Héctor Hernández','Fuerteventura 74');
insert into socios values('33333333','Inés Izquierdo','Gran Canaria 45');

insert into profesores values('22222222','Ana Acosta','Los Menceyes 31');
insert into profesores values('23333333','Carlos Castro','Mencey Bencomo 5');
insert into profesores values('24444444','Daniel Díaz','Mencey Acaymo 87');
insert into profesores values('25555555','Esteban López','C/ Méndez Nuñez 4');

insert into cursos values('tenis','lunes','22222222');
insert into cursos values('tenis','martes','22222222');
insert into cursos values('natacion','miercoles','22222222');
insert into cursos values('natacion','jueves','23333333');
insert into cursos values('natacion','viernes','23333333');
insert into cursos values('futbol','sabado','24444444');
insert into cursos values('futbol','lunes','24444444');
insert into cursos values('baloncesto','martes','24444444');

insert into inscritos values('30000000',1,'s');
insert into inscritos values('30000000',3,'n');
insert into inscritos values('30000000',6,null);
insert into inscritos values('31111111',1,'s');
insert into inscritos values('31111111',4,'s');
insert into inscritos values('32222222',8,'s');

-- 3- Elimine la vista "vi_club" si existe:
if object_id('vi_club') is not null drop view vi_club;

-- 4- Cree una vista en la que aparezca el nombre y documento del socio, el deporte, el día y el nombre del profesor:
create or alter view vi_club as
select s.nombre 'NombreSocio', s.documento 'DocumentoSocio', c.deporte 'Deporte', c.dia 'Dia', p.nombre 'NombreProfesor'
from inscritos i
INNER JOIN socios s ON i.documentosocio = s.documento
INNER JOIN cursos c ON i.numero = c.numero
INNER JOIN profesores p ON c.documentoprofesor= p.documento;

-- 5- Muestre la información contenida en la vista:
select * from vi_club;

-- 6- Realice una consulta a la vista donde muestre la cantidad de socios inscritos en cada deporte ordenados por cantidad:
select Deporte, count(*) 'Cantidad Inscritos'
from vi_club
group by Deporte
order by [Cantidad Inscritos] desc;

-- 7- Muestre (consultando la vista) los cursos (deporte y día) para los cuales no hay inscritos:
select 
    c.deporte,
    c.dia
from cursos c
left join inscritos i on c.numero = i.numero
where i.numero is null;

-- 8- Muestre los nombres de los socios que no se han inscrito en ningún curso (consultando la vista):
select 
    s.nombre
from socios s
left join inscritos i on s.documento = i.documentosocio
where i.documentosocio is null;

-- 9- Muestre (consultando la vista) los profesores que no tienen asignado ningún deporte aún:
select 
    p.nombre
from profesores p
left join cursos c on p.documento = c.documentoprofesor
where c.documentoprofesor is null;

-- 10- Muestre (consultando la vista) el nombre y documento de los socios que deben matrículas:
select 
    s.nombre,
    s.documento
from inscritos i
join socios s on i.documentosocio = s.documento
where i.matricula is null;

-- 11- Consulte la vista y muestre los nombres de los profesores y los días en que asisten al club para impartir sus clases:
select 
    NombreProfesor,
    Dia
from vi_club;

-- 12- Muestre la misma información anterior pero ordenada por día:
select 
    NombreProfesor,
    Dia
from vi_club
order by Dia;

-- 13- Muestre todos los socios que son compañeros en tenis los lunes:
select 
    s.nombre
from inscritos i
join cursos c on i.numero = c.numero
join socios s on i.documentosocio = s.documento
where c.deporte = 'tenis' and c.dia = 'lunes';

-- 14- Elimine la vista "vi_inscritos" si existe y créela para que muestre la cantidad de inscritos por curso, incluyendo el número del curso, el nombre del deporte y el día:
if object_id('vi_inscritos') is not null drop view vi_inscritos;

create view vi_inscritos as
select 
    c.numero as NumeroCurso,
    c.deporte as Deporte,
    c.dia as Dia,
    count(i.documentosocio) as CantidadInscritos
from cursos c
left join inscritos i on c.numero = i.numero
group by c.numero, c.deporte, c.dia;
