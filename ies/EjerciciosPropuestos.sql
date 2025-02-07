/*Ejercicios de la base de datos IES*/

use ies;

/*Una tabla*/

/*1.- Relación de alumnos del grupo 811NMA*/

select a.* from Alumno a
where a.CodigoGrupo = "811NMA";

select * from Alumno;

/*2.- Relación de alumnos que son de TACORONTE*/

select a.* from Alumno a
where a.Municipio like "Tacoronte";

select * from Alumno;

/*3.- Relación de grupos que no tienen tutor*/

select g.* from Grupo g
where g.CodigoTutor is null;

select * from Grupo;

/*4.- Relación de alumnos que viven en el CALVARIO*/

select a.* from Alumno a
where Direccion like "%Calvario%";

select * from Alumno;

/*5.- ¿Cuántos alumnos tienen de código postal 38350?*/

select count(*) from Alumno al
where al.Codigo_Postal = 38350;

select * from Alumno;

/*6.- ¿Cuántos alumnos tienen el grupo 811NMA?*/

select count(*) "Cantidad" from Alumno al
where al.CodigoGrupo like "811NMA";

select * from Alumno;

/*7.- ¿Cuátos grupos tiene el centro escolar?*/

select count(*) "Cantidad" from Grupo gp;

select * from Grupo;


/*Varias tablas*/

/*8.- Realación de asignaturas del alumno "PEPE GARCIA SANCHEZ"*/

select al.*, asig.Denominacion from Alumno al inner join AlumnoNota an
on al.Codigo = an.CodigoAlumno inner join Asignatura asig
on an.CodigoAsignatura = asig.Codigo
where al.Nombre like "PEPE" and al.Apellidos like "GARCIA SANCHEZ";

select * from Alumno;
select * from Asignatura;

/*9.- Relación de asignaturas aprobadas del alumno "PEPE GARCIA SANCHEZ"*/

select al.Codigo, al.Nombre, al.Apellidos, asig.Denominacion, an.Nota from Alumno al inner join AlumnoNota an
on al.Codigo = an.CodigoAlumno inner join Asignatura asig
on an.CodigoAsignatura = asig.Codigo
where al.Nombre like "PEPE" and al.Apellidos like "GARCIA SANCHEZ" and an.Nota >= 5;

/*10.- Boletín de notas del alumno "PEPA PEREZ DE LEON"*/

select al.Nombre, al.Apellidos, asig.Denominacion, an.Nota from Alumno al inner join AlumnoNota an
on al.Codigo = an.CodigoAlumno inner join Asignatura asig
on an.CodigoAsignatura = asig.Codigo
where al.Nombre = "PEPE" and al.Apellidos = "GARCIA SANCHEZ";

select * from Alumno where Nombre like "PEPA" and Apellidos like "PEREZ DE LEON";

/*11.- Relación de asignaturas aprobadas del grupo 811NMA*/

select al.CodigoGrupo, asig.Denominacion, an.Nota from Alumno al inner join AlumnoNota an
on al.Codigo = an.CodigoAlumno inner join Asignatura asig
on an.CodigoAsignatura = asig.Codigo
where al.CodigoGrupo = "811NMA" and an.Nota >= 5;

/*12.- Relación de alumnos que tiene la asignatura con código 91302*/

select al.Nombre, al.Apellidos from Alumno al inner join AlumnoNota an
on al.Codigo = an.CodigoAlumno
where an.CodigoAsignatura = 91302;

/*13.- Realción de alumnos que han aprobado la asignatura "Cultivos en Viveros e Invernaderos*/

select al.Nombre, al.Apellidos, an.Nota from Alumno al inner join AlumnoNota an
on al.Codigo = an.CodigoAlumno inner join Asignatura asig 
on an.CodigoAsignatura = asig.Codigo
where asig.Denominacion like "Cultivos en Viveros e Invernaderos" and an.Nota > 4;

/*14.- Relación de los Grupos indicando el nombre del Tutor*/

