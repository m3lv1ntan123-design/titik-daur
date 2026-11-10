import 'package:flutter/material.dart';
import '../responsive.dart';
import '../screens/login_screen.dart';
import '../theme.dart';
import '../widgets.dart';

/// Multi-child layout: Stack (badge di avatar), Row, Column, Expanded, Wrap.
class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});
  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  bool _lihat = true;

  Widget _stat(IconData i, String v, String u, String t, Color c) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Column(children: [
            CircleAvatar(backgroundColor: kMint, child: Icon(i, color: kGreen)),
            const SizedBox(height: 8),
            Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            Text(u, style: const TextStyle(color: kMuted, fontSize: 12), textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Pill(t, bg: c, fg: kInk),
          ]),
        ),
      );

  Widget _aksi(IconData i, String t, String s, {bool oranye = false}) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
          decoration: BoxDecoration(color: oranye ? kPeach : Colors.white12, borderRadius: BorderRadius.circular(14)),
          child: Column(children: [
            Icon(i, color: oranye ? kInk : Colors.white),
            Text(t, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: oranye ? kInk : Colors.white), textAlign: TextAlign.center),
            Text(s, style: TextStyle(fontSize: 10, color: oranye ? kMuted : Colors.white70)),
          ]),
        ),
      );

  Widget _riwayat(IconData i, String t, String s, String nilai, String st, {bool minus = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          IconBox(i, size: 44, color: minus ? kBlue : kMint),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(s, style: const TextStyle(color: kMuted, fontSize: 12)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(nilai, style: TextStyle(fontWeight: FontWeight.w800, color: minus ? Colors.red : kGreen)),
            Text(st, style: const TextStyle(color: kMuted, fontSize: 11)),
          ]),
        ]),
      );

  Widget _menu(IconData i, String t, String s, {Pill? badge, bool merah = false, VoidCallback? onTap}) => ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: IconBox(i, size: 44, color: merah ? const Color(0xFFFFE0E0) : kField),
        title: Row(children: [Flexible(child: Text(t, style: TextStyle(fontWeight: FontWeight.bold, color: merah ? Colors.red : kInk))), if (badge != null) ...[const SizedBox(width: 6), badge]]),
        subtitle: Text(s, style: const TextStyle(fontSize: 12)),
        trailing: Icon(Icons.chevron_right, color: merah ? Colors.red : kMuted),
      );

    Widget _voucher() {
    const data = [
      ('Pulsa 10rb', '500 Poin', Icons.phone_android),
      ('Token Listrik', '1.500 Poin', Icons.bolt),
      ('Kupon Sembako', '1.000 Poin', Icons.shopping_basket_outlined),
      ('Tote Bag', '800 Poin', Icons.shopping_bag_outlined),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionHead('Tukar Poin Bumi'),
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.6,
        children: [
          for (final v in data)
            Panel(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(v.$3, color: kGreen),
                const SizedBox(height: 4),
                Text(v.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(v.$2, style: const TextStyle(color: kMuted, fontSize: 12)),
              ]),
            ),
        ],
      ),
    ]);
  }
  @override
  Widget build(BuildContext context) {
    final header = Panel(
      child: Column(children: [
        Row(children: [
          Stack(children: const [
            CircleAvatar(radius: 38, backgroundColor: kMint, child: Icon(Icons.person, size: 44, color: kGreen)),
            Positioned(right: 0, bottom: 0, child: CircleAvatar(radius: 11, backgroundColor: kGreen, child: Icon(Icons.verified, size: 14, color: Colors.white))),
          ]),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Budi Santoso', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const Row(children: [Icon(Icons.place_outlined, size: 16, color: kMuted), Text(' Tebet, Jakarta Selatan', style: TextStyle(color: kMuted))]),
            const SizedBox(height: 6),
            const Wrap(spacing: 6, runSpacing: 4, children: [Pill('Pahlawan Hijau Lvl 3', icon: Icons.emoji_events_outlined), Pill('Ksatria Plastik', bg: kBlue, fg: kInk)]),
          ])),
          const Icon(Icons.edit_outlined, color: kGreen),
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Expanded(child: Text('Progress ke Level 4 (Penyelamat Bumi)', style: TextStyle(fontSize: 12, color: kMuted))),
          Text('142.5 / 200 kg', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ]),
        const SizedBox(height: 6),
        ClipRRect(borderRadius: BorderRadius.circular(8), child: const LinearProgressIndicator(value: .71, minHeight: 10, color: kGreen, backgroundColor: kField)),
      ]),
    );

    final dampak = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionHead('Dampak Nyata Anda', action: 'Akumulasi'),
      Row(children: [
        _stat(Icons.recycling, '142.5', 'kg Terdaur', '+14kg bln ini', kMint),
        const SizedBox(width: 10),
        _stat(Icons.eco_outlined, '58.2', 'kg CO₂ Dicegah', 'Setara 24L BBM', kMint),
        const SizedBox(width: 10),
        _stat(Icons.park_outlined, '7', 'Pohon Selamat', 'Kardus & Kertas', kPeach),
      ]),
    ]);

    final dompet = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: kGreen, borderRadius: BorderRadius.circular(24)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: const [
          Icon(Icons.account_balance_wallet_outlined, color: Colors.white70, size: 18),
          Text('  DOMPET HIJAU', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
          Spacer(),
          Pill('Bank Sampah Aktif', bg: Colors.white24, fg: Colors.white),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Text(_lihat ? 'Rp 385.000' : 'Rp •••••••', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800)),
          IconButton(onPressed: () => setState(() => _lihat = !_lihat), icon: Icon(_lihat ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.white70)),
        ]),
        const Text('Saldo dapat dicairkan instan atau didonasikan', style: TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 14),
        Row(children: [
          _aksi(Icons.payments_outlined, 'Tarik e-Wallet', 'GoPay / OVO'),
          const SizedBox(width: 8),
          _aksi(Icons.account_balance_outlined, 'Transfer Bank', 'BCA, Mandiri, BRI'),
          const SizedBox(width: 8),
          _aksi(Icons.volunteer_activism_outlined, 'Donasikan', 'Bibit Pohon', oranye: true),
        ]),
      ]),
    );

    final riwayat = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionHead('Riwayat Transaksi', action: 'Lihat Semua'),
      Panel(child: Column(children: [
        _riwayat(Icons.storefront, 'Bank Sampah Maju Jaya', 'Setor 14 kg Plastik & Kertas • Kemarin', '+Rp 45.000', 'Berhasil'),
        const Divider(),
        _riwayat(Icons.local_shipping_outlined, 'Penjemputan Truk Titik Daur', 'Setor 20 kg Kardus • 3 hari lalu', '+Rp 50.000', 'Berhasil'),
        const Divider(),
        _riwayat(Icons.logout, 'Tarik Saldo ke GoPay', '0812-3456-7890 • 1 minggu lalu', '-Rp 100.000', 'Selesai', minus: true),
      ])),
    ]);

    final akun = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionHead('Preferensi & Akun'),
      Panel(child: Column(children: [
        _menu(Icons.bookmark_border, 'Lokasi Tersimpan (Favorite)', '3 Bank Sampah langganan'),
        _menu(Icons.workspace_premium_outlined, 'Sertifikat Kontribusi Lingkungan', 'Unduh sertifikat PDF resmi DLH', badge: const Pill('Baru', bg: kPeach, fg: Color(0xFF7A4100))),
        _menu(Icons.school_outlined, 'Pusat Bantuan & Edukasi Daur Ulang', 'Katalog harga pilah & tips kompos'),
        _menu(Icons.tune, 'Pengaturan Akun', 'Keamanan PIN, notifikasi WhatsApp'),
        _menu(Icons.logout, 'Keluar', 'Keluar dari perangkat ini', merah: true, onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
      ])),
    ]);

    final komunitas = Panel(
      color: kMint,
      child: Row(children: [
        const CircleAvatar(backgroundColor: kGreen, child: Icon(Icons.groups_outlined, color: Colors.white)),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Komunitas Daur Tebet Timur', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('420 warga telah menyetor minggu ini', style: TextStyle(fontSize: 12)),
        ])),
        FilledButton(style: FilledButton.styleFrom(minimumSize: const Size(0, 40)), onPressed: () {}, child: const Text('Gabung')),
      ]),
    );

    return AdaptivePage(
      builder: (wide) => Cols(
        wide: wide,
        left: Column(children: [header, gap, dampak, gap, dompet, gap, riwayat]),
        right: Column(children: [_voucher(), gap, akun, gap, komunitas]),
      ),
    );
  }
}
