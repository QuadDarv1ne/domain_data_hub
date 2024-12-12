-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ БЕССМЕРТНОГО ПОЛКА
-- *******************************************************
CREATE DATABASE IF NOT EXISTS memory_archive;
USE memory_archive;

-- *******************************************************
-- Таблица для хранения информации о героях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Heroes (
    hero_id INT AUTO_INCREMENT PRIMARY KEY,               -- Уникальный идентификатор героя
    name VARCHAR(255) NOT NULL,                           -- Имя героя
    surname VARCHAR(255) NOT NULL,                        -- Фамилия героя
    patronymic VARCHAR(255),                              -- Отчество героя
    birth_date DATE,                                      -- Дата рождения
    death_date DATE,                                      -- Дата смерти (если есть)
    biography TEXT,                                       -- Биография героя
    photo VARCHAR(255),                                   -- Фото героя (ссылка)
    military_rank VARCHAR(100),                           -- Воинское звание
    military_unit VARCHAR(255),                           -- Военное подразделение
    awards TEXT,                                          -- Награды героя (можно в формате JSON)
    battle_participations TEXT                            -- Участие в битвах (можно в формате JSON)
);

-- *******************************************************
-- Таблица для хранения информации о родственниках героев
-- *******************************************************
CREATE TABLE IF NOT EXISTS Relatives (
    relative_id INT AUTO_INCREMENT PRIMARY KEY,           -- Уникальный идентификатор родственника
    hero_id INT,                                          -- Идентификатор героя (FK)
    name VARCHAR(255) NOT NULL,                           -- Имя родственника
    surname VARCHAR(255) NOT NULL,                        -- Фамилия родственника
    patronymic VARCHAR(255),                              -- Отчество родственника
    relationship VARCHAR(100),                            -- Родство с героем (например, "отец", "жена")
    birth_date DATE,                                      -- Дата рождения родственника
    death_date DATE,                                      -- Дата смерти (по желанию)
    FOREIGN KEY (hero_id) REFERENCES Heroes(hero_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о событиях, связанных с героями
-- *******************************************************
CREATE TABLE IF NOT EXISTS Hero_Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,              -- Уникальный идентификатор события
    hero_id INT,                                          -- Идентификатор героя (FK)
    event_date DATE,                                      -- Дата события
    event_description TEXT NOT NULL,                      -- Описание события (например, участие в бою)
    location VARCHAR(255),                                -- Место события
    FOREIGN KEY (hero_id) REFERENCES Heroes(hero_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о памятниках и мемориалах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Memorials (
    memorial_id INT AUTO_INCREMENT PRIMARY KEY,           -- Уникальный идентификатор памятника
    name VARCHAR(255) NOT NULL,                           -- Название памятника
    location VARCHAR(255) NOT NULL,                       -- Местоположение памятника
    description TEXT,                                     -- Описание памятника
    unveiling_date DATE,                                  -- Дата открытия памятника
    hero_id INT,                                          -- Ссылка на героя, если памятник связан с ним
    FOREIGN KEY (hero_id) REFERENCES Heroes(hero_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о фотогалерее
-- *******************************************************
CREATE TABLE IF NOT EXISTS Photo_Gallery (
    photo_id INT AUTO_INCREMENT PRIMARY KEY,              -- Уникальный идентификатор фото
    hero_id INT,                                          -- Ссылка на героя
    photo_url VARCHAR(255) NOT NULL,                      -- Ссылка на фото
    description TEXT,                                     -- Описание фото
    date_added DATE,                                      -- Дата добавления фото
    FOREIGN KEY (hero_id) REFERENCES Heroes(hero_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о пользователях сайта (для создания профилей участников)
-- *******************************************************
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,               -- Уникальный идентификатор пользователя
    username VARCHAR(255) NOT NULL,                       -- Имя пользователя
    password VARCHAR(255) NOT NULL,                       -- Пароль
    email VARCHAR(255),                                   -- Электронная почта
    role ENUM('admin', 'user') DEFAULT 'user',            -- Роль пользователя (администратор или пользователь)
    registered_date DATE                                  -- Дата регистрации
);
