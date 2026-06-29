Week 2 — Sesión de Repaso y Entregas: Modificar datos sin destruir el negocio
-- ======================================
-- ENTREGA WEEK 2 — TECHSTORE INVENTARIO
-- Nombre: [Christian Velazquez]  |  Fecha: [28-06-2026]
-- ======================================

-- DROP DATABASE IF EXISTS techstore_inventario; ejecutar solo si ya se habia creado la base de datos 
CREATE DATABASE techstore_inventario;
USE techstore_inventario;

SELECT DATABASE();  -- debe imprimir 'techstore_inventario'

-- FASE 1
-- Crear la tabla productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_producto VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    stock_minimo INT DEFAULT 5,
    proveedor VARCHAR(100),
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear tabla ventas 
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Verifica
SHOW TABLES;
DESCRIBE productos;
DESCRIBE ventas;

-- Fase 2 — Cargar el catálogo y las primeras ventas
-- 2.1 — Insertar 20 productos
-- Cuatro categorías (Laptops, Periféricos, Audio, Componentes), precios entre $19 y $1,499, stock variado, algunos productos sin descripción (NULL).
INSERT INTO productos
    (codigo_producto, nombre, descripcion, categoria, precio, costo, stock, stock_minimo, proveedor, activo)
VALUES
    -- Laptops
    ('LAP001', 'Laptop HP Pavilion 15', 'Laptop Intel i5, 8GB RAM, 256GB SSD', 'Laptops', 799.99, 650.00, 12, 5, 'HP Inc', TRUE),
    ('LAP002', 'MacBook Air M2', 'Apple MacBook Air con chip M2, 8GB, 256GB', 'Laptops', 1299.99, 1050.00, 8, 3, 'Apple', TRUE),
    ('LAP003', 'Dell XPS 13', 'Ultrabook Dell XPS 13, i7, 16GB, 512GB SSD', 'Laptops', 1499.99, 1200.00, 5, 3, 'Dell', TRUE),
    ('LAP004', 'Lenovo ThinkPad', NULL, 'Laptops', 899.99, 720.00, 0, 5, 'Lenovo', FALSE),

    -- Periféricos
    ('PER001', 'Mouse Logitech MX Master 3', 'Mouse ergonómico inalámbrico', 'Perifericos', 99.99, 65.00, 35, 10, 'Logitech', TRUE),
    ('PER002', 'Teclado Mecánico Keychron K2', 'Teclado mecánico RGB, switches Gateron Brown', 'Perifericos', 89.99, 55.00, 20, 8, 'Keychron', TRUE),
    ('PER003', 'Webcam Logitech C920', 'Webcam Full HD 1080p', 'Perifericos', 79.99, 50.00, 15, 10, 'Logitech', TRUE),
    ('PER004', 'Hub USB-C 7 puertos', NULL, 'Perifericos', 45.99, 25.00, 50, 15, 'Anker', TRUE),
    ('PER005', 'Mouse Pad XL', 'Mouse pad gaming 90x40cm', 'Perifericos', 24.99, 10.00, 80, 20, 'SteelSeries', TRUE),
    ('PER006', 'Soporte Laptop Ajustable', 'Soporte ergonómico aluminio', 'Perifericos', 39.99, 20.00, 25, 10, 'Rain Design', TRUE),

    -- Audio
    ('AUD001', 'Audífonos Sony WH-1000XM5', 'Audífonos con cancelación de ruido', 'Audio', 399.99, 280.00, 10, 5, 'Sony', TRUE),
    ('AUD002', 'Audífonos Gaming HyperX', NULL, 'Audio', 79.99, 45.00, 30, 10, 'HyperX', TRUE),
    ('AUD003', 'Micrófono Blue Yeti', 'Micrófono USB profesional', 'Audio', 129.99, 85.00, 12, 6, 'Logitech', TRUE),
    ('AUD004', 'Parlantes Logitech Z623', 'Sistema 2.1, 200W', 'Audio', 149.99, 95.00, 8, 5, 'Logitech', TRUE),
    ('AUD005', 'Audífonos Bluetooth JBL', 'Audífonos inalámbricos portátiles', 'Audio', 49.99, 25.00, 2, 10, 'JBL', TRUE),

    -- Componentes
    ('COM001', 'SSD Samsung 1TB', 'SSD NVMe M.2 1TB', 'Componentes', 89.99, 60.00, 40, 15, 'Samsung', TRUE),
    ('COM002', 'RAM Corsair 16GB DDR4', '16GB (2x8GB) DDR4 3200MHz', 'Componentes', 79.99, 50.00, 25, 10, 'Corsair', TRUE),
    ('COM003', 'Monitor LG 27" 4K', 'Monitor IPS 27 pulgadas 4K', 'Componentes', 449.99, 320.00, 7, 5, 'LG', TRUE),
    ('COM004', 'Cable HDMI 2.1 - 2m', NULL, 'Componentes', 19.99, 8.00, 100, 30, 'Cable Matters', TRUE),
    ('COM005', 'Adaptador USB-C a HDMI', 'Adaptador 4K 60Hz', 'Componentes', 29.99, 15.00, 60, 20, 'Anker', TRUE);

