import 'package:flutter/material.dart';
import '../data.dart';
import '../responsive.dart';
import '../theme.dart';
import '../widgets.dart';

/// Multi-child layout: Column, Row, Expanded, ListView, Wrap, Stack.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _f = 'Semua', _q = '';

  List<Lokasi> get _hasil {
    final r = kLokasi
        .where((l) => _f == 'Semua' || l.tags.any((t) => t.contains(_f)))
        .where((l) => l.nama.toLowerCase().contains(_q.toLowerCase()))
        .toList();
    r.sort((a, b) => a.km.compareTo(b.km)); // terdekat di atas
    return r;
  }

  Widget _saldo() => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: kGreen, borderRadius: BorderRadius.circular(24)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Saldo Tabungan Bank Sampah', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 4),
                Text('Rp 148.500', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800)),
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Total Daur Ulang', style: TextStyle(color: Colors.white70, fontSize: 11)),
                Text('42.5 kg', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ]),
            ),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: kInk),
                onPressed: () {},
                icon: const Icon(Icons.payments_outlined),
                label: const Text('Tarik Saldo'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.white24),
                onPressed: () {},
                icon: const Icon(Icons.history),
                label: const Text('Riwayat'),
              ),
            ),
          ]),
        ]),
      );

  Widget _peta() => Panel(
        padding: EdgeInsets.zero,
        child: Column(children: [
          const FakeMap(height: 170, label: 'Lokasi Anda'),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              const Icon(Icons.explore_outlined, color: kGreen),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('14 Titik Pengumpulan Terdeteksi', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Di sekitar area radius 5 km', style: TextStyle(color: kMuted, fontSize: 12)),
                ]),
              ),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(0, 40), backgroundColor: kBlue, foregroundColor: kGreen),
                onPressed: () => navIndex.value = 1,
                child: const Text('Lihat Peta'),
              ),
            ]),
          ),
        ]),
      );

  Widget _promo() => Panel(
        color: kField,
        child: Row(children: [
          const IconBox(Icons.local_shipping_outlined, color: kPeach),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Punya sampah menumpuk?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('Pesan penjemputan langsung ke rumah Anda!', style: TextStyle(color: kMuted)),
            ]),
          ),
          const SizedBox(width: 10),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            onPressed: () => navIndex.value = 2,
            child: const Text('Panggil Truk'),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final hasil = _hasil;
    return AdaptivePage(
      builder: (wide) {
        final kiri = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Halo, Budi! 🌱', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: kInk)),
                Text('Siap berkontribusi untuk bumi hari ini?', style: TextStyle(color: kMuted)),
              ]),
            ),
            const Pill('Pahlawan Hijau Lvl 3', icon: Icons.workspace_premium_outlined),
          ]),
          gap,
          _saldo(),
          gap,
          Row(children: [
            Expanded(
              child: TextField(
                onChanged: (v) => setState(() => _q = v),
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Cari lokasi bank sampah terdekat...', fillColor: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.tune),
            ),
          ]),
          gap,
          ChipBar(items: kKategori, selected: _f, onSelect: (v) => setState(() => _f = v)),
          if (!wide) ...[gap, _peta()],
          gap,
          const SectionHead('Lokasi Terdekat', action: 'Lihat Semua'),
          if (hasil.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Center(child: Text('Lokasi tidak ditemukan'))),
          for (final l in hasil) LokasiTile(l),
        ]);
        final kanan = Column(children: [_peta(), gap, _promo()]);
        return wide
            ? Cols(wide: true, left: kiri, right: kanan)
            : Column(children: [kiri, _promo()]);
      },
    );
  }
}
