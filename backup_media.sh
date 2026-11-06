#!/bin/sh
set -eu

APP_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
cd "$APP_DIR"

BACKUP_DIR="$APP_DIR/backups"
BACKUP_FILE="$BACKUP_DIR/media_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
mkdir -p "$BACKUP_DIR"

docker compose exec -T web tar -czf - -C /app/media . > "$BACKUP_FILE"
if [ ! -s "$BACKUP_FILE" ]; then
    rm -f "$BACKUP_FILE"
    echo "Backup media gagal atau tidak berisi data." >&2
    exit 1
fi

echo "Backup media tersimpan: $BACKUP_FILE"