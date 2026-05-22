
-- BASE DE DATOS: AgroServicios
-- CONSULTAS SQL PARA ÁLGEBRA RELACIONAL

USE mi_proyectu1;

-- CONSULTA 1 — Selección con Proyección (σ + π combinados).
-- Mostrar el nombre del usuario, el tipo de movimiento que realizó y el número de lote que fue afectado.
-- Álgebra Relacional: π nombre_completo, tipo, numero_lote_fabricante (usuario ⨝ movimiento_inventario ⨝ lote_ingreso)

SELECT usuario.nombre_completo, movimiento_inventario.tipo, lote_ingreso.numero_lote_fabricante
FROM usuario
INNER JOIN movimiento_inventario ON usuario.id_usuario = movimiento_inventario.id_usuario
INNER JOIN lote_ingreso ON movimiento_inventario.id_lote = lote_ingreso.id_lote;

-- CONSULTA 2 — Proyección con JOIN (π + ⋈)

-- Mostrar RUC del proveedor y nombre comercial del producto que suministra.
-- Álgebra Relacional: π ruc, nombre_comercial (proveedor ⨝ producto_proveedor ⨝ producto)

SELECT proveedor.ruc, producto.nombre_comercial
FROM proveedor
INNER JOIN producto_proveedor ON proveedor.id_proveedor = producto_proveedor.id_proveedor
INNER JOIN producto ON producto_proveedor.id_producto = producto.id_producto;

-- CONSULTA 3 — Agrupamiento con función de agregación (γ)

-- Obtener por cada usuario, la cantidad total de movimientos que ha realizado.
-- Álgebra Relacional: γ nombre_completo; COUNT(id_movimiento) → total_movimientos (usuario ⨝ movimiento_inventario)

SELECT usuario.nombre_completo, COUNT(movimiento_inventario.id_movimiento) AS total_movimientos
FROM usuario
INNER JOIN movimiento_inventario ON usuario.id_usuario = movimiento_inventario.id_usuario
GROUP BY usuario.id_usuario, usuario.nombre_completo;

-- CONSULTA 4 — Reunión natural / JOIN (⋈)

-- Mostrar el nombre del producto, la categoría a la que pertenece, el número de lote y la fecha de vencimiento.
-- Álgebra Relacional: π nombre_comercial, nombre, numero_lote_fabricante, fecha_vencimiento(producto ⨝ categoria ⨝ lote_ingreso)

SELECT producto.nombre_comercial, categoria.nombre AS categoria, 
       lote_ingreso.numero_lote_fabricante, lote_ingreso.fecha_vencimiento
FROM producto
INNER JOIN categoria ON producto.id_categoria = categoria.id_categoria
INNER JOIN lote_ingreso ON producto.id_producto = lote_ingreso.id_producto;

-- CONSULTA 5 — Agrupamiento con función de agregación (γ)

-- Obtener por cada categoría, el precio de venta promedio de sus productos.
-- Álgebra Relacional: γ nombre; AVG(precio_venta) → precio_promedio (categoria ⋈ producto)

SELECT categoria.nombre AS categoria, AVG(producto.precio_venta) AS precio_promedio
FROM categoria
INNER JOIN producto ON categoria.id_categoria = producto.id_categoria
GROUP BY categoria.id_categoria, categoria.nombre;