select g.Codigo, p.Nombre from Grupo g inner join Profesor p
on g.CodigoTutor = p.Codigo;

select * from Grupo;
select * from Profesor;

/*15.- Relación de los profesores que imparten las asignaturas de los grupos. Indicando nombre del profesor 
y nombre de la asignatura.*/

select p.Nombre, a.Denominacion from Profesor p inner join AsignaturasGrupo ag
on p.Codigo = ag.CodigoProfesor inner join Asignatura a
on ag.CodigoAsignatura = a.Codigo;

/*16.- Relación de profesores por orden alfabético*/

select distinct p.Nombre, p.Codigo from Profesor p inner join AsignaturasGrupo ag
on p.Codigo = ag.CodigoProfesor
order by p.Nombre;

select * from Profesor;

/*17.- Relación de asignaturas suspendidas del grupo 124NMA*/

select an.Nota, a.Denominacion from AlumnoNota an inner Join Asignatura a
on an.CodigoAsignatura = a.Codigo inner join AsignaturasGrupo ag
on a.Codigo = ag.CodigoAsignatura
where an.Nota < 5 and ag.CodigoGrupo like "124NMA";

/*18.- Relación de alumnos que han sacado un 6 en la nota de la asignatura "TECNICAS BASICAS DE JARDINERIA"*/

select al.Nombre, al.Apellidos, an.Nota from Alumno al inner join AlumnoNota an
on al.Codigo = an.CodigoAlumno inner join Asignatura asig 
on an.CodigoAsignatura = asig.Codigo
where asig.Denominacion like "TECNICAS BASICAS DE JARDINERIA" and an.Nota = 6;

/*19.- Relación de asignaturas que imparte el profesor "ARRATE MARRERO, CARLOS"*/

select distinct asig.Denominacion from Asignatura asig inner join AsignaturasGrupo ag
on asig.Codigo = ag.CodigoAsignatura inner join Profesor p
on ag.CodigoProfesor = p.Codigo
where p.Nombre like "ARRATE MARRERO, CARLOS";

/*20.- Relación de alumnos que a suspendido el profesor "VIZCAINO SOSA, JOAQUIN"*/

select prof.Nombre "Profesor", al.Nombre "Alumno" from Profesor prof inner join AsignaturasGrupo ag
on prof.Codigo = ag.CodigoGrupo inner join Grupo gp
on ag.CodigoGrupo = gp.Codigo inner join Alumno al
on gp.Codigo = al.CodigoGrupo inner join AlumnoNota an
on al.Codigo = an.CodigoAlumno
where prof.Nombre like "VIZCAINO SOSA, JOAQUIN" and an.Nota < 5;

/*21.- Relación de grupos a los que imparte clase el profesor "POLO ORTEGA, ANGEL"*/

select ag.CodigoGrupo from AsignaturasGrupo ag inner join Profesor prof
on ag.CodigoProfesor = prof.Codigo 
where prof.Nombre like "POLO ORTEGA, ANGEL";

/*22.- Relación de alumnos que son del SAUZAL y les da clase el profesor "PRIETO, RAMON"*/

select al.Nombre from Alumno al inner join Grupo gp
on al.CodigoGrupo = gp.Codigo inner join AsignaturasGrupo ag
on gp.Codigo = ag.CodigoGrupo inner join Profesor prof
on ag.CodigoProfesor = prof.Codigo
where al.Municipio like "SAUZAL" and prof.Nombre like "PRIETO, RAMON";

/*23.- Número de alumnos del grupo 913NMA*/

select count(*) "Total" from Alumno al
where al.CodigoGrupo like "913NMA";

/*24.- Número de grupos que hay en este centro*/

select count(*) from Grupo;

/*25.- Número de alumnos que son del SAUZAL */

select count(*) "Total" from Alumno al
where al.Municipio like "%SAUZAL%";

/*26.- Número de alumnos que han suspendido la asignatura 91302*/

select count(*) "Total Suspendidos" from AlumnoNota an
where an.Nota < 5 and an.CodigoAsignatura = 91302;

