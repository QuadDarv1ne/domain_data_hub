# Создание базы данных для учебного заведения

### Структура БД

```
+-------------------+       +-------------------+        +-----------------+
|    Students       |       |     Teachers      |        |     Subjects    |
|-------------------|       |-------------------|        |-----------------|
| student_id (PK)   |<----->| teacher_id (PK)   |        | subject_id (PK) |
| name              |       | name              |        | subject_name    |
| surname           |       | surname           |        | description     |
| patronymic        |       | patronymic        |        +-----------------+
| email             |       | email             |
| phone             |       | phone             |          +-----------------+
| address           |       | department        |          | Course_Subjects |
| date_of_birth     |       +-------------------+          |-----------------|
| registration_date |                                 +--> | course_id (FK)  |
+-------------------+                                 |    | subject_id (FK) |
                                                      |    +-----------------+
                                                      |
                                                      |    +-----------------+
+-------------------+                                 |    |    Courses      |
|      Grades       |<--------------------------------+    |-----------------|
|-------------------|                                 +----| course_id (PK)  |
| grade_id (PK)     |                                      | course_name     |
| student_id (FK)   |                                      | description     |
| course_id (FK)    |                                      | duration        |
| grade             |                                      | teacher_id (FK) |
| grade_date        |                                      +-----------------+
+-------------------+


            +--------------------+  
            |      Classes       |  
            |--------------------|  
            | class_id (PK)      |  
            | course_id (FK)     |  
            | class_date         |  
            | class_time         |  
            +--------------------+
```

### Объяснение структуры

1. `Students`:

Таблица для студентов, где каждый студент имеет уникальный идентификатор (`student_id`).
Связь с таблицей Grades через внешний ключ `student_id`

2. `Teachers`:

Таблица для преподавателей, где каждый преподаватель имеет уникальный идентификатор (`teacher_id`).
Связь с таблицей `Courses` через внешний ключ `teacher_id`

3. `Courses`:

Таблица для курсов.
Каждый курс имеет уникальный идентификатор (`course_id`) и связан с таблицей Teachers (внешний ключ teacher_id), а также с таблицей Classes (внешний ключ course_id).

4. `Classes`:

Таблица для расписания занятий.
Каждый класс связан с курсом через внешний ключ `course_id`

5. `Grades`:

Таблица для оценок студентов.
Оценки связаны с таблицами `Students` и `Courses` через внешние ключи `student_id` и `course_id`

6. `Subjects`:

Таблица для предметов.
Связана с таблицей Courses через таблицу `Course_Subjects`

7. `Course_Subjects`:

Связующая таблица для связи курсов и предметов, содержащая внешние ключи `course_id` и `subject_id`


**Автор:** Дуплей Максим Игоревич

**Дата:** 17.11.2024
