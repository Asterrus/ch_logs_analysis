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

2. Запустить docker-compose.  
   Таблица логов создается из файла init/001_create_tables.sql:

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

5. SQL запросы.  
   1.Общее количество запросов за каждый день.  
   Выводы: Нагрузка равномерная по дням
   ```bash
    docker exec -i clickhouse_logs_analysis clickhouse-client --multiquery < scripts/sql/counts_by_days.sql
   ```  
   2.Среднее время ответа для каждого URL.  
   Выводы: Среднее время запросов примерно 177 мс
   ```bash
    docker exec -i clickhouse_logs_analysis clickhouse-client --multiquery < scripts/sql/average_response_time_by_url.sql
   ```  
   3.Общее число ошибок.  
   Выводы: Ошибок примерно 10% от всех запросов, ошибок сервера меньше чем ошибок клиента
   ```bash
    docker exec -i clickhouse_logs_analysis clickhouse-client --multiquery < scripts/sql/count_of_errors.sql
   ```  
   4.Топ-10 пользователей по количеству запросов.  
   Выводы: Топ 10 покупателей
   ```bash
    docker exec -i clickhouse_logs_analysis clickhouse-client --multiquery < scripts/sql/top_users_by_request_count.sql
   ```

6. Оптимизации:  
  1.Партиционирование:  
    PARTITION BY toDate(timestamp)  
  2.Сортировка:  
    ORDER BY (timestamp, url)  
  3.LowCardinality:  
    url LowCardinality(String)
