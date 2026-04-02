# =========================
# BASE IMAGE
# =========================
FROM python:3.12-slim

# =========================
# ENVIRONMENT
# =========================
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# =========================
# WORKDIR
# =========================
WORKDIR /app

# =========================
# SYSTEM DEPENDENCIES
# =========================
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && apt-get clean

# =========================
# INSTALL PYTHON DEPENDENCIES
# =========================
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# =========================
# COPY PROJECT
# =========================
COPY . .

# =========================
# COLLECT STATIC (optional nanti)
# =========================
# RUN python manage.py collectstatic --noinput

# =========================
# RUN APP
# =========================
CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]