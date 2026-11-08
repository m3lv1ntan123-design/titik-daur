/// Model + data contoh (dummy). Belum memakai database/server.
class Lokasi {
  final String nama, alamat, jam;
  final double km, rating;
  final int ulasan;
  final List<String> tags;
  const Lokasi(this.nama, this.alamat, this.km, this.jam, this.rating, this.ulasan, this.tags);
}

const kLokasi = <Lokasi>[
  Lokasi('Bank Sampah Maju Jaya', 'Jl. Tebet Timur Dalam VII No. 14', 1.2, '08:00 - 15:00', 4.8, 128, ['Plastik', 'Kertas', 'Menerima Antar Langsung']),
  Lokasi('TPS 3R Berkah Alam', 'Jl. Tebet Raya No. 22', 2.5, '09:00 - 17:00', 4.7, 94, ['E-Waste', 'Besi & Logam', 'Timbangan Digital']),
  Lokasi('Drop Point EcoRecycle RW 04', 'Jl. Tebet Barat IV', 3.1, '07:30 - 16:00', 4.9, 62, ['Plastik', 'Kardus', 'Kaca']),
  Lokasi('Bank Sampah Sejahtera 08', 'Balai Warga RW 08, Tebet Barat', 1.8, '08:00 - 14:00', 4.9, 84, ['E-Waste', 'Minyak Jelantah']),
];

const kKategori = ['Semua', 'Plastik', 'Kertas', 'E-Waste', 'Logam', 'Kaca'];
