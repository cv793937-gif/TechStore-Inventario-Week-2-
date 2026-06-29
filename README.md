TechStore Inventario (Week 2)
🎯 Resumen del Proyecto
Implementación completa del módulo de Inventario y Ventas para TechStore, utilizando MySQL con enfoque en buenas prácticas, auditoría, transacciones y control seguro de datos.
El proyecto cubre desde la creación de la base de datos hasta operaciones críticas como UPDATE, DELETE y ventas atómicas.

🧱 Arquitectura del Proyecto
El script está organizado en 6 fases, cada una con objetivos claros y verificación antes de ejecutar cambios:

Creación de la base y tablas principales

productos

ventas

Campos de auditoría (fecha_creacion, fecha_actualizacion)

Estructura robusta para inventarios reales.

Carga inicial del catálogo y ventas

20 productos en 4 categorías

5 ventas iniciales

Datos realistas con costos, precios y stock.

Operaciones críticas con UPDATE y transacciones

Incremento de precios por categoría

Reducción de stock basada en ventas

Activación/desactivación automática según stock

Uso correcto de SQL_SAFE_UPDATES

Transacciones con START TRANSACTION + COMMIT.

Soft delete vs Hard delete

Implementación de deleted_at

Borrado lógico para catálogo

Borrado físico para ventas antiguas

Auditoría clara de elementos eliminados.

Venta atómica real

Verificación de stock

Captura del precio actual

Inserción de venta y actualización de stock en una sola transacción

Garantía de consistencia ACID.

Reportes avanzados (Bonus)

Productos con stock bajo (priorizados)

Top 10 por margen de ganancia

Revenue por categoría con JOIN

Reportes listos para BI / dashboards.

🔥 Buenas Prácticas Aplicadas
✔ Control de cambios con Verificar → Ejecutar → Confirmar  
✔ Uso de transacciones para evitar inconsistencias
✔ Separación clara entre soft delete y hard delete  
✔ Auditoría automática con fecha_actualizacion  
✔ Queries seguros con SQL_SAFE_UPDATES  
✔ Catálogo limpio y filtrado con deleted_at IS NULL  
✔ Reportes listos para análisis empresarial
✔ Comentarios claros y estructura profesional del script

📊 Qué demuestra este proyecto
Este entregable muestra dominio en:

Diseño de bases de datos

SQL profesional (DDL, DML, transacciones, auditoría)

Inventarios reales

Control de stock

Procesos seguros de actualización

Reportes empresariales

Buenas prácticas de desarrollo backend


🏆 Valor para empresas
Este módulo es equivalente a lo que usan:

Sistemas de compras

ERP básicos

Inventarios de retail

E‑commerce

Control de almacén

Con este tipo de entregables demuestras que puedes trabajar en:

Data Analyst

SQL Developer

Backend Jr

Compras técnicas con manejo de datos

Inventario de TechStore - Semana 2
/
Foto de Bd 194827.png


BI con bases limpias
