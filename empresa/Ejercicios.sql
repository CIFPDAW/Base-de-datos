/* EJEMPLO SUBConsultas */
SELECT e.nombre,
       e.oficina,
       (SELECT o.localidad
        FROM oficinas o
        WHERE e.oficina = o.numoficina)
FROM empleados e;

SELECT o.numoficina, o.localidad
FROM oficinas o
WHERE objetivo > ANY (SELECT SUM(e.minimo)
                      FROM empleados e
                      GROUP BY e.oficina);

SELECT o.numoficina, o.localidad
FROM oficinas o
WHERE objetivo > ALL (SELECT SUM(e.minimo)
                      FROM empleados e
                      GROUP BY e.oficina);

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
              WHERE e.nombre LIKE "%Antonio Hernández%"
                AND c.repre = e.num);

/*2 Listar los vendedores (numemp, nombre, y nº de oficina) que trabajan en oficinas "buenas" (las que tienen ventas superiores a su objetivo).*/

SELECT e.num, e.nombre, e.oficina 'Oficinas Buenas'
FROM empleados e
WHERE e.oficina IN (SELECT o.numoficina
                    FROM oficinas o
                    WHERE o.objetivo < o.ventas);

/*3 Listar los vendedores que no trabajan en oficinas dirigidas por el empleado 108.*/

SELECT e.num, e.nombre, e.oficina, e.superior
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
                  WHERE e.nombre LIKE "Ana Delgado"
                    AND e.num IN (SELECT p.repre
                                  FROM pedidos p
                                  WHERE p.cantidad <= 30));

/*6 Listar las oficinas en donde haya un vendedor cuyas ventas representen más del
55% del objetivo de su oficina.*/

SELECT o.numoficina, o.dir, o.objetivo 'Objetivo', (o.objetivo * 0.55) '55%'
FROM oficinas o
WHERE EXISTS(SELECT *
             FROM empleados e
             WHERE e.num = o.dir
               AND e.ventas > (o.objetivo * 0.55));


/*7 Listar las oficinas en donde todos los vendedores tienen ventas que superan al 50% del objetivo de la oficina.*/

SELECT o.numoficina
FROM oficinas o
WHERE 0.5 * o.objetivo < ALL (SELECT e.ventas
                              FROM empleados e
                              WHERE e.oficina = o.numoficina);

/*8 Listar las oficinas que tengan un objetivo mayor que la suma de las cuotas de sus
vendedores.*/

SELECT o.numoficina, o.objetivo
FROM oficinas o
WHERE o.objetivo < (SELECT SUM(e.ventas)
                    FROM empleados e
                    WHERE e.oficina = o.numoficina
                    GROUP BY e.oficina);


/* ACTUALIZACIONES */

/*6. Añadir una nueva oficina para la ciudad de Madrid, con el número de
oficina 30, con un objetivo de 100000 y región Centro.*/

INSERT INTO oficinas (numoficina, localidad, zona, objetivo)
VALUES (69, 'Madrid', 'Centro', 100000);

SELECT *
FROM oficinas o
WHERE numoficina = 30;

/*7. Cambiar los empleados de la oficina 21 a la oficina 30.*/

UPDATE empleados e
SET e.oficina = 30
WHERE e.oficina = 21;

SELECT *
FROM empleados e
WHERE e.oficina = 30;

/*8. Eliminar los pedidos del empleado 105.*/

DELETE p.*
FROM pedidos p
WHERE p.repre = 105;

SELECT p.*
FROM pedidos p
WHERE p.repre = 105;

/*BORRAR todos los pedidos del empleado Alvaro Jorge*/

SELECT e.*
FROM empleados e
WHERE e.nombre LIKE "%Alvaro%";

DELETE p.*
FROM pedidos p
WHERE p.repre = (SELECT e.num
                 FROM empleados e
                 WHERE e.nombre LIKE "Alvaro Jorge");

SELECT p.*
FROM pedidos p
WHERE p.repre = (SELECT e.num
                 FROM empleados e
                 WHERE e.nombre LIKE "Alvaro Jorge");

/*9. Eliminar las oficinas que no tengan empleados.*/

