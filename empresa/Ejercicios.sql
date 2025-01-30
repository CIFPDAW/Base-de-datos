/* EJEMPLO SUBConsultas */
SELECT e.nombre, e.oficina, (SELECT o.localidad
                            FROM oficinas o
                            WHERE e.oficina = o.numoficina)
FROM empleados e;

SELECT o.numoficina, o.localidad
FROM oficinas o
WHERE objetivo > ANY (SELECT SUM(e.minimo)
                      FROM empleados e GROUP BY e.oficina)

SELECT o.numoficina, o.localidad
FROM oficinas o
WHERE objetivo > ALL (SELECT SUM(e.minimo)
                      FROM empleados e GROUP BY e.oficina)