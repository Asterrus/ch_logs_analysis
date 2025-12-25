select
  replaceRegexpAll(url, '/\d+', '/{id}') as url,
  avg(response_time) as average_response_time
from web_logs
group by url
order by average_response_time desc
limit 5;