-- 2.2 — Insertar 5 ventas iniciales
INSERT INTO ventas (producto_id, cantidad, precio_venta, total) VALUES
    (1,  2,  799.99, 1599.98),
    (5,  5,   99.99,  499.95),
    (6,  3,   89.99,  269.97),
    (11, 1,  399.99,  399.99),
    (16, 4,   89.99,  359.96);

-- Verifica
SELECT COUNT(*) FROM productos;  -- 20
SELECT COUNT(*) FROM ventas;     -- 5
SELECT categoria, COUNT(*) FROM productos GROUP BY categoria;

-- Fase 3 — UPDATE: el verbo más peligroso
-- Paso 1 — VERIFICAR (este bloque NO cambia nada)
SELECT nombre, precio, ROUND(precio * 1.10, 2) AS nuevo_precio
FROM productos
WHERE categoria = 'Audio';

-- Paso 2 — EJECUTAR (este bloque SÍ cambia los datos)
SET SQL_SAFE_UPDATES = 0;   -- quitas el seguro (Safe Updates) solo para este disparo
UPDATE productos
SET precio = precio * 1.10
WHERE categoria = 'Audio';
SET SQL_SAFE_UPDATES = 1;   -- vuelves a poner el seguro, de inmediato

-- Paso 3 — CONFIRMAR (¿quedó como esperaba?)
-- Corre solo este SELECT para comprobar el resultado real:
SELECT nombre, precio
FROM productos
WHERE categoria = 'Audio';

-- 3.2 — Reducir stock por las ventas hechas en Fase 2
-- Paso 1 — Abrir el borrador y aplicar los 5 cambios (a lápiz)
-- Selecciona y corre estos 6 statements juntos:
START TRANSACTION;

UPDATE productos SET stock = stock - 2 WHERE id = 1;   -- venta 1: 2 unidades
UPDATE productos SET stock = stock - 5 WHERE id = 5;   -- venta 2: 5 unidades
UPDATE productos SET stock = stock - 3 WHERE id = 6;   -- venta 3: 3 unidades
UPDATE productos SET stock = stock - 1 WHERE id = 11;  -- venta 4: 1 unidad
UPDATE productos SET stock = stock - 4 WHERE id = 16;  -- venta 5: 4 unidades

-- Paso 2 — Revisar el borrador ANTES de entregar
SELECT id, nombre, stock FROM productos WHERE id IN (1, 5, 6, 11, 16);

-- Paso 3 — Entregar en limpio (COMMIT)
COMMIT;

-- 3.3 — Marcar como inactivos los productos con stock bajo
-- Paso 1 — VERIFICAR quiénes están bajo mínimo

SELECT nombre, stock, stock_minimo
FROM productos
WHERE stock < stock_minimo;

-- Paso 2 — EJECUTAR el cambio

SET SQL_SAFE_UPDATES = 0;

UPDATE productos
SET activo = FALSE
WHERE stock < stock_minimo;

SET SQL_SAFE_UPDATES = 1;

-- Paso 3 — CONFIRMAR
SELECT nombre, stock, stock_minimo, activo
FROM productos
WHERE activo = FALSE;

--  ¿Notaste que fecha_actualizacion cambió sola? Verifícalo:
SELECT nombre, fecha_creacion, fecha_actualizacion FROM productos WHERE id IN (1, 5);
-- fecha_actualizacion debe ser HOY, fecha_creacion debe ser HOY también pero más temprano.

