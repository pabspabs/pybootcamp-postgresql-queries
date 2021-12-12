--Reto 8 - Consultas DDL/DML

--1.1 Obtener los nombres de los productos de la tienda
SELECT nombre FROM articulos ORDER BY nombre;

--1.2 Obtener los nombres y los precios de los productos de la tienda
SELECT nombre, precio FROM articulos ORDER BY precio;

--1.3 Obtener el nombre de los productos cuyo precio sea menor o igual a 200€
SELECT nombre FROM articulos WHERE precio <= 200 ORDER BY nombre;

--1.4 Obtener todos los datos de los artículos cuyo precio esté entre los 60€ y los 120€ (ambas cantidades incluidas)
SELECT * FROM articulos WHERE (precio BETWEEN 60 AND 120) ORDER BY nombre;

--1.5 Obtener el nombre y precio en pesetas (es decir, el precio en euros multiplicado por 166'386)
SELECT nombre, ROUND(nombre * 166.386) as precio_pesetas FROM articulos ORDER BY precio;

--1.6 Seleccionar el precio medio de todos los productos
SELECT ROUND(AVG(precio),2) FROM articulos;

--1.7 Obtener el precio medio de los articulos cuyo fabricante sea 2
SELECT ROUND(AVG(precio),2) FROM articulos WHERE fabricante=2;

--1.8 Obtener el número de articulos cuyo precio sea mayor o igual a 180 €
SELECT COUNT(CODIGO) FROM articulos WHERE precio >= 180;

--1.9 Obtener el nombre y precio de los artículos cuyo precio sea mayor o igual a 180€ y ordenarlos descendentemente por precio y luego ascendentemente por nombre.
SELECT nombre, precio FROM articulos WHERE precio >=180 ORDER BY precio DESC, nombre ASC;

--1.10 Obtener un listado completo de artículos, incluyendo por cada articulo los datos del articulo y de su fabricante.
SELECT * 
FROM articulos 
INNER JOIN fabricantes 
ON articulos.fabricante = fabricantes.codigo;

--1.11 Obtener un listado de articulos incluyendo su nombre, su precio y el nombre del fabricante
SELECT
articulos.nombre as articulo,
articulos.precio as precio,
fabricantes.nombre as fabricante
FROM articulos
JOIN fabricantes
ON articulos.fabricante = fabricantes.codigo
ORDER BY articulos.nombre;


--1.12 Obtener el precio medio de los productos de cada fabricante, mostrando solo los códigos de fabricante:
SELECT
   fabricantes.codigo as codigo_fabricante, ROUND(AVG(articulos.precio),2) as precio_medio
FROM fabricantes
INNER JOIN articulos
ON fabricantes.codigo = articulos.fabricante
GROUP BY fabricantes.codigo
ORDER BY precio_medio;

--1.13 Obtener el precio medio de los productos de cada fabricante, mostrando el nombre del fabricante
SELECT
   fabricantes.nombre as nombre_fabricante, ROUND(AVG(articulos.precio),2) as precio_medio
FROM fabricantes
INNER JOIN articulos
ON fabricantes.codigo = articulos.fabricante
GROUP BY fabricantes.nombre
ORDER BY fabricantes.nombre;

--1.14 Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio sea mayor o igual a 150 €
SELECT fabricantes.nombre
FROM fabricantes
WHERE fabricantes.codigo IN (SELECT articulos.fabricante FROM articulos GROUP BY articulos.fabricante HAVING AVG(articulos.precio) >= 150);

--1.15 Obtener el nombre y el precio del articulo más barato
SELECT nombre, precio FROM articulos as nombre WHERE PRECIO = ( SELECT MIN(precio) FROM articulos );

--1.16 Obtener una lista con el nombre y precio de los articulos más caros de cada proveedor (incluyendo el nombre del proveedor)
SELECT fabricantes.nombre as proveedor, articulos.nombre, articulos.precio FROM articulos
JOIN fabricantes
   ON articulos.fabricante = fabricantes.codigo
WHERE precio IN(
   SELECT MAX(articulos.precio)
   FROM articulos
   GROUP BY fabricante
);

--1.17 Añadir nuevo producto: Altavoces, 70€, Fabricante 2
INSERT INTO articulos VALUES (11,'Altavoces',70,2);

--1.18 Cambiar el nombre del producto 8 a 'Impresora Laser'**
UPDATE articulos SET nombre = 'Impresora Laser' WHERE codigo = 8;

--1.19 Aplicar un descuento del 10% (multiplicar el precio por 0,9) a todos los productos**
ALTER TABLE articulos 
ADD COLUMN precio_dto decimal(10,2);
UPDATE articulos
SET precio_dto = precio * 0.9;

--1.20 Aplicar un descuento de 10€ a todos los productos cuyo precio sea mayor o igual a 120€**
UPDATE articulos
SET precio_dto = precio - 10
WHERE precio >= 120;
