-- Создание базы данных
CREATE DATABASE cafe_management;
USE cafe_management;

-- Таблица меню
CREATE TABLE Menu (
    MenuID INT PRIMARY KEY AUTO_INCREMENT,        -- Уникальный идентификатор блюда
    Name VARCHAR(255) NOT NULL,                   -- Название блюда
    Description TEXT,                             -- Описание блюда (например, ингредиенты, особенности)
    Price DECIMAL(10, 2) NOT NULL,                -- Цена блюда
    Category VARCHAR(100),                        -- Категория (например, закуски, основные блюда, десерты)
    Availability BOOLEAN DEFAULT TRUE,            -- Доступность блюда (TRUE - в наличии, FALSE - временно недоступно)
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP, -- Дата добавления блюда
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Дата последнего обновления информации о блюде
) COMMENT = 'Список доступных блюд в меню ресторана';

-- Таблица рецептов
CREATE TABLE MenuIngredients (
    RecipeID INT PRIMARY KEY AUTO_INCREMENT, -- Уникальный идентификатор записи
    MenuID INT NOT NULL,                     -- Ссылка на блюдо из таблицы Menu
    IngredientID INT NOT NULL,               -- Ссылка на ингредиент из таблицы Inventory
    Quantity DECIMAL(10, 2),                 -- Количество ингредиента, необходимого для блюда
    FOREIGN KEY (MenuID) REFERENCES Menu(MenuID) ON DELETE CASCADE,
    FOREIGN KEY (IngredientID) REFERENCES Inventory(InventoryID) ON DELETE CASCADE
) COMMENT = 'Связь между блюдами и используемыми ингредиентами (рецепты)';

-- Таблица запасов
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT, -- Уникальный идентификатор ингредиента
    IngredientName VARCHAR(255) NOT NULL,       -- Название ингредиента (например, мука, сахар)
    Quantity DECIMAL(10, 2),                    -- Текущее количество ингредиента на складе
    Unit VARCHAR(50),                           -- Единица измерения (например, кг, л, шт)
    MinimumThreshold DECIMAL(10, 2),            -- Минимальное количество для уведомлений о необходимости пополнения
    LastUpdated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Дата последнего обновления информации
) COMMENT = 'Учет ингредиентов и запасов на складе';

-- Таблица клиентов
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,   -- Уникальный идентификатор клиента
    Name VARCHAR(255),                           -- Имя клиента
    PhoneNumber VARCHAR(15),                     -- Номер телефона клиента
    Email VARCHAR(255) UNIQUE,                   -- Электронная почта (уникальная)
    Address TEXT,                                -- Адрес клиента (опционально)
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP -- Дата регистрации клиента
) COMMENT = 'Информация о клиентах ресторана';

-- Таблица сотрудников
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,   -- Уникальный идентификатор сотрудника
    Name VARCHAR(255) NOT NULL,                  -- Имя сотрудника
    Role VARCHAR(100),                           -- Должность (например, официант, повар)
    PhoneNumber VARCHAR(15),                     -- Номер телефона сотрудника
    HireDate DATE,                               -- Дата найма
    Salary DECIMAL(10, 2),                       -- Зарплата сотрудника
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP -- Дата добавления информации о сотруднике
) COMMENT = 'Сведения о сотрудниках ресторана';

-- Таблица заказов
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,       -- Уникальный идентификатор заказа
    CustomerID INT,                               -- Ссылка на клиента из таблицы Customers
    EmployeeID INT,                               -- Ссылка на сотрудника, обработавшего заказ
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP, -- Дата оформления заказа
    TotalAmount DECIMAL(10, 2),                   -- Общая сумма заказа
    Status ENUM('Ожидание', 'В процессе', 'Завершен', 'Отменен') DEFAULT 'Ожидание', -- Статус заказа
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
) COMMENT = 'Сведения о заказах клиентов';

-- Таблица позиций заказа
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT, -- Уникальный идентификатор записи
    OrderID INT,                                -- Ссылка на заказ из таблицы Orders
    MenuID INT,                                 -- Ссылка на блюдо из таблицы Menu
    Quantity INT NOT NULL,                      -- Количество порций блюда
    Price DECIMAL(10, 2),                       -- Цена блюда в заказе (с учетом возможных скидок)
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (MenuID) REFERENCES Menu(MenuID) ON DELETE CASCADE
) COMMENT = 'Подробная информация о позициях в заказах';

-- Таблица поставщиков
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,   -- Уникальный идентификатор поставщика
    Name VARCHAR(255) NOT NULL,                  -- Название компании-поставщика
    ContactInfo TEXT,                            -- Контактная информация (телефон, email)
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP -- Дата добавления информации о поставщике
) COMMENT = 'Список поставщиков ингредиентов';

-- Таблица поставок
CREATE TABLE Supplies (
    SupplyID INT PRIMARY KEY AUTO_INCREMENT, -- Уникальный идентификатор поставки
    SupplierID INT,                          -- Ссылка на поставщика из таблицы Suppliers
    IngredientID INT,                        -- Ссылка на ингредиент из таблицы Inventory
    Quantity DECIMAL(10, 2),                 -- Количество поставленного ингредиента
    Unit VARCHAR(50),                        -- Единица измерения
    Price DECIMAL(10, 2),                    -- Цена поставки
    DeliveryDate DATE,                       -- Дата поставки
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE CASCADE,
    FOREIGN KEY (IngredientID) REFERENCES Inventory(InventoryID) ON DELETE CASCADE
) COMMENT = 'Информация о поставках ингредиентов от поставщиков';

