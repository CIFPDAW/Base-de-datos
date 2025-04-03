create database baloncesto;
use baloncesto;

CREATE TABLE arbitro  (
   id_arbitro  decimal(10,0) NOT NULL,
   nombre  varchar(50)    NOT NULL,
   nif  varchar(10)    NOT NULL,
   temporadas  decimal(10,0) NOT NULL,
   num_hijos  int NOT NULL,
   Provinciarbit  varchar(15)    NOT NULL,
  PRIMARY KEY ( id_arbitro )
);

--
-- Volcar la base de datos para la tabla  arbitro 
--

INSERT INTO  arbitro  ( id_arbitro ,  nombre ,  nif ,  temporadas ,  num_hijos ,  Provinciarbit ) VALUES
(1, 'Arencibia', '12345678B', 12, 2, 'Tenerife');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla  equipo 
--

CREATE TABLE equipo  (
   id_equipo  decimal(10,0) NOT NULL,
   nombre  varchar(150)    NOT NULL,
   maximo  int NOT NULL,
   provincia  varchar(15)    NOT NULL,
  PRIMARY KEY ( id_equipo )
);

--
-- Volcar la base de datos para la tabla  equipo 
--

INSERT INTO  equipo  ( id_equipo ,  nombre ,  maximo ,  provincia ) VALUES
(1, 'Real Madrid', 15, 'Madrid'),
(2, 'FC Barcelona', 15, 'Barcelona'),
(3, 'Canarias', 15, 'La Laguna'),
(5, 'Estudiantes', 15, 'Madrid'),
(6, 'Juventud', 15, 'Barcelona'),
(7, 'Unicaja', 15, 'Málaga'),
(9, 'Gran Canaria', 15, 'Gran Canaria');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla  jugador 
--

CREATE TABLE jugador  (
   id_jugador  decimal(10,0) NOT NULL,
   nombre  varchar(150)    NOT NULL,
   nif  varchar(10)    NOT NULL,
   equipo  decimal(10,0) DEFAULT NULL,
   fecha  date NOT NULL,
   num_hijos  int NOT NULL,
  PRIMARY KEY ( id_jugador )
);

--
-- Volcar la base de datos para la tabla  jugador 
--

INSERT INTO  jugador  ( id_jugador ,  nombre ,  nif ,  equipo ,  fecha ,  num_hijos ) VALUES
(1, 'Sergio Rodrí­guez', '12312312A', 1, '2012-09-01', 0),
(40, 'Luke Sigma', '12345678A', 3, '2015-10-10', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla  jugadorpartido 
--

CREATE TABLE jugadorpartido  (
   jugador  decimal(10,0) NOT NULL,
   partido  decimal(10,0) NOT NULL,
   faltasrecibidas  decimal(10,0) NOT NULL,
   faltascometidas  decimal(10,0) NOT NULL,
   puntos  decimal(10,0) NOT NULL,
   asistencias  int NOT NULL,
   rebotes  int NOT NULL,
   perdidas  int NOT NULL,
   recuperacion  int NOT NULL,
  PRIMARY KEY ( jugador , partido ),
);

--
-- Volcar la base de datos para la tabla  jugadorpartido 
--

INSERT INTO  jugadorpartido  ( jugador ,  partido ,  faltasrecibidas ,  faltascometidas ,  puntos ,  asistencias ,  rebotes ,  perdidas ,  recuperacion ) VALUES
(1, 1, 6, 2, 17, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla  partido 
--

CREATE TABLE partido  (
   id_partido  decimal(10,0) NOT NULL,
   jornada  date NOT NULL,
   cronica  text   ,
   local  decimal(10,0) NOT NULL,
   visitante  decimal(10,0) NOT NULL,
   arbitro  decimal(10,0) NOT NULL,
   puntos_local  int NOT NULL,
   puntos_visitante  int NOT NULL,
  PRIMARY KEY ( id_partido,local, visitante, arbitro ),
);

--
-- Volcar la base de datos para la tabla  partido 
--

INSERT INTO  partido  ( id_partido ,  jornada ,  cronica ,  local ,  visitante ,  arbitro ,  puntos_local ,  puntos_visitante ) VALUES
(1, '2013-10-05', 'Partido muy igualado que el Real Madrid resolviÃ³ en el tercer cuarto', 9, 1, 1, 0, 0);

--
-- Filtros para las tablas descargadas (dump)
--

--
-- Filtros para la tabla  jugador 
--
ALTER TABLE  jugador 
  ADD CONSTRAINT  jugador_ibfk_1  FOREIGN KEY ( equipo ) REFERENCES  equipo  ( id_equipo ) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla  jugadorpartido 
--
ALTER TABLE  jugadorpartido 
  ADD CONSTRAINT  jugadorpartido_ibfk_1  FOREIGN KEY ( jugador ) REFERENCES  jugador  ( id_jugador ) ON DELETE CASCADE ON UPDATE CASCADE;
  ALTER TABLE  jugadorpartido 
  ADD CONSTRAINT  jugadorpartido_ibfk_2  FOREIGN KEY ( partido ) REFERENCES  partido  ( id_partido ) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla  partido 
--
ALTER TABLE  partido 
  ADD CONSTRAINT  partido_ibfk_1  FOREIGN KEY ( local ) REFERENCES  equipo  ( id_equipo ) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT  partido_ibfk_2  FOREIGN KEY ( visitante ) REFERENCES  equipo  ( id_equipo ) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT  partido_ibfk_3  FOREIGN KEY ( arbitro ) REFERENCES  arbitro  ( id_arbitro ) ON UPDATE CASCADE;
