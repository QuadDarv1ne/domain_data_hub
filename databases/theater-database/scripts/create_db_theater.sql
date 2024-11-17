-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ ТЕАТРА
-- *******************************************************
CREATE DATABASE IF NOT EXISTS theater;
USE theater;

-- *******************************************************
-- Таблица для хранения информации о спектаклях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Plays (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор спектакля
    title VARCHAR(255) NOT NULL,  -- Название спектакля
    genre VARCHAR(100),  -- Жанр спектакля
    description TEXT,  -- Описание спектакля
    duration TIME NOT NULL,  -- Длительность спектакля
    age_restriction INT CHECK (age_restriction >= 0 AND age_restriction <= 18)  -- Возрастное ограничение
);

-- *******************************************************
-- Таблица для хранения информации о актерах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Actors (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор актера
    name VARCHAR(100) NOT NULL,  -- Имя актера
    patronymic VARCHAR(100),  -- Отчество актера
    surname VARCHAR(100) NOT NULL,  -- Фамилия актера
    birth_date DATE,  -- Дата рождения актера
    experience TEXT  -- Опыт актера
);

-- *******************************************************
-- Таблица для хранения информации о ролях актера в спектаклях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Play_Roles (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор роли
    play_id INT NOT NULL,  -- Идентификатор спектакля
    role_name VARCHAR(100) NOT NULL,  -- Название роли
    actor_id INT,  -- Идентификатор актера
    FOREIGN KEY (play_id) REFERENCES Plays(id) ON DELETE CASCADE,  -- Связь с таблицей спектаклей
    FOREIGN KEY (actor_id) REFERENCES Actors(id) ON DELETE SET NULL  -- Связь с таблицей актеров
);

-- *******************************************************
-- Таблица для хранения информации о театральных залах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Halls (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор зала
    name VARCHAR(100) NOT NULL,  -- Название зала
    capacity INT NOT NULL  -- Вместимость зала
);

-- *******************************************************
-- Таблица для хранения информации о сеансах спектаклей
-- *******************************************************
CREATE TABLE IF NOT EXISTS Sessions (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор сеанса
    play_id INT NOT NULL,  -- Идентификатор спектакля
    session_date DATETIME NOT NULL,  -- Дата и время сеанса
    hall_id INT,  -- Идентификатор зала
    FOREIGN KEY (play_id) REFERENCES Plays(id) ON DELETE CASCADE,  -- Связь с таблицей спектаклей
    FOREIGN KEY (hall_id) REFERENCES Halls(id) ON DELETE SET NULL,  -- Связь с таблицей залов
    INDEX (session_date)  -- Индекс для быстрого поиска по дате сеанса
);

-- *******************************************************
-- Таблица для хранения информации о билетах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор билета
    session_id INT NOT NULL,  -- Идентификатор сеанса
    seat_number CHAR(10) NOT NULL,  -- Номер места
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),  -- Цена билета
    status ENUM('available', 'sold', 'reserved') DEFAULT 'available',  -- Статус билета
    sold_at DATETIME,  -- Дата и время продажи/резервирования билета
    FOREIGN KEY (session_id) REFERENCES Sessions(id) ON DELETE CASCADE,  -- Связь с таблицей сеансов
    INDEX (status)  -- Индекс для быстрого поиска по статусу билета
);

-- *******************************************************
-- Таблица для хранения информации о персонале театра
-- *******************************************************
CREATE TABLE IF NOT EXISTS Personnel (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор персонала
    name VARCHAR(100) NOT NULL,  -- Имя персонала
    patronymic VARCHAR(100),  -- Отчество персонала
    surname VARCHAR(100) NOT NULL,  -- Фамилия персонала
    position ENUM('actor', 'director', 'usher', 'manager', 'other') NOT NULL,  -- Должность персонала
    phone CHAR(20),  -- Телефон персонала
    INDEX (position)  -- Индекс для быстрого поиска по должности
);

