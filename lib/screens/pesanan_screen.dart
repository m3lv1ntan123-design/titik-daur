import 'package:flutter/material.dart';
import '../responsive.dart';
import '../theme.dart';
import '../widgets.dart';

/// Layout dasar + multi-child: Row, Column, Container, Padding, SizedBox, Expanded.
class _Item {
  final String nama, ket, unit;
  final int harga;
  final IconData icon;
  int qty;
  _Item(this.nama, this.ket, this.harga, this.qty, this.unit, this.icon);
}

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});
  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  final _items = [
    _Item('Botol Plastik PET & Gelas', 'Rp 3.500 / kg • Bersih & kering', 3500, 8, 'kg', Icons.local_drink_outlined),
    _Item('Kardus & Kertas Bekas', 'Rp 2.500 / kg • Terlipat rapi', 2500, 15, 'kg', Icons.inventory_2_outlined),
    _Item('Minyak Jelantah', 'Rp 7.000 / liter • Jeriken tertutup', 7000, 5, 'liter', Icons.oil_barrel_outlined),
  ];
  int _hari = 0, _slot = 1;

  int get _total => _items.fold(0, (s, e) => s + e.harga * e.qty);
  String _rp(int v) => 'Rp ${v.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.')}';

  Widget _stepper() => Panel(
        child: Column(children: [
          Row(children: const [
            CircleAvatar(radius: 12, backgroundColor: kGreen, child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12))),
            Text('  Pilih Sampah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Spacer(),
            CircleAvatar(radius: 12, backgroundColor: kGreen, child: Text('2', style: TextStyle(color: Colors.white, fontSize: 12))),
            Text('  Alamat & Waktu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Spacer(),
            CircleAvatar(radius: 12, backgroundColor: kField, child: Text('3', style: TextStyle(fontSize: 12))),
            Text('  Konfirmasi', style: TextStyle(color: kMuted, fontSize: 12)),
          ]),
          const SizedBox(height: 10),
          ClipRRect(borderRadius: BorderRadius.circular(6), child: const LinearProgressIndicator(value: .66, minHeight: 6, color: kGreen, backgroundColor: kField)),
        ]),
      );

  Widget _barang(_Item e) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: kField, borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Row(children: [
            IconBox(e.icon, size: 52, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(e.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(e.ket, style: const TextStyle(color: kMuted, fontSize: 12)),
            ])),
            IconButton(onPressed: () => setState(() => _items.remove(e)), icon: const Icon(Icons.close, size: 18)),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            const Text('Subtotal: ', style: TextStyle(color: kMuted, fontSize: 12)),
            Text(_rp(e.harga * e.qty), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Spacer(),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(children: [
                IconButton(onPressed: () => setState(() { if (e.qty > 1) e.qty--; }), icon: const Icon(Icons.remove, size: 18)),
                Text('${e.qty} ${e.unit}', style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(style: IconButton.styleFrom(backgroundColor: kGreen, foregroundColor: Colors.white), onPressed: () => setState(() => e.qty++), icon: const Icon(Icons.add, size: 18)),
              ]),
            ),
          ]),
        ]),
      );

  Widget _hariChip(int i, String a, String b) => Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _hari = i),
          child: Container(
            margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(color: _hari == i ? kGreen : kField, borderRadius: BorderRadius.circular(14)),
            child: Column(children: [
              Text(a, style: TextStyle(fontSize: 12, color: _hari == i ? Colors.white70 : kMuted)),
              Text(b, style: TextStyle(fontWeight: FontWeight.bold, color: _hari == i ? Colors.white : kInk)),
            ]),
          ),
        ),
      );

  Widget _slotTile(int i, String nama, String jam, String sisa, IconData ic) {
    final on = _slot == i;
    return GestureDetector(
      onTap: () => setState(() => _slot = i),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: on ? kGreen : kField, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Icon(ic, color: on ? Colors.white : kMuted),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(nama, style: TextStyle(fontWeight: FontWeight.bold, color: on ? Colors.white : kInk)),
            Text(jam, style: TextStyle(fontSize: 12, color: on ? Colors.white70 : kMuted)),
          ])),
          if (on) const Pill('Dipilih', bg: Colors.white24, fg: Colors.white, icon: Icons.check) else Pill(sisa, bg: kMint),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final kg = _items.where((e) => e.unit == 'kg').fold(0, (s, e) => s + e.qty);
    final lt = _items.where((e) => e.unit == 'liter').fold(0, (s, e) => s + e.qty);
    final kiri = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionHead('Jenis Sampah & Estimasi'),
      const Text('Tentukan taksiran berat sampah untuk penjemputan mitra', style: TextStyle(color: kMuted)),
      gap,
      for (final e in _items) _barang(e),
      OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.add_circle_outline), label: const Text('Tambah Kategori Lain (Kaca, Logam, E-Waste)')),
    ]);
    final kanan = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Panel(
        color: kMint,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Text('HASIL PENJUALAN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const Spacer(),
            Pill('+${_total ~/ 838} Poin Bumi', bg: kGreen, fg: Colors.white, icon: Icons.local_offer_outlined),
          ]),
          const SizedBox(height: 6),
          const Text('Total Estimasi Diterima'),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(_rp(_total), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: kGreen)),
            const Text(' / masuk Dompet Hijau', style: TextStyle(fontSize: 12)),
          ]),
          const SizedBox(height: 6),
          const Text('Berat final akan ditimbang ulang di tempat oleh timbangan digital mitra.', style: TextStyle(fontSize: 12)),
        ]),
      ),
      gap,
      const SectionHead('Lokasi Penjemputan', action: 'Lihat Peta'),
      Panel(
        child: Column(children: [
          Row(children: const [
            IconBox(Icons.place, size: 40),
            SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Rumah Utama', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Jl. Tebet Timur Dalam VII No. 14, RT 04 / RW 08, Tebet, Jakarta Selatan', style: TextStyle(color: kMuted, fontSize: 13)),
            ])),
            Text('Ubah', style: TextStyle(color: kGreen, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: kField, borderRadius: BorderRadius.circular(12)),
            child: const Row(children: [Icon(Icons.edit_note, size: 20), SizedBox(width: 8), Expanded(child: Text('Catatan: Taruh di depan pagar samping pot bunga', style: TextStyle(fontSize: 13)))]),
          ),
        ]),
      ),
      gap,
      const SectionHead('Jadwal Penjemputan', action: 'Pilih slot luang Anda'),
      Row(children: [_hariChip(0, 'Hari Ini', '24 Okt'), _hariChip(1, 'Besok', '25 Okt'), _hariChip(2, 'Lusa', '26 Okt')]),
      const SizedBox(height: 10),
      _slotTile(0, 'Pagi Hari', '09:00 - 11:00 WIB', 'Sisa 2 Slot', Icons.wb_twilight),
      _slotTile(1, 'Siang Hari', '13:00 - 15:00 WIB', 'Sisa 3 Slot', Icons.wb_sunny_outlined),
      _slotTile(2, 'Sore Hari', '16:00 - 18:00 WIB', 'Sisa 5 Slot', Icons.wb_twilight),
      Panel(color: kField, child: Row(children: const [
        Icon(Icons.verified_user_outlined, color: kGreen),
        SizedBox(width: 12),
        Expanded(child: Text('Mitra Berlisensi Titik Daur: driver terverifikasi membawa timbangan presisi berstandar SNI.', style: TextStyle(fontSize: 13))),
      ])),
    ]);

    return Column(children: [
      Expanded(
        child: AdaptivePage(builder: (wide) => Column(children: [
          Row(children: const [
            Icon(Icons.local_shipping_outlined, color: kGreen),
            SizedBox(width: 8),
            Expanded(child: Text('Pesan Penjemputan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800))),
            Pill('Pickup Kilat'),
          ]),
          gap,
          _stepper(),
          gap,
          Cols(wide: wide, left: kiri, right: kanan, lf: 1, rf: 1),
        ])),
      ),
      Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Total Muatan', style: TextStyle(color: kMuted, fontSize: 12)),
                Text('$kg kg${lt > 0 ? '  +$lt L' : ''}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              ]),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: _items.isEmpty ? null : () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mitra Titik Daur dipanggil!'))),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Panggil Mitra Titik Daur'), SizedBox(width: 8), Icon(Icons.arrow_forward, size: 20)]),
                ),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}
