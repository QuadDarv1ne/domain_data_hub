import json

# Пример данных о пользователях
users_data = [
    {
        "username": "john_doe",
        "email": "john.doe@example.com",
        "password": "password123",  # В реальных приложениях пароль должен быть зашифрован
        "role": "user"
    },
    {
        "username": "admin_user",
        "email": "admin@example.com",
        "password": "adminpass",
        "role": "admin"
    },
    {
        "username": "alice_smith",
        "email": "alice.smith@example.com",
        "password": "alicepass",
        "role": "user"
    }
]

# Путь к файлу для записи
file_path = 'users.json'

# Запись данных о пользователях в JSON файл
with open(file_path, 'w', encoding='utf-8') as file:
    json.dump(users_data, file, ensure_ascii=False, indent=4)

print(f"Файл {file_path} успешно создан с аккаунтами пользователей.")
