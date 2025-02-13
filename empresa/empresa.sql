-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-11-2019 a las 13:16:32
-- Versión del servidor: 10.3.16-MariaDB
-- Versión de PHP: 7.1.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `empresa`
--

CREATE DATABASE IF NOT EXISTS `empresa`;
USE `empresa`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `clie` int(11) NOT NULL DEFAULT 0,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `repre` tinyint(4) DEFAULT NULL,
  `credito` decimal(19,4) DEFAULT 0.0000,
  `Pago` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`clie`, `nombre`, `repre`, `credito`, `Pago`) VALUES
(2101, 'Luis Lázaro S.L.', 106, '65000.0000', 'Contado'),
(2102, 'Antonio Castro', 101, '65000.0000', 'A plazos'),
(2103, 'Jaime Campoy', 105, '50000.0000', 'Contado'),
(2105, 'Antonio García', 101, '45000.0000', '60 días'),
(2106, 'Juan Rodríguez', 102, '65000.0000', '30 Días'),
(2107, 'Julián Pérez', 110, '35000.0000', NULL),
(2108, 'Juana Mª Martín', 109, '55000.0000', NULL),
(2109, 'Alberto de Funes', 103, '25000.0000', NULL),
(2111, 'Cristóbal Rodríguez', 103, '50000.0000', NULL),
(2112, 'María Solano', 108, '50000.0000', NULL),
(2113, 'Luisa Peña', 104, '20000.0000', NULL),
(2114, 'Cristina Ruiz', 102, '20000.0000', NULL),
(2115, 'Vicente López', 101, '20000.0000', NULL),
(2117, 'Carline Fischer', 106, '35000.0000', NULL),
(2118, 'Juan Álvarez', 108, '60000.0000', NULL),
(2119, 'Samuel González', 109, '25000.0000', NULL),
(2120, 'Juan Maldonado', 102, '50000.0000', NULL),
(2121, 'Vicente Ros', 103, '45000.0000', NULL),
(2122, 'José Luís Ríos', 105, '30000.0000', NULL),
(2123, 'José Pestano', 102, '40000.0000', NULL),
(2124, 'Juan Mora', 107, '40000.0000', NULL),
(2125, 'Yeray Pérez', 108, '50000.0000', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `num` tinyint(4) NOT NULL DEFAULT 0,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `edad` tinyint(4) DEFAULT 0,
  `oficina` tinyint(4) DEFAULT 0,
  `cargo` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fcontrato` datetime DEFAULT NULL,
  `superior` tinyint(4) DEFAULT NULL,
  `minimo` decimal(19,4) DEFAULT 0.0000,
  `ventas` decimal(19,4) DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`num`, `nombre`, `edad`, `oficina`, `cargo`, `fcontrato`, `superior`, `minimo`, `ventas`) VALUES
(101, 'Antonio Hernández', 25, 12, 'representante', '1998-10-20 00:00:00', 104, '300000.0000', '305000.0000'),
(102, 'Álvaro Jorge', 48, 21, 'representante', '1998-12-10 00:00:00', 108, '350000.0000', '474000.0000'),
(103, 'Juan Castro', 29, 12, 'representante', '1999-03-01 00:00:00', 104, '275000.0000', '286000.0000'),
(104, 'José Luís Díaz', 33, 12, 'Dir Ventas', '1998-06-19 00:00:00', 106, '200000.0000', '143000.0000'),
(105, 'Vicente Delgado', 37, 13, 'representante', '1988-02-12 00:00:00', 104, '350000.0000', '368000.0000'),
(106, 'Luís González', 52, 11, 'Dir General', '1997-12-10 00:00:00', NULL, '275000.0000', '299000.0000'),
(107, 'Jorge Gimera', 49, 22, 'representante', '1998-11-14 00:00:00', 108, '300000.0000', '186000.0000'),
(108, 'Ana Delgado', 62, 21, 'Dir Ventas', '1998-07-12 00:00:00', 106, '300000.0000', '361000.0000'),
(109, 'María Jiménez', 31, 11, 'representante', '1999-10-12 00:00:00', 106, '300000.0000', '392000.0000'),
(110, 'Víctor Henríquez', 41, NULL, 'representante', '1997-12-10 00:00:00', 104, '0.0000', '76000.0000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oficinas`
--

CREATE TABLE `oficinas` (
  `numoficina` tinyint(4) NOT NULL DEFAULT 0,
  `localidad` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `zona` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `dir` tinyint(4) DEFAULT 0,
  `objetivo` decimal(19,4) DEFAULT 0.0000,
  `ventas` decimal(19,4) DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `oficinas`
--

INSERT INTO `oficinas` (`numoficina`, `localidad`, `zona`, `dir`, `objetivo`, `ventas`) VALUES
(11, 'Castellón', 'este', 106, '575000.0000', '693000.0000'),
(12, 'Alicante', 'este', 104, '800000.0000', '735000.0000'),
(13, 'Tarragona', 'este', 105, '350000.0000', '368000.0000'),
(21, 'Cáceres', 'oeste', 108, '725000.0000', '836000.0000'),
(22, 'Pontevedra', 'oeste', 108, '300000.0000', '186000.0000'),
(23, 'Toledo', 'centro', 108, '0.0000', '0.0000'),
(24, 'Madrid', 'centro', 108, '250000.0000', '150000.0000'),
(26, 'Bilbao', 'norte', NULL, '0.0000', '0.0000'),
(28, 'Valencia', 'este', NULL, '900000.0000', '0.0000'),
(99, 'tenerife CC', 'sur', 0, '500000.0000', '700000.0000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `codigo` int(11) NOT NULL,
  `numpedido` varchar(6) DEFAULT NULL,
  `fpedido` datetime DEFAULT NULL,
  `cliente` int(11) DEFAULT 0,
  `repre` tinyint(4) DEFAULT 0,
  `fab` varchar(3) DEFAULT NULL,
  `producto` varchar(5) DEFAULT NULL,
  `cantidad` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`codigo`, `numpedido`, `fpedido`, `cliente`, `repre`, `fab`, `producto`, `cantidad`) VALUES
(39, '112989', '1997-12-10 00:00:00', 2101, 106, 'fea', '114', 6),
(34, '112968', '1990-01-11 00:00:00', 2102, 101, 'aci', '41004', 34),
(33, '112963', '1997-05-10 00:00:00', 2103, 105, 'aci', '41004', 28),
(37, '112983', '1997-05-10 00:00:00', 2103, 105, 'aci', '41004', 6),
(38, '112987', '1997-01-01 00:00:00', 2103, 105, 'aci', '4100y', 11),
(48, '113027', '1997-02-05 00:00:00', 2103, 105, 'aci', '41002', 54),
(41, '112993', '1997-03-10 00:00:00', 2106, 102, 'rei', '2a45c', 24),
(59, '113065', '1997-06-03 00:00:00', 2106, 102, 'qsa', 'xk47', 6),
(31, '110036', '1997-01-02 00:00:00', 2107, 110, 'aci', '4100z', 9),
(49, '113034', '1997-11-05 00:00:00', 2107, 110, 'rei', '2a45c', 8),
(43, '113003', '1997-05-05 00:00:00', 2108, 109, 'imm', '779c', 3),
(55, '113055', '1997-04-01 00:00:00', 2108, 101, 'aci', '4100x', 6),
(57, '113058', '1989-07-04 00:00:00', 2108, 109, 'fea', '112', 10),
(60, '113069', '1997-08-01 00:00:00', 2109, 107, 'imm', '773c', 22),
(35, '112975', '1997-02-11 00:00:00', 2111, 113, 'rei', '2a44g', 6),
(45, '113012', '1997-05-05 00:00:00', 2111, 105, 'aci', '41003', 35),
(56, '113057', '1997-11-01 00:00:00', 2111, 103, 'aci', '4100x', 24),
(44, '113007', '1997-01-01 00:00:00', 2112, 108, 'imm', '773c', 3),
(51, '113045', '1997-07-02 00:00:00', 2112, 108, 'rei', '2a44r', 10),
(50, '113042', '1997-01-01 00:00:00', 2113, 101, 'rei', '2a44r', 5),
(36, '112979', '1989-10-12 00:00:00', 2114, 108, 'aci', '4100z', 6),
(47, '113024', '1997-07-04 00:00:00', 2114, 108, 'qsa', 'xk47', 20),
(32, '110036', '1997-01-02 00:00:00', 2117, 106, 'rei', '2a44l', 7),
(40, '112992', '1990-04-15 00:00:00', 2118, 108, 'aci', '41002', 10),
(46, '113013', '1997-08-06 00:00:00', 2118, 108, 'bic', '41003', 1),
(53, '113049', '1997-04-04 00:00:00', 2118, 108, 'qsa', 'xk47', 2),
(54, '113051', '1997-07-06 00:00:00', 2118, 108, 'qsa', 'xk47', 4),
(52, '113048', '1997-02-02 00:00:00', 2120, 102, 'imm', '779c', 2),
(42, '112997', '1997-04-04 00:00:00', 2124, 107, 'bic', '41003', 1),
(58, '113062', '1997-07-04 00:00:00', 2124, 107, 'bic', '41003', 10),
(61, '100', '2009-11-19 00:00:00', 2125, 108, 'fea', 'aci', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idfab` varchar(3) DEFAULT NULL,
  `idproducto` varchar(5) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `precio` decimal(19,4) DEFAULT 0.0000,
  `stock` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idfab`, `idproducto`, `descripcion`, `precio`, `stock`) VALUES
('fec', '112', 'cubo', '1.4800', 115),
('fec', '114', 'cubo', '2.4300', 15),
('rei', '2a44g', 'pas', '3.5000', 14),
('rei', '2a44l', 'bomba l', '450.0000', 12),
('rei', '2a44r', 'bomba r', '450.0000', 12),
('rei', '2a45c', 'Junta', '7.9000', 210),
('aci', '41001', 'Arandela', '0.5800', 277),
('aci', '41002', 'Bisagra', '0.8000', 167),
('aci', '41003', 'Art. T3', '1.1200', 207),
('bic', '41003', 'manivela', '6.5200', 3),
('aci', '41004', 'Art. T4', '1.2300', 139),
('aci', '4100x', 'junta', '0.2600', 37),
('aci', '4100y', 'extractor', '288.0000', 25),
('aci', '4100z', 'mont', '262.0000', 28),
('bic', '41089', 'Rodamiento', '2.2500', 78),
('bic', '41672', 'Plato', '1.8000', 0),
('imn', '773c', 'reostato', '9.7500', 28),
('imn', '775c', 'reostato 2', '14.2500', 5),
('imn', '779c', 'reostato 3', '18.7500', 0),
('imn', '887h', 'caja clavos', '5.4000', 223),
('imn', '887p', 'Perno', '2.5000', 24),
('imn', '887x', 'Manivela', '4.7500', 32),
('qsa', 'xk47', 'red', '3.5500', 38),
('qsa', 'xk48', 'red', '1.3400', 203),
('qsa', 'xk48a', 'red', '1.1700', 37);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`clie`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`num`);

--
-- Indices de la tabla `oficinas`
--
ALTER TABLE `oficinas`
  ADD PRIMARY KEY (`numoficina`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD KEY `codigo` (`codigo`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD KEY `idfab` (`idfab`),
  ADD KEY `idproducto` (`idproducto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
