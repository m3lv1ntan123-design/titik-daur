import 'package:flutter/material.dart';

/// Responsive & Adaptive UI: lebar >= 800 dianggap layar laptop/tablet.
const double kWide = 800;
const gap = SizedBox(height: 16);

/// Halaman scroll dengan lebar konten dibatasi di layar besar.
class AdaptivePage extends StatelessWidget {
  final Widget Function(bool wide) builder;
  const AdaptivePage({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final wide = c.maxWidth >= kWide;
      return SingleChildScrollView(
        padding: EdgeInsets.all(wide ? 28 : 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: builder(wide),
          ),
        ),
      );
    });
  }
}

/// Dua kolom di layar lebar (Row), ditumpuk di HP (Column).
class Cols extends StatelessWidget {
  final bool wide;
  final Widget left, right;
  final int lf, rf;
  const Cols({super.key, required this.wide, required this.left, required this.right, this.lf = 3, this.rf = 2});

  @override
  Widget build(BuildContext context) {
    if (!wide) return Column(children: [left, gap, right]);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: lf, child: left),
        const SizedBox(width: 24),
        Expanded(flex: rf, child: right),
      ],
    );
  }
}
