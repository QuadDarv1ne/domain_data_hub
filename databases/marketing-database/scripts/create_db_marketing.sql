-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ МАРКЕТИНГОВОЙ КОМПАНИИ
-- *******************************************************
CREATE DATABASE IF NOT EXISTS marketing_company;
USE marketing_company;

-- *******************************************************
-- Таблица для хранения информации о клиентах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор клиента
    company_name VARCHAR(255) NOT NULL,        -- Название компании
    contact_name VARCHAR(255),                 -- Имя контактного лица
    email VARCHAR(255),                        -- Электронная почта
    phone VARCHAR(15),                         -- Телефон
    address VARCHAR(255),                      -- Адрес
    industry VARCHAR(100),                     -- Отрасль
    website VARCHAR(255)                       -- Сайт компании
);

-- *******************************************************
-- Таблица для хранения информации о кампаниях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Campaigns (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор кампании
    campaign_name VARCHAR(255) NOT NULL,         -- Название кампании
    client_id INT,                               -- Идентификатор клиента (FK)
    start_date DATE,                             -- Дата начала кампании
    end_date DATE,                               -- Дата окончания кампании
    budget DECIMAL(15, 2),                       -- Бюджет кампании
    status ENUM('planned', 'active', 'completed') DEFAULT 'planned', -- Статус кампании
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о рекламных материалах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Ad_Materials (
    material_id INT AUTO_INCREMENT PRIMARY KEY,   -- Уникальный идентификатор материала
    campaign_id INT,                              -- Идентификатор кампании (FK)
    material_name VARCHAR(255) NOT NULL,          -- Название материала (например, баннер, видео)
    type ENUM('banner', 'video', 'article', 'other') NOT NULL,  -- Тип материала
    description TEXT,                             -- Описание материала
    cost DECIMAL(10, 2),                          -- Стоимость материала
    FOREIGN KEY (campaign_id) REFERENCES Campaigns(campaign_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения данных об эффективности кампаний
-- *******************************************************
CREATE TABLE IF NOT EXISTS Campaign_Performance (
    performance_id INT AUTO_INCREMENT PRIMARY KEY, -- Уникальный идентификатор
    campaign_id INT,                               -- Идентификатор кампании (FK)
    metric_name VARCHAR(255) NOT NULL,             -- Название показателя (например, клики, конверсии)
    value DECIMAL(15, 2),                          -- Значение показателя
    date DATE,                                     -- Дата записи
    FOREIGN KEY (campaign_id) REFERENCES Campaigns(campaign_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о сотрудниках
-- *******************************************************
CREATE TABLE IF NOT EXISTS Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,    -- Уникальный идентификатор сотрудника
    first_name VARCHAR(255) NOT NULL,               -- Имя сотрудника
    last_name VARCHAR(255) NOT NULL,                -- Фамилия сотрудника
    position VARCHAR(255),                          -- Должность
    email VARCHAR(255) NOT NULL,                    -- Электронная почта
    phone VARCHAR(15),                              -- Телефон
    hire_date DATE                                  -- Дата найма
);

-- *******************************************************
-- Таблица для хранения данных о задачах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,        -- Уникальный идентификатор задачи
    campaign_id INT,                               -- Идентификатор кампании (FK)
    employee_id INT,                               -- Идентификатор сотрудника (FK)
    task_name VARCHAR(255) NOT NULL,               -- Название задачи
    due_date DATE,                                 -- Дата выполнения задачи
    status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',  -- Статус задачи
    FOREIGN KEY (campaign_id) REFERENCES Campaigns(campaign_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE CASCADE
);
