CREATE TABLE web_logs_daily
(
    day Date,
    url LowCardinality(String),
    requests_count UInt64,
    avg_response_time Float64
)
ENGINE = SummingMergeTree
PARTITION BY day
ORDER BY (day, url);

CREATE MATERIALIZED VIEW mv_web_logs_daily
TO web_logs_daily
AS
SELECT
    toDate(timestamp) AS day,
    url,
    count() AS requests_count,
    avg(response_time) AS avg_response_time
FROM web_logs
GROUP BY day, url;
