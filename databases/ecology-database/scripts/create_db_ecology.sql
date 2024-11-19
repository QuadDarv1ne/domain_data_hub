-- *******************************************************
-- СКРИПТ СОЗДАНИЯ УЛУЧШЕННОЙ БАЗЫ ДАННЫХ ДЛЯ ЭКОЛОГИИ
-- *******************************************************
CREATE DATABASE IF NOT EXISTS ecology_database;
USE ecology_database;

-- *******************************************************
-- Таблица для хранения информации о наблюдаемых зонах
-- *******************************************************
CREATE TABLE IF NOT EXISTS ObservationZones (
    zone_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор зоны
    zone_name VARCHAR(255) NOT NULL,  -- Название зоны
    location VARCHAR(255) NOT NULL,  -- Географическое местоположение
    area_km2 DECIMAL(10, 2) NOT NULL,  -- Площадь зоны в квадратных километрах
    description TEXT,  -- Описание зоны
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Дата добавления зоны
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Дата последнего обновления
    INDEX(zone_name),  -- Индекс для быстрого поиска по названию
    INDEX(location)  -- Индекс для быстрого поиска по местоположению
);

-- *******************************************************
-- Таблица для хранения типов экологических метрик
-- *******************************************************
CREATE TABLE IF NOT EXISTS MetricTypes (
    metric_type_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор типа метрики
    metric_name VARCHAR(255) NOT NULL,  -- Название метрики (например, уровень CO2)
    measurement_unit VARCHAR(50) NOT NULL  -- Единица измерения (ppm, °C, и т.д.)
);

-- *******************************************************
-- Таблица для хранения экологических метрик
-- *******************************************************
CREATE TABLE IF NOT EXISTS EnvironmentalMetrics (
    metric_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор метрики
    zone_id INT NOT NULL,  -- Идентификатор зоны
    metric_type_id INT NOT NULL,  -- Идентификатор типа метрики
    value DECIMAL(10, 2) NOT NULL,  -- Значение метрики
    recorded_at DATETIME NOT NULL,  -- Время фиксации метрики
    FOREIGN KEY (zone_id) REFERENCES ObservationZones(zone_id) ON DELETE CASCADE,  -- Связь с зоной
    FOREIGN KEY (metric_type_id) REFERENCES MetricTypes(metric_type_id) ON DELETE CASCADE,  -- Связь с типом метрики
    INDEX(recorded_at)  -- Индекс для быстрого поиска по времени
);

-- *******************************************************
-- Таблица для хранения данных о проектах
-- *******************************************************
CREATE TABLE IF NOT EXISTS EcoProjects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор проекта
    project_name VARCHAR(255) NOT NULL,  -- Название проекта
    description TEXT,  -- Описание проекта
    start_date DATE NOT NULL,  -- Дата начала проекта
    end_date DATE,  -- Дата завершения проекта
    budget DECIMAL(15, 2),  -- Бюджет проекта
    status ENUM('Planning', 'In Progress', 'Completed') DEFAULT 'Planning',  -- Статус проекта
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Дата добавления проекта
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Дата последнего обновления
    INDEX(project_name)  -- Индекс для быстрого поиска по названию проекта
);

-- *******************************************************
-- Таблица для связи проектов и наблюдаемых зон
-- *******************************************************
CREATE TABLE IF NOT EXISTS ProjectZones (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор записи
    project_id INT NOT NULL,  -- Идентификатор проекта
    zone_id INT NOT NULL,  -- Идентификатор зоны
    FOREIGN KEY (project_id) REFERENCES EcoProjects(project_id) ON DELETE CASCADE,  -- Связь с проектом
    FOREIGN KEY (zone_id) REFERENCES ObservationZones(zone_id) ON DELETE CASCADE  -- Связь с зоной
);

-- *******************************************************
-- Таблица для учёта экологических событий
-- *******************************************************
CREATE TABLE IF NOT EXISTS EcoEvents (
    event_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор события
    zone_id INT NOT NULL,  -- Идентификатор зоны
    event_type VARCHAR(255) NOT NULL,  -- Тип события (загрязнение, пожар и т.д.)
    description TEXT,  -- Описание события
    event_date DATETIME NOT NULL,  -- Дата и время события
    severity_level ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL,  -- Уровень серьёзности
    FOREIGN KEY (zone_id) REFERENCES ObservationZones(zone_id) ON DELETE CASCADE,  -- Связь с зоной
    INDEX(event_date)  -- Индекс для быстрого поиска по дате события
);

-- *******************************************************
-- Таблица для учёта данных о пользователях, которые могут управлять проектами и событиями
-- *******************************************************
CREATE TABLE IF NOT EXISTS Users (
    user_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора
    username VARCHAR(255) NOT NULL,  -- Логин пользователя
    email VARCHAR(255) NOT NULL,  -- Электронная почта
    password VARCHAR(255) NOT NULL,  -- Пароль
    role ENUM('Admin', 'Manager', 'Observer') DEFAULT 'Observer',  -- Роль пользователя
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Дата добавления пользователя
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Дата последнего обновления
    UNIQUE(email),  -- Уникальность почты
    UNIQUE(username)  -- Уникальность логина
);
