-- Muestra los primeros 20 contactos con su nombre, correo e indica si son empresas
SELECT id, name, email, is_company
FROM res_partner
ORDER BY id
LIMIT 20;

-- Muestra los usuarios de Odoo con su identificador, nombre de acceso y nombre del contacto asociado
SELECT u.id, u.login, p.name AS nombre
FROM res_users u
JOIN res_partner p ON p.id = u.partner_id
ORDER BY u.id;

-- Muestra los productos con su nombre en español e inglés y su precio
SELECT id, name,
name->>'es_ES' AS nombre_es,
name->>'en_US' AS nombre_en,
list_price AS precio
FROM product_template
ORDER BY id;

-- Lista los módulos instalados, indicando su nombre, si son aplicaciones y su versión
SELECT name AS nombre_tecnico,
COALESCE(shortdesc->>'es_ES', shortdesc->>'en_US') AS nombre,
application AS es_aplicacion,
latest_version AS version
FROM ir_module_module
WHERE state = 'installed'
ORDER BY application DESC, name;

-- Cuenta cuántos módulos hay en cada estado
SELECT state AS estado, count(*) AS modulos
FROM ir_module_module
GROUP BY state
ORDER BY modulos DESC;

-- Cuenta el número total de tablas de la base de datos
SELECT count(*) AS tablas
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_type = 'BASE TABLE';

-- Muestra los 15 módulos asociados a más modelos
SELECT d.module AS modulo, count(*) AS modelos
FROM ir_model_data d
WHERE d.model = 'ir.model'
GROUP BY d.module
ORDER BY modelos DESC
LIMIT 15;

-- Muestra los modelos asociados al módulo Ventas y los nombres de sus tablas
SELECT m.model AS modelo,
replace(m.model, '.', '_') AS tabla
FROM ir_model m
JOIN ir_model_data d ON d.res_id = m.id AND d.model = 'ir.model'
WHERE d.module = 'sale'
ORDER BY m.model;

-- Resume la base de datos mostrando su nombre y el número de contactos, usuarios y módulos instalados
SELECT current_database() AS base_datos,
(SELECT count(*) FROM res_partner) AS contactos,
(SELECT count(*) FROM res_users) AS usuarios,
(SELECT count(*) FROM ir_module_module WHERE state = 'installed') AS modulos;

-- Muestra las cinco últimas facturas de cliente con su fecha, estado e importe total
SELECT name AS factura, invoice_date AS fecha,
state AS estado, amount_total AS total
FROM account_move
WHERE move_type = 'out_invoice'
ORDER BY id DESC
LIMIT 5;

-- Muestra parámetros de configuración relacionados con la identificación y neutralización de la base de datos y su URL
SELECT key AS parametro, value AS valor
FROM ir_config_parameter
WHERE key IN ('database.uuid', 'database.is_neutralized', 'web.base.url')
ORDER BY key; 

-- Cuenta las tareas automáticas activas e inactivas
SELECT count(*) FILTER (WHERE active) AS activas,
count(*) FILTER (WHERE NOT active) AS inactivas
FROM ir_cron;