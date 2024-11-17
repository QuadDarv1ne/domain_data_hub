-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ ОНЛАЙН-МАГАЗИНА
-- *******************************************************
CREATE DATABASE IF NOT EXISTS online_store;
USE online_store;

-- *******************************************************
-- Таблица для хранения информации о пользователях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Users (
    user_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора
    username VARCHAR(255) NOT NULL,  -- Логин пользователя
    email VARCHAR(255) NOT NULL,  -- Электронная почта
    password VARCHAR(255) NOT NULL,  -- Пароль
    first_name VARCHAR(255),  -- Имя
    last_name VARCHAR(255),  -- Фамилия
    phone VARCHAR(15),  -- Телефон
    address VARCHAR(255),  -- Адрес пользователя
    role ENUM('customer', 'admin', 'moderator') DEFAULT 'customer',  -- Роль пользователя
    UNIQUE(email),  -- Уникальность почты
    UNIQUE(username),  -- Уникальность логина
    CHECK (LENGTH(username) > 0)  -- Логин не может быть пустым
);

-- *******************************************************
-- Таблица для хранения информации о категориях товаров
-- *******************************************************
CREATE TABLE IF NOT EXISTS Categories (
    category_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора категории
    name VARCHAR(255) NOT NULL,  -- Название категории товара
    description TEXT,  -- Описание категории
    UNIQUE(name),  -- Уникальность названия категории
    CHECK (LENGTH(name) > 0)  -- Название категории не должно быть пустым
);

-- *******************************************************
-- Таблица для хранения информации о товарах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Products (
    product_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора товара
    name VARCHAR(255) NOT NULL,  -- Название товара
    description TEXT,  -- Описание товара
    price DECIMAL(10, 2) NOT NULL,  -- Цена товара
    stock_quantity INT NOT NULL DEFAULT 0,  -- Количество товара на складе
    category_id CHAR(36) NOT NULL,  -- Внешний ключ на категорию товара
    supplier_id CHAR(36) NOT NULL,  -- Внешний ключ на поставщика
    image_url VARCHAR(255),  -- Ссылка на изображение товара
    FOREIGN KEY (category_id) REFERENCES Categories (category_id) ON DELETE CASCADE,  -- Связь с таблицей категорий
    FOREIGN KEY (supplier_id) REFERENCES Suppliers (supplier_id) ON DELETE CASCADE,  -- Связь с таблицей поставщиков
    CHECK (LENGTH(name) > 0),  -- Название товара не может быть пустым
    CHECK (price > 0)  -- Цена товара должна быть больше 0
);

-- *******************************************************
-- Таблица для хранения информации о поставщиках
-- *******************************************************
CREATE TABLE IF NOT EXISTS Suppliers (
    supplier_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора поставщика
    name VARCHAR(255) NOT NULL,  -- Название поставщика
    contact_person VARCHAR(255),  -- Контактное лицо
    phone VARCHAR(15),  -- Телефон поставщика
    email VARCHAR(255),  -- Электронная почта
    address VARCHAR(255),  -- Адрес поставщика
    UNIQUE(name),  -- Уникальность названия поставщика
    CHECK (LENGTH(name) > 0)  -- Название поставщика не может быть пустым
);

-- *******************************************************
-- Таблица для хранения информации о заказах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Orders (
    order_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора заказа
    user_id CHAR(36) NOT NULL,  -- Внешний ключ на пользователя
    total_price DECIMAL(10, 2) NOT NULL,  -- Общая стоимость заказа
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Дата и время заказа
    status ENUM('pending', 'shipped', 'delivered', 'cancelled', 'returned') DEFAULT 'pending',  -- Статус заказа
    shipping_address VARCHAR(255),  -- Адрес доставки
    FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE,  -- Связь с таблицей пользователей
    CHECK (total_price > 0)  -- Общая стоимость заказа должна быть больше 0
);

