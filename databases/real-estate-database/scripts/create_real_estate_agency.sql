-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ АГЕНТСТВА НЕДВИЖИМОСТИ
-- *******************************************************
CREATE DATABASE IF NOT EXISTS real_estate_agency;
USE real_estate_agency;

-- *******************************************************
-- Таблица для хранения информации о пользователях (клиенты, агенты, администраторы)
-- *******************************************************
CREATE TABLE IF NOT EXISTS Users (
    user_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора
    username VARCHAR(255) NOT NULL,  -- Логин пользователя
    email VARCHAR(255) NOT NULL,  -- Электронная почта
    password VARCHAR(255) NOT NULL,  -- Хеш пароля
    first_name VARCHAR(255),  -- Имя
    last_name VARCHAR(255),  -- Фамилия
    phone VARCHAR(15),  -- Телефон
    address VARCHAR(255),  -- Адрес пользователя
    role_id INT,  -- Роль пользователя (ссылка на таблицу roles)
    FOREIGN KEY (role_id) REFERENCES Roles(role_id) ON DELETE SET NULL,  -- Роль пользователя
    UNIQUE(email),  -- Уникальность почты
    UNIQUE(username),  -- Уникальность логина
    CHECK (CHAR_LENGTH(username) > 0 AND CHAR_LENGTH(username) BETWEEN 3 AND 50),  -- Логин от 3 до 50 символов
    CHECK (CHAR_LENGTH(password) >= 8),  -- Пароль минимум 8 символов
    INDEX idx_email (email),  -- Индекс для поиска по email
    INDEX idx_username (username)  -- Индекс для поиска по username
);

-- *******************************************************
-- Таблица для хранения ролей пользователей
-- *******************************************************
CREATE TABLE IF NOT EXISTS Roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,  -- Идентификатор роли
    role_name ENUM('customer', 'agent', 'admin') NOT NULL UNIQUE  -- Роль пользователя
);

-- *******************************************************
-- Вставка стандартных ролей в таблицу Roles
-- *******************************************************
INSERT INTO Roles (role_name) VALUES ('customer'), ('agent'), ('admin');

-- *******************************************************
-- Таблица для хранения объектов недвижимости
-- *******************************************************
CREATE TABLE IF NOT EXISTS Properties (
    property_id INT AUTO_INCREMENT PRIMARY KEY,  -- Идентификатор объекта
    title VARCHAR(255) NOT NULL,  -- Название объекта
    description TEXT,  -- Описание объекта
    price DECIMAL(15, 2) NOT NULL,  -- Цена объекта
    property_type ENUM('apartment', 'house', 'commercial') NOT NULL,  -- Тип объекта
    area DECIMAL(10, 2),  -- Площадь в кв.м.
    address VARCHAR(255),  -- Адрес объекта
    status ENUM('available', 'sold', 'rented') DEFAULT 'available',  -- Статус объекта
    agent_id CHAR(36),  -- Идентификатор агента, ответственного за объект
    FOREIGN KEY (agent_id) REFERENCES Users(user_id) ON DELETE SET NULL  -- Связь с агентом
);

-- *******************************************************
-- Таблица для хранения сделок (покупка/продажа)
-- *******************************************************
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,  -- Идентификатор сделки
    property_id INT,  -- Идентификатор объекта недвижимости
    buyer_id CHAR(36),  -- Идентификатор клиента-покупателя
    sale_price DECIMAL(15, 2),  -- Цена продажи
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Дата сделки
    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE,  -- Связь с объектом недвижимости
    FOREIGN KEY (buyer_id) REFERENCES Users(user_id) ON DELETE CASCADE  -- Связь с покупателем
);

-- *******************************************************
-- Таблица для хранения аренды объектов недвижимости
-- *******************************************************
CREATE TABLE IF NOT EXISTS Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,  -- Идентификатор аренды
    property_id INT,  -- Идентификатор объекта недвижимости
    renter_id CHAR(36),  -- Идентификатор клиента-арендатора
    rent_price DECIMAL(15, 2),  -- Цена аренды
    start_date DATE,  -- Дата начала аренды
    end_date DATE,  -- Дата окончания аренды
    rental_status ENUM('active', 'completed', 'terminated') DEFAULT 'active',  -- Статус аренды
    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE,  -- Связь с объектом недвижимости
    FOREIGN KEY (renter_id) REFERENCES Users(user_id) ON DELETE CASCADE  -- Связь с арендатором
);

-- *******************************************************
-- Таблица для хранения истории цен объектов недвижимости
-- *******************************************************
CREATE TABLE IF NOT EXISTS PriceHistory (
    price_history_id INT AUTO_INCREMENT PRIMARY KEY,  -- Идентификатор записи
    property_id INT,  -- Идентификатор объекта недвижимости
    price DECIMAL(15, 2) NOT NULL,  -- Цена на момент изменения
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Дата изменения цены
    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE  -- Связь с объектом недвижимости
);

-- *******************************************************
-- Таблица для хранения истории показов объектов недвижимости
-- *******************************************************
CREATE TABLE IF NOT EXISTS PropertyViews (
    view_id INT AUTO_INCREMENT PRIMARY KEY,  -- Идентификатор просмотра
    property_id INT,  -- Идентификатор объекта недвижимости
    user_id CHAR(36),  -- Идентификатор клиента, который посмотрел объект
    view_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Дата и время просмотра
    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE,  -- Связь с объектом недвижимости
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE  -- Связь с пользователем
);
