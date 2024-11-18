-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ БАНКА ИЛИ ФИНАНСОВОЙ КОМПАНИИ
-- *******************************************************
CREATE DATABASE IF NOT EXISTS finance_database;
USE finance_database;

-- *******************************************************
-- Таблица для хранения информации о клиентах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Clients (
    id INT AUTO_INCREMENT PRIMARY KEY,                     -- Уникальный идентификатор клиента
    first_name VARCHAR(255) NOT NULL,                       -- Имя клиента
    last_name VARCHAR(255) NOT NULL,                        -- Фамилия клиента
    email VARCHAR(255) UNIQUE NOT NULL,                     -- Электронная почта клиента (уникальная)
    phone VARCHAR(20),                                      -- Номер телефона клиента
    address TEXT,                                           -- Адрес клиента
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,   -- Дата и время регистрации клиента
    status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active', -- Статус клиента (активен, неактивен, приостановлен)
    last_login DATETIME,                                    -- Дата последнего входа клиента
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,          -- Дата создания записи
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- Дата последнего обновления
) COMMENT = 'Информация о клиентах банка';

-- *******************************************************
-- Таблица для хранения информации о счетах клиентов
-- *******************************************************
CREATE TABLE IF NOT EXISTS Accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,                      -- Уникальный идентификатор счета
    client_id INT NOT NULL,                                  -- Идентификатор клиента (внешний ключ)
    account_type ENUM('Checking', 'Savings', 'Business') NOT NULL,  -- Тип счета (например, текущий, сберегательный)
    balance DECIMAL(15, 2) DEFAULT 0.00,                     -- Баланс счета
    currency VARCHAR(3) DEFAULT 'USD',                       -- Валюта счета (например, USD, EUR)
    opened_at DATETIME DEFAULT CURRENT_TIMESTAMP,            -- Дата открытия счета
    status ENUM('Active', 'Closed', 'Suspended') DEFAULT 'Active', -- Статус счета (активен, закрыт, приостановлен)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Дата создания записи
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Дата последнего обновления
    FOREIGN KEY (client_id) REFERENCES Clients(id) ON DELETE CASCADE -- Внешний ключ на таблицу клиентов
) COMMENT = 'Счета клиентов';

-- *******************************************************
-- Таблица для хранения транзакций по счетам клиентов
-- *******************************************************
CREATE TABLE IF NOT EXISTS Transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,                      -- Уникальный идентификатор транзакции
    account_id INT NOT NULL,                                 -- Идентификатор счета (внешний ключ)
    transaction_type ENUM('Deposit', 'Withdrawal', 'Transfer') NOT NULL,  -- Тип транзакции (депозит, снятие, перевод)
    amount DECIMAL(15, 2) NOT NULL,                          -- Сумма транзакции
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,     -- Дата и время транзакции
    description TEXT,                                        -- Описание транзакции (например, причина перевода)
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Completed', -- Статус транзакции
    FOREIGN KEY (account_id) REFERENCES Accounts(id) ON DELETE CASCADE -- Внешний ключ на таблицу счетов
) COMMENT = 'Транзакции по счетам клиентов';

-- *******************************************************
-- Таблица для хранения информации о кредитах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Loans (
    id INT AUTO_INCREMENT PRIMARY KEY,                      -- Уникальный идентификатор кредита
    client_id INT NOT NULL,                                  -- Идентификатор клиента (внешний ключ)
    loan_amount DECIMAL(15, 2) NOT NULL,                     -- Сумма кредита
    interest_rate DECIMAL(5, 2) NOT NULL,                    -- Процентная ставка по кредиту
    loan_type ENUM('Personal', 'Mortgage', 'Car', 'Business') NOT NULL, -- Тип кредита
    start_date DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Дата начала кредита
    end_date DATETIME,                                       -- Дата окончания кредита
    status ENUM('Active', 'Closed', 'Defaulted') DEFAULT 'Active', -- Статус кредита
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Дата создания записи
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Дата последнего обновления
    FOREIGN KEY (client_id) REFERENCES Clients(id) ON DELETE CASCADE -- Внешний ключ на таблицу клиентов
) COMMENT = 'Информация о кредитах клиентов';

-- *******************************************************
-- Таблица для хранения платежей по кредитам
-- *******************************************************
CREATE TABLE IF NOT EXISTS LoanPayments (
    id INT AUTO_INCREMENT PRIMARY KEY,                      -- Уникальный идентификатор платежа
    loan_id INT NOT NULL,                                    -- Идентификатор кредита (внешний ключ)
    payment_amount DECIMAL(15, 2) NOT NULL,                  -- Сумма платежа
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,         -- Дата и время платежа
    payment_method ENUM('Bank Transfer', 'Credit Card', 'Cash') NOT NULL, -- Способ платежа
    FOREIGN KEY (loan_id) REFERENCES Loans(id) ON DELETE CASCADE -- Внешний ключ на таблицу кредитов
) COMMENT = 'Платежи по кредитам клиентов';

-- *******************************************************
-- Таблица для хранения записей по депозитам (например, для долгосрочных вкладов)
-- *******************************************************
CREATE TABLE IF NOT EXISTS Deposits (
    id INT AUTO_INCREMENT PRIMARY KEY,                      -- Уникальный идентификатор депозита
    client_id INT NOT NULL,                                  -- Идентификатор клиента (внешний ключ)
    deposit_amount DECIMAL(15, 2) NOT NULL,                  -- Сумма депозита
    deposit_type ENUM('Fixed', 'Recurring') NOT NULL,        -- Тип депозита (фиксированный, регулярный)
    interest_rate DECIMAL(5, 2) NOT NULL,                    -- Процентная ставка по депозиту
    start_date DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Дата начала депозита
    maturity_date DATETIME,                                  -- Дата завершения депозита
    status ENUM('Active', 'Closed', 'Matured') DEFAULT 'Active', -- Статус депозита
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Дата создания записи
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Дата последнего обновления
    FOREIGN KEY (client_id) REFERENCES Clients(id) ON DELETE CASCADE -- Внешний ключ на таблицу клиентов
) COMMENT = 'Депозиты клиентов';

-- *******************************************************
-- Таблица для хранения информации о валютных операциях
-- *******************************************************
CREATE TABLE IF NOT EXISTS CurrencyTransactions (
    id INT AUTO_INCREMENT PRIMARY KEY,                      -- Уникальный идентификатор валютной операции
    account_id INT NOT NULL,                                 -- Идентификатор счета (внешний ключ)
    transaction_type ENUM('Exchange', 'Conversion') NOT NULL, -- Тип операции (обмен, конвертация)
    from_currency VARCHAR(3) NOT NULL,                       -- Валюта, из которой происходит операция (например, USD)
    to_currency VARCHAR(3) NOT NULL,                         -- Валюта, в которую происходит операция (например, EUR)
    amount DECIMAL(15, 2) NOT NULL,                          -- Сумма операции
    exchange_rate DECIMAL(10, 4) NOT NULL,                   -- Курс обмена/конвертации
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,     -- Дата и время операции
    FOREIGN KEY (account_id) REFERENCES Accounts(id) ON DELETE CASCADE -- Внешний ключ на таблицу счетов
) COMMENT = 'Валютные операции клиентов';
