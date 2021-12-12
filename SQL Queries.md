# Reto 8 - Consultas DDL/DML

**1.1 Obtener los nombres de los productos de la tienda**
```SQL
SELECT nombre FROM articulos ORDER BY nombre;
```
Output:
```plaintext
     nombre      
-----------------
 CD drive
 DVD burner
 DVD drive
 Floppy disk
 Hard drive
 Memory
 Monitor
 Printer
 Toner cartridge
 ZIP drive
(10 rows)
```
---
**1.2 Obtener los nombres y los precios de los productos de la tienda**
```SQL
SELECT nombre, precio FROM articulos ORDER BY precio;
```
Output:
```plaintext
     nombre      | precio 
-----------------+--------
 Floppy disk     |      5
 Toner cartridge |     66
 CD drive        |     90
 Memory          |    120
 ZIP drive       |    150
 DVD burner      |    180
 DVD drive       |    180
 Monitor         |    240
 Hard drive      |    240
 Printer         |    270
(10 rows)

```
---
**1.3 Obtener el nombre de los productos cuyo precio sea menor o igual a 200€**
```SQL
SELECT nombre FROM articulos WHERE precio <= 200 ORDER BY nombre;
```
```plaintext
     nombre      
-----------------
 CD drive
 DVD burner
 DVD drive
 Floppy disk
 Memory
 Toner cartridge
 ZIP drive
(7 rows)
```
---
**1.4 Obtener todos los datos de los artículos cuyo precio esté entre los 60€ y los 120€** (ambas cantidades incluidas)
```SQL
SELECT * FROM articulos WHERE (precio BETWEEN 60 AND 120) ORDER BY nombre;
```
```plaintext
 codigo |     nombre      | precio | fabricante 
--------+-----------------+--------+------------
      7 | CD drive        |     90 |          2
      2 | Memory          |    120 |          6
      9 | Toner cartridge |     66 |          3
(3 rows)
```
---
**1.5 Obtener el nombre y precio en pesetas** (es decir, el precio en euros multiplicado por 166'386)
```SQL
SELECT nombre, ROUND(nombre * 166.386) as precio_pesetas FROM articulos ORDER BY precio;
```
```plaintext
     nombre      | precio_pesetas 
-----------------+----------------
 Floppy disk     |           832
 Toner cartridge |         10981
 CD drive        |         14975
 Memory          |         19966
 ZIP drive       |         24958
 DVD burner      |         29949
 DVD drive       |         29949
 Monitor         |         39933
 Hard drive      |         39933
 Printer         |         44924
(10 rows)
```
---
**1.6 Seleccionar el precio medio de todos los productos**
```SQL
SELECT ROUND(AVG(precio),2) FROM articulos;
```
```plaintext
 round  
--------
 154.10
(1 row)
```
---
**1.7 Obtener el precio medio de los articulos cuyo fabricante sea 2**
```SQL
SELECT ROUND(AVG(precio),2) FROM articulos WHERE fabricante=2;
```
```plaintext
 round  
--------
 150.00
(1 row)
```
---
**1.8 Obtener el número de articulos cuyo precio sea mayor o igual a 180 €**
```SQL
SELECT COUNT(CODIGO) FROM articulos WHERE precio >= 180;
```
```plaintext
 count 
-------
     5
(1 row)
```
---
**1.9 Obtener el nombre y precio de los artículos cuyo precio sea mayor o igual a 180€** y ordenarlos descendentemente por precio y luego ascendentemente por nombre.
```SQL
SELECT nombre, precio FROM articulos WHERE precio >=180 ORDER BY precio DESC, nombre ASC;
```
```plaintext
   nombre   | precio 
------------+--------
 Printer    |    270
 Hard drive |    240
 Monitor    |    240
 DVD burner |    180
 DVD drive  |    180
(5 rows)
```
---
**1.10 Obtener un listado completo de artículos, incluyendo por cada articulo los datos del articulo y de su fabricante.**
```SQL
SELECT * 
FROM articulos 
INNER JOIN fabricantes 
ON articulos.fabricante = fabricantes.codigo;
```
```plaintext
 codigo |     nombre      | precio | fabricante | codigo |     nombre      
--------+-----------------+--------+------------+--------+-----------------
      1 | Hard drive      |    240 |          5 |      5 | Fujitsu
      2 | Memory          |    120 |          6 |      6 | Winchester
      3 | ZIP drive       |    150 |          4 |      4 | Iomega
      4 | Floppy disk     |      5 |          6 |      6 | Winchester
      5 | Monitor         |    240 |          1 |      1 | Sony
      6 | DVD drive       |    180 |          2 |      2 | Creative Labs
      7 | CD drive        |     90 |          2 |      2 | Creative Labs
      8 | Printer         |    270 |          3 |      3 | Hewlett-Packard
      9 | Toner cartridge |     66 |          3 |      3 | Hewlett-Packard
     10 | DVD burner      |    180 |          2 |      2 | Creative Labs
(10 rows)
```
---
**1.11 Obtener un listado de articulos incluyendo su nombre, su precio y el nombre del fabricante**
```SQL
SELECT
articulos.nombre as articulo,
articulos.precio as precio,
fabricantes.nombre as fabricante
FROM articulos
JOIN fabricantes
ON articulos.fabricante = fabricantes.codigo
ORDER BY articulos.nombre;
```
```plaintext
    articulo     | precio |   fabricante    
-----------------+--------+-----------------
 CD drive        |     90 | Creative Labs
 DVD burner      |    180 | Creative Labs
 DVD drive       |    180 | Creative Labs
 Floppy disk     |      5 | Winchester
 Hard drive      |    240 | Fujitsu
 Memory          |    120 | Winchester
 Monitor         |    240 | Sony
 Printer         |    270 | Hewlett-Packard
 Toner cartridge |     66 | Hewlett-Packard
 ZIP drive       |    150 | Iomega
(10 rows)

```
---
**1.12 Obtener el precio medio de los productos de cada fabricante, mostrando solo los códigos de fabricante:**
```SQL
SELECT
   fabricantes.codigo as codigo_fabricante, ROUND(AVG(articulos.precio),2) as precio_medio
FROM fabricantes
INNER JOIN articulos
ON fabricantes.codigo = articulos.fabricante
GROUP BY fabricantes.codigo
ORDER BY precio_medio;
```
```plaintext
 codigo_fabricante | precio_medio 
-------------------+--------------
                 3 |       168.00
                 5 |       240.00
                 4 |       150.00
                 6 |        62.50
                 2 |       150.00
                 1 |       240.00
(6 rows)
```
---
**1.13 Obtener el precio medio de los productos de cada fabricante, mostrando el nombre del fabricante**
```SQL
SELECT
   fabricantes.nombre as nombre_fabricante, ROUND(AVG(articulos.precio),2) as precio_medio
FROM fabricantes
INNER JOIN articulos
ON fabricantes.codigo = articulos.fabricante
GROUP BY fabricantes.nombre
ORDER BY fabricantes.nombre;
```
```plaintext
 nombre_fabricante | precio_medio 
-------------------+--------------
 Creative Labs     |       150.00
 Fujitsu           |       240.00
 Hewlett-Packard   |       168.00
 Iomega            |       150.00
 Sony              |       240.00
 Winchester        |        62.50
(6 rows)
```
---
**1.14 Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio sea mayor o igual a 150 €**
```SQL
SELECT fabricantes.nombre
FROM fabricantes
WHERE fabricantes.codigo IN (SELECT articulos.fabricante FROM articulos GROUP BY articulos.fabricante HAVING AVG(articulos.precio) >= 150);
```
```plaintext
     nombre      
-----------------
 Sony
 Creative Labs
 Hewlett-Packard
 Iomega
 Fujitsu
(5 rows)
```
---
**1.15 Obtener el nombre y el precio del articulo más barato**
```SQL
SELECT nombre, precio FROM articulos as nombre WHERE PRECIO = ( SELECT MIN(precio) FROM articulos );
```
```plaintext
   nombre    | precio 
-------------+--------
 Floppy disk |      5
(1 row)
```
---
**1.16 Obtener una lista con el nombre y precio de los articulos más caros de cada proveedor** (incluyendo el nombre del proveedor)
```SQL
SELECT fabricantes.nombre as proveedor, articulos.nombre, articulos.precio FROM articulos
JOIN fabricantes
   ON articulos.fabricante = fabricantes.codigo
WHERE precio IN(
   SELECT MAX(articulos.precio)
   FROM articulos
   GROUP BY fabricante
);
```
```plaintext
    proveedor    |     nombre      | precio 
-----------------+-----------------+--------
 Fujitsu         | Hard drive      |    240
 Winchester      | Memory          |    120
 Iomega          | ZIP drive       |    150
 Sony            | Monitor         |    240
 Creative Labs   | DVD drive       |    180
 Creative Labs   | DVD burner      |    180
 Hewlett-Packard | Impresora Láser |    270
(7 rows)

```
---
**1.17 Añadir nuevo producto: Altavoces, 70€, Fabricante 2**
```SQL
INSERT INTO articulos VALUES (11,'Altavoces',70,2);
```
```plaintext
INSERT 0 1
```
---
**1.18 Cambiar el nombre del producto 8 a 'Impresora Laser'**
```SQL
UPDATE articulos SET nombre = 'Impresora Laser' WHERE codigo = 8;
```
```plaintext
UPDATE 1;
```
---
**1.19 Aplicar un descuento del 10% (multiplicar el precio por 0,9) a todos los productos**
```SQL
ALTER TABLE articulos 
ADD COLUMN precio_dto decimal(10,2);
UPDATE articulos
SET precio_dto = precio * 0.9;
```
```plaintext
ALTER TABLE
UPDATE 11
```
---
**1.20 Aplicar un descuento de 10€ a todos los productos cuyo precio sea mayor o igual a 120€**
```SQL
UPDATE articulos
SET precio_dto = precio - 10
WHERE precio >= 120;
```
```plaintext
UPDATE 7
```
---