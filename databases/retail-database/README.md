# Cоздание базы данных для продуктового магазина (по франшизе)

### Структура БД

```
+----------------+         +-----------------+        +-----------------+
|     Stores     |         |    Suppliers    |        |    Categories   |
+----------------+         +-----------------+        +-----------------+
| store_id (PK)  | <-----> | supplier_id (PK)|        | category_id (PK)|
| name           |         | name            |        | name            |
| address        |         | contact_person  |        | description     |
| city           |         | phone           |        +-----------------+
| region         |         | email           |
| phone          |         | address         |
| opening_date   |         +-----------------+
+----------------+        
        |
        |
        v
+-----------------+         +-----------------+       +------------------+
|    Products     |         |    Employees    |       |     Sales        |
+-----------------+         +-----------------+       +------------------+
| product_id (PK) |         | employee_id (PK)|       | sale_id (PK)     |
| name            |         | first_name      |       | store_id (FK)    |
| category_id (FK)| <-----> | last_name       |       | employee_id (FK) |
| brand           |         | position        |       | product_id (FK)  |
| price           |         | store_id (FK)   |       | quantity         |
| stock_quantity  |         | hire_date       |       | total_price      |
| supplier_id (FK)| <-----> | salary          |       | sale_date        |
+-----------------+         +-----------------+       +------------------+
         |
         |
         v
+-------------------+
|     Inventory     |
+-------------------+
| inventory_id (PK) |
| store_id (FK)     |
| product_id (FK)   |
| stock_quantity    |
| last_updated      |
+-------------------+
```

### Объяснение структуры

1. `Stores ↔ Products`: Таблица Products имеет внешний ключ store_id, который ссылается на таблицу Stores. Это связывает товары с конкретными магазинами.
2. `Products ↔ Categories`: Каждому товару в таблице Products соответствует категория, для чего используется внешний ключ category_id.
3. `Products ↔ Suppliers`: Таблица Products ссылается на таблицу Suppliers через внешний ключ supplier_id.
4. `Employees ↔ Stores`: Каждый сотрудник привязан к магазину через внешний ключ store_id.
5. `Sales ↔ Stores`, `Employees`, `Products`: Продажи связаны с конкретным магазином (store_id), сотрудником (employee_id) и товаром (product_id).
6. `Inventory ↔ Stores`, `Products`: Таблица Inventory отслеживает количество товаров на складе, ссылаясь на Stores и Products.

Каждая связь обеспечена с помощью внешних ключей (FK), что гарантирует целостность данных в базе.


**Автор:** Дуплей Максим Игоревич

**Дата:** 18.11.2024
