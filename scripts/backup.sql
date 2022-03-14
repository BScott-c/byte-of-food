CREATE ROLE readaccess;
GRANT CONNECT ON DATABASE byteoffood TO readaccess;
GRANT USAGE ON SCHEMA public TO readaccess;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readaccess;

CREATE USER backup WITH PASSWORD 'read_password';
GRANT readaccess TO backup;