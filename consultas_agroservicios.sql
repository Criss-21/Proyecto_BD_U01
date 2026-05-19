
-- BASE DE DATOS: AgroServicios
-- CONSULTAS SQL PARA ÁLGEBRA RELACIONAL

USE mi_proyectou1;

-- CONSULTA 1 — Selección con Proyección (σ + π combinados)

-- Descripción: Listar nombre completo del usuario y tipo de movimiento que realizó
-- Álgebra Relacional: π nombre_completo, tipo (usuario ⨝ movimiento_inventario)

SELECT usuario.nombre_completo, movimiento_inventario.tipo
FROM usuario
INNER JOIN movimiento_inventario ON usuario.id_usuario = movimiento_inventario.id_usuario;

-- CONSULTA 2 — Proyección con JOIN (π + ⋈)

-- Descripción: Mostrar RUC del proveedor y nombre comercial del producto que suministra
-- Álgebra Relacional: π ruc, nombre_comercial (proveedor ⨝ producto_proveedor ⨝ producto)

SELECT proveedor.ruc, producto.nombre_comercial
FROM proveedor
INNER JOIN producto_proveedor ON proveedor.id_proveedor = producto_proveedor.id_proveedor
INNER JOIN producto ON producto_proveedor.id_producto = producto.id_producto;

-- CONSULTA 3 — Selección con Proyección (σ + π combinados)

-- Descripción: Listar nombre de usuario y tipo de movimiento que realizó
-- Álgebra Relacional: π nombre_completo, tipo (usuario ⨝ movimiento_inventario)

SELECT usuario.nombre_completo, movimiento_inventario.tipo
FROM usuario
INNER JOIN movimiento_inventario ON usuario.id_usuario = movimiento_inventario.id_usuario;

-- CONSULTA 4 — Reunión natural / JOIN (⨝)

-- Descripción: Mostrar RUC del proveedor y nombre comercial del producto que suministra
-- Álgebra Relacional: π ruc, nombre_comercial (proveedor ⨝ producto_proveedor ⨝ producto)

SELECT proveedor.ruc, producto.nombre_comercial
FROM proveedor 
INNER JOIN producto_proveedor ON proveedor.id_proveedor = producto_proveedor.id_proveedor
INNER JOIN producto ON producto_proveedor.id_producto = producto.id_producto;

-- CONSULTA 5 — Agrupamiento con función de agregación (γ)

-- Descripción: Obtener por cada categoría, el precio de venta promedio de sus productos
-- Álgebra Relacional: γ nombre; AVG(precio_venta) → precio_promedio (categoria ⋈ producto)

SELECT categoria.nombre AS categoria, AVG(producto.precio_venta) AS precio_promedio
FROM categoria 
INNER JOIN producto ON categoria.id_categoria = producto.id_categoria
GROUP BY categoria.id_categoria, categoria.nombre;