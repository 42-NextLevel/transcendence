#!/bin/sh

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -p "$port" -U "$user" -d "$dbname" -c '\q'; do
  >&2 echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

>&2 echo "PostgreSQL is up - executing Django commands"

python manage.py migrate

exec "$@"