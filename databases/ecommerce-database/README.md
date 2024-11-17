# Создание базы данных для продуктового магазина (по франшизе)

### Структура БД

```
+--------------------+
|       Users        |
+--------------------+
| user_id (PK)       |
| username (UNIQUE)  |
| email (UNIQUE)     |
| password           |
| first_name         |
| last_name          |
| phone              |
| address            |
| role               |
+--------------------+
          |
          |
          |
          v
+--------------------+             +--------------------+             +--------------------+
|     Products       |-----------> |     Categories     | <-----------|      Suppliers     |
+--------------------+             +--------------------+             +--------------------+
| product_id (PK)    |             | category_id (PK)   |             | supplier_id (PK)   |
| name               |             | name (UNIQUE)      |             | name (UNIQUE)      |
| description        |             | description        |             | contact_person     |
| price              |             +--------------------+             | phone              |
| stock_quantity     |                                           +----| email              |
| category_id (FK)   |                                           |    | address            |
| supplier_id (FK)   |                                           |    +--------------------+
| image_url          |                                           |
+--------------------+                                           |
          |                                                      |
          |                                                      +--------------+
          v                                                                     v
+--------------------+            +--------------------+             +--------------------+
|       Orders       |            |    Order_Items     |             |      Payments      |
+--------------------+            +--------------------+             +--------------------+
| order_id (PK)      |            | order_item_id (PK) |             | payment_id (PK)    |
| user_id (FK)       |            | order_id (FK)      | <-----------| order_id (FK)      |
| total_price        |            | product_id (FK)    |             | payment_date       |
| order_date         |            | quantity           |             | amount             |
| status             |            | total_price        |             | payment_method     |
| shipping_address   |            +--------------------+             | payment_status     |
+--------------------+                                               +--------------------+
          ^
          |
          |
          |
+--------------------+
|       Users        |
+--------------------+
| user_id (PK)       |
| username (UNIQUE)  |
| email (UNIQUE)     |
| password           |
| first_name         |
| last_name          |
| phone              |
| address            |
| role               |
+--------------------+
```

### Объяснение структуры



**Автор:** Дуплей Максим Игоревич

**Дата:** 17.11.2024
