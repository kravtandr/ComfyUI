#!/bin/bash

# Проверяем, существует ли виртуальное окружение
if [ ! -d "venv" ]; then
  echo "Виртуальное окружение 'venv' не найдено. Убедитесь, что оно создано."
  exit 1
fi

# Активируем виртуальное окружение
echo "Активируем виртуальное окружение..."
source venv/bin/activate

# Проверяем, существует ли файл launch.py
if [ ! -f "launch.py" ]; then
  echo "Файл 'launch.py' не найден. Убедитесь, что он находится в текущей директории."
  deactivate
  exit 1
fi

# Запускаем Python-скрипт с параметром --skip-install
echo "Запускаем launch.py с параметром --skip-install..."
python3 launch.py --skip-install

# Деактивируем виртуальное окружение после выполнения
echo "Деактивируем виртуальное окружение..."
deactivate
