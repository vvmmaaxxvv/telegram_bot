FROM python:3.12-slim

# Устанавливаем зависимости
RUN pip install --no-cache-dir python-dotenv python-telegram-bot asyncpg asyncssh paramiko

# Копируем необходимые файлы
COPY ./BD_bot.py /app/BD_bot.py

# Указываем рабочую директорию
WORKDIR /app

# Запускаем бота
CMD ["python", "./BD_bot.py"]