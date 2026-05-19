CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(100) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `rol` enum('admin','vendedor','bodeguero') NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  UNIQUE KEY `email` (`email`)
);
CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_categoria`)
);
CREATE TABLE `lote_ingreso` (
  `id_lote` int NOT NULL,
  `id_producto` int NOT NULL,
  `numero_lote_fabricante` varchar(30) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `cantidad_inicial` int NOT NULL,
  `cantidad_disponible` int NOT NULL,
  PRIMARY KEY (`id_lote`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `lote_ingreso_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`)
);
CREATE TABLE `movimiento_inventario` (
  `id_movimiento` int NOT NULL,
  `id_lote` int NOT NULL,
  `tipo` enum('ingreso','venta','merma') NOT NULL,
  `fecha_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  `cantidad` int NOT NULL,
  `saldo_lote_despues` int NOT NULL,
  PRIMARY KEY (`id_movimiento`),
  KEY `id_lote` (`id_lote`),
  CONSTRAINT `movimiento_inventario_ibfk_1` FOREIGN KEY (`id_lote`) REFERENCES `lote_ingreso` (`id_lote`)
);
CREATE TABLE `producto` (
  `id_producto` int NOT NULL,
  `codigo_unico` varchar(20) NOT NULL,
  `id_categoria` int NOT NULL,
  `nombre_comercial` varchar(100) NOT NULL,
  `principio_activo` varchar(100) DEFAULT NULL,
  `precio_venta` double(10,2) NOT NULL,
  `stock_actual` int DEFAULT '0',
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `codigo_unico` (`codigo_unico`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`)
);
CREATE TABLE `producto_proveedor` (
  `id_producto` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `precio_compra` double(10,2) NOT NULL,
  `tiempo_entrega_dias` int DEFAULT NULL,
  PRIMARY KEY (`id_producto`,`id_proveedor`),
  KEY `id_proveedor` (`id_proveedor`),
  CONSTRAINT `producto_proveedor_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `producto_proveedor_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`)
);
CREATE TABLE `producto_proveedor` (
  `id_producto` int NOT NULL,
  `id_proveedor` int NOT NULL,
  `precio_compra` double(10,2) NOT NULL,
  `tiempo_entrega_dias` int DEFAULT NULL,
  PRIMARY KEY (`id_producto`,`id_proveedor`),
  KEY `id_proveedor` (`id_proveedor`),
  CONSTRAINT `producto_proveedor_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `producto_proveedor_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`)
);
CREATE TABLE `proveedor` (
  `id_proveedor` int NOT NULL,
  `ruc` varchar(13) NOT NULL,
  `nombre_empresa` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE KEY `ruc` (`ruc`)
);
