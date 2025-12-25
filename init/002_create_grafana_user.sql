CREATE USER IF NOT EXISTS grafana
IDENTIFIED WITH plaintext_password BY 'grafana';

GRANT SELECT ON default.* TO grafana;