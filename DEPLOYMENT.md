# Deployment

## Persiapan server

Pasang Docker Engine dan plugin Docker Compose. Salin project ke server, lalu siapkan secret berikut sebagai file non-kosong:

- `secrets/db_name.txt`
- `secrets/db_user.txt`
- `secrets/db_password.txt`
- `secrets/secret_key.txt`

Compose mengharapkan PostgreSQL dan reverse proxy berada pada Docker network eksternal `production_network`. Hubungkan container database dengan hostname `postgres`, sesuai `DB_HOST` pada Compose. Network ini harus dibuat sebelum deploy jika belum ada.

## Deploy atau update

Jalankan dari folder project:

```sh
chmod +x deploy.sh backup_media.sh
./deploy.sh
```

Skrip menjalankan `docker compose up -d --build`. Entrypoint menunggu PostgreSQL, menjalankan migrasi, mengumpulkan static files, lalu memulai Gunicorn. Cek status dengan `docker compose ps` dan log dengan `docker compose logs -f web`.

## Static dan upload

- Django menjalankan `collectstatic` ke `/app/staticfiles`; named volume `perjadin_static` mempertahankan hasilnya antar-recreate. WhiteNoise melayani URL `/static/`.
- Foto laporan, foto profil, bukti PDF, dan unggahan lain tersimpan di `/app/media`; named volume `perjadin_media` mempertahankan file saat image dibangun ulang. URL `/media/` dilayani oleh aplikasi.
- Kedua volume dibuat otomatis oleh Compose dan sengaja tidak dihapus saat update biasa.
- Logo bawaan kop dokumen adalah `static/assets/images/logo.png` (lambang Kabupaten Asahan). Kop PDF menggunakan logo OPD jika tersedia dan otomatis memakai lambang ini sebagai fallback.
- File static dapat dibangun ulang dari source. Backup volume `perjadin_media` secara berkala:

```sh
./backup_media.sh
```

Untuk memulihkan salah satu arsip hasil backup, jalankan dari folder project:

```sh
docker compose exec -T web tar -xzf - -C /app/media < backups/media_YYYY-MM-DD_HH-MM-SS.tar.gz
```

Jangan gunakan `docker compose down -v` saat update karena opsi tersebut menghapus volume static dan media. Backup database tetap perlu dilakukan terpisah dari backup file media.