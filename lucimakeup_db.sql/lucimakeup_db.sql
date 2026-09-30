-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-09-2026 a las 22:50:47
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lucimakeup_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(11) NOT NULL,
  `nombre_Categ` varchar(60) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `nombre_Categ`, `descripcion`) VALUES
(1, 'Maquillaje', 'Productos de maquillaje y cosmética'),
(2, 'Cuidado Personal', 'Productos para el cuidado de la piel y personal'),
(3, 'Estilo y Vida', 'Velas aromáticas y accesorios de hogar'),
(4, 'Papelería', 'Cuadernos, blocks y útiles de escritorio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `Nombre` varchar(200) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `Email` varchar(200) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idCliente`, `Nombre`, `Apellido`, `telefono`, `Email`, `Password`, `fecha_registro`) VALUES
(1, 'Adriana', 'María', '3001234567', 'adriana@gmail.com', '123456', '2026-08-26 14:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallepedido`
--

CREATE TABLE `detallepedido` (
  `idDetallePedido` int(11) NOT NULL,
  `Producto_idProducto` int(11) NOT NULL,
  `Pedido_idPedido` int(11) NOT NULL,
  `precio_Unitario` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `SubTotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detallepedido`
--

INSERT INTO `detallepedido` (`idDetallePedido`, `Producto_idProducto`, `Pedido_idPedido`, `precio_Unitario`, `cantidad`, `SubTotal`) VALUES
(1, 1, 1, 12000.00, 1, 12000.00),
(2, 2, 1, 8000.00, 1, 8000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_Pago` int(11) NOT NULL,
  `id_Pedido` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_Pago` varchar(30) NOT NULL,
  `estado_Pago` varchar(20) NOT NULL,
  `fecha_Pago` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`id_Pago`, `id_Pedido`, `monto`, `metodo_Pago`, `estado_Pago`, `fecha_Pago`) VALUES
(1, 1, 38000.00, 'Nequi', 'Aprobado', '2026-08-26 14:28:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `idPedido` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `subtotal` decimal(10,2) NOT NULL,
  `impuesto` decimal(10,2) NOT NULL DEFAULT 0.00,
  `costo_envio` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `Estado` varchar(70) NOT NULL,
  `Cliente_idCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`idPedido`, `fecha`, `subtotal`, `impuesto`, `costo_envio`, `total`, `Estado`, `Cliente_idCliente`) VALUES
(1, '2026-08-26 14:28:01', 30000.00, 0.00, 8000.00, 38000.00, 'Procesando', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idProducto` int(11) NOT NULL,
  `Nombre_Producto` varchar(70) NOT NULL,
  `descripcion_producto` varchar(200) NOT NULL,
  `Precio_Producto` decimal(10,2) NOT NULL,
  `Stock_Producto` int(11) NOT NULL,
  `Categoria_idCategoria` int(11) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idProducto`, `Nombre_Producto`, `descripcion_producto`, `Precio_Producto`, `Stock_Producto`, `Categoria_idCategoria`, `imagen`) VALUES
(101, 'Lapicero con diseño', 'Papelería - img/lapicerosDiseños.jpeg', 5000.00, 15, 1, 'img/lapicerosDiseños.jpeg'),
(102, 'Lápiz porta mina', 'Lápiz porta mina', 6500.00, 10, 1, 'img/lapizMina.jpeg'),
(103, 'Cartuchera con diseño', 'Cartuchera con diseño', 18000.00, 10, 1, 'img/cartuchera.jpeg'),
(104, 'Resaltadores con diseño', 'Resaltadores con diseño', 12000.00, 10, 1, 'img/resaltadores.jpeg'),
(105, 'Cuadernos surtidos', 'Cuadernos surtidos', 8000.00, 10, 1, 'img/cuadernos.jpeg'),
(106, 'Carpeta plástica', 'Carpeta plástica', 4500.00, 10, 1, 'img/carpeta.jpeg'),
(107, 'Cuaderno Zootopia', 'Cuaderno Zootopia', 9500.00, 10, 1, 'img/cuadernoZootopia.jpeg'),
(108, 'Block iris', 'Block iris', 7000.00, 10, 1, 'img/block.jpeg'),
(109, 'Morral unisex', 'Morral unisex', 45000.00, 10, 1, 'img/morrales.jpeg'),
(110, 'Llavero surtido', 'Llavero surtido', 4000.00, 10, 1, 'img/llavero.jpeg'),
(111, 'Llavero gato', 'Llavero gato', 5000.00, 10, 1, 'img/llaveroGato.jpeg'),
(201, 'Mascarilla Facial Bioaqua', 'Cuidado Personal', 5000.00, 20, 2, 'img/MascarillasHidratantes.jpeg'),
(202, 'Polvo Compacto Matte', 'Polvo Compacto Matte - Tonos: Claro, medio, oscuro', 38000.00, 10, 2, 'img/polvo.png'),
(203, 'Corrector Líquido de Ojeras', 'Corrector Líquido de Ojeras', 25000.00, 10, 2, 'img/corrector.jpeg'),
(204, 'Paleta de Sombras Nude', 'Paleta de Sombras Nude', 65000.00, 10, 2, 'img/sombras.jpeg'),
(205, 'Pestañina Volumen Extremo', 'Pestañina Volumen Extremo', 30000.00, 10, 2, 'img/pestañinaExtra.jpeg'),
(301, 'Termo térmico de acero', 'Estilo y Vida - img/termo.jpg', 35000.00, 10, 3, 'img/cojinesEstampados.jpeg'),
(302, 'Espejo con diseño', 'Espejo con diseño', 45000.00, 10, 3, 'img/espejoconDiseño.jpeg'),
(303, 'Soporte para computador portátil', 'Soporte para computador portátil', 55000.00, 10, 3, 'img/soportePC.jpeg'),
(304, 'Difusor de aroma electrónico', 'Difusor de aroma electrónico', 48000.00, 10, 3, 'img/difusorAroma.jpeg'),
(305, 'Vela con aroma', 'Vela con aroma', 22000.00, 10, 3, 'img/velaAromatica.jpeg'),
(306, 'Aceite esencial Lavanda', 'Aceite esencial Lavanda', 18000.00, 10, 3, 'img/aceiteEscencial.jpeg'),
(400, 'Acondicionador', 'Cuidado Capilar - img/cuidadocapilar.jpeg', 0.00, 10, 2, 'img/cuidadocapilar.jpeg'),
(401, 'Shampoo Todo tipo', 'Cuidado Capilar - img/shampoo.jpeg', 0.00, 10, 2, 'img/shampoo.jpeg'),
(402, 'Crema de peinar', 'Cuidado Capilar ', 0.00, 10, 2, 'img/cremaPeinar.jpeg'),
(403, 'Aceite de coco corporal', 'Cuidado Corporal - img/cuidadocorporal.jpeg', 0.00, 10, 2, NULL),
(404, 'Mantequilla corporal', 'Cuidado Corporal - img/mantequilla.jpeg', 0.00, 10, 2, NULL),
(405, 'Perfume con Glitter', 'Cuidado Corporal - img/perfumeGlitter.jpeg', 0.00, 10, 2, NULL),
(406, 'Gel de cejas', 'Maquillaje y Rostro - img/gelcejas.jpeg', 0.00, 10, 2, NULL),
(407, 'Rubor en barra', 'Maquillaje y Rostro - img/ruborBarra.jpeg', 0.00, 10, 2, NULL),
(408, 'Blush Líquido', 'Maquillaje y Rostro - img/blushLiquido.jpeg', 0.00, 10, 2, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`),
  ADD UNIQUE KEY `Email_UNIQUE` (`Email`);

--
-- Indices de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD PRIMARY KEY (`idDetallePedido`),
  ADD KEY `fk_DetallePedido_Pedido1_idx` (`Pedido_idPedido`),
  ADD KEY `fk_DetallePedido_Producto1_idx` (`Producto_idProducto`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_Pago`),
  ADD KEY `fk_Pago_Pedido1_idx` (`id_Pedido`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`idPedido`),
  ADD KEY `fk_Pedido_Cliente1_idx` (`Cliente_idCliente`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `fk_Producto_Categoria1_idx` (`Categoria_idCategoria`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  MODIFY `idDetallePedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_Pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `idPedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=409;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detallepedido`
--
ALTER TABLE `detallepedido`
  ADD CONSTRAINT `fk_DetallePedido_Pedido1` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_DetallePedido_Producto1` FOREIGN KEY (`Producto_idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `fk_Pago_Pedido1` FOREIGN KEY (`id_Pedido`) REFERENCES `pedido` (`idPedido`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_Pedido_Cliente1` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_Producto_Categoria1` FOREIGN KEY (`Categoria_idCategoria`) REFERENCES `categoria` (`idCategoria`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
