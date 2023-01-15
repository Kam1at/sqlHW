SELECT DISTINCT c.company_name, CONCAT(e.first_name, ' ', e.last_name) AS contact	--Название компании заказчика (company_name из табл. customers) и ФИО сотрудника,
FROM orders AS o																	--работающего над заказом этой компании (см таблицу employees), когда и заказчик и
JOIN customers AS c USING(customer_id)													--сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United
JOIN employees AS e USING(employee_id)													--Package (company_name в табл shippers)
LEFT JOIN shippers AS s ON o.ship_via=s.shipper_id
WHERE e.city='London'
AND c.city='London'
AND s.company_name='United Package';

SELECT p.product_name, p.units_in_stock, s.contact_name, s.phone					--Наименование продукта, количество товара (product_name и units_in_stock в табл
FROM products p																		--products), имя поставщика и его телефон (contact_name и phone в табл suppliers) для
JOIN categories c USING(category_id)												--таких продуктов, которые не сняты с продажи (поле discontinued) и которых меньше 25
LEFT JOIN suppliers s USING(supplier_id)											--и которые в категориях Dairy Products и Condiments. Отсортировать результат по
WHERE p.discontinued = 0															--возрастанию количества оставшегося товара.
AND p.units_in_stock < 25
AND c.category_name IN ('Dairy Products', 'Condiments')
ORDER BY p.units_in_stock;

SELECT c.company_name																--Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
FROM customers c
FULL JOIN orders o USING(customer_id)
WHERE o.order_id IS NULL;

SELECT DISTINCT product_name														--уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц
FROM products																		--см в колонке quantity табл order_details)
WHERE product_id IN(																--Написать запрос именно с использвованием подзапроса.
	SELECT product_id
	FROM order_details
	WHERE quantity=10);