-- *******************************************************
-- Таблица для хранения информации о заказанных товарах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Order_Items (
    order_item_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора записи
    order_id CHAR(36) NOT NULL,  -- Внешний ключ на заказ
    product_id CHAR(36) NOT NULL,  -- Внешний ключ на товар
    quantity INT NOT NULL,  -- Количество товара в заказе
    total_price DECIMAL(10, 2) NOT NULL,  -- Общая стоимость товаров в заказе
    FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE,  -- Связь с таблицей заказов
    FOREIGN KEY (product_id) REFERENCES Products (product_id) ON DELETE CASCADE,  -- Связь с таблицей товаров
    CHECK (quantity > 0),  -- Количество товара в заказе должно быть больше 0
    CHECK (total_price > 0)  -- Общая стоимость товаров в заказе должна быть больше 0
);

-- *******************************************************
-- Таблица для хранения информации о платежах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Payments (
    payment_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора платежа
    order_id CHAR(36) NOT NULL,  -- Внешний ключ на заказ
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Дата и время платежа
    amount DECIMAL(10, 2) NOT NULL,  -- Сумма платежа
    payment_method ENUM('credit_card', 'paypal', 'bank_transfer', 'cryptocurrency') NOT NULL,  -- Способ оплаты
    payment_status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',  -- Статус платежа
    FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE,  -- Связь с таблицей заказов
    CHECK (amount > 0)  -- Сумма платежа должна быть больше 0
);

-- *******************************************************
-- Индексы для улучшения производительности запросов
-- *******************************************************
CREATE INDEX idx_users_email ON Users (email);
CREATE INDEX idx_products_name ON Products (name);
CREATE INDEX idx_orders_order_date ON Orders (order_date);
CREATE INDEX idx_payments_payment_date ON Payments (payment_date);
CREATE INDEX idx_order_items_order_id ON Order_Items (order_id);
CREATE INDEX idx_order_items_product_id ON Order_Items (product_id);

-- *******************************************************
-- Скрипт для добавления данных в каждую таблицу
-- *******************************************************

-- *******************************************************
-- Добавление данных в таблицу Users
-- *******************************************************
INSERT INTO Users (user_id, username, email, password, first_name, last_name, phone, address, role)
VALUES 
(UUID(), 'johndoe', 'johndoe@example.com', 'hashedpassword', 'John', 'Doe', '1234567890', 'Москва, Ленин 1', 'customer'),
(UUID(), 'janedoe', 'janedoe@example.com', 'hashedpassword', 'Jane', 'Doe', '0987654321', 'Москва, Тверская 2', 'customer'),
(UUID(), 'alexsmith', 'alexsmith@example.com', 'hashedpassword', 'Alex', 'Smith', '1112223333', 'Санкт-Петербург, Невский 3', 'customer'),
(UUID(), 'emilyjones', 'emilyjones@example.com', 'hashedpassword', 'Emily', 'Jones', '4445556666', 'Москва, Арбат 4', 'customer'),
(UUID(), 'markbrown', 'markbrown@example.com', 'hashedpassword', 'Mark', 'Brown', '7778889999', 'Москва, Пушкина 5', 'customer'),
(UUID(), 'lucywhite', 'lucywhite@example.com', 'hashedpassword', 'Lucy', 'White', '1231231231', 'Казань, Кремлевская 6', 'customer'),
(UUID(), 'chrisgreen', 'chrisgreen@example.com', 'hashedpassword', 'Chris', 'Green', '3213213213', 'Москва, Сокольники 7', 'customer'),
(UUID(), 'karenblack', 'karenblack@example.com', 'hashedpassword', 'Karen', 'Black', '6546546546', 'Москва, Таганка 8', 'customer'),
(UUID(), 'jamesmiller', 'jamesmiller@example.com', 'hashedpassword', 'James', 'Miller', '9879879879', 'Санкт-Петербург, Петроградская 9', 'customer'),
(UUID(), 'susanclark', 'susanclark@example.com', 'hashedpassword', 'Susan', 'Clark', '3453453453', 'Москва, Павелецкая 10', 'customer');

