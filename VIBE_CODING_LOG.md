# Vibe Coding Log - Titik Daur

Alat: Claude (chat AI). Pendekatan: beri konteks jelas -> minta hasil per bagian -> uji -> revisi.

## Prompt 1 - Konteks proyek
"Kami membuat aplikasi Flutter bernama Titik Daur (direktori lokasi bank sampah terdekat, SDG 12).
Gunakan Material 3, warna utama hijau #00513A, data dummy, tanpa database.
Layar: Login, Beranda, Peta, Detail Titik Kumpul, Lapor, Pesan Penjemputan, Profil sesuai desain Figma,
dan layout responsif HP + laptop. Buat struktur folder lib/screens."

## Prompt 2 - Spesifik per layar (contoh Beranda)
"Buat HomeScreen: sapaan + koin, TextField pencarian, FilterChip horizontal, carousel PageView,
dan daftar lokasi yang diurutkan dari jarak terkecil. Di layar lebar tampilkan GridView."

## Prompt 3 - Perbaikan
"Tambahkan validasi form (email harus ada '@', sandi minimal 6 karakter) dan SnackBar saat laporan terkirim."

## Hasil review manual oleh tim
- Kode dibaca dan dijalankan di emulator, bukan disalin mentah.
- Hal yang disesuaikan tim: (ISI sendiri: nama lokasi sekitar kampus, teks, warna, dll.)

## Catatan
Tambahkan screenshot percakapan prompt dan hasil aplikasi sebagai bukti di sheet Log Book.
