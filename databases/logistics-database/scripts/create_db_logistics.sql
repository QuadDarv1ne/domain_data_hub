-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ ЛОГИСТИЧЕСКОЙ КОМПАНИИ
-- *******************************************************
CREATE DATABASE IF NOT EXISTS logistics_database;
USE logistics_database;

-- *******************************************************
-- Таблица для хранения информации о клиентах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Clients (
    id INT AUTO_INCREMENT PRIMARY KEY,                     -- Уникальный идентификатор клиента
    name VARCHAR(255) NOT NULL,                            -- Имя клиента
    contact_info TEXT NOT NULL,                            -- Контактная информация
    address TEXT NOT NULL,                                 -- Адрес клиента
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE   -- Дата регистрации клиента
);

-- *******************************************************
-- Таблица для хранения информации о складах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Warehouses (
    id INT AUTO_INCREMENT PRIMARY KEY,                     -- Уникальный идентификатор склада
    location VARCHAR(255) NOT NULL,                        -- Местоположение склада
    capacity DECIMAL(10, 2) NOT NULL                       -- Вместимость склада
);

-- *******************************************************
-- Таблица для хранения информации о грузах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Shipments (
    id INT AUTO_INCREMENT PRIMARY KEY,                     -- Уникальный идентификатор груза
    client_id INT NOT NULL,                                -- Идентификатор клиента
    description TEXT NOT NULL,                             -- Описание груза
    weight DECIMAL(10, 2) NOT NULL,                        -- Вес груза
    warehouse_id INT,                                      -- Идентификатор склада
    status ENUM('in transit', 'stored', 'delivered')       -- Статус груза
        DEFAULT 'stored',                                  
    FOREIGN KEY (client_id) REFERENCES Clients(id)         -- Внешний ключ для клиента
        ON DELETE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(id)   -- Внешний ключ для склада
        ON DELETE SET NULL
);

-- *******************************************************
-- Таблица для хранения информации о маршрутах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Routes (
    id INT AUTO_INCREMENT PRIMARY KEY,                     -- Уникальный идентификатор маршрута
    origin VARCHAR(255) NOT NULL,                          -- Пункт отправления
    destination VARCHAR(255) NOT NULL,                     -- Пункт назначения
    distance DECIMAL(10, 2) NOT NULL,                      -- Расстояние в км
    estimated_time DECIMAL(5, 2) NOT NULL                  -- Ожидаемое время доставки в часах
);

-- *******************************************************
-- Таблица для хранения информации о транспортных средствах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,                     -- Уникальный идентификатор транспорта
    type ENUM('truck', 'van', 'bike') NOT NULL,            -- Тип транспорта
    capacity DECIMAL(10, 2) NOT NULL,                      -- Вместимость транспорта
    status ENUM('in transit', 'available', 'maintenance')  -- Статус транспорта
        DEFAULT 'available',
    driver_id INT,                                         -- Идентификатор водителя
    FOREIGN KEY (driver_id) REFERENCES Drivers(id)         -- Внешний ключ для водителя
        ON DELETE SET NULL
);

-- *******************************************************
-- Таблица для хранения информации о водителях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Drivers (
    id INT AUTO_INCREMENT PRIMARY KEY,                     -- Уникальный идентификатор водителя
    name VARCHAR(255) NOT NULL,                            -- Имя водителя
    phone VARCHAR(15) NOT NULL,                            -- Телефон водителя
    license_number VARCHAR(50) UNIQUE NOT NULL             -- Уникальный номер водительского удостоверения
);

-- *******************************************************
-- Таблица для трекинга доставки
-- *******************************************************
CREATE TABLE IF NOT EXISTS DeliveryTracking (
    id INT AUTO_INCREMENT PRIMARY KEY,                     -- Уникальный идентификатор записи трекинга
    shipment_id INT NOT NULL,                              -- Идентификатор груза
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,          -- Временная метка
    location VARCHAR(255),                                 -- Текущее местоположение
    status ENUM('in transit', 'stored', 'delivered')       -- Статус доставки
        DEFAULT 'in transit',
    FOREIGN KEY (shipment_id) REFERENCES Shipments(id)     -- Внешний ключ для груза
        ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для аналитики
-- *******************************************************
CREATE TABLE IF NOT EXISTS Analytics (
    id INT AUTO_INCREMENT PRIMARY KEY,                     -- Уникальный идентификатор аналитики
    route_id INT NOT NULL,                                 -- Идентификатор маршрута
    vehicle_id INT NOT NULL,                               -- Идентификатор транспорта
    delivery_time DECIMAL(5, 2) NOT NULL,                  -- Время доставки в часах
    cost DECIMAL(10, 2) NOT NULL,                          -- Стоимость доставки
    FOREIGN KEY (route_id) REFERENCES Routes(id)           -- Внешний ключ для маршрута
        ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(id)       -- Внешний ключ для транспорта
        ON DELETE CASCADE
);
