FROM postgres:14-alpine

COPY ./init.sql /docker-entrypoint-initdb.d/init.sql
# COPY ./postgrest.conf ~/postgrest.conf

# RUN echo 'db-uri = "postgres://<username>:<password>@127.0.0.1/<dbname>"' \
#          'db-schema = "public"' \
#          'db-anon-role = "<username>"' \
#          'server-port=8000''

CMD ["postgres", "-c", "log_statement=all", "-c", "log_connections=true", "-c", "log_destination=stderr"]