-- *******************************************************
-- Таблица для хранения информации о режиссерах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Directors (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор режиссера
    name VARCHAR(100) NOT NULL,  -- Имя режиссера
    patronymic VARCHAR(100),  -- Отчество режиссера
    surname VARCHAR(100) NOT NULL,  -- Фамилия режиссера
    play_id INT,  -- Идентификатор спектакля
    FOREIGN KEY (play_id) REFERENCES Plays(id) ON DELETE SET NULL  -- Связь с таблицей спектаклей
);

-- *******************************************************
-- Таблица для хранения информации о посетителях театра
-- *******************************************************
CREATE TABLE IF NOT EXISTS Visitors (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор посетителя
    name VARCHAR(100) NOT NULL,  -- Имя посетителя
    patronymic VARCHAR(100),  -- Отчество посетителя
    surname VARCHAR(100) NOT NULL,  -- Фамилия посетителя
    phone CHAR(20),  -- Телефон посетителя
    email VARCHAR(100) UNIQUE NOT NULL  -- Электронная почта посетителя
);

-- *******************************************************
-- Таблица для хранения информации о заказах билетов
-- *******************************************************
CREATE TABLE IF NOT EXISTS Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор заказа
    visitor_id INT NOT NULL,  -- Идентификатор посетителя
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Дата и время заказа
    total_cost DECIMAL(10, 2) NOT NULL CHECK (total_cost > 0),  -- Общая стоимость заказа
    FOREIGN KEY (visitor_id) REFERENCES Visitors(id) ON DELETE CASCADE  -- Связь с таблицей посетителей
);

-- *******************************************************
-- Таблица для хранения информации о билетах в заказах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Ordered_Tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор записи
    order_id INT NOT NULL,  -- Идентификатор заказа
    ticket_id INT NOT NULL,  -- Идентификатор билета
    FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE,  -- Связь с таблицей заказов
    FOREIGN KEY (ticket_id) REFERENCES Tickets(id) ON DELETE CASCADE  -- Связь с таблицей билетов
);

-- *******************************************************
-- Таблица для хранения информации о подписках на рассылки
-- *******************************************************
CREATE TABLE IF NOT EXISTS Subscriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор подписки
    visitor_id INT NOT NULL,  -- Идентификатор посетителя
    subscription_type ENUM('new_plays', 'special_offers', 'general') DEFAULT 'general',  -- Тип рассылки
    subscribed_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Дата подписки
    FOREIGN KEY (visitor_id) REFERENCES Visitors(id) ON DELETE CASCADE  -- Связь с таблицей посетителей
);

-- *******************************************************
-- Таблица для хранения информации о бонусах и скидках
-- *******************************************************
CREATE TABLE IF NOT EXISTS Discounts (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор скидки
    visitor_id INT NOT NULL,  -- Идентификатор посетителя
    discount_percentage DECIMAL(5, 2) CHECK (discount_percentage BETWEEN 0 AND 100),  -- Процент скидки
    valid_until DATE,  -- Дата окончания действия скидки
    FOREIGN KEY (visitor_id) REFERENCES Visitors(id) ON DELETE CASCADE  -- Связь с таблицей посетителей
);

-- *******************************************************
-- Таблица для хранения оценок спектаклей
-- *******************************************************
CREATE TABLE IF NOT EXISTS Play_Ratings (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Уникальный идентификатор оценки
    play_id INT NOT NULL,  -- Идентификатор спектакля
    visitor_id INT NOT NULL,  -- Идентификатор посетителя
    rating INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,  -- Оценка от 1 до 5
    review TEXT,  -- Отзыв
    rated_at DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Дата и время оценки
    FOREIGN KEY (play_id) REFERENCES Plays(id) ON DELETE CASCADE,  -- Связь с таблицей спектаклей
    FOREIGN KEY (visitor_id) REFERENCES Visitors(id) ON DELETE CASCADE  -- Связь с таблицей посетителей
);

