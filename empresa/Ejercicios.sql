/* EJEMPLO SUBConsultas */
SELECT e.nombre, e.oficina, (SELECT o.localidad
                            FROM oficinas o
                            WHERE e.oficina = o.numoficina)
FROM empleados e;

SELECT o.numoficina, o.localidad
FROM oficinas o
WHERE objetivo > ANY (SELECT SUM(e.minimo)
                      FROM empleados e GROUP BY e.oficina);

SELECT o.numoficina, o.localidad
FROM oficinas o
WHERE objetivo > ALL (SELECT SUM(e.minimo)
                      FROM empleados e GROUP BY e.oficina);

/*1 Listar los nombres de los clientes que tienen asignado el representante Antonio Hernández (suponiendo que no pueden haber representantes con el mismo nombre).*/

SELECT c.nombre
FROM clientes c
WHERE c.repre IN (SELECT e.num
        FROM empleados e
        WHERE e.nombre LIKE "%Antonio Hernández%");

SELECT c.nombre
FROM clientes c
WHERE EXISTS (SELECT *
            FROM empleados e
            WHERE e.nombre LIKE "%Antonio Hernández%" AND c.repre = e.num);

/*2 Listar los vendedores (numemp, nombre, y nº de oficina) que trabajan en oficinas "buenas" (las que tienen ventas superiores a su objetivo).*/

SELECT e.num, e.nombre, e.oficina 'Oficinas Buenas'
FROM empleados e
WHERE e.oficina IN (SELECT o.numoficina
                    FROM oficinas o
                    WHERE o.objetivo < o.ventas);

/*3 Listar los vendedores que no trabajan en oficinas dirigidas por el empleado 108.*/

SELECT e.num ,e.nombre, e.oficina, e.superior
FROM empleados e
WHERE e.superior IN (SELECT o.dir
                     FROM oficinas o
                     WHERE o.dir != 108);

/*4 Listar los productos (idfab, idproducto y descripción) para los cuales no se ha
recibido ningún pedido de 25 o más.*/

SELECT p.idfab, p.idproducto, p.descripcion
FROM productos p
WHERE p.idproducto IN (SELECT pe.producto
                       FROM pedidos pe
                       WHERE pe.cantidad < 25);

/*5 Listar los clientes asignados a Ana Delgado que no han remitido un pedido superior a 30.*/

SELECT c.*
FROM clientes c
WHERE c.repre IN (SELECT e.num
                      FROM empleados e
                      WHERE e.nombre LIKE "Ana Delgado" AND e.num IN(
                                SELECT p.repre
                                FROM pedidos p
                                WHERE p.cantidad <= 30
                          ));

/*6 Listar las oficinas en donde haya un vendedor cuyas ventas representen más del
55% del objetivo de su oficina.*/

SELECT o.numoficina, o.dir, o.objetivo 'Objetivo',(o.objetivo * 0.55) '55%'
FROM oficinas o
WHERE EXISTS(SELECT *
            FROM empleados e
            WHERE e.num = o.dir AND e.ventas > (o.objetivo * 0.55));


/*7 Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% del objetivo de la oficina.*/

SELECT o.numoficina
FROM oficinas o
WHERE 0.5*o.objetivo < ALL(SELECT e.ventas
                         FROM empleados e
                         WHERE e.oficina = o.numoficina);

/*8 Listar las oficinas que tengan un objetivo mayor que la suma de las cuotas de sus
vendedores.*/

SELECT o.numoficina, o.objetivo
FROM oficinas o
WHERE o.objetivo < (SELECT SUM(e.ventas)
                    FROM empleados e
                    WHERE e.oficina = o.numoficina
                    GROUP BY e.oficina
);

