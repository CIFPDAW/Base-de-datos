-- 1. Crear un procedimiento para reemplazar un valor "null" por el texto "No tiene" del atributo num_hijos asociados a la tabla jugador y árbitro. Incluir también el script para probarlo.
CREATE OR ALTER PROCEDURE pa_reemplazarNull
    AS BEGIN
        UPDATE jugador
        SET num_hijos = 0
        WHERE num_hijos IS NULL;

        UPDATE arbitro
        SET num_hijos = 0
        WHERE num_hijos IS NULL;
    END;

-- Script para probarlo:
exec pa_reemplazarNull;

-- 2. Cree el procedimiento para que muestre los equipos que tienen más de quince jugadores en ficha. Incluir también el script para probarlo.
CREATE OR ALTER PROCEDURE pa_equiposJugadores
    AS BEGIN
        SELECT e.nombre AS equipo, COUNT(r.id_jugador) AS total_jugadores
        FROM equipo e
        JOIN reserva r ON e.id_equipo = r.id_equipo
        GROUP BY e.id_equipo
        HAVING COUNT(r.id_jugador) > 15;
    END;


-- Script para probarlo:
exec pa_equiposJugadores;

-- 3. Cree un script para que muestre el MVP (Jugador Mejor Valorado) de un partido, para hacer este cálculo se tiene como referencia lo siguiente:
-- a. Puntos acertados = +1 x nº de puntos.
-- b. Faltas cometidas = -1 x faltacometida.
-- c. Faltas recibidas = + 0,5 x faltarecibida.
-- d. Asistencias = +1 x asistencia.
-- e. Perdidas = -1 x perdida.
-- f. Recuperación = + 1 x recuperación
-- Ejemplo: Si Sergio Rodríguez contra el Gran Canaria tiene: 20 puntos, 3 faltas cometidas, 2 recibidas, 1 asistencia, 2 pérdidas y 3 recuperaciones hace una valoración de: 20 – 3 + 1 + 1 – 2 + 3 = 20. (Poner un ejemplo de su ejecución)

-- 4. Cree una vista que guarde las fechas, equipos y árbitros ordenador por fecha.

CREATE OR ALTER VIEW vi_Arbitros AS
SELECT p.fecha, e1.nombre equipo_local, e2.nombre equipo_visitante, a.nombre arbitro 
FROM partido p
INNER JOIN equipo e1 ON p.local = e1.id_equipo
INNER JOIN equipo e2 ON p.visitante = e2.id_equipo
INNER JOIN arbitro a ON p.arbitro = a.id_arbitro
ORDER BY p.fecha;

-- 5. Cree un proc. Almacenado para que muestre las provincias con más de cinco equipos.

CREATE OR ALTER PROCEDURE pa_provinciasMasCincoEquipos
    AS BEGIN
        SELECT provincia, COUNT(*) total_equipos
        FROM equipo
        GROUP BY provincia
        HAVING COUNT(*) > 5;
    END;

-- 6. Procedimiento que muestre la relación de jugadores con su nombre y fecha de incorporación al indicar como parámetro el nombre del equipo. Ejercicio de vistas y procedimientos
-- 7. Procedimiento que muestre el jugador del partido con su nombre, equipo y estadística al indicar como parámetro el código del partido, si no se introduce el código del partido se mostrará por pantalla como un error y se sale de la ejecución.
-- 8. Cree una vista que muestre los MVP de cada jornada.

CREATE OR ALTER VIEW vi_mvp_jornada AS
SELECT p.jornada, 
       j.nombre jugador_mvp
FROM jugadorpartido jp
INNER JOIN jugador j ON jp.jugador = j.id_jugador
INNER JOIN partido p ON jp.partido = p.id_partido
ORDER BY p.jornada, valoracion DESC;