/*27.- Número de alumnos que han aprobado la asignatura 91302*/

select count(*) "Total Aprobado" from AlumnoNota an
where an.Nota > 4 and an.CodigoAsignatura = 91302;

/*28.- Número de alumnos que tienen la asignatura 91302*/

select count(*) from AlumnoNota an
where an.CodigoAsignatura = 91302;

/*29.- Número de alumnos a los que les da calse el profesor "POLO ORTEGA, ANGEL"*/

select count(*) from Alumno al inner join Grupo gp
on al.CodigoGrupo = gp.Codigo inner join AsignaturasGrupo ag
on gp.Codigo = ag.CodigoGrupo inner join Profesor prof
on ag.CodigoProfesor = prof.Codigo
where prof.Nombre like "POLO ORTEGA, ANGEL";

select count(an.CodigoAlumno) from AlumnoNota an inner join AsignaturasGrupo ag
on an.CodigoAsignatura = ag.CodigoAsignatura inner join Profesor prof
on ag.CodigoProfesor = prof.Codigo
where prof.Nombre like "POLO ORTEGA, ANGEL";

/*30.- Nota media del alumno "PEPE GARCIA SANCHEZ"*/

select avg(an.Nota) from AlumnoNota an inner join Alumno al
on an.CodigoAlumno = al.Codigo
where al.Nombre like "PEPE GARCIA SANCHEZ";

/*31.- Nota media del grupo 913NMA en la asignatura 91303*/

select avg(an.Nota) from AlumnoNota an inner join AsignaturasGrupo ag
on an.CodigoAsignatura = ag.CodigoAsignatura
where ag.CodigoGrupo like "913NMA" and an.CodigoAsignatura = 91303;

/*32.- Nota media de la asignatura 91303 de todos los grupos*/

select avg(an.Nota) from AlumnoNota an
where an.CodigoAsignatura = 91303;

/*33.- Nota media de los alumnos que se matricularon por primera ven en el año 96*/

select * from Alumno;

/*34.- Cual es la nota máxima en la asignatura 91304*/

select max(Nota) from AlumnoNota
where CodigoAsignatura = 91304;

/*35.- Cual es la nota mínima en la asignatura 91302*/

select min(Nota) from AlumnoNota
where CodigoAsignatura = 91302;

/*GROUP BY*/

/*40. Relación de notas medias de los alumnos del grupo 913NMB*/



/*41. Número de asignaturas que imparte cada profesor del centro.*/

SELECT COUNT(ag.CodigoAsignatura), p.Nombre FROM profesor p INNER JOIN asignaturasgrupo ag ON p.Codigo = ag.CodigoProfesor GROUP BY p.Nombre;

/*42. Nota media de los alumnos de cada municipio.*/

SELECT AVG(an.Nota) 'Nota Media', a.Municipio FROM alumno a INNER JOIN alumnonota an ON an.CodigoAlumno = a.Codigo GROUP BY a.Municipio;

/*43. Nota media de los alumnos por profesor.*/

SELECT AVG(an.Nota) 'Nota Media', p.Nombre FROM alumno a INNER JOIN alumnonota an ON an.CodigoAlumno = a.Codigo INNER JOIN asignatura asi ON asi.Codigo = an.CodigoAsignatura INNER JOIN asignaturasgrupo ag ON ag.CodigoAsignatura = asi.Codigo INNER JOIN profesor p ON ag.CodigoProfesor = p.Codigo GROUP BY p.Nombre;

/*44. de alumnos del SAUZAL cuya nota media este entre 2 y 6.*/

SELECT AVG(an.Nota) 'Nota Media', a.Nombre, a.Municipio FROM alumno a INNER JOIN alumnonota an ON an.CodigoAlumno = a.Codigo WHERE a.Municipio LIKE '%SAUZAL' GROUP BY an.CodigoAlumno HAVING AVG(an.Nota) BETWEEN 2 AND 6;

