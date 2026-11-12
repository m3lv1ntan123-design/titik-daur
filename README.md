# Titik Daur 🌱

> **Aplikasi Mobile Front-End Deteksi & Direktori Bank Sampah Terdekat (SDG 12)**  
> Mata Kuliah: Mobile Front End (Semester 5)

Titik Daur adalah aplikasi front-end berbasis **Flutter (Material 3)** yang memudahkan masyarakat menemukan titik kumpul daur ulang sampah terdekat, melihat jadwal operasional dan jenis sampah yang diterima, melaporkan lokasi bank sampah baru, serta memesan layanan penjemputan sampah secara terjadwal.

---

## 📚 Dokumen Logbook & Konteks Proyek

Untuk mempermudah pelacakan perkembangan dan pergantian sesi pengembang/AI, telah disediakan dokumentasi terstruktur berikut:

1. **[`PROJECT_CONTEXT.md`](PROJECT_CONTEXT.md)**  
   *Anchor ringkas konteks proyek*: Baca file ini jika berpindah sesi AI atau berganti akun. Berisi spesifikasi arsitektur, tech stack (Flutter 3.10.5), palet warna Figma, struktur direktori, dan aturan teknis kompatibilitas.
2. **[`LOGBOOK.md`](LOGBOOK.md)**  
   *Logbook kronologis*: Catatan lengkap setiap iterasi prompt, tujuan, kendala yang dihadapi, dan perubahan kode yang diterapkan.
3. **[`PLANNING.md`](PLANNING.md)**  
   *Perencanaan & pembagian tugas*: Checklist fitur, pembagian tugas 4 anggota tim, roadmap pengembangan, dan panduan Git.
4. **[`Laporan_Perkembangan_Titik_Daur.docx`](Laporan_Perkembangan_Titik_Daur.docx)**  
   *Dokumen resmi Microsoft Word*: Laporan perkembangan dan logbook iterasi yang siap dicetak/dikumpulkan untuk keperluan tugas kuliah.
5. **[`generate_report.py`](generate_report.py)**  
   *Script generator laporan Word*: Menghasilkan dokumen `.docx` secara otomatis berdasarkan pembaruan iterasi prompt.

---

## 🚀 Cara Menjalankan Aplikasi

Pastikan Flutter SDK terpasang di sistem Anda.

1. **Unduh dependensi**:
   ```bash
   flutter pub get
   ```

2. **Jalankan pengujian**:
   ```bash
   flutter test
   ```

3. **Jalankan aplikasi**:
   - **Google Chrome (Web)**:
     ```bash
     flutter run -d chrome
     ```
   - **Windows Desktop**:
     ```bash
     flutter run -d windows
     ```
   - **Android**:
     ```bash
     flutter run
     ```

---

## 🎨 Token Desain & Skema Warna

| Token | Warna Hex | Deskripsi |
|-------|-----------|-----------|
| `kGreen` | `#00513A` | Warna utama / primer brand |
| `kBg` | `#F7F9FF` | Latar belakang aplikasi |
| `kField` | `#EEF3FF` | Latar belakang input form & panel sekunder |
| `kMint` | `#C8EBD3` | Aksen badge hijau muda & panel info |
| `kPeach` | `#FFDDC2` | Badge kategori khusus (E-Waste / Minyak) |
| `kInk` | `#111C2D` | Warna teks utama |
| `kMuted` | `#5B6475` | Warna teks sekunder / keterangan |

---

## 📱 Struktur Halaman (`lib/screens/`)

- `login_screen.dart`: Halaman masuk & daftar baru dengan validasi form.
- `home_screen.dart`: Beranda, saldo koin, pencarian real-time, filter kategori, sorting jarak terdekat.
- `peta_screen.dart`: Tampilan peta titik kumpul daur ulang (mockup interaktif).
- `detail_screen.dart`: Detail informasi titik kumpul, jam buka, jenis sampah diterima.
- `lapor_screen.dart`: Formulir lapor lokasi bank sampah baru + koordinat GPS.
- `pesanan_screen.dart`: Booking penjemputan sampah dengan stepper 3 langkah.
- `profil_screen.dart`: Profil pengguna, tingkatan pahlawan hijau, statistik daur ulang.
