# Base de Datos IES 📚

Base de datos educativa que gestiona información de un instituto de educación secundaria.

## Descripción

Este proyecto contiene una serie de consultas SQL para gestionar y analizar datos relacionados con:
- Alumnos
- Profesores
- Grupos
- Asignaturas
- Calificaciones

## Estructura de la Base de Datos

La base de datos contiene las siguientes tablas principales:
- `Alumno`: Información de estudiantes
- `Profesor`: Datos del profesorado
- `Grupo`: Grupos académicos
- `Asignatura`: Materias impartidas
- `AlumnoNota`: Calificaciones de los alumnos
- `AsignaturasGrupo`: Relación entre asignaturas y grupos

## Tipos de Consultas

El archivo incluye consultas para:
1. Búsquedas simples en una tabla
2. Consultas con joins entre múltiples tablas
3. Cálculos estadísticos (promedios, conteos)
4. Filtrado por condiciones específicas

## Ejemplos de Consultas

- Búsqueda de alumnos por municipio
- Listado de asignaturas por profesor
- Cálculo de notas medias
- Estadísticas de aprobados/suspensos
- Información de tutorías

## Requisitos

- MySQL Server
- Base de datos 'ies' creada y configurada
- Permisos de lectura/escritura en la base de datos

## Uso

1. Crear la base de datos:

`sql

CREATE DATABASE ies;

USE ies;`


2. Ejecutar las consultas según necesidad desde el archivo `EjerciciosPropuestos.sql`

## Contribución

Si deseas contribuir al proyecto, puedes:
1. Hacer fork del repositorio
2. Crear una rama para tus cambios
3. Enviar un pull request

## Licencia

Este proyecto está disponible como código abierto bajo la licencia MIT.