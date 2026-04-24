#!/bin/bash

# ======================================================
# PRODUCTION PostgreSQL Backup / Restore Script
# Project  : Django + PostgreSQL + Docker
# Container: postgres_db
# Usage    : Production-safe database maintenance
# ======================================================

set -e

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$BASE_DIR"

# ------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------
DB_CONTAINER="postgres_db"
SECRETS_DIR="./secrets"
BACKUP_DIR="./backups"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

DB_NAME=$(cat ${SECRETS_DIR}/db_name.txt)
DB_USER=$(cat ${SECRETS_DIR}/db_user.txt)

DATA_BACKUP_FILE="${BACKUP_DIR}/backup_data_${DATE}.sql"
FULL_BACKUP_FILE="${BACKUP_DIR}/full_backup_${DATE}.sql"
LATEST_BACKUP_LINK="${BACKUP_DIR}/latest_backup.sql"

# ------------------------------------------------------
# PRECHECKS
# ------------------------------------------------------
check_requirements() {
    echo "Checking environment..."

    if ! command -v docker >/dev/null 2>&1; then
        echo "ERROR: Docker tidak ditemukan"
        exit 1
    fi

    if [ ! -d "$SECRETS_DIR" ]; then
        echo "ERROR: Folder ./secrets tidak ditemukan"
        exit 1
    fi

    mkdir -p "$BACKUP_DIR"

    if ! docker ps --format '{{.Names}}' | grep -q "^${DB_CONTAINER}$"; then
        echo "ERROR: Container ${DB_CONTAINER} tidak berjalan"
        exit 1
    fi

    echo "Environment OK"
}

confirm_action() {
    read -p "$1 (yes/no): " confirm
    if [ "$confirm" != "yes" ]; then
        echo "Dibatalkan"
        exit 0
    fi
}

# ------------------------------------------------------
# PERMISSION SETUP
# ------------------------------------------------------
setup_permissions() {
    echo "=== Setup permission script & backup folder ==="

    chmod +x "$0"
    chmod 700 "$BACKUP_DIR" 2>/dev/null || true

    echo "Permission updated"
    echo "Script executable: yes"
    echo "Backup folder protected: yes"
}

# ------------------------------------------------------
# BACKUP DATA ONLY
# ------------------------------------------------------
backup_data() {
    echo "=== Backup DATA ONLY dimulai ==="

    docker exec -t ${DB_CONTAINER} pg_dump \
        -U ${DB_USER} \
        -d ${DB_NAME} \
        --data-only \
        --column-inserts \
        --disable-triggers \
        > "${DATA_BACKUP_FILE}"

    ln -sf "$(basename ${DATA_BACKUP_FILE})" "${LATEST_BACKUP_LINK}"

    echo "Backup selesai"
    echo "File: ${DATA_BACKUP_FILE}"
}

# ------------------------------------------------------
# FULL BACKUP (SCHEMA + DATA)
# ------------------------------------------------------
backup_full() {
    echo "=== Full Backup dimulai ==="

    docker exec -t ${DB_CONTAINER} pg_dump \
        -U ${DB_USER} \
        -d ${DB_NAME} \
        > "${FULL_BACKUP_FILE}"

    echo "Full backup selesai"
    echo "File: ${FULL_BACKUP_FILE}"
}

# ------------------------------------------------------
# TRUNCATE MASTER TABLES
# ------------------------------------------------------
truncate_tables() {
    confirm_action "PERINGATAN: Ini akan menghapus data tabel master. Lanjutkan?"

    echo "=== Truncate dimulai ==="

    docker exec -i ${DB_CONTAINER} psql \
        -U ${DB_USER} \
        -d ${DB_NAME} <<EOF
TRUNCATE TABLE
    spd_standardpenginapan,
    spd_standardtransport,
    spd_lokasi
RESTART IDENTITY CASCADE;
EOF

    echo "Truncate selesai"
}

# ------------------------------------------------------
# RESTORE LATEST BACKUP
# ------------------------------------------------------
restore_latest() {
    if [ ! -f "${LATEST_BACKUP_LINK}" ]; then
        echo "ERROR: latest backup tidak ditemukan"
        exit 1
    fi

    confirm_action "Restore akan menimpa data existing jika belum truncate. Lanjutkan?"

    echo "=== Restore dimulai ==="

    cat "${LATEST_BACKUP_LINK}" | docker exec -i ${DB_CONTAINER} psql \
        -U ${DB_USER} \
        -d ${DB_NAME}

    echo "Restore selesai"
}

# ------------------------------------------------------
# TRUNCATE + RESTORE
# ------------------------------------------------------
truncate_and_restore() {
    truncate_tables
    restore_latest
}

# ------------------------------------------------------
# LIST BACKUPS
# ------------------------------------------------------
list_backups() {
    echo "=== Daftar Backup ==="
    ls -lh "$BACKUP_DIR"
}

# ------------------------------------------------------
# MENU
# ------------------------------------------------------
main_menu() {
    check_requirements

    echo ""
    echo "================================================="
    echo " PostgreSQL Production Maintenance Script"
    echo "================================================="
    echo "1. Setup Permission"
    echo "2. Backup Data Only (Recommended)"
    echo "3. Full Backup (Schema + Data)"
    echo "4. Truncate Master Tables"
    echo "5. Restore Latest Backup"
    echo "6. Truncate + Restore"
    echo "7. List Backup Files"
    echo "================================================="

    read -p "Pilih menu (1-7): " pilihan

    case $pilihan in
        1) setup_permissions ;;
        2) backup_data ;;
        3) backup_full ;;
        4) truncate_tables ;;
        5) restore_latest ;;
        6) truncate_and_restore ;;
        7) list_backups ;;
        *) echo "Pilihan tidak valid" ;;
    esac
}

main_menu