/*45. Relación de nota media por profesor y asignatura.*/

SELECT AVG(an.Nota) 'Nota Media', p.Nombre
FROM alumnonota an INNER JOIN asignatura asi
ON an.CodigoAsignatura = asi.Codigo INNER JOIN asignaturasgrupo ag
ON ag.CodigoAsignatura = asi.Codigo INNER JOIN profesor p
ON p.Codigo = ag.CodigoProfesor GROUP BY p.Codigo, p.Nombre;

/*46. Relación de nota media por asignatura.*/

SELECT asi.Denominacion, AVG(an.Nota) 'Nota Media'
FROM alumnonota an INNER JOIN asignatura asi
ON an.CodigoAsignatura = asi.Codigo INNER JOIN asignaturasgrupo ag
ON ag.CodigoAsignatura = asi.Codigo  GROUP BY asi.Codigo;

/*47. Relación de nota media por asignatura del grupo 913NMA.*/

SELECT asi.Denominacion, AVG(an.Nota) 'Nota Media'
FROM alumnonota an INNER JOIN asignatura asi
ON an.CodigoAsignatura = asi.Codigo INNER JOIN asignaturasgrupo ag
ON ag.CodigoAsignatura = asi.Codigo WHERE ag.CodigoGrupo = '913NMA'
GROUP BY asi.Codigo;

/*48. Relación alumnos con sus notas medias que son de TACORONTE y tienen de nota media entre un 5 y un 9.*/

SELECT asi.Denominacion, AVG(an.Nota) 'Nota Media'
FROM alumnonota an INNER JOIN asignatura asi
ON an.CodigoAsignatura = asi.Codigo INNER JOIN asignaturasgrupo ag
ON ag.CodigoAsignatura = asi.Codigo INNER JOIN alumno a
ON a.Codigo = an.CodigoAlumno WHERE a.Municipio LIKE 'TACORONTE'
GROUP BY asi.Codigo
HAVING AVG(an.Nota) BETWEEN 5 AND 9;

/* 49. Relación del número de bajas de cada grupo.*/

SELECT COUNT(*) 'Numero total de bajas', alb.Grupo
FROM alumnos_de_baja alb
GROUP BY alb.Grupo;

/* 50. Relación de alumnos del 811NMA que tiene al menos una asignatura suspendida.*/

SELECT a.Codigo, a.Nombre, a.Apellidos, COUNT(an.Nota) Suspendidas
FROM alumno a
INNER JOIN alumnonota an ON an.CodigoAlumno = a.Codigo
WHERE a.CodigoGrupo LIKE '811NMA' AND an.Nota < 5
GROUP BY a.Codigo, a.Nombre;

/* 51. Relación de alumnos del grupo 811NMA que tiene nota media mayor que la media del grupo.*/

/*MEDIA DEL GRUPO*/

SELECT AVG(an.Nota) MediaGrupo
FROM alumno a
INNER JOIN alumnonota an ON a.Codigo = an.CodigoAlumno
WHERE a.CodigoGrupo LIKE '811NMA';


SELECT a.CodigoGrupo, a.Codigo, AVG(an.Nota) MediaAlumno
FROM alumno a
INNER JOIN alumnonota an ON a.Codigo = an.CodigoAlumno
WHERE a.CodigoGrupo LIKE '811NMA'
GROUP BY a.Codigo
HAVING AVG(an.Nota) > (
    SELECT AVG(an.Nota)
    FROM alumno a
    INNER JOIN alumnonota an ON a.Codigo = an.CodigoAlumno
    WHERE a.CodigoGrupo LIKE '811NMA'
);

/*52. Relación de alumnos del grupo 913NMA que no tienen asignaturas.*/

/*CONTAR ASIGNATURAS*/
SELECT ag.CodigoGrupo, COUNT(ag.CodigoAsignatura)
FROM asignaturasgrupo ag
WHERE ag.CodigoGrupo LIKE '913NMA';

