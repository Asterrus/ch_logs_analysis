### Описание
Анализ логов веб-сервиса. ClickHouse

### Инструменты

- docker
- docker-compose
- uv

### Запуск

1. Клонировать репозиторий и перейти в директорию проекта:

   ```bash
   git clone ...
   cd ch_logs_analysis
   ```

2. Запустить docker-compose(таблица логов создается из файла init/001_create_tables.sql):

   ```bash
   docker compose up -d
   ```
3. Генерация данных:

   ```bash
   uv run scripts/logs_generation.py
   ```
4. Загрузка сгенерированных данных в clickhouse:

   ```bash
    docker exec -i clickhouse_logs_analysis clickhouse-client --query="INSERT INTO web_logs FORMAT JSONEachRow" < logs.jsonl
   ```
