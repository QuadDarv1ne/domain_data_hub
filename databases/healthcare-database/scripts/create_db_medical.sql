-- *******************************************************
-- СКРИПТ СОЗДАНИЯ БАЗЫ ДАННЫХ ДЛЯ МЕДИЦИНСКОГО УЧРЕЖДЕНИЯ
-- *******************************************************

-- Создание базы данных, если она еще не существует
CREATE DATABASE IF NOT EXISTS healthcare_db;
USE healthcare_db;

-- *******************************************************
-- Таблица для хранения информации о пациентах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор пациента
    name VARCHAR(100) NOT NULL,                 -- Имя пациента
    surname VARCHAR(100) NOT NULL,              -- Фамилия пациента
    patronymic VARCHAR(100),                    -- Отчество пациента
    birth_date DATE NOT NULL,                   -- Дата рождения
    gender ENUM('Male', 'Female', 'Other') NOT NULL, -- Пол пациента
    phone VARCHAR(15),                          -- Телефон пациента
    email VARCHAR(100),                         -- Электронная почта пациента
    address TEXT,                               -- Адрес пациента
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Дата регистрации
);

-- *******************************************************
-- Таблица для хранения информации о врачах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор врача
    name VARCHAR(100) NOT NULL,                 -- Имя врача
    surname VARCHAR(100) NOT NULL,              -- Фамилия врача
    patronymic VARCHAR(100),                    -- Отчество врача
    specialty VARCHAR(100),                     -- Специальность врача
    phone VARCHAR(15),                          -- Телефон врача
    email VARCHAR(100),                         -- Электронная почта врача
    department VARCHAR(100)                     -- Отделение врача
);

-- *******************************************************
-- Таблица для хранения информации о назначениях
-- *******************************************************
CREATE TABLE IF NOT EXISTS Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор назначения
    patient_id INT NOT NULL,                        -- Идентификатор пациента
    doctor_id INT NOT NULL,                         -- Идентификатор врача
    appointment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время назначения
    diagnosis TEXT,                                 -- Диагноз пациента
    treatment_plan TEXT,                            -- План лечения
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения истории болезней пациентов
-- *******************************************************
CREATE TABLE IF NOT EXISTS Diseases (
    disease_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор болезни
    patient_id INT NOT NULL,                     -- Идентификатор пациента
    disease_name VARCHAR(255) NOT NULL,           -- Название болезни
    start_date DATE,                             -- Дата начала болезни
    end_date DATE,                               -- Дата окончания болезни
    description TEXT,                            -- Описание болезни
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о медицинских анализах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Medical_Exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,     -- Уникальный идентификатор анализа
    patient_id INT NOT NULL,                     -- Идентификатор пациента
    exam_name VARCHAR(255) NOT NULL,             -- Название анализа
    exam_date DATE NOT NULL,                     -- Дата проведения анализа
    results TEXT,                                -- Результаты анализа
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE
);

-- *******************************************************
-- Таблица для хранения информации о назначенных медикаментах
-- *******************************************************
CREATE TABLE IF NOT EXISTS Medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY, -- Уникальный идентификатор лекарства
    name VARCHAR(255) NOT NULL,                   -- Название лекарства
    dosage VARCHAR(100),                          -- Дозировка
    frequency VARCHAR(100)                        -- Частота приема
);

-- *******************************************************
-- Таблица для хранения информации о назначениях медикаментов
-- *******************************************************
CREATE TABLE IF NOT EXISTS Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,  -- Уникальный идентификатор назначения
    appointment_id INT NOT NULL,                      -- Идентификатор назначения
    medication_id INT NOT NULL,                       -- Идентификатор лекарства
    start_date DATE NOT NULL,                         -- Дата начала назначения
    end_date DATE NOT NULL,                           -- Дата окончания назначения
    dosage VARCHAR(100),                              -- Дозировка
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id) ON DELETE CASCADE
);



-- *******************************************************
-- Добавление тестовых данных в таблицу Patients
-- *******************************************************
INSERT INTO Patients (name, surname, patronymic, birth_date, gender, phone, email, address)
VALUES
('Ivan', 'Ivanov', 'Ivanovich', '1985-06-15', 'Male', '1234567890', 'ivanov@mail.com', 'Moscow, Red Square, 1'),
('Maria', 'Petrova', 'Sergeevna', '1990-03-20', 'Female', '2345678901', 'petrova@mail.com', 'Moscow, Tverskaya, 2'),
('Alexey', 'Sidorov', 'Vladimirovich', '1975-11-05', 'Male', '3456789012', 'sidorov@mail.com', 'Moscow, Arbat, 3'),
('Olga', 'Smirnova', 'Alekseevna', '1982-01-30', 'Female', '4567890123', 'smirnova@mail.com', 'Moscow, Nevsky, 4'),
('Dmitry', 'Kozlov', 'Igorevich', '1995-12-10', 'Male', '5678901234', 'kozlov@mail.com', 'Moscow, Pushkin Square, 5'),
('Elena', 'Morozova', 'Viktorovna', '1988-07-22', 'Female', '6789012345', 'morozova@mail.com', 'Moscow, Kitay-gorod, 6'),
('Andrey', 'Lebedev', 'Pavlovich', '1992-09-17', 'Male', '7890123456', 'lebedev@mail.com', 'Moscow, Lubyanka, 7'),
('Svetlana', 'Vasilieva', 'Borisovna', '1980-05-12', 'Female', '8901234567', 'vasilieva@mail.com', 'Moscow, Khamovniki, 8'),
('Vladimir', 'Zaharov', 'Mikhailovich', '1965-03-01', 'Male', '9012345678', 'zaharov@mail.com', 'Moscow, Basmanny, 9'),
('Irina', 'Nikolaeva', 'Grigorievna', '1999-10-09', 'Female', '0123456789', 'nikolaeva@mail.com', 'Moscow, Sokolniki, 10');

-- *******************************************************
-- Добавление тестовых данных в таблицу Doctors
-- *******************************************************
INSERT INTO Doctors (name, surname, patronymic, specialty, phone, email, department)
VALUES
('Alexey', 'Baranov', 'Pavlovich', 'Therapist', '1112233445', 'baranov@mail.com', 'Internal Medicine'),
('Olga', 'Sokolova', 'Mikhailovna', 'Cardiologist', '2223344556', 'sokolova@mail.com', 'Cardiology'),
('Vladimir', 'Semenov', 'Sergeevich', 'Surgeon', '3334455667', 'semenov@mail.com', 'Surgery'),
('Dmitry', 'Frolov', 'Igorevich', 'Pediatrician', '4445566778', 'frolov@mail.com', 'Pediatrics'),
('Irina', 'Nikiforova', 'Alexeyevna', 'Dentist', '5556677889', 'nikiforova@mail.com', 'Dentistry'),
('Natalia', 'Vasilieva', 'Grigorievna', 'Neurologist', '6667788990', 'vasilieva@mail.com', 'Neurology'),
('Andrey', 'Petrov', 'Vladimirovich', 'Orthopedist', '7778899001', 'petrov@mail.com', 'Orthopedics'),
('Maria', 'Kozlova', 'Maksimovna', 'Endocrinologist', '8889900112', 'kozlova@mail.com', 'Endocrinology'),
('Eugene', 'Cherepanov', 'Olegovich', 'Urologist', '9990011223', 'cherepanov@mail.com', 'Urology'),
('Tatiana', 'Karpova', 'Antonovna', 'Gynecologist', '1011122334', 'karpova@mail.com', 'Gynecology');
