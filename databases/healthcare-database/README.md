# Создание базы данных для медицинского учреждения

### Структура БД

```
+-------------------+        +-------------------+      +-------------------+
|    Patients       |        |      Doctors      |      |   Medical_Exams   |
+-------------------+        +-------------------+      +-------------------+
| patient_id (PK)   | <----> | doctor_id (PK)    |      | exam_id (PK)      |
| name              |        | name              |      | patient_id (FK)   |
| surname           |        | surname           |      | exam_name         |
| patronymic        |        | patronymic        |      | exam_date         |
| birth_date        |        | specialty         |      | results           |
| gender            |        | phone             |      |                   |
| phone             |        | email             |      +-------------------+
| email             |        | department        |
| address           |        +-------------------+
| registration_date |                   |
+-------------------+                   |
       |                                |
       |                                |
       v                                v
+--------------------+         +-------------------+       +-------------------+
|    Appointments    |         |     Diseases      |       |   Medications     |
+--------------------+         +-------------------+       +-------------------+
| appointment_id (PK)|         | disease_id (PK)   |       | medication_id (PK)|
| patient_id (FK)    | <-----> | patient_id (FK)   |       | name              |
| doctor_id (FK)     |         | disease_name      |       | dosage            |
| appointment_date   |         | start_date        |       | frequency         |
| diagnosis          |         | end_date          |       +-------------------+
| treatment_plan     |         | description       |
+--------------------+         +-------------------+        
       |
       |
       |
       v
+---------------------+
|     Prescriptions   |
+---------------------+
| prescription_id (PK)|
| appointment_id (FK) |
| medication_id (FK)  |
| start_date          |
| end_date            |
| dosage              |
+---------------------+
```

### Объяснение cвязей

1. `Patients ↔ Appointments`:
   Один пациент может иметь несколько назначений (визитов к врачам). Поэтому поле patient_id в таблице Appointments является внешним ключом, ссылающимся на patient_id в таблице Patients.

2. `Doctors ↔ Appointments`:
   Один врач может вести несколько пациентов. Поле doctor_id в таблице Appointments связывает конкретное назначение с врачом.

3. `Patients ↔ Diseases`:
   У каждого пациента может быть несколько заболеваний. Поле patient_id в таблице Diseases ссылается на patient_id в таблице Patients.

4. `Patients ↔ Medical_Exams`:
   Пациент может пройти несколько анализов, каждый из которых связан с конкретным пациентом. Поле patient_id в таблице Medical_Exams связывает анализ с пациентом.

5. `Appointments ↔ Prescriptions`:
   Каждое назначение может включать в себя несколько рецептов на лекарства, поэтому таблица Prescriptions имеет внешние ключи appointment_id (ссылается на Appointments) и medication_id (ссылается на Medications).

6. `Medications ↔ Prescriptions`:
   Лекарства, назначаемые пациентам, связаны с конкретными назначениями через таблицу Prescriptions.


**Автор:** Дуплей Максим Игоревич

**Дата:** 17.11.2024
