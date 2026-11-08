import 'package:flutter/material.dart';
import '../data.dart';
import '../responsive.dart';
import '../theme.dart';
import '../widgets.dart';

/// UI Components: Text, Icon, Image (placeholder), RichText, CircleAvatar, Reusable Widget.
class DetailScreen extends StatelessWidget {
  final Lokasi lokasi;
  const DetailScreen({super.key, required this.lokasi});

  Widget _judul(IconData i, String t, {String? aksi}) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(children: [
          CircleAvatar(radius: 16, backgroundColor: kMint, child: Icon(i, size: 18, color: kGreen)),
          const SizedBox(width: 10),
          Expanded(child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          if (aksi != null) Text(aksi, style: const TextStyle(color: kMuted, fontSize: 12)),
        ]),
      );

  Widget _tarif(String n, String s, String h, IconData i) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: kField, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Icon(i, color: kGreen),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(n, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(s, style: const TextStyle(color: kMuted, fontSize: 12)),
          ])),
          Text(h, style: const TextStyle(fontWeight: FontWeight.bold, color: kGreen)),
        ]),
      );

  Widget _fasilitas(String n, String s, IconData i) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: kField, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          IconBox(i, size: 40),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(n, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(s, style: const TextStyle(color: kMuted, fontSize: 12)),
          ])),
        ]),
      );

  Widget _ulasan(String n, String s, String isi) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: kField, borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(radius: 18, child: Text(n[0])),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(n, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(s, style: const TextStyle(color: kMuted, fontSize: 12)),
            ])),
            const Icon(Icons.star, size: 16, color: Colors.amber),
            const Icon(Icons.star, size: 16, color: Colors.amber),
            const Icon(Icons.star, size: 16, color: Colors.amber),
            const Icon(Icons.star, size: 16, color: Colors.amber),
            const Icon(Icons.star, size: 16, color: Colors.amber),
          ]),
          const SizedBox(height: 8),
          Text('"$isi"', style: const TextStyle(fontStyle: FontStyle.italic)),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final l = lokasi;
    final foto = Stack(children: [
      Container(
        height: 220,
        decoration: BoxDecoration(color: kMint, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Icon(Icons.storefront, size: 80, color: kGreen)),
      ),
      Positioned(left: 12, bottom: 12, child: Pill('${l.km} km dari lokasimu', bg: Colors.white, fg: kInk, icon: Icons.place_outlined)),
      const Positioned(right: 12, bottom: 12, child: Pill('Terverifikasi', bg: kGreen, fg: Colors.white, icon: Icons.verified_outlined)),
    ]);

    final info = Panel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Text(l.nama, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800))),
          const Pill('Buka Sekarang', icon: Icons.circle),
        ]),
        const SizedBox(height: 8),
        Row(children: [const Icon(Icons.place_outlined, size: 18, color: kMuted), const SizedBox(width: 6), Expanded(child: Text('${l.alamat}, RW 05', style: const TextStyle(color: kMuted)))]),
        const SizedBox(height: 10),
        Row(children: [
          Pill('${l.rating} (${l.ulasan} Ulasan)', bg: kPeach, fg: const Color(0xFF7A4100), icon: Icons.star),
          const SizedBox(width: 12),
          const Icon(Icons.schedule, size: 18),
          const SizedBox(width: 4),
          RichText(text: const TextSpan(style: TextStyle(color: kInk), children: [
            TextSpan(text: 'Tutup '),
            TextSpan(text: '15:00 WIB', style: TextStyle(fontWeight: FontWeight.bold)),
          ])),
        ]),
      ]),
    );

    final tarif = Panel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _judul(Icons.recycling, 'Menerima & Tarif Setor', aksi: 'Per kilogram'),
        _tarif('Plastik', 'Botol & Cup', 'Rp 3.500', Icons.local_drink_outlined),
        const SizedBox(height: 8),
        _tarif('Kertas', 'HVS & Koran', 'Rp 2.000', Icons.description_outlined),
        const SizedBox(height: 8),
        _tarif('Kardus', 'Karton tebal', 'Rp 2.500', Icons.inventory_2_outlined),
        const SizedBox(height: 8),
        _tarif('Logam', 'Besi & Kaleng', 'Rp 6.000', Icons.hardware),
      ]),
    );

    final jam = Panel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _judul(Icons.calendar_today_outlined, 'Jam Operasional'),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: kField, borderRadius: BorderRadius.circular(12)),
          child: const Row(children: [Icon(Icons.circle, size: 10, color: kGreen), SizedBox(width: 8), Expanded(child: Text('Senin - Jumat')), Text('08:00 - 15:00 WIB', style: TextStyle(fontWeight: FontWeight.bold))]),
        ),
        const Padding(
          padding: EdgeInsets.all(12),
          child: Row(children: [Icon(Icons.circle, size: 10, color: kMuted), SizedBox(width: 8), Expanded(child: Text('Sabtu - Minggu')), Text('Tutup', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))]),
        ),
      ]),
    );

    final deskripsi = Panel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _judul(Icons.info_outline, 'Deskripsi'),
        const Text('Bank sampah ini dikelola oleh warga RW 05 dengan tujuan mengurangi sampah plastik dan meningkatkan kesadaran lingkungan di sekitar wilayah. Menyediakan fasilitas timbangan digital terkalibrasi dan pencairan saldo tunai langsung atau via e-wallet.'),
      ]),
    );

    final fasilitas = Panel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _judul(Icons.check_circle_outline, 'Fasilitas & Layanan'),
        _fasilitas('Parkir Motor & Mobil', 'Akses muat barang luas dan teduh', Icons.local_parking),
        _fasilitas('Timbangan Digital Transparan', 'Layar monitor terlihat langsung oleh nasabah', Icons.scale_outlined),
        _fasilitas('Edukasi Pemilahan Sampah', 'Konsultasi gratis pilah sampah rumah tangga', Icons.school_outlined),
      ]),
    );

    final lokasiPanel = Panel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _judul(Icons.map_outlined, 'Lokasi & Navigasi'),
        FakeMap(height: 160, label: l.nama),
      ]),
    );

    final ulasan = Panel(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _judul(Icons.rate_review_outlined, 'Ulasan Nasabah', aksi: 'Lihat Semua'),
        _ulasan('Siti Rahmawati', 'Nasabah Aktif • 2 hari lalu', 'Pelayanan sangat cepat dan ramah! Timbangan sangat jelas bisa kita pantau sendiri.'),
        _ulasan('Bambang Haryanto', 'Warga RT 03 • 1 minggu lalu', 'Lokasi bersih, jalan masuk mudah untuk motor berkeranjang.'),
      ]),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Titik Kumpul', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
      body: AdaptivePage(
        builder: (wide) => Cols(
          wide: wide,
          left: Column(children: [foto, gap, info, gap, deskripsi, gap, fasilitas]),
          right: Column(children: [tarif, gap, jam, gap, lokasiPanel, gap, ulasan]),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: SafeArea(
          top: false,
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.recycling), label: const Text('SETOR SAMPAH DI SINI SEKARANG')),
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.directions, size: 18), label: const Text('BUKA RUTE DI GOOGLE MAPS')),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
