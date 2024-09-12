#!/bin/bash

# PostgreSQL 서비스가 완전히 시작될 때까지 대기
until PGPASSWORD=$DB_PASSWORD psql -h "localhost" -U "$DB_USER" -c '\q'; do
  >&2 echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

>&2 echo "PostgreSQL is up - executing command"

# 데이터베이스 존재 여부 확인 및 생성
PGPASSWORD=$DB_PASSWORD psql -U "$DB_USER" -d postgres <<-EOSQL
    SELECT 'CREATE DATABASE $DB_NAME'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$DB_NAME')\gexec

EOSQL

echo "Database $DB_NAME is ready."


# ---------------------------------------
# for entrypoint

#!/bin/bash

# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
#     CREATE DATABASE testDB;
#     \c testDB
#     CREATE TABLE FT_TS (id SERIAL PRIMARY KEY, column1 TEXT);
# EOSQL