-- Таблица скидок
CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY AUTO_INCREMENT, -- Уникальный идентификатор скидки
    Name VARCHAR(255) NOT NULL,                -- Название скидки (например, "Счастливые часы")
    DiscountPercentage DECIMAL(5, 2) NOT NULL, -- Размер скидки в процентах
    StartDate DATE,                            -- Дата начала действия скидки
    EndDate DATE,                              -- Дата окончания действия скидки
    MenuID INT,                                -- Ссылка на блюдо, для которого действует скидка
    FOREIGN KEY (MenuID) REFERENCES Menu(MenuID) ON DELETE SET NULL
) COMMENT = 'Система скидок для блюд';

-- Таблица логирования действий сотрудников
CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,          -- Уникальный идентификатор записи
    EmployeeID INT,                                -- Ссылка на сотрудника из таблицы Employees
    Action VARCHAR(255),                           -- Описание действия (например, "Добавил блюдо в меню")
    ActionDate DATETIME DEFAULT CURRENT_TIMESTAMP, -- Дата и время действия
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
) COMMENT = 'Логирование действий сотрудников ресторана';



/* Добавление данных в базу данных */
-- Добавление данных в таблицу Menu
INSERT INTO Menu (Name, Description, Price, Category, Availability) VALUES
('Борщ', 'Традиционный русский суп с говядиной и свеклой', 300.00, 'Супы', TRUE),
('Цезарь', 'Классический салат с курицей, сыром и сухариками', 450.00, 'Салаты', TRUE),
('Чизкейк', 'Десерт на основе сыра с малиновым соусом', 250.00, 'Десерты', TRUE),
('Паста Карбонара', 'Итальянская паста с соусом на основе сливок и бекона', 550.00, 'Основные блюда', TRUE);

-- Добавление данных в таблицу Inventory
INSERT INTO Inventory (IngredientName, Quantity, Unit, MinimumThreshold) VALUES
('Свекла', 50, 'кг', 10),
('Говядина', 30, 'кг', 5),
('Сыр', 20, 'кг', 5),
('Курица', 25, 'кг', 5),
('Малина', 15, 'кг', 5),
('Макароны', 50, 'кг', 10),
('Сливки', 10, 'л', 3);

-- Добавление данных в таблицу MenuIngredients
INSERT INTO MenuIngredients (MenuID, IngredientID, Quantity) VALUES
(1, 1, 0.2), -- Борщ, свекла
(1, 2, 0.3), -- Борщ, говядина
(2, 4, 0.2), -- Цезарь, курица
(2, 3, 0.1), -- Цезарь, сыр
(3, 5, 0.1), -- Чизкейк, малина
(4, 6, 0.3), -- Паста Карбонара, макароны
(4, 7, 0.2); -- Паста Карбонара, сливки

-- Добавление данных в таблицу Customers
INSERT INTO Customers (Name, PhoneNumber, Email, Address) VALUES
('Иван Иванов', '+79991234567', 'ivanov@example.com', 'г. Москва, ул. Ленина, д. 1'),
('Анна Смирнова', '+79987654321', 'smirnova@example.com', 'г. Санкт-Петербург, Невский пр., д. 10');

-- Добавление данных в таблицу Employees
INSERT INTO Employees (Name, Role, PhoneNumber, HireDate, Salary) VALUES
('Ольга Петрова', 'Официант', '+79995551234', '2023-01-15', 40000.00),
('Дмитрий Соколов', 'Повар', '+79994442345', '2022-11-20', 60000.00);

-- Добавление данных в таблицу Orders
INSERT INTO Orders (CustomerID, EmployeeID, TotalAmount, Status) VALUES
(1, 1, 750.00, 'Ожидание'),
(2, 2, 1050.00, 'Завершен');

-- Добавление данных в таблицу OrderItems
INSERT INTO OrderItems (OrderID, MenuID, Quantity, Price) VALUES
(1, 1, 2, 300.00), -- 2 порции Борща
(1, 2, 1, 450.00), -- 1 порция Цезаря
(2, 4, 1, 550.00), -- 1 порция Пасты Карбонара
(2, 3, 2, 250.00); -- 2 порции Чизкейка

-- Добавление данных в таблицу Suppliers
INSERT INTO Suppliers (Name, ContactInfo) VALUES
('ООО Поставки Вкуса', 'example@supplies.ru, +79998887766'),
('Фермерский Союз', 'farmunion@example.com, +79997775544');

-- Добавление данных в таблицу Supplies
INSERT INTO Supplies (SupplierID, IngredientID, Quantity, Unit, Price, DeliveryDate) VALUES
(1, 1, 20, 'кг', 3000.00, '2023-10-01'),
(1, 2, 10, 'кг', 5000.00, '2023-10-01'),
(2, 5, 5, 'кг', 1500.00, '2023-10-02');

-- Добавление данных в таблицу Discounts
INSERT INTO Discounts (Name, DiscountPercentage, StartDate, EndDate, MenuID) VALUES
('Счастливые часы', 10.00, '2023-10-01', '2023-10-31', 1);

-- Добавление данных в таблицу EmployeeLogs
INSERT INTO EmployeeLogs (EmployeeID, Action) VALUES
(1, 'Оформление заказа №1'),
(2, 'Добавление нового блюда: Паста Карбонара');
