-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ АГЕНТСТВА ПУТЕШЕСТВИЙ
-- *******************************************************
CREATE DATABASE IF NOT EXISTS travel_agency;
USE travel_agency;

-- *******************************************************
-- Таблица для хранения информации о клиентах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,           -- Уникальный идентификатор клиента
    first_name VARCHAR(255) NOT NULL,                    -- Имя клиента
    last_name VARCHAR(255) NOT NULL,                     -- Фамилия клиента
    email VARCHAR(255) NOT NULL UNIQUE,                  -- Электронная почта клиента
    phone VARCHAR(15),                                   -- Телефон клиента
    passport_number VARCHAR(20),                         -- Номер паспорта клиента
    date_of_birth DATE,                                  -- Дата рождения клиента
    address VARCHAR(255)                                 -- Адрес клиента
);

-- *******************************************************
-- Таблица для хранения информации о путешествиях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,             -- Уникальный идентификатор путешествия
    destination VARCHAR(255) NOT NULL,                   -- Направление путешествия
    start_date DATE NOT NULL,                            -- Дата начала путешествия
    end_date DATE NOT NULL,                              -- Дата окончания путешествия
    price DECIMAL(10, 2) NOT NULL,                       -- Цена путешествия
    description TEXT,                                    -- Описание путешествия
    available_seats INT NOT NULL,                        -- Количество доступных мест
    status ENUM('available', 'booked', 'completed') DEFAULT 'available'  -- Статус путешествия
);

-- *******************************************************
-- Таблица для хранения информации о бронированиях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,          -- Уникальный идентификатор бронирования
    client_id INT,                                      -- Идентификатор клиента (внешний ключ)
    trip_id INT,                                        -- Идентификатор путешествия (внешний ключ)
    booking_date DATE NOT NULL,                         -- Дата бронирования
    number_of_seats INT NOT NULL,                       -- Количество забронированных мест
    total_price DECIMAL(10, 2) NOT NULL,                -- Общая стоимость бронирования
    status ENUM('confirmed', 'canceled', 'completed') DEFAULT 'confirmed',  -- Статус бронирования
    FOREIGN KEY (client_id) REFERENCES Clients(client_id), -- Связь с таблицей клиентов
    FOREIGN KEY (trip_id) REFERENCES Trips(trip_id)     -- Связь с таблицей путешествий
);

-- *******************************************************
-- Таблица для хранения информации о транзакциях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,      -- Уникальный идентификатор транзакции
    booking_id INT,                                     -- Идентификатор бронирования (внешний ключ)
    transaction_date DATE NOT NULL,                      -- Дата транзакции
    amount DECIMAL(10, 2) NOT NULL,                      -- Сумма транзакции
    payment_method ENUM('credit_card', 'bank_transfer', 'paypal') NOT NULL, -- Метод оплаты
    status ENUM('pending', 'completed', 'failed') DEFAULT 'pending', -- Статус транзакции
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) -- Связь с таблицей бронирований
);

-- *******************************************************
-- Таблица для хранения информации о сотрудниках агентства
-- *******************************************************
CREATE TABLE IF NOT EXISTS Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,         -- Уникальный идентификатор сотрудника
    first_name VARCHAR(255) NOT NULL,                    -- Имя сотрудника
    last_name VARCHAR(255) NOT NULL,                     -- Фамилия сотрудника
    email VARCHAR(255) NOT NULL UNIQUE,                  -- Электронная почта сотрудника
    phone VARCHAR(15),                                   -- Телефон сотрудника
    position VARCHAR(255),                               -- Должность сотрудника
    hire_date DATE,                                      -- Дата найма
    salary DECIMAL(10, 2)                                -- Зарплата сотрудника
);

-- *******************************************************
-- Таблица для хранения информации о туроператорах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Tour_Operators (
    operator_id INT AUTO_INCREMENT PRIMARY KEY,         -- Уникальный идентификатор туроператора
    name VARCHAR(255) NOT NULL,                          -- Название туроператора
    contact_info VARCHAR(255),                           -- Контактная информация
    website VARCHAR(255),                                -- Веб-сайт
    description TEXT                                     -- Описание туроператора
);

-- *******************************************************
-- Таблица для хранения связи туроператоров и путешествий
-- *******************************************************
CREATE TABLE IF NOT EXISTS Operators_Trips (
    operator_trip_id INT AUTO_INCREMENT PRIMARY KEY,    -- Уникальный идентификатор связи
    operator_id INT,                                     -- Идентификатор туроператора (внешний ключ)
    trip_id INT,                                         -- Идентификатор путешествия (внешний ключ)
    FOREIGN KEY (operator_id) REFERENCES Tour_Operators(operator_id), -- Связь с туроператорами
    FOREIGN KEY (trip_id) REFERENCES Trips(trip_id)      -- Связь с путешествиями
);
