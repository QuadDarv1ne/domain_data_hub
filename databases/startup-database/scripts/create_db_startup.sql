-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ СТАРТАПОВ
-- *******************************************************
CREATE DATABASE IF NOT EXISTS startup_db;
USE startup_db;

-- *******************************************************
-- Таблица для хранения информации о стартапах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Startups (
    startup_id INT AUTO_INCREMENT PRIMARY KEY,        -- Уникальный идентификатор стартапа
    name VARCHAR(255) NOT NULL,                        -- Название стартапа
    description TEXT,                                  -- Описание стартапа
    founder_id INT,                                    -- Идентификатор основателя (внешний ключ)
    founded_date DATE NOT NULL,                        -- Дата основания стартапа
    industry VARCHAR(255),                             -- Отрасль стартапа
    website VARCHAR(255),                              -- Веб-сайт стартапа
    status ENUM('active', 'inactive', 'closed') DEFAULT 'active', -- Статус стартапа
    FOREIGN KEY (founder_id) REFERENCES Founders(founder_id)  -- Связь с таблицей основателей
);

-- *******************************************************
-- Таблица для хранения информации об основателях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Founders (
    founder_id INT AUTO_INCREMENT PRIMARY KEY,         -- Уникальный идентификатор основателя
    first_name VARCHAR(255) NOT NULL,                   -- Имя основателя
    last_name VARCHAR(255) NOT NULL,                    -- Фамилия основателя
    email VARCHAR(255) NOT NULL UNIQUE,                 -- Электронная почта основателя
    phone VARCHAR(15),                                  -- Телефон основателя
    date_of_birth DATE,                                 -- Дата рождения основателя
    linkedin_profile VARCHAR(255)                       -- Ссылка на профиль в LinkedIn
);

-- *******************************************************
-- Таблица для хранения информации о инвесторах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Investors (
    investor_id INT AUTO_INCREMENT PRIMARY KEY,        -- Уникальный идентификатор инвестора
    name VARCHAR(255) NOT NULL,                         -- Имя инвестора
    email VARCHAR(255) NOT NULL UNIQUE,                 -- Электронная почта инвестора
    phone VARCHAR(15),                                  -- Телефон инвестора
    investment_amount DECIMAL(15, 2)                    -- Сумма инвестиций
);

-- *******************************************************
-- Таблица для хранения информации о финансировании стартапов
-- *******************************************************
CREATE TABLE IF NOT EXISTS Startup_Funding (
    funding_id INT AUTO_INCREMENT PRIMARY KEY,         -- Уникальный идентификатор финансирования
    startup_id INT,                                    -- Идентификатор стартапа (внешний ключ)
    investor_id INT,                                   -- Идентификатор инвестора (внешний ключ)
    funding_date DATE NOT NULL,                        -- Дата инвестирования
    amount DECIMAL(15, 2) NOT NULL,                    -- Сумма инвестиции
    equity_percentage DECIMAL(5, 2) NOT NULL,          -- Доля в стартапе (в процентах)
    FOREIGN KEY (startup_id) REFERENCES Startups(startup_id),   -- Связь с таблицей стартапов
    FOREIGN KEY (investor_id) REFERENCES Investors(investor_id)  -- Связь с таблицей инвесторов
);

-- *******************************************************
-- Таблица для хранения информации о вехах стартапа
-- *******************************************************
CREATE TABLE IF NOT EXISTS Milestones (
    milestone_id INT AUTO_INCREMENT PRIMARY KEY,       -- Уникальный идентификатор вехи
    startup_id INT,                                    -- Идентификатор стартапа (внешний ключ)
    description TEXT NOT NULL,                          -- Описание вехи
    milestone_date DATE NOT NULL,                       -- Дата достижения вехи
    status ENUM('achieved', 'pending') DEFAULT 'pending', -- Статус вехи (достигнута или нет)
    FOREIGN KEY (startup_id) REFERENCES Startups(startup_id)  -- Связь с таблицей стартапов
);

-- *******************************************************
-- Таблица для хранения информации о документах стартапов
-- *******************************************************
CREATE TABLE IF NOT EXISTS Documents (
    document_id INT AUTO_INCREMENT PRIMARY KEY,        -- Уникальный идентификатор документа
    startup_id INT,                                    -- Идентификатор стартапа (внешний ключ)
    document_type VARCHAR(255) NOT NULL,                -- Тип документа (например, договор, бизнес-план)
    document_url VARCHAR(255) NOT NULL,                 -- URL документа (ссылка на хранилище)
    upload_date DATE NOT NULL,                          -- Дата загрузки документа
    FOREIGN KEY (startup_id) REFERENCES Startups(startup_id)  -- Связь с таблицей стартапов
);
