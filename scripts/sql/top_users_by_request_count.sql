select
    user_id,
    count() as requests_count
from web_logs
group by user_id
order by requests_count desc
limit 10;