-- *******************************************************
-- Добавление данных в таблицу Categories
-- *******************************************************
INSERT INTO Categories (category_id, name, description)
VALUES 
(UUID(), 'Электроника', 'Все виды электронных гаджетов и приборов'),
(UUID(), 'Книги', 'Книги различных жанров'),
(UUID(), 'Одежда', 'Модная одежда для всех'),
(UUID(), 'Товары для дома и кухни', 'Мебель и кухонная техника'),
(UUID(), 'Спортивные товары', 'Товары для спорта и фитнеса'),
(UUID(), 'Игрушки', 'Игрушки для детей всех возрастов'),
(UUID(), 'Косметика', 'Косметика и средства личной гигиены'),
(UUID(), 'Здоровье', 'БАДы и товары для здоровья'),
(UUID(), 'Автомобили', 'Автозапчасти и аксессуары'),
(UUID(), 'Продукты', 'Продукты питания и товары для дома');

-- *******************************************************
-- Добавление данных в таблицу Suppliers
-- *******************************************************
INSERT INTO Suppliers (supplier_id, name, contact_person, phone, email, address)
VALUES 
(UUID(), 'TechSupply', 'Джон Уэйн', '5555555555', 'techsupply@example.com', 'Москва, Проспект Мира 1'),
(UUID(), 'BookWorld', 'Сьюзен Уэллс', '5556666666', 'bookworld@example.com', 'Москва, Пушкин 2'),
(UUID(), 'FashionCorp', 'Эмма Дэвис', '5557777777', 'fashioncorp@example.com', 'Санкт-Петербург, Ленин 3'),
(UUID(), 'HomeStuff', 'Майкл Браун', '5558888888', 'homestuff@example.com', 'Казань, Кремлевская 4'),
(UUID(), 'SportMaster', 'Дэвид Грин', '5559999999', 'sportmaster@example.com', 'Москва, Тверская 5'),
(UUID(), 'ToyStore', 'Оливия Уайт', '5551111111', 'toystore@example.com', 'Москва, Новослободская 6'),
(UUID(), 'BeautyShop', 'Исла Кларк', '5552222222', 'beautyshop@example.com', 'Санкт-Петербург, Невский 7'),
(UUID(), 'HealthFirst', 'Люк Миллер', '5553333333', 'healthfirst@example.com', 'Москва, Варшавка 8'),
(UUID(), 'AutoParts', 'Лили Мур', '5554444444', 'autoparts@example.com', 'Москва, Остоженка 9'),
(UUID(), 'SuperMart', 'Джеймс Ли', '5550000000', 'supermart@example.com', 'Казань, Центральная 10');

-- *******************************************************
-- Добавление данных в таблицу Products
-- *******************************************************
INSERT INTO Products (product_id, name, description, price, stock_quantity, category_id, supplier_id, image_url)
VALUES 
(UUID(), 'Смартфон', 'Последняя модель смартфона с 6ГБ оперативной памяти и 128ГБ памяти', 599.99, 100, UUID(), UUID(), 'url_to_image1'),
(UUID(), 'Ноутбук', 'Мощный ноутбук с процессором Intel i7', 999.99, 50, UUID(), UUID(), 'url_to_image2'),
(UUID(), 'Наушники', 'Наушники с активным шумоподавлением', 199.99, 200, UUID(), UUID(), 'url_to_image3'),
(UUID(), 'Умные часы', 'Смарт-часы для фитнес-трекинга с мониторингом сердечного ритма', 149.99, 300, UUID(), UUID(), 'url_to_image4'),
(UUID(), 'Беспроводная мышь', 'Эргономичная беспроводная мышь с долгим временем работы', 29.99, 500, UUID(), UUID(), 'url_to_image5'),
(UUID(), 'Футболка', 'Хлопковая футболка с модным принтом', 19.99, 400, UUID(), UUID(), 'url_to_image6'),
(UUID(), 'Джинсы', 'Стильные джинсы для повседневной носки', 49.99, 150, UUID(), UUID(), 'url_to_image7'),
(UUID(), 'Блендер', 'Мощный блендер для смузи и супов', 89.99, 75, UUID(), UUID(), 'url_to_image8'),
(UUID(), 'Фитнес-трекер', 'Трекер для подсчета шагов, калорий и сна', 59.99, 250, UUID(), UUID(), 'url_to_image9'),
(UUID(), 'Автомобильный аккумулятор', 'Качественный автомобильный аккумулятор для надежной работы', 129.99, 40, UUID(), UUID(), 'url_to_image10');

