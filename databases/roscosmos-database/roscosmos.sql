-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ РОСКОСМОСА
-- *******************************************************
CREATE DATABASE IF NOT EXISTS RoscosmosDB;
USE RoscosmosDB;

-- *******************************************************
-- Таблица для хранения информации о космических миссиях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Missions (
    mission_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор миссии
    mission_name VARCHAR(255) NOT NULL,  -- Название миссии
    launch_date DATE,  -- Дата запуска
    end_date DATE,  -- Дата завершения
    status ENUM('planned', 'active', 'completed', 'failed') DEFAULT 'planned',  -- Статус миссии
    description TEXT,  -- Описание миссии
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Дата добавления миссии
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Дата последнего обновления
    INDEX(mission_name),  -- Индекс для быстрого поиска по названию
    INDEX(status)  -- Индекс для поиска по статусу
);

-- *******************************************************
-- Таблица для хранения информации о спутниках
-- *******************************************************
CREATE TABLE IF NOT EXISTS Satellites (
    satellite_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор спутника
    satellite_name VARCHAR(255) NOT NULL,  -- Название спутника
    mission_id INT,  -- Связь с миссией
    launch_date DATE,  -- Дата запуска
    status ENUM('active', 'inactive', 'decommissioned') DEFAULT 'active',  -- Статус спутника
    description TEXT,  -- Описание спутника
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Дата добавления спутника
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Дата последнего обновления
    FOREIGN KEY (mission_id) REFERENCES Missions(mission_id),
    INDEX(satellite_name),  -- Индекс для быстрого поиска по названию
    INDEX(status)  -- Индекс для поиска по статусу
);

-- *******************************************************
-- Таблица для хранения научных данных
-- *******************************************************
CREATE TABLE IF NOT EXISTS ScientificData (
    data_id INT AUTO_INCREMENT PRIMARY KEY,
    satellite_id INT NOT NULL,
    data_type VARCHAR(255) NOT NULL,  -- Тип данных (например, изображение, телеметрия)
    data_value TEXT NOT NULL,  -- Значение данных
    collection_date DATETIME NOT NULL,  -- Дата и время сбора данных
    FOREIGN KEY (satellite_id) REFERENCES Satellites(satellite_id),
    INDEX(collection_date),  -- Индекс для быстрого поиска по дате сбора
    INDEX(data_type)  -- Индекс для поиска по типу данных
);

-- *******************************************************
-- Таблица для хранения информации о пользователях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,  -- Хэш пароля
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('admin', 'scientist', 'viewer') DEFAULT 'viewer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX(email)
);

-- *******************************************************
-- Таблица для хранения истории изменений
-- *******************************************************
CREATE TABLE IF NOT EXISTS AuditLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    action VARCHAR(255) NOT NULL,  -- Действие (например, добавление, обновление)
    table_name VARCHAR(255) NOT NULL,  -- Имя таблицы
    record_id INT NOT NULL,  -- ID записи
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    INDEX(change_date),
    INDEX(user_id)
);
