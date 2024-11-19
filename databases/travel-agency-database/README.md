# Создание базы данных для агентства путешествий

### Структура БД

```
+------------------+        +-------------------+        +------------------+
|    Clients       |        |       Trips       |        |    Bookings      |
+------------------+        +-------------------+        +------------------+
| client_id (PK)   | <----> | trip_id (PK)      | <----> | booking_id (PK)  |
| first_name       |        | destination       |        | client_id (FK)   |
| last_name        |        | start_date        |        | trip_id (FK)     |
| email            |        | end_date          |        | booking_date     |
| phone            |        | price             |        | number_of_seats  |
| passport_number  |        | description       |        | total_price      |
| date_of_birth    |        | available_seats   |        | status           |
| address          |        | status            |        +------------------+
+------------------+        +-------------------+
                                      |
                                      |
                                      v
                           +---------------------+
                           | Transactions        |
                           +---------------------+
                           | transaction_id (PK) |
                           | booking_id (FK)     |
                           | transaction_date    |
                           | amount              |
                           | payment_method      |
                           | status              |
                           +---------------------+

+------------------+      +------------------+
|   Employees      |      | Tour_Operators   |
+------------------+      +------------------+
| employee_id (PK) |      | operator_id (PK) |
| first_name       |      | name             |
| last_name        |      | contact_info     |
| email            |      | website          |
| phone            |      | description      |
| position         |      +------------------+
| hire_date        |               |
| salary           |               |
+------------------+               |
                                   |
                                   v
                        +-----------------------+
                        | Operators_Trips       |
                        +-----------------------+
                        | operator_trip_id (PK) |
                        | operator_id (FK)      |
                        | trip_id (FK)          |
                        +-----------------------+
```

### Объяснение структуры

`Clients` — информация о клиентах.

`Trips` — информация о путешествиях.

`Bookings` — информация о бронированиях, которая ссылается на клиентов и путешествия.

`Transactions` — информация о транзакциях, связанных с бронированиями.

`Employees` — информация о сотрудниках агентства.

`Tour_Operators` — информация о туроператорах.

`Operators_Trips` — связь между туроператорами и путешествиями, предлагаемых ими.

#### Связи между таблицами

1. `Clients` и `Bookings` — один клиент может забронировать несколько путешествий.
2. `Trips` и `Bookings` — одно путешествие может быть забронировано несколькими клиентами.
3. `Bookings` и `Transactions` — транзакция привязана к конкретному бронированию.
4. `Tour_Operators` и `Operators_Trips` — туроператоры предлагают различные путешествия.

**Автор:** Дуплей Максим Игоревич

**Дата:** 19.11.2024