-- *******************************************************
-- Добавление данных в таблицу Orders
-- *******************************************************
INSERT INTO Orders (order_id, user_id, total_price, order_date, status, shipping_address)
VALUES 
(UUID(), UUID(), 799.99, NOW(), 'pending', 'Москва, Ленин 1'),
(UUID(), UUID(), 1299.99, NOW(), 'shipped', 'Москва, Тверская 2'),
(UUID(), UUID(), 499.99, NOW(), 'delivered', 'Санкт-Петербург, Невский 3'),
(UUID(), UUID(), 299.99, NOW(), 'cancelled', 'Казань, Кремлевская 4'),
(UUID(), UUID(), 899.99, NOW(), 'returned', 'Москва, Арбат 5'),
(UUID(), UUID(), 49.99, NOW(), 'pending', 'Санкт-Петербург, Петроградская 6'),
(UUID(), UUID(), 199.99, NOW(), 'shipped', 'Москва, Сокольники 7'),
(UUID(), UUID(), 149.99, NOW(), 'delivered', 'Москва, Таганка 8'),
(UUID(), UUID(), 59.99, NOW(), 'cancelled', 'Москва, Павелецкая 9'),
(UUID(), UUID(), 999.99, NOW(), 'returned', 'Санкт-Петербург, Центральная 10');

-- *******************************************************
-- Добавление данных в таблицу Order_Items
-- *******************************************************
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, total_price)
VALUES 
(UUID(), UUID(), UUID(), 1, 599.99),
(UUID(), UUID(), UUID(), 2, 999.99),
(UUID(), UUID(), UUID(), 3, 199.99),
(UUID(), UUID(), UUID(), 1, 149.99),
(UUID(), UUID(), UUID(), 4, 29.99),
(UUID(), UUID(), UUID(), 2, 49.99),
(UUID(), UUID(), UUID(), 3, 89.99),
(UUID(), UUID(), UUID(), 1, 59.99),
(UUID(), UUID(), UUID(), 1, 129.99),
(UUID(), UUID(), UUID(), 4, 79.99);

-- *******************************************************
-- Добавление данных в таблицу Payments
-- *******************************************************
INSERT INTO Payments (payment_id, order_id, payment_date, amount, payment_method, status)
VALUES 
(UUID(), UUID(), NOW(), 799.99, 'credit_card', 'completed'),
(UUID(), UUID(), NOW(), 1299.99, 'paypal', 'pending'),
(UUID(), UUID(), NOW(), 499.99, 'bank_transfer', 'completed'),
(UUID(), UUID(), NOW(), 299.99, 'credit_card', 'failed'),
(UUID(), UUID(), NOW(), 899.99, 'paypal', 'completed'),
(UUID(), UUID(), NOW(), 49.99, 'credit_card', 'pending'),
(UUID(), UUID(), NOW(), 199.99, 'bank_transfer', 'completed'),
(UUID(), UUID(), NOW(), 149.99, 'credit_card', 'completed'),
(UUID(), UUID(), NOW(), 59.99, 'paypal', 'failed'),
(UUID(), UUID(), NOW(), 999.99, 'credit_card', 'completed');
