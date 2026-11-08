import 'package:flutter/material.dart';
import 'data.dart';
import 'screens/detail_screen.dart';
import 'theme.dart';

/// Indeks tab aktif (0 Beranda, 1 Peta, 2 Pesanan, 3 Profil).
final navIndex = ValueNotifier<int>(0);

/// Widget reusable: kartu putih membulat.
class Panel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  const Panel({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.color = Colors.white});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 4))],
        ),
        child: child,
      );
}

/// Widget reusable: label kecil berwarna.
class Pill extends StatelessWidget {
  final String text;
  final Color bg, fg;
  final IconData? icon;
  const Pill(this.text, {super.key, this.bg = kMint, this.fg = kGreen, this.icon});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[Icon(icon, size: 14, color: fg), const SizedBox(width: 4)],
          Flexible(child: Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg))),
        ]),
      );
}

Pill tagPill(String t) {
  if (t.contains('E-Waste') || t.contains('Minyak')) return Pill(t, bg: kPeach, fg: const Color(0xFF7A4100));
  if (t == 'Plastik' || t == 'Kertas') return Pill(t);
  return Pill(t, bg: kBlue, fg: const Color(0xFF1D3A6B));
}

/// Pengganti foto (belum ada aset gambar).
class IconBox extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  const IconBox(this.icon, {super.key, this.size = 56, this.color = kMint});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
        child: Icon(icon, color: kGreen, size: size * .5),
      );
}

class SectionHead extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  const SectionHead(this.title, {super.key, this.action, this.onAction});

  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kInk))),
        if (action != null) TextButton(onPressed: onAction, child: Text(action!)),
      ]);
}

/// Deretan chip filter (scroll horizontal).
class ChipBar extends StatelessWidget {
  final List<String> items;
  final String selected;
  final ValueChanged<String> onSelect;
  const ChipBar({super.key, required this.items, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 44,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final on = items[i] == selected;
            return FilterChip(
              showCheckmark: false,
              label: Text(items[i], style: TextStyle(color: on ? Colors.white : kInk, fontWeight: FontWeight.w600)),
              selected: on,
              selectedColor: kGreen,
              backgroundColor: Colors.white,
              side: BorderSide.none,
              onSelected: (_) => onSelect(items[i]),
            );
          },
        ),
      );
}

/// Peta statis (placeholder) digambar dengan CustomPaint.
class FakeMap extends StatelessWidget {
  final double? height;
  final String? label;
  const FakeMap({super.key, this.height, this.label});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: height,
          child: Stack(fit: StackFit.expand, children: [
            CustomPaint(painter: _MapPainter()),
            const Align(alignment: Alignment(-.5, -.4), child: _Pin()),
            const Align(alignment: Alignment(.5, -.2), child: _Pin()),
            const Align(alignment: Alignment(-.1, .35), child: _Pin()),
            if (label != null) Align(alignment: const Alignment(0, .8), child: Pill(label!, bg: Colors.white, fg: kInk)),
          ]),
        ),
      );
}

class _Pin extends StatelessWidget {
  const _Pin();
  @override
  Widget build(BuildContext context) => Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(color: kGreen, shape: BoxShape.circle),
        child: const Icon(Icons.recycling, color: Colors.white, size: 20),
      );
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    c.drawRect(Offset.zero & s, Paint()..color = const Color(0xFFE6EEE4));
    c.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(s.width * .6, s.height * .55, s.width * .35, s.height * .3), const Radius.circular(24)),
      Paint()..color = const Color(0xFFCFE6CF),
    );
    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    c.drawLine(Offset(0, s.height * .3), Offset(s.width, s.height * .45), road);
    c.drawLine(Offset(s.width * .35, 0), Offset(s.width * .45, s.height), road);
    c.drawLine(Offset(s.width * .8, 0), Offset(s.width * .7, s.height), road);
    road.strokeWidth = 9;
    c.drawLine(Offset(0, s.height * .8), Offset(s.width, s.height * .7), road);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/// Kartu lokasi di Beranda.
class LokasiTile extends StatelessWidget {
  final Lokasi l;
  const LokasiTile(this.l, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(lokasi: l))),
          child: Panel(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const IconBox(Icons.storefront, size: 72),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(l.nama, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: kInk)),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Icon(Icons.place_outlined, size: 16, color: kMuted),
                      Text(' ${l.km} km', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      const Icon(Icons.schedule, size: 16, color: kMuted),
                      Text(' ${l.jam}', style: const TextStyle(color: kMuted)),
                    ]),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      Text(' ${l.rating} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('(${l.ulasan} ulasan)', style: const TextStyle(color: kMuted)),
                    ]),
                  ]),
                ),
                const Icon(Icons.bookmark_border, color: kMuted),
              ]),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 6, children: [for (final t in l.tags) tagPill(t)]),
            ]),
          ),
        ),
      );
}
