-- ============================================================
-- PROYECTO FORMATIVO SENA: LUCIMAKEUP STORE
-- EVIDENCIA: GA6-220501096-AA2-EV03 - Script base de datos
-- Versión: Compatible con MariaDB / XAMPP
-- ============================================================

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lucimakeup_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `lucimakeup_db` ;
CREATE SCHEMA IF NOT EXISTS `lucimakeup_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `lucimakeup_db` ;

-- -----------------------------------------------------
-- Table `lucimakeup_db`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lucimakeup_db`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  `Apellido` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(200) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lucimakeup_db`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lucimakeup_db`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre_Categ` VARCHAR(60) NOT NULL,
  `descripcion` VARCHAR(200) NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lucimakeup_db`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lucimakeup_db`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Producto` VARCHAR(70) NOT NULL,
  `descripcion_producto` VARCHAR(200) NOT NULL,
  `Precio_Producto` DECIMAL(10,2) NOT NULL,
  `Stock_Producto` INT NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Producto_Categoria1_idx` (`Categoria_idCategoria` ASC),
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `lucimakeup_db`.`Categoria` (`idCategoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lucimakeup_db`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lucimakeup_db`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subtotal` DECIMAL(10,2) NOT NULL,
  `impuesto` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `costo_envio` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `total` DECIMAL(10,2) NOT NULL,
  `Estado` VARCHAR(70) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `lucimakeup_db`.`Cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lucimakeup_db`.`DetallePedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lucimakeup_db`.`DetallePedido` (
  `idDetallePedido` INT NOT NULL AUTO_INCREMENT,
  `Producto_idProducto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `precio_Unitario` DECIMAL(10,2) NOT NULL,
  `cantidad` INT NOT NULL,
  `SubTotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idDetallePedido`),
  INDEX `fk_DetallePedido_Pedido1_idx` (`Pedido_idPedido` ASC),
  INDEX `fk_DetallePedido_Producto1_idx` (`Producto_idProducto` ASC),
  CONSTRAINT `fk_DetallePedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `lucimakeup_db`.`Pedido` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_DetallePedido_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `lucimakeup_db`.`Producto` (`idProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lucimakeup_db`.`Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lucimakeup_db`.`Pago` (
  `id_Pago` INT NOT NULL AUTO_INCREMENT,
  `id_Pedido` INT NOT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `metodo_Pago` VARCHAR(30) NOT NULL,
  `estado_Pago` VARCHAR(20) NOT NULL,
  `fecha_Pago` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_Pago`),
  INDEX `fk_Pago_Pedido1_idx` (`id_Pedido` ASC),
  CONSTRAINT `fk_Pago_Pedido1`
    FOREIGN KEY (`id_Pedido`)
    REFERENCES `lucimakeup_db`.`Pedido` (`idPedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- ============================================================
-- INSERCIÓN DE DATOS DE PRUEBA
-- ============================================================

INSERT INTO `Categoria` (`idCategoria`, `nombre_Categ`, `descripcion`) VALUES
(1, 'Maquillaje', 'Productos de maquillaje y cosmética'),
(2, 'Cuidado Personal', 'Productos para el cuidado de la piel y personal'),
(3, 'Estilo y Vida', 'Velas aromáticas y accesorios de hogar'),
(4, 'Papelería', 'Cuadernos, blocks y útiles de escritorio');

INSERT INTO `Cliente` (`idCliente`, `Nombre`, `Apellido`, `telefono`, `Email`, `Password`, `fecha_registro`) VALUES
(1, 'Adriana', 'María', '3001234567', 'adriana@gmail.com', '123456', NOW());

INSERT INTO `Producto` (`idProducto`, `Nombre_Producto`, `descripcion_producto`, `Precio_Producto`, `Stock_Producto`, `Categoria_idCategoria`) VALUES
(1, 'Brillo Gloss', 'Brillo labial hidratante', 12000.00, 50, 1),
(2, 'Block 100 hojas', 'Block iris escolar hojas de colores', 8000.00, 100, 4),
(3, 'Vela con aroma', 'Vela aromática ecológica relajante', 10000.00, 30, 3);

INSERT INTO `Pedido` (`idPedido`, `fecha`, `subtotal`, `impuesto`, `costo_envio`, `total`, `Estado`, `Cliente_idCliente`) VALUES
(1, NOW(), 30000.00, 0.00, 8000.00, 38000.00, 'Procesando', 1);

INSERT INTO `DetallePedido` (`idDetallePedido`, `Producto_idProducto`, `Pedido_idPedido`, `precio_Unitario`, `cantidad`, `SubTotal`) VALUES
(1, 1, 1, 12000.00, 1, 12000.00),
(2, 2, 1, 8000.00, 1, 8000.00),
(3, 3, 1, 10000.00, 1, 10000.00);

INSERT INTO `Pago` (`id_Pago`, `id_Pedido`, `monto`, `metodo_Pago`, `estado_Pago`, `fecha_Pago`) VALUES
(1, 1, 38000.00, 'Nequi', 'Aprobado', NOW());

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;