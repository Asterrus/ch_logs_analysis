select
    countIf(status_code between 400 and 499) as client_errors,
    countIf(status_code between 500 and 599) as server_errors
from web_logs;