-- Fase 4 — DELETE: soft vs hard
-- 4.1 — Soft delete del Lenovo ThinkPad
-- Paso 1 — Agregar la columna deleted_at (esto es DDL: cambia la ESTRUCTURA)
ALTER TABLE productos ADD COLUMN deleted_at TIMESTAMP NULL;
-- Paso 2 — "Borrar" el Lenovo (que en realidad es un UPDATE)
UPDATE productos
SET deleted_at = CURRENT_TIMESTAMP
WHERE codigo_producto = 'LAP004';
-- Paso 3 — Ver el catálogo "vivo" (lo que vería un cliente)
SELECT id, nombre FROM productos WHERE deleted_at IS NULL;
-- Paso 4 — Auditar lo "borrado" (lo que el cliente NO ve, pero tú sí)
SELECT id, nombre, deleted_at FROM productos WHERE deleted_at IS NOT NULL;

-- 4.2 — Hard delete: ventas viejas
-- Paso 1 — VERIFICAR qué se borraría (antes de borrar nada)
SELECT *
FROM ventas
WHERE fecha_venta < '2023-01-01';

-- Paso 2 — EJECUTAR el DELETE
SET SQL_SAFE_UPDATES = 0;

DELETE FROM ventas WHERE fecha_venta < '2023-01-01';

SET SQL_SAFE_UPDATES = 1;

-- Paso 3 — CONFIRMAR que no perdimos nada
SELECT COUNT(*) FROM ventas;

-- Fase 5 — Una venta atómica de verdad
-- Paso 1 — Abrir la transacción y verificar que hay stock --
START TRANSACTION;

SELECT id, nombre, stock, precio
FROM productos
WHERE id = 9 AND stock >= 3 AND deleted_at IS NULL;

-- Paso 2 — Reducir el stock (a lápiz) --
UPDATE productos
SET stock = stock - 3
WHERE id = 9;
-- Paso 3 — Capturar el precio actual en una variable --
SELECT @precio_actual := precio FROM productos WHERE id = 9;

-- Paso 4 — Registrar la venta usando el precio capturado --
INSERT INTO ventas (producto_id, cantidad, precio_venta, total)
VALUES (9, 3, @precio_actual, @precio_actual * 3);

-- Paso 5 — Verificar las dos mitades antes de cerrar --
SELECT id, nombre, stock FROM productos WHERE id = 9;
SELECT * FROM ventas WHERE id = LAST_INSERT_ID();

-- Paso 6 — Cerrar la venta (COMMIT)
COMMIT;

-- Fase 6 — Entrega + 3 reportes bonus --
-- Reporte 1 — Productos en alerta de stock bajo (con prioridad)
 -- > "Dame los productos donde stock &lt; stock_minimo, mostrando cuántas unidades faltan, ordenados por urgencia (más faltantes primero). Excluye productos eliminados."
SELECT
    codigo_producto,
    nombre,
    categoria,
    stock,
    stock_minimo,
    stock_minimo - stock AS unidades_faltantes
FROM productos
WHERE stock < stock_minimo
  AND deleted_at IS NULL
ORDER BY unidades_faltantes DESC;

-- Reporte 2 — Margen de ganancia top 10
-- > "Dame los 10 productos con mayor margen absoluto (precio - costo), incluyendo el margen porcentual. Solo productos no eliminados (deleted_at IS NULL)."
SELECT
    nombre,
    categoria,
    precio,
    costo,
    precio - costo AS margen_abs,
    ROUND(((precio - costo) / precio) * 100, 2) AS margen_pct
FROM productos
WHERE deleted_at IS NULL
ORDER BY margen_abs DESC
LIMIT 10;

-- Reporte 3 — Revenue por categoría
-- > "Cuánto vendió cada categoría en total: número de ventas, unidades, revenue."
-- Nota: este query usa JOIN — herramienta de Week 4. Si todavía no
-- la viste, no te angusties. Lo presentamos aquí como aperitivo.
SELECT
    p.categoria,
    COUNT(v.id)      AS num_ventas,
    SUM(v.cantidad)  AS unidades,
    SUM(v.total)     AS revenue_total
FROM ventas v
JOIN productos p ON v.producto_id = p.id
GROUP BY p.categoria
ORDER BY revenue_total DESC;

COMMIT;




