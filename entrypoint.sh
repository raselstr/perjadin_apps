#!/bin/sh
set -e

mkdir -p /app/staticfiles /app/media

echo "⏳ Waiting for Postgres..."
until pg_isready -h "$DB_HOST" -p "$DB_PORT"; do
  sleep 2
done

echo "🚀 Apply database migrations..."
python manage.py migrate --noinput

echo "📦 Collect static files..."
python manage.py collectstatic --noinput --clear

echo "🔥 Starting server..."
exec gunicorn config.wsgi:application --bind 0.0.0.0:80 --bind 0.0.0.0:8085 --workers 3 --timeout 120 --access-logfile -
