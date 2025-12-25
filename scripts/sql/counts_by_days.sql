select
  toDate(timestamp) as day,
  count()
from web_logs
group by day
order by day asc;
