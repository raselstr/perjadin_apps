#!/bin/bash

# ======================================================
# PostgreSQL Global Maintenance Script
# ======================================================

set -e

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$BASE_DIR"

# ======================================================
# CONFIG
# ======================================================

DB_CONTAINER="postgres"
SECRETS_DIR="./secrets"

DB_NAME=$(cat ${SECRETS_DIR}/db_name.txt)
DB_USER=$(cat ${SECRETS_DIR}/db_user.txt)
DB_PASSWORD=$(cat ${SECRETS_DIR}/db_password.txt)

BACKUP_DIR="./backups"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

DATA_BACKUP_FILE="${BACKUP_DIR}/backup_data_${DATE}.sql"
FULL_BACKUP_FILE="${BACKUP_DIR}/full_backup_${DATE}.sql"
LATEST_BACKUP_FILE="${BACKUP_DIR}/latest_backup.sql"

# ======================================================
# CHECK ENVIRONMENT
# ======================================================

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

    # gunakan sudo otomatis
    if ! sudo docker ps >/dev/null 2>&1; then
        echo "ERROR: Docker tidak dapat diakses"
        exit 1
    fi

    if ! sudo docker ps --format '{{.Names}}' | grep -q "^${DB_CONTAINER}$"; then
        echo "ERROR: Container ${DB_CONTAINER} tidak berjalan"
        exit 1
    fi

    echo "Environment OK"
}

# ======================================================
# CONFIRM
# ======================================================

confirm_action() {
    read -p "$1 (yes/no): " confirm

    if [ "$confirm" != "yes" ]; then
        echo "Dibatalkan"
        exit 0
    fi
}

# ======================================================
# SETUP
# ======================================================

setup_permissions() {

    echo "Setup permission..."

    chmod +x "$0"

    mkdir -p "$BACKUP_DIR"

    chmod 700 "$BACKUP_DIR" 2>/dev/null || true

    echo "Permission updated"
}

# ======================================================
# BACKUP DATA ONLY
# ======================================================

backup_data() {

    echo "Backup DATA ONLY..."

    sudo docker exec -t ${DB_CONTAINER} pg_dump \
        -U ${DB_USER} \
        -d ${DB_NAME} \
        --data-only \
        --column-inserts \
        --disable-triggers \
        > "${DATA_BACKUP_FILE}"

    cp "${DATA_BACKUP_FILE}" "${LATEST_BACKUP_FILE}"

    echo "Backup selesai"
    echo "File:"
    echo "${DATA_BACKUP_FILE}"
}

# ======================================================
# FULL BACKUP
# ======================================================

backup_full() {

    echo "Full backup..."

    sudo docker exec -t ${DB_CONTAINER} pg_dump \
        -U ${DB_USER} \
        -d ${DB_NAME} \
        > "${FULL_BACKUP_FILE}"

    echo "Backup selesai"
    echo "File:"
    echo "${FULL_BACKUP_FILE}"
}

# ======================================================
# RESTORE
# ======================================================

restore_latest() {

    if [ ! -f "${LATEST_BACKUP_FILE}" ]; then
        echo "ERROR: latest_backup.sql tidak ditemukan"
        exit 1
    fi

    confirm_action "Restore akan menimpa data. Lanjutkan?"

    echo "Restore database..."

    cat "${LATEST_BACKUP_FILE}" | sudo docker exec -i ${DB_CONTAINER} psql \
        -U ${DB_USER} \
        -d ${DB_NAME}

    echo "Restore selesai"
}

# ======================================================
# LIST BACKUPS
# ======================================================

list_backups() {

    echo "Daftar backup:"
    ls -lh "$BACKUP_DIR"
}

# ======================================================
# MENU
# ======================================================

main_menu() {

    check_requirements

    echo ""
    echo "================================================="
    echo " PostgreSQL Global Maintenance"
    echo "================================================="
    echo "1. Setup Permission"
    echo "2. Backup Data Only"
    echo "3. Full Backup"
    echo "4. Restore latest_backup.sql"
    echo "5. List Backup Files"
    echo "================================================="

    read -p "Pilih menu (1-5): " pilihan

    case $pilihan in
        1) setup_permissions ;;
        2) backup_data ;;
        3) backup_full ;;
        4) restore_latest ;;
        5) list_backups ;;
        *) echo "Pilihan tidak valid" ;;
    esac
}

main_menu