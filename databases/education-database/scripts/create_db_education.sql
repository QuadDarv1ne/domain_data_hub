
-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ УЧЕБНОГО ЗАВЕДЕНИЯ
-- *******************************************************
CREATE DATABASE IF NOT EXISTS education;
USE education;

-- *******************************************************
-- Таблица для хранения информации о студентах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Students (
    student_id CHAR(36) PRIMARY KEY,                       -- UUID для уникального идентификатора студента
    name VARCHAR(255) NOT NULL,                            -- Имя студента
    surname VARCHAR(255) NOT NULL,                         -- Фамилия студента
    patronymic VARCHAR(255),                               -- Отчество студента
    email VARCHAR(255) UNIQUE,                             -- Электронная почта
    phone VARCHAR(15),                                     -- Телефон
    address VARCHAR(255),                                  -- Адрес
    date_of_birth DATE,                                    -- Дата рождения
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Дата регистрации
);

-- *******************************************************
-- Таблица для хранения информации о преподавателях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Teachers (
    teacher_id CHAR(36) PRIMARY KEY,  -- UUID для уникального идентификатора преподавателя
    name VARCHAR(255) NOT NULL,       -- Имя преподавателя
    surname VARCHAR(255) NOT NULL,    -- Фамилия преподавателя
    patronymic VARCHAR(255),          -- Отчество преподавателя
    email VARCHAR(255) UNIQUE,        -- Электронная почта
    phone VARCHAR(15),                -- Телефон
    department VARCHAR(255)           -- Кафедра или факультет
);

-- *******************************************************
-- Таблица для хранения информации о курсах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор курса
    course_name VARCHAR(255) NOT NULL,         -- Название курса
    description TEXT,                          -- Описание курса
    duration INT,                              -- Продолжительность курса (в неделях)
    teacher_id CHAR(36),                       -- Внешний ключ на преподавателя
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- *******************************************************
-- Таблица для хранения информации о занятиях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор занятия
    course_id INT,                            -- Внешний ключ на курс
    class_date DATE,                          -- Дата занятия
    class_time TIME,                          -- Время занятия
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- *******************************************************
-- Таблица для хранения информации о студенческих оценках
-- *******************************************************
CREATE TABLE IF NOT EXISTS Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,         -- Уникальный идентификатор оценки
    student_id CHAR(36),                             -- Внешний ключ на студента
    course_id INT,                                   -- Внешний ключ на курс
    grade DECIMAL(5, 2),                             -- Оценка
    grade_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Дата выставления оценки
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- *******************************************************
-- Таблица для хранения информации о предметах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор предмета
    subject_name VARCHAR(255) NOT NULL,         -- Название предмета
    description TEXT                            -- Описание предмета
);

-- *******************************************************
-- Таблица для хранения связей между курсами и предметами
-- *******************************************************
CREATE TABLE IF NOT EXISTS Course_Subjects (
    course_id INT,   -- Внешний ключ на курс
    subject_id INT,  -- Внешний ключ на предмет
    PRIMARY KEY (course_id, subject_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- *******************************************************
-- Вставка тестовых данных в таблицу Teachers (Преподаватели)
-- *******************************************************
INSERT INTO Teachers (teacher_id, name, surname, patronymic, email, phone, department) VALUES
    ('1e6e9b80-532d-4e59-b238-1c58fddf41c9', 'Анна', 'Иванова', 'Петровна', 'anna.ivanova@school.com', '1234567890', 'Математика'),
    ('2d16c0c1-36d9-4b67-9c8e-09f8fd89a74e', 'Борис', 'Смирнов', 'Александрович', 'boris.smirnov@school.com', '0987654321', 'Физика');

-- *******************************************************
-- Вставка тестовых данных в таблицу Courses (Курсы)
-- *******************************************************
INSERT INTO Courses (course_name, description, duration, teacher_id) VALUES
    ('Математика для начинающих', 'Основы математики для школьников', 12, '1e6e9b80-532d-4e59-b238-1c58fddf41c9'),
    ('Физика для начинающих', 'Основы физики для школьников', 10, '2d16c0c1-36d9-4b67-9c8e-09f8fd89a74e');

-- *******************************************************
-- Вставка тестовых данных в таблицу Classes (Занятия)
-- *******************************************************
INSERT INTO Classes (course_id, class_date, class_time) VALUES
    (1, '2024-11-20', '10:00:00'),
    (1, '2024-11-22', '10:00:00'),
    (2, '2024-11-20', '14:00:00'),
    (2, '2024-11-22', '14:00:00');

-- *******************************************************
-- Вставка тестовых данных в таблицу Students (Студенты)
-- *******************************************************
INSERT INTO Students (student_id, name, surname, patronymic, email, phone, address, date_of_birth) VALUES
    ('1f3e6a69-b4b0-41da-bf56-0c74a36e7d4c', 'Иван', 'Петров', 'Сергеевич', 'ivan.petrov@student.com', '1231231234', 'ул. Ленина, д. 10', '2000-05-15'),
    ('2a4b5c1e-98e6-4ab6-b2db-c4f023f7b8d2', 'Мария', 'Кузнецова', 'Дмитриевна', 'maria.kuznetsova@student.com', '3213214321', 'ул. Победы, д. 5', '1999-08-22');

-- *******************************************************
-- Вставка тестовых данных в таблицу Grades (Оценки)
-- *******************************************************
INSERT INTO Grades (student_id, course_id, grade) VALUES
    ('1f3e6a69-b4b0-41da-bf56-0c74a36e7d4c', 1, 4.5),
    ('2a4b5c1e-98e6-4ab6-b2db-c4f023f7b8d2', 2, 5.0);

-- *******************************************************
-- Вставка тестовых данных в таблицу Subjects (Предметы)
-- *******************************************************
INSERT INTO Subjects (subject_name, description) VALUES
    ('Математика', 'Основы математики и алгебры'),
    ('Физика', 'Основы механики и термодинамики');

-- *******************************************************
-- Вставка тестовых данных в таблицу Course_Subjects (Курсы и предметы)
-- *******************************************************
INSERT INTO Course_Subjects (course_id, subject_id) VALUES
    (1, 1),
    (2, 2);

-- Завершение
