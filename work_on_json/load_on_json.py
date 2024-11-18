import json
from pathlib import Path

def load_and_pretty_print_json(file_path):
    """
    Чтение и красивый вывод данных из JSON файла.
    :param file_path: Путь к JSON файлу.
    """
    file = Path(file_path)
    
    if not file.exists():
        print(f"Ошибка: файл '{file_path}' не найден.")
        return
    
    try:
        # Чтение и загрузка данных из JSON файла
        with file.open('r', encoding='utf-8') as f:
            data = json.load(f)
        
        # Вывод данных с отступами для улучшенной читаемости
        print(json.dumps(data, indent=4, ensure_ascii=False))
        
    except json.JSONDecodeError:
        print(f"Ошибка: не удалось разобрать файл '{file_path}' как JSON.")
    except Exception as e:
        print(f"Неизвестная ошибка: {e}")


# Пример использования с исправленным путём
file_path = r'C:\Users\maksi\Documents\GitHub\domain_data_hub\work_on_json\users.json'
load_and_pretty_print_json(file_path)
