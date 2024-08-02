--a) Crear la base de datos con el archivo create_restaurant_db.sql

--b) Explorar la tabla “menu_items” para conocer los productos del menú.

--1.- Realizar consultas para contestar las siguientes preguntas:

--● Encontrar el número de artículos en el menú.
SELECT COUNT (*) FROM menu_items;

--● ¿Cuál es el artículo menos caro y el más caro en el menú?
SELECT * FROM MENU_ITEMS
WHERE PRICE = (SELECT MIN(PRICE) FROM MENU_ITEMS);


SELECT * FROM MENU_ITEMS
WHERE PRICE = (SELECT MAX(PRICE) FROM MENU_ITEMS);

--● ¿Cuántos platos americanos hay en el menú?
SELECT COUNT (*)
FROM MENU_ITEMS
WHERE CATEGORY = 'American';

--● ¿Cuál es el precio promedio de los platos?
SELECT ROUND(AVG(PRICE),2)
FROM MENU_ITEMS;

--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.

--1.- Realizar consultas para contestar las siguientes preguntas:

--● ¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT (DISTINCT ORDER_ID) FROM ORDER_DETAILS;

--● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
SELECT ORDER_ID, COUNT (ITEM_ID)
FROM ORDER_DETAILS
GROUP BY ORDER_ID
ORDER BY COUNT(ITEM_ID) DESC
LIMIT 5;

--● ¿Cuándo se realizó el primer pedido y el último pedido?
SELECT MIN(ORDER_DATE)
FROM order_details;

SELECT MAX(ORDER_DATE)
FROM order_details;

--● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
SELECT COUNT (*) FROM ORDER_DETAILS
WHERE ORDER_DATE BETWEEN '2023-01-01' AND '2023-01-05';

--d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.

--1.- Realizar un left join entre entre order_details y menu_items con el identificador item_id(tabla order_details) y menu_item_id(tabla menu_items)
SELECT * FROM ORDER_DETAILS
LEFT JOIN MENU_ITEMS
ON ORDER_DETAILS.ITEM_ID = MENU_ITEMS.MENU_ITEM_ID;

-- CATEGORIAS MAS PEDIDAS.
SELECT MENU_ITEMS.category, COUNT(ORDER_DETAILS.item_id) AS TotalOrders
FROM ORDER_DETAILS
LEFT JOIN MENU_ITEMS ON ORDER_DETAILS.item_id = MENU_ITEMS.menu_item_id
GROUP BY MENU_ITEMS.category
ORDER BY TotalOrders DESC
LIMIT 5;

-- PLATILLOS MAS BARATO
SELECT MENU_ITEMS.*
FROM ORDER_DETAILS
LEFT JOIN MENU_ITEMS ON ORDER_DETAILS.item_id = MENU_ITEMS.menu_item_id
WHERE MENU_ITEMS.price IS NOT NULL
ORDER BY MENU_ITEMS.price ASC
LIMIT 1;

SELECT MENU_ITEMS.*
FROM ORDER_DETAILS
LEFT JOIN MENU_ITEMS ON ORDER_DETAILS.item_id = MENU_ITEMS.menu_item_id
WHERE MENU_ITEMS.price IS NOT NULL
ORDER BY MENU_ITEMS.price DESC
LIMIT 1;






