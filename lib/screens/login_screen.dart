import 'package:flutter/material.dart';
import '../main.dart';
import '../responsive.dart';
import '../theme.dart';
import '../widgets.dart';

/// Layout dasar: Center, Container, Padding, SizedBox, Align.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  bool _daftar = false, _hide = true;

  void _go() {
    if (_key.currentState!.validate()) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Shell()));
    }
  }

  Widget _label(String t, {String? trailing}) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(t, style: const TextStyle(fontWeight: FontWeight.w600)),
          if (trailing != null) Text(trailing, style: const TextStyle(color: kGreen, fontWeight: FontWeight.bold, fontSize: 13)),
        ]),
      );

  Widget _tab(String t, bool on, VoidCallback f) => Expanded(
        child: GestureDetector(
          onTap: f,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(color: on ? kGreen : Colors.transparent, borderRadius: BorderRadius.circular(12)),
            child: Text(t, style: TextStyle(fontWeight: FontWeight.w600, color: on ? Colors.white : kInk)),
          ),
        ),
      );

  Widget _brand({bool light = false}) {
    final fg = light ? Colors.white : kInk;
    return Column(children: [
      Container(
        width: 84,
        height: 84,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: const Icon(Icons.eco, color: kGreen, size: 48),
      ),
      const SizedBox(height: 16),
      Text('Selamat Datang di Titik Daur', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: fg)),
      const SizedBox(height: 8),
      Text('Ubah sampahmu jadi berkah dan cuan untuk bumi yang lebih hijau.', textAlign: TextAlign.center, style: TextStyle(color: light ? Colors.white70 : kMuted)),
      const SizedBox(height: 12),
      const Pill('Bergabung bersama 48.000+ Pejuang Bumi', icon: Icons.eco_outlined),
    ]);
  }

  Widget _form() => Panel(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _key,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: kField, borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                _tab('Masuk', !_daftar, () => setState(() => _daftar = false)),
                _tab('Daftar Baru', _daftar, () => setState(() => _daftar = true)),
              ]),
            ),
            gap,
            if (_daftar) ...[
              _label('Nama Lengkap'),
              TextFormField(
                decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline), hintText: 'Nama kamu'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
              ),
              gap,
            ],
            _label('Nomor WhatsApp atau Email', trailing: 'Wajib'),
            TextFormField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.badge_outlined), hintText: '08123456789 atau nama@email.com'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            gap,
            _label('Kata Sandi', trailing: 'Lupa Kata Sandi?'),
            TextFormField(
              obscureText: _hide,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: 'Masukkan kata sandi aman',
                suffixIcon: IconButton(icon: Icon(_hide ? Icons.visibility_outlined : Icons.visibility_off_outlined), onPressed: () => setState(() => _hide = !_hide)),
              ),
              validator: (v) => (v == null || v.length < 6) ? 'Minimal 6 karakter' : null,
            ),
            gap,
            FilledButton(
              onPressed: _go,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(_daftar ? 'Daftar Sekarang' : 'Masuk Sekarang'),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 20),
              ]),
            ),
            gap,
            Row(children: const [
              Expanded(child: Divider()),
              Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('atau masuk dengan', style: TextStyle(color: kMuted))),
              Expanded(child: Divider()),
            ]),
            gap,
            Row(children: [
              Expanded(child: OutlinedButton.icon(onPressed: _go, icon: const Icon(Icons.g_mobiledata, size: 30), label: const Text('Lanjutkan Akun Google'))),
              const SizedBox(width: 8),
              Container(width: 64, height: 52, decoration: BoxDecoration(color: kMint, borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.fingerprint, color: kGreen)),
            ]),
          ]),
        ),
      );

  Widget _kategori() => Panel(
        color: kField,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Kategori Daur Ulang Diterima', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: const [
            Pill('Plastik', bg: Colors.white, fg: kInk, icon: Icons.local_drink_outlined),
            Pill('Kertas', bg: Colors.white, fg: kInk, icon: Icons.description_outlined),
            Pill('Logam', bg: Colors.white, fg: kInk, icon: Icons.hardware),
            Pill('E-Waste', bg: kPeach, fg: Color(0xFF7A4100), icon: Icons.devices_other),
            Pill('Minyak Jelantah', icon: Icons.oil_barrel_outlined),
          ]),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, c) {
        if (c.maxWidth >= kWide) {
          // Laptop: panel hijau di kiri, form di kanan
          return Row(children: [
            Expanded(
              child: Container(
                color: kGreen,
                padding: const EdgeInsets.all(48),
                child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 440), child: _brand(light: true))),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 460), child: Column(children: [_form(), gap, _kategori()])),
                ),
              ),
            ),
          ]);
        }
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(children: [
                const SizedBox(height: 16),
                _brand(),
                gap,
                _form(),
                gap,
                _kategori(),
                gap,
                const Text('Dengan mengetuk tombol masuk atau mendaftar, kamu menyetujui Syarat & Ketentuan serta Kebijakan Privasi Titik Daur Indonesia.', textAlign: TextAlign.center, style: TextStyle(color: kMuted, fontSize: 12)),
              ]),
            ),
          ),
        );
      }),
    );
  }
}
