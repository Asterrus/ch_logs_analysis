CREATE TABLE IF NOT EXISTS web_logs
(
    timestamp     DateTime,
    user_id       UInt64,
    url           String,
    response_time UInt32,
    status_code   UInt16
)
ENGINE = MergeTree
PARTITION BY toDate(timestamp)
ORDER BY (timestamp, url);
