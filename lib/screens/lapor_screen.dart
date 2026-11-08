import 'package:flutter/material.dart';
import '../responsive.dart';
import '../theme.dart';
import '../widgets.dart';

/// Komponen Material 3: TextFormField, CheckboxListTile, time picker, Dropdown, FilledButton.
class LaporScreen extends StatefulWidget {
  const LaporScreen({super.key});
  @override
  State<LaporScreen> createState() => _LaporScreenState();
}

class _LaporScreenState extends State<LaporScreen> {
  final _key = GlobalKey<FormState>();
  final _jenis = <String>{'Plastik', 'Kertas & Kardus'};
  bool _foto = true;
  TimeOfDay _buka = const TimeOfDay(hour: 8, minute: 0), _tutup = const TimeOfDay(hour: 15, minute: 0);
  String _hari = 'Senin - Sabtu (Aktif)';

  static const _opsi = ['Plastik', 'Kertas & Kardus', 'E-Waste', 'Kaca & Botol', 'Logam / Kaleng', 'Minyak Jelantah'];

  void _kirim() {
    final ok = _key.currentState!.validate();
    String? err;
    if (!_foto) err = 'Foto lokasi wajib diunggah';
    else if (_jenis.isEmpty) err = 'Pilih minimal satu kategori sampah';
    if (!ok || err != null) {
      if (err != null) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data lokasi terkirim! Menunggu verifikasi kurator.')));
  }

  Future<void> _pilihJam(bool buka) async {
    final t = await showTimePicker(context: context, initialTime: buka ? _buka : _tutup);
    if (t != null) setState(() => buka ? _buka = t : _tutup = t);
  }

  Widget _lbl(String t, {String? sub}) => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 4),
        child: Row(children: [
          Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          if (sub != null) Text('  $sub', style: const TextStyle(color: kMuted, fontSize: 12)),
        ]),
      );

  Widget _jam(bool buka) => Expanded(
        child: InkWell(
          onTap: () => _pilihJam(buka),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Row(children: [
              const Icon(Icons.schedule, color: kMuted),
              const SizedBox(width: 10),
              Text('${(buka ? _buka : _tutup).format(context)} WIB'),
            ]),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final kiri = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Panel(color: kMint, child: const Text('Bantu komunitas menemukan titik daur ulang baru. Setiap kontribusimu menjaga kelestarian bumi!')),
      gap,
      _lbl('Foto Lokasi / Bank Sampah *'),
      InkWell(
        onTap: () => setState(() => _foto = true),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(color: kField, borderRadius: BorderRadius.circular(20)),
          child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(radius: 28, backgroundColor: kMint, child: Icon(Icons.add_a_photo_outlined, color: kGreen)),
            SizedBox(height: 8),
            Text('Klik untuk tambah foto', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('(JPG, PNG • Maks. 5MB)', style: TextStyle(color: kMuted, fontSize: 12)),
          ]),
        ),
      ),
      if (_foto) ...[
        const SizedBox(height: 10),
        Panel(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            const IconBox(Icons.image_outlined, size: 48),
            const SizedBox(width: 12),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('foto_tampak_depan_lokasi.jpg', style: TextStyle(fontWeight: FontWeight.w600)),
              Text('1.8 MB • Siap diunggah', style: TextStyle(color: kMuted, fontSize: 12)),
            ])),
            IconButton(onPressed: () => setState(() => _foto = false), icon: const Icon(Icons.delete_outline, color: Colors.red)),
          ]),
        ),
      ],
      gap,
      _lbl('Nama Lokasi / Bank Sampah *'),
      TextFormField(
        decoration: const InputDecoration(hintText: 'Contoh: Bank Sampah Berkah Mandiri', fillColor: Colors.white),
        validator: (v) => (v == null || v.trim().length < 5) ? 'Nama lokasi wajib diisi lengkap sesuai plang resmi!' : null,
      ),
      gap,
      _lbl('Kategori Sampah yang Diterima', sub: '(Pilih > 1)'),
      LayoutBuilder(builder: (context, c) => Wrap(
        spacing: 10, runSpacing: 10,
        children: [
          for (final o in _opsi)
            SizedBox(
              width: (c.maxWidth - 10) / 2,
              child: InkWell(
                onTap: () => setState(() => _jenis.contains(o) ? _jenis.remove(o) : _jenis.add(o)),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(color: _jenis.contains(o) ? kMint : Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Row(children: [
                    Icon(_jenis.contains(o) ? Icons.check_box : Icons.check_box_outline_blank, color: kGreen),
                    const SizedBox(width: 8),
                    Expanded(child: Text(o, style: const TextStyle(fontSize: 13))),
                  ]),
                ),
              ),
            ),
        ],
      )),
    ]);

    final kanan = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _lbl('Jam Operasional *'),
      Row(children: [_jam(true), const SizedBox(width: 10), _jam(false)]),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(
        initialValue: _hari,
        decoration: const InputDecoration(prefixIcon: Icon(Icons.calendar_today_outlined), fillColor: Colors.white),
        items: const ['Senin - Sabtu (Aktif)', 'Senin - Jumat', 'Setiap Hari'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => setState(() => _hari = v!),
      ),
      gap,
      Row(children: const [
        Expanded(child: Text('Titik Lokasi GPS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
        Icon(Icons.gps_fixed, size: 16, color: kGreen),
        Text(' Akurasi Tinggi', style: TextStyle(color: kGreen, fontSize: 12)),
      ]),
      const SizedBox(height: 8),
      const FakeMap(height: 150, label: '-6.2088° S, 106.8456° E'),
      const SizedBox(height: 8),
      Panel(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          const Icon(Icons.near_me_outlined, color: kMuted),
          const SizedBox(width: 8),
          const Expanded(child: Text('Tebet, Jakarta Selatan (Radius ±5m)')),
          FilledButton(style: FilledButton.styleFrom(minimumSize: const Size(0, 36), backgroundColor: kMint, foregroundColor: kGreen), onPressed: () {}, child: const Text('Ubah di Peta')),
        ]),
      ),
      gap,
      _lbl('Catatan / Alamat Lengkap *'),
      TextFormField(
        maxLines: 3,
        maxLength: 200,
        decoration: const InputDecoration(hintText: 'Contoh: Dekat pos ronda RT 04, masuk gang samping masjid.', fillColor: Colors.white),
        validator: (v) => (v == null || v.trim().isEmpty) ? 'Alamat wajib diisi' : null,
      ),
      FilledButton.icon(onPressed: _kirim, icon: const Icon(Icons.rocket_launch_outlined), label: const Text('KIRIM DATA LOKASI')),
      const Padding(
        padding: EdgeInsets.only(top: 8),
        child: Center(child: Text('Data akan diverifikasi oleh tim kurator Titik Daur dalam 1x24 jam.', textAlign: TextAlign.center, style: TextStyle(color: kMuted, fontSize: 12))),
      ),
    ]);

    return Scaffold(
      appBar: AppBar(title: const Text('Lapor', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Form(
        key: _key,
        child: AdaptivePage(builder: (wide) => Cols(wide: wide, left: kiri, right: kanan, lf: 1, rf: 1)),
      ),
    );
  }
}
