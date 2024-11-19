-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ ГЕЙМДЕВА
-- *******************************************************
CREATE DATABASE IF NOT EXISTS game_dev;
USE game_dev;

-- *******************************************************
-- Таблица для хранения информации о играх
-- *******************************************************
CREATE TABLE IF NOT EXISTS Games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор игры
    game_name VARCHAR(255) NOT NULL,         -- Название игры
    genre VARCHAR(100),                      -- Жанр игры
    release_date DATE,                       -- Дата релиза
    platform VARCHAR(255),                   -- Платформа (например, PC, PS5, Xbox)
    developer_id INT,                        -- Идентификатор разработчика (FK)
    description TEXT                          -- Описание игры
);

-- *******************************************************
-- Таблица для хранения информации о разработчиках
-- *******************************************************
CREATE TABLE IF NOT EXISTS Developers (
    developer_id INT AUTO_INCREMENT PRIMARY KEY, -- Уникальный идентификатор разработчика
    developer_name VARCHAR(255) NOT NULL,        -- Название студии или имя разработчика
    country VARCHAR(100),                        -- Страна разработки
    established YEAR,                            -- Год основания студии
    website VARCHAR(255)                         -- Сайт разработчика
);

-- *******************************************************
-- Таблица для хранения информации о персонажах игры
-- *******************************************************
CREATE TABLE IF NOT EXISTS Characters (
    character_id INT AUTO_INCREMENT PRIMARY KEY, -- Уникальный идентификатор персонажа
    game_id INT,                                 -- Идентификатор игры (FK)
    character_name VARCHAR(255) NOT NULL,        -- Имя персонажа
    role VARCHAR(100),                           -- Роль персонажа в игре
    abilities TEXT,                              -- Способности персонажа
    backstory TEXT,                              -- История персонажа
    FOREIGN KEY (game_id) REFERENCES Games(game_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о уровнях игры
-- *******************************************************
CREATE TABLE IF NOT EXISTS Levels (
    level_id INT AUTO_INCREMENT PRIMARY KEY, -- Уникальный идентификатор уровня
    game_id INT,                             -- Идентификатор игры (FK)
    level_name VARCHAR(255) NOT NULL,        -- Название уровня
    difficulty VARCHAR(50),                  -- Сложность уровня
    description TEXT,                        -- Описание уровня
    FOREIGN KEY (game_id) REFERENCES Games(game_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о внутриигровых предметах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор предмета
    game_id INT,                             -- Идентификатор игры (FK)
    item_name VARCHAR(255) NOT NULL,         -- Название предмета
    item_type VARCHAR(100),                  -- Тип предмета (например, оружие, броня, зелье)
    description TEXT,                        -- Описание предмета
    FOREIGN KEY (game_id) REFERENCES Games(game_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о достижениях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Achievements (
    achievement_id INT AUTO_INCREMENT PRIMARY KEY, -- Уникальный идентификатор достижения
    game_id INT,                                   -- Идентификатор игры (FK)
    achievement_name VARCHAR(255) NOT NULL,         -- Название достижения
    description TEXT,                              -- Описание достижения
    points INT,                                    -- Количество очков за достижение
    FOREIGN KEY (game_id) REFERENCES Games(game_id) ON DELETE CASCADE
);