SELECT o.numoficina
FROM oficinas o;

SELECT o.numoficina, COUNT(e.num) AS num_empleados
FROM empleados e
         INNER JOIN oficinas o ON e.oficina = o.numoficina
GROUP BY o.numoficina;

DELETE
FROM oficinas
WHERE numoficina NOT IN (SELECT DISTINCT e.oficina
                         FROM empleados e);

/*1 Crear la tabla empleados y definir su clave principal en la misma
instrucción de creación.*/

CREATE TABLE empleados2
(
    num       tinyint,
    nombre    varchar(50),
    edad      tinyint,
    oficina   tinyint,
    cargo     varchar(20),
    fcontrato datetime,
    superior  tinyint,
    minimo    decimal(19, 4),
    ventas    decimal(19, 4),
    CONSTRAINT pke1 PRIMARY KEY (num)
);

/*2 Crear la tabla oficinas con su clave principal y su clave foránea ( la
columna dir contiene el código de empleado del director de la oficina luego es
un campo que hace referencia a un empleado luego es clave foránea y hace
referencia a la tabla empleados).*/

CREATE TABLE oficinas2
(
    numofcina tinyint,
    localidad varchar(30),
    zona      varchar(10),
    dir       tinyint,
    objetivo  decimal(19, 4),
    ventas    decimal(19, 4),
    CONSTRAINT pko1 PRIMARY KEY (numofcina),
    CONSTRAINT fko1 FOREIGN KEY (dir) REFERENCES empleados2 (num)
);

/*3 Crear la tabla productos con su clave principal.*/

CREATE TABLE productos1
(
    idfab       VARCHAR(3),
    idproducto  VARCHAR(5),
    descripcion VARCHAR(50),
    precio      DECIMAL(19, 4),
    stock       INT,
    CONSTRAINT pkp1 PRIMARY KEY (idfab, idproducto)
);

/*4 Crear la tabla clientes también con todas sus claves y sin la columna
limitecredito.*/

CREATE TABLE clientes1
(
    clie   int,
    nombre varchar(50),
    repre  tinyint,
    Pago   varchar(10),
    CONSTRAINT pkc1 PRIMARY KEY (clie)
);

/*5 Crear la tabla pedidos sin clave principal, con la clave foránea que hace
referencia a los productos, la que hace referencia a clientes y la que indica el
representante (empleado) que ha realizado el pedido.*/

CREATE TABLE pedidos1
(
    codigo    int,
    numpedido varchar(6),
    fpedido   datetime,
    cliente   int,
    repre     tinyint,
    fab       varchar(3),
    producto  varchar(5),
    cantidad  int,
    CONSTRAINT fkp1 FOREIGN KEY (cliente) REFERENCES clientes1 (clie),
    CONSTRAINT fkp2 FOREIGN KEY (fab, producto) REFERENCES productos1 (idfab, idproducto),
    CONSTRAINT fkp3 FOREIGN KEY (repre) REFERENCES empleados2 (num)
);

/*6 Añadir a la definición de clientes la columna limitecredito.*/

ALTER TABLE clientes1 ADD limitecredito decimal(19, 4);

/*7 Añadir a la tabla empleados las claves foráneas que le faltan. (Si no tienes
claro cuales son te lo decimos ahora: la columna oficina indica la oficina donde
trabaja el empleado y la columna director indica quién dirige al empleado, su
jefe inmediato).*/

ALTER TABLE empleados2 ADD CONSTRAINT fke1 Foreign Key (oficina) REFERENCES oficinas2(numofcina),
                            ADD CONSTRAINT  fke2 FOREIGN KEY (superior) REFERENCES empleados2(num);

/*8 Hacer que no puedan haber dos empleados con el mismo nombre*/

ALTER TABLE empleados2 ADD UNIQUE (nombre);

/*9 Añadir a la tabla de pedidos la definición de clave principal.*/

ALTER TABLE pedidos1 ADD CONSTRAINT pkp1 PRIMARY KEY (codigo);

/*10 Definir un índice sobre la columna region de la tabla de oficinas.*/



/*11 Eliminar el índice creado.*/