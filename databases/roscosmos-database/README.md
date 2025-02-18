# Структура базы данных RoscosmosDB

## 1. Таблица Missions

- **Назначение:** Хранение информации о космических миссиях.

- **Поля:**

   `mission_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Уникальный идентификатор миссии.

   `mission_name` (VARCHAR(255), NOT NULL): Название миссии.

   `launch_date` (DATE): Дата запуска миссии.

   `end_date` (DATE): Дата завершения миссии.

   `status` (ENUM('planned', 'active', 'completed', 'failed'), DEFAULT 'planned'): Статус миссии.

   `description` (TEXT): Описание миссии.

   `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Дата создания записи.

   `updated_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP): Дата последнего обновления.

- **Индексы:** На mission_name, status.

## 2. Таблица Satellites

- **Назначение:** Хранение данных о спутниках.

- **Поля:**

   `satellite_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Уникальный идентификатор спутника.

   `satellite_name` (VARCHAR(255), NOT NULL): Название спутника.

   `mission_id` (INT, FOREIGN KEY REFERENCES Missions(mission_id)): Связь с миссией.

   `launch_date` (DATE): Дата запуска спутника.

   `status` (ENUM('active', 'inactive', 'decommissioned'), DEFAULT 'active'): Статус спутника.

   `description` (TEXT): Описание спутника.

   `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Дата создания записи.

   `updated_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP): Дата последнего обновления.

- **Индексы:** На satellite_name, status.

## 3. Таблица ScientificData

- **Назначение:** Хранение научных данных, собранных спутниками.

- **Поля:**

   `data_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Уникальный идентификатор записи данных.

   `satellite_id` (INT, FOREIGN KEY REFERENCES Satellites(satellite_id)): Связь со спутником.

   `data_type` (VARCHAR(255), NOT NULL): Тип данных (например, изображение, телеметрия).

   `data_value` (TEXT, NOT NULL): Значение данных.

   `collection_date` (DATETIME, NOT NULL): Дата и время сбора данных.

- **Индексы:** На collection_date, data_type.

## 4. Таблица Users

- **Назначение:** Управление пользователями системы.

- **Поля:**

   `user_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Уникальный идентификатор пользователя.

   `username` (VARCHAR(50), NOT NULL, UNIQUE): Уникальное имя пользователя.

   `password_hash` (VARCHAR(255), NOT NULL): Хэш пароля.

   `email` (VARCHAR(100), NOT NULL, UNIQUE): Уникальный адрес электронной почты.

   `role` (ENUM('admin', 'scientist', 'viewer'), DEFAULT 'viewer'): Роль пользователя.

   `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Дата создания записи.

**Индексы:** На email.

## 5. Таблица AuditLog

- **Назначение:** Отслеживание изменений в базе данных.

- **Поля:**

   `log_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Уникальный идентификатор записи лога.

   `user_id` (INT, FOREIGN KEY REFERENCES Users(user_id)): Связь с пользователем.

   `action` (VARCHAR(255), NOT NULL): Действие, выполненное пользователем.

   `table_name` (VARCHAR(255), NOT NULL): Имя таблицы, в которой были внесены изменения.

   `record_id` (INT, NOT NULL): Идентификатор записи, которая была изменена.

   `change_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Дата и время изменения.

- **Индексы:** На change_date, user_id.

#### **Основные принципы:**

- **Нормализация:** Таблицы разделены для минимизации избыточности данных.
- **Целостность данных:** Использование внешних ключей для обеспечения связей между таблицами.
- **Индексация:** Индексы добавлены для ускорения поиска по часто используемым полям.

**Автор:** Дуплей Максим Игоревич

**Дата:** 18.02.2025
