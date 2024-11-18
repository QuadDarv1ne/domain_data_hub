-- *******************************************************
-- Вставка данных в таблицу Users (пользователи)
-- *******************************************************
INSERT INTO Users (user_id, username, email, password, first_name, last_name, phone, address, role_id)
VALUES 
(UUID(), 'john_doe', 'john.doe@example.com', 'hashed_password_1', 'John', 'Doe', '1234567890', '123 Main St, City', 1),
(UUID(), 'jane_smith', 'jane.smith@example.com', 'hashed_password_2', 'Jane', 'Smith', '9876543210', '456 Oak St, City', 2),
(UUID(), 'mark_taylor', 'mark.taylor@example.com', 'hashed_password_3', 'Mark', 'Taylor', '5551234567', '789 Pine St, City', 2),
(UUID(), 'admin_user', 'admin@example.com', 'hashed_password_4', 'Admin', 'User', '1231231234', '101 Admin St, City', 3),
(UUID(), 'lisa_white', 'lisa.white@example.com', 'hashed_password_5', 'Lisa', 'White', '8887776666', '202 White St, City', 1);

-- *******************************************************
-- Вставка данных в таблицу Properties (недвижимость)
-- *******************************************************
INSERT INTO Properties (title, description, price, property_type, area, address, status, agent_id)
VALUES 
('Modern Apartment', 'A beautiful modern apartment in the city center.', 120000.00, 'apartment', 85.5, '123 Main St, City', 'available', (SELECT user_id FROM Users WHERE username = 'john_doe')),
('Cozy House', 'A cozy house with a garden and garage.', 250000.00, 'house', 150.0, '456 Oak St, City', 'available', (SELECT user_id FROM Users WHERE username = 'jane_smith')),
('Luxury Villa', 'Luxury villa with a private pool and stunning view.', 500000.00, 'house', 350.0, '789 Pine St, City', 'available', (SELECT user_id FROM Users WHERE username = 'mark_taylor')),
('Office Space', 'Commercial office space available for rent.', 80000.00, 'commercial', 120.0, '101 Business Ave, City', 'available', (SELECT user_id FROM Users WHERE username = 'admin_user')),
('Penthouse Apartment', 'Exclusive penthouse with a panoramic view of the city.', 750000.00, 'apartment', 200.0, '202 White St, City', 'available', (SELECT user_id FROM Users WHERE username = 'lisa_white'));

-- *******************************************************
-- Вставка данных в таблицу Transactions (сделки)
-- *******************************************************
INSERT INTO Transactions (property_id, buyer_id, sale_price, transaction_date)
VALUES 
((SELECT property_id FROM Properties WHERE title = 'Modern Apartment'), (SELECT user_id FROM Users WHERE username = 'john_doe'), 120000.00, NOW()),
((SELECT property_id FROM Properties WHERE title = 'Cozy House'), (SELECT user_id FROM Users WHERE username = 'jane_smith'), 250000.00, NOW()),
((SELECT property_id FROM Properties WHERE title = 'Luxury Villa'), (SELECT user_id FROM Users WHERE username = 'mark_taylor'), 500000.00, NOW());

-- *******************************************************
-- Вставка данных в таблицу Rentals (аренда)
-- *******************************************************
INSERT INTO Rentals (property_id, renter_id, rent_price, start_date, end_date, rental_status)
VALUES 
((SELECT property_id FROM Properties WHERE title = 'Office Space'), (SELECT user_id FROM Users WHERE username = 'john_doe'), 5000.00, '2024-11-01', '2025-11-01', 'active'),
((SELECT property_id FROM Properties WHERE title = 'Penthouse Apartment'), (SELECT user_id FROM Users WHERE username = 'jane_smith'), 15000.00, '2024-12-01', '2025-12-01', 'active');

-- *******************************************************
-- Вставка данных в таблицу PriceHistory (история цен)
-- *******************************************************
INSERT INTO PriceHistory (property_id, price, change_date)
VALUES 
((SELECT property_id FROM Properties WHERE title = 'Modern Apartment'), 120000.00, NOW()),
((SELECT property_id FROM Properties WHERE title = 'Cozy House'), 250000.00, NOW()),
((SELECT property_id FROM Properties WHERE title = 'Luxury Villa'), 500000.00, NOW()),
((SELECT property_id FROM Properties WHERE title = 'Office Space'), 80000.00, NOW()),
((SELECT property_id FROM Properties WHERE title = 'Penthouse Apartment'), 750000.00, NOW());

-- *******************************************************
-- Вставка данных в таблицу PropertyViews (просмотры объектов)
-- *******************************************************
INSERT INTO PropertyViews (property_id, user_id, view_date)
VALUES 
((SELECT property_id FROM Properties WHERE title = 'Modern Apartment'), (SELECT user_id FROM Users WHERE username = 'john_doe'), NOW()),
((SELECT property_id FROM Properties WHERE title = 'Cozy House'), (SELECT user_id FROM Users WHERE username = 'jane_smith'), NOW()),
((SELECT property_id FROM Properties WHERE title = 'Luxury Villa'), (SELECT user_id FROM Users WHERE username = 'mark_taylor'), NOW()),
((SELECT property_id FROM Properties WHERE title = 'Office Space'), (SELECT user_id FROM Users WHERE username = 'admin_user'), NOW()),
((SELECT property_id FROM Properties WHERE title = 'Penthouse Apartment'), (SELECT user_id FROM Users WHERE username = 'lisa_white'), NOW());
