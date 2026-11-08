import 'package:flutter/material.dart';
import '../data.dart';
import '../responsive.dart';
import '../theme.dart';
import '../widgets.dart';
import 'detail_screen.dart';

/// Responsive: HP = peta penuh + bottom sheet, laptop = peta kiri + daftar kanan.
class PetaScreen extends StatefulWidget {
  const PetaScreen({super.key});
  @override
  State<PetaScreen> createState() => _PetaScreenState();
}

class _PetaScreenState extends State<PetaScreen> {
  String _f = 'Semua';

  Widget _peta(double bottomPad) => Stack(children: [
        const Positioned.fill(child: FakeMap()),
        Positioned(
          top: 12, left: 16, right: 16,
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(children: const [
                Icon(Icons.search),
                SizedBox(width: 10),
                Expanded(child: Text('Bank Sampah sekitar Tebet')),
                Icon(Icons.mic_none, color: kGreen),
              ]),
            ),
            const SizedBox(height: 10),
            ChipBar(items: const ['Semua (12)', 'Plastik', 'E-Waste', 'Kertas'], selected: _f == 'Semua' ? 'Semua (12)' : _f, onSelect: (v) => setState(() => _f = v.startsWith('Semua') ? 'Semua' : v)),
          ]),
        ),
        Positioned(
          right: 16, bottom: bottomPad,
          child: Column(children: [
            FloatingActionButton.extended(
              heroTag: 'ai', backgroundColor: kGreen, foregroundColor: Colors.white,
              onPressed: () {}, icon: const Icon(Icons.photo_camera_outlined), label: const Text('Deteksi AI'),
            ),
            const SizedBox(height: 10),
            FloatingActionButton.small(heroTag: 'gps', backgroundColor: Colors.white, onPressed: () {}, child: const Icon(Icons.my_location, color: kGreen)),
          ]),
        ),
      ]);

  Widget _kartu(Lokasi l, {bool utama = false}) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: utama ? kGreen : Colors.black12, width: utama ? 1.5 : 1),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Pill(utama ? 'BANK SAMPAH INDUK' : 'DROP BOX & TPS 3R'),
            const SizedBox(width: 8),
            const Icon(Icons.star, size: 14, color: Colors.amber),
            Text(' ${l.rating} (${l.ulasan})', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const Spacer(),
            Text('${l.km} km', style: const TextStyle(color: kMuted)),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            const IconBox(Icons.storefront, size: 64),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.nama, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(l.alamat, style: const TextStyle(color: kMuted, fontSize: 13)),
                Text('Buka ${l.jam}', style: const TextStyle(fontSize: 13)),
              ]),
            ),
          ]),
          const SizedBox(height: 10),
          Wrap(spacing: 6, runSpacing: 6, children: [for (final t in l.tags) tagPill(t)]),
          if (utama) ...[
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(backgroundColor: kBlue, foregroundColor: kGreen),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(lokasi: l))),
                  icon: const Icon(Icons.info_outline), label: const Text('Detail Unit'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.directions), label: const Text('Pandu Rute'))),
            ]),
          ],
        ]),
      );

  Widget _sheet(List<Lokasi> data, {required bool wide}) => Container(
        decoration: BoxDecoration(
          color: kBg,
          borderRadius: wide ? null : const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 16)],
        ),
        child: ListView(padding: const EdgeInsets.all(16), children: [
          if (!wide) Center(child: Container(width: 44, height: 5, margin: const EdgeInsets.only(bottom: 12), decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(3)))),
          Text('${data.length} Bank Sampah Ditemukan', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text('Dalam radius 2.5 km dari posisi Anda', style: TextStyle(color: kMuted)),
          gap,
          for (var i = 0; i < data.length; i++) _kartu(data[i], utama: i == 0),
          Panel(color: kMint, child: const Text('Bawa sampah terpilah dan bersih untuk mendapatkan koin reward daur ulang maksimal.')),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final data = kLokasi.where((l) => _f == 'Semua' || l.tags.any((t) => t.contains(_f))).toList()..sort((a, b) => a.km.compareTo(b.km));
    return LayoutBuilder(builder: (context, c) {
      if (c.maxWidth >= kWide) {
        return Row(children: [
          Expanded(child: _peta(24)),
          SizedBox(width: 400, child: _sheet(data, wide: true)),
        ]);
      }
      final h = c.maxHeight * .46;
      return Stack(children: [
        Positioned.fill(child: _peta(h + 16)),
        Positioned(left: 0, right: 0, bottom: 0, height: h, child: _sheet(data, wide: false)),
      ]);
    });
  }
}