SELECT COUNT(an.CodigoAsignatura) ,a.*
FROM alumno a INNER JOIN alumnonota an
ON  a.Codigo = an.CodigoAlumno
WHERE a.CodigoGrupo LIKE '913NMA'
GROUP BY a.Codigo
HAVING COUNT(an.CodigoAsignatura) < (SELECT COUNT(ag.CodigoAsignatura)
                                    FROM asignaturasgrupo ag
                                    WHERE ag.CodigoGrupo LIKE '913NMA');

/*53. Relación de alumnos de centros cuya nota media sea menor que la media del centro.*/

/*CALCULAS MEDIA TOTAL*/

SELECT AVG(an.Nota)
FROM alumnonota an;



SELECT AVG(an.Nota) MediaAlumno ,a.*
FROM alumno a
INNER JOIN alumnonota an ON a.Codigo = an.CodigoAlumno
GROUP BY a.Codigo
HAVING AVG(an.Nota) > (SELECT AVG(an.Nota)
                        FROM alumnonota an);

/*56. Relación de profesores del centro que aprueban a todos los alumnos. */

SELECT p.*
FROM Profesor p
INNER JOIN AsignaturasGrupo ag ON p.Codigo = ag.CodigoProfesor
INNER JOIN AlumnoNota an ON ag.CodigoAsignatura = an.CodigoAsignatura
INNER JOIN Alumno a ON an.CodigoAlumno = a.Codigo
GROUP BY p.Codigo
HAVING MIN(an.Nota) >= 5;

SELECT DISTINCT p.*
FROM Profesor p
INNER JOIN AsignaturasGrupo ag ON p.Codigo = ag.CodigoProfesor
INNER JOIN alumnonota an ON an.CodigoAsignatura = ag.CodigoAsignatura
WHERE 5 <= ALL (SELECT an.Nota
    FROM AlumnoNota an
    WHERE an.CodigoAsignatura = ag.CodigoAsignatura
);

SELECT p.*, ag.CodigoAsignatura, ag.CodigoGrupo
FROM profesor p
INNER JOIN asignaturasgrupo ag ON p.Codigo = ag.CodigoProfesor
WHERE 5 <= ALL(SELECT an.Nota
                FROM alumnonota an
                WHERE an.CodigoAsignatura = ag.CodigoAsignatura);

/*57. Relación de profesores del centro que suspenden a mas del 50% de sus alumnos. */

/* Número de alumnos que tiene un profesor */
SELECT p.*, COUNT(DISTINCT a.Codigo) NumeroAlumnos
FROM Profesor p
INNER JOIN AsignaturasGrupo ag ON p.Codigo = ag.CodigoProfesor
INNER JOIN Alumno a ON a.CodigoGrupo = ag.CodigoGrupo
GROUP BY p.Codigo;

/* Número de alumnos que tiene un profesor SUSPENDIDOS*/
SELECT p.Codigo, p.Nombre, COUNT(DISTINCT a.Codigo) NumeroAlumnosSuspendidos
FROM Profesor p
INNER JOIN AsignaturasGrupo ag ON p.Codigo = ag.CodigoProfesor
INNER JOIN Alumno a ON a.CodigoGrupo = ag.CodigoGrupo
INNER JOIN AlumnoNota an ON a.Codigo = an.CodigoAlumno
WHERE an.Nota < 5
GROUP BY p.Codigo;

/*FINAL*/
SELECT p.Codigo, p.Nombre
FROM Profesor p
INNER JOIN AsignaturasGrupo ag ON p.Codigo = ag.CodigoProfesor
INNER JOIN Alumno a ON a.CodigoGrupo = ag.CodigoGrupo
INNER JOIN AlumnoNota an ON a.Codigo = an.CodigoAlumno
WHERE an.Nota < 5
GROUP BY p.Codigo, p.Nombre
HAVING COUNT(an.CodigoAlumno) > (
    SELECT COUNT(DISTINCT an2.CodigoAlumno) * 0.5
    FROM ies.alumnonota an2
    WHERE an2.Nota < 5
);