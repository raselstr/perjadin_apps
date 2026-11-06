#!/usr/bin/env bash
# ==============================================================================
# Script Otomasi Deploy & Penanganan Static Files untuk Production (Docker)
# Aplikasi: Perjadin Apps
# ==============================================================================
set -euo pipefail

APP_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd "$APP_DIR"

echo "=========================================================="
echo "🚀 Memulai Deployment Perjadin Apps ke Docker (Production)"
echo "=========================================================="

# 1. Mendeteksi Perintah Docker & Docker Compose
DOCKER_CMD=""
if command -v docker >/dev/null 2>&1; then
    DOCKER_CMD="docker"
elif [ -x "/home/stafperbendaharaan/.local/bin/docker" ]; then
    DOCKER_CMD="/home/stafperbendaharaan/.local/bin/docker"
elif command -v flatpak-spawn >/dev/null 2>&1 && flatpak-spawn --host which docker >/dev/null 2>&1; then
    DOCKER_CMD="flatpak-spawn --host docker"
else
    echo "❌ Docker tidak ditemukan pada sistem." >&2
    exit 1
fi

echo "✔ Docker: $($DOCKER_CMD --version)"

if ! $DOCKER_CMD compose version >/dev/null 2>&1; then
    echo "❌ Docker Compose plugin tidak tersedia pada Docker." >&2
    exit 1
fi
echo "✔ Docker Compose: $($DOCKER_CMD compose version)"

# 2. Verifikasi File Secrets
echo "🔑 Memeriksa berkas secrets..."
for secret in db_name db_user db_password secret_key; do
    if [ ! -s "secrets/${secret}.txt" ]; then
        echo "❌ Secret 'secrets/${secret}.txt' belum ada atau kosong!" >&2
        echo "   Pastikan secrets terisi sebelum deploy ke production." >&2
        exit 1
    fi
done
echo "✔ File secrets lengkap."

# 3. Verifikasi & Buat Network Docker jika Belum Ada
echo "🌐 Memeriksa Docker network 'production_network'..."
if ! $DOCKER_CMD network inspect production_network >/dev/null 2>&1; then
    echo "⚙ Network 'production_network' belum ada, membuat network..."
    $DOCKER_CMD network create production_network
fi
echo "✔ Network 'production_network' siap."

# 4. Siapkan Direktori Pendukung
mkdir -p static staticfiles media backups

# 5. Build Image & Up Container
echo "📦 Membangun image dan menjalankan container (docker compose up -d --build)..."
$DOCKER_CMD compose up -d --build

# 6. Menunggu Container Siap
echo "⏳ Memastikan container 'perjadin_apps' berjalan..."
MAX_WAIT=40
READY=false
for i in $(seq 1 $MAX_WAIT); do
    STATUS="$($DOCKER_CMD inspect -f '{{.State.Status}}' perjadin_apps 2>/dev/null || true)"
    if [ "$STATUS" = "running" ]; then
        READY=true
        break
    fi
    sleep 1
done

if [ "$READY" != "true" ]; then
    echo "❌ Container 'perjadin_apps' gagal mencapai status running." >&2
    $DOCKER_CMD compose logs --tail 40 web
    exit 1
fi
echo "✔ Container 'perjadin_apps' telah berjalan."

# Beri jeda singkat untuk inisialisasi Gunicorn dan database
sleep 2

# 7. Penanganan Static Files untuk Production
echo "📦 Menangani static files (collectstatic --clear)..."
$DOCKER_CMD compose exec -T web python manage.py collectstatic --noinput --clear
echo "✔ Static files berhasil dikumpulkan ke volume perjadin_static."

# Opsional: Salin staticfiles dari container ke host jika direktori host dapat ditulisi
if [ -w "./staticfiles" ]; then
    echo "📂 Memperbarui cache staticfiles lokal host..."
    $DOCKER_CMD compose cp web:/app/staticfiles/. ./staticfiles/ 2>/dev/null || true
fi

# 8. Migrasi Database
echo "🚀 Memeriksa dan menjalankan migrasi database..."
$DOCKER_CMD compose exec -T web python manage.py migrate --noinput
echo "✔ Migrasi database selesai."

# 9. Ringkasan Status
echo "=========================================================="
echo "🎉 Deployment ke Production Berhasil!"
echo "=========================================================="
$DOCKER_CMD compose ps

echo ""
echo "Detail Akses:"
echo " - Akses Lokal/LAN : http://192.168.66.167:8085/"
echo " - Reverse Proxy   : http://192.168.66.167/ (Nginx Proxy Manager)"
echo " - Static Files    : Ditangani WhiteNoise via volume 'perjadin_static'"
echo " - Media Uploads   : Volume 'perjadin_media'"
echo ""
echo "Untuk melihat log realtime server:"
echo " $DOCKER_CMD compose logs -f web"
