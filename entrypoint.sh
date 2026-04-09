#!/bin/sh

echo "⏳ Waiting for Postgres..."
until pg_isready -h "$DB_HOST" -p "$DB_PORT"; do
  sleep 2
done

echo "🚀 Apply database migrations..."
python manage.py migrate

echo "📦 Collect static files..."
python manage.py collectstatic --noinput

echo "🔥 Starting server..."
exec gunicorn config.wsgi:application --bind 0.0.0.0:8000