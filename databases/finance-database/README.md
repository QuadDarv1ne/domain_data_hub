# Cоздание базы данных для

### Структура БД

```
+-------------------+        +-------------------+      +-------------------+      +-------------------+
|     Clients       |        |     Accounts      |      |    Transactions   |      |      Loans        |
+-------------------+        +-------------------+      +-------------------+      +-------------------+
| id (PK)           | <----> | id (PK)           |      | id (PK)           |      | id (PK)           |
| first_name        |        | client_id (FK)    |<-----| account_id (FK)   |      | client_id (FK)    |
| last_name         |        | account_type      |      | transaction_type  |      | loan_amount       |
| email             |        | balance           |      | amount            |      | interest_rate     |
| phone             |        | currency          |      | transaction_date  |      | loan_type         |
| address           |        | opened_at         |      | description       |      | start_date        |
| registration_date |        | status            |      | status            |      | end_date          |
| status            |        | created_at        |      |                   |      | status            |
| last_login        |        | updated_at        |      |                   |      | created_at        |
| created_at        |        +-------------------+      +-------------------+      | updated_at        |
| updated_at        |               |                          |                   +-------------------+
+-------------------+               |                          |
                                    |                          |
                                    |                          |
                                    |                          |
                       +-------------------+           +-------------------+
                       |   LoanPayments    |           |     Deposits      |
                       +-------------------+           +-------------------+
                       | id (PK)           |           | id (PK)           |
                       | loan_id (FK)      |           | client_id (FK)    |
                       | payment_amount    |           | deposit_amount    |
                       | payment_date      |           | deposit_type      |
                       | payment_method    |           | interest_rate     |
                       +-------------------+           | start_date        |
                                 |                     | maturity_date     |
                                 |                     | status            |
                                 |                     | created_at        |
                                 |                     | updated_at        |
                                 |                     +-------------------+
                                 |
                       +---------------------+
                       | CurrencyTransactions|
                       +---------------------+
                       | id (PK)             |
                       | account_id (FK)     |
                       | transaction_type    |
                       | from_currency       |
                       | to_currency         |
                       | amount              |
                       | exchange_rate       |
                       | transaction_date    |
                       +---------------------+
```

### Объяснение структуры

`Клиенты (Clients)`: Добавлены новые поля для отслеживания статуса клиента и времени последнего входа.
`Счета (Accounts)`: Для различных типов счетов добавлена валюта и статус счета. Это поможет легко отслеживать активные и закрытые счета.
`Транзакции (Transactions)`: Включает тип транзакции и статус для более детализированного контроля над процессом.
`Кредиты (Loans)`: Добавлены новые поля для более точного учета сроков кредита и его статуса (например, в случае дефолта).
`Платежи по кредитам (LoanPayments)`: Добавлен способ платежа для улучшенного учета.
`Депозиты (Deposits)`: Для учета депозитов с возможностью выбора типа (фиксированный или регулярный) и статуса.
`Валютные операции (CurrencyTransactions)`: Позволяет отслеживать операции обмена валют и конвертации, что важно для международных операций.

**Автор:** Дуплей Максим Игоревич

**Дата:** 18.11.2024
