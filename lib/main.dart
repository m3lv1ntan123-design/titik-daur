import 'package:flutter/material.dart';
import 'responsive.dart';
import 'theme.dart';
import 'widgets.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/peta_screen.dart';
import 'screens/pesanan_screen.dart';
import 'screens/profil_screen.dart';
import 'screens/lapor_screen.dart';

void main() => runApp(const TitikDaurApp());

class TitikDaurApp extends StatelessWidget {
  const TitikDaurApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Titik Daur',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const LoginScreen(),
      );
}

/// Kerangka utama (Scaffold): HP = bottom bar + tombol "+", laptop = NavigationRail.
class Shell extends StatelessWidget {
  const Shell({super.key});

  static const _titles = ['Beranda', 'Peta', 'Pesanan', 'Profil'];
  static const _icons = [Icons.eco_outlined, Icons.map_outlined, Icons.receipt_long_outlined, Icons.person_outline];
  static const _pages = [HomeScreen(), PetaScreen(), PesananScreen(), ProfilScreen()];

  void _lapor(BuildContext c) => Navigator.push(c, MaterialPageRoute(builder: (_) => const LaporScreen()));

  PreferredSizeWidget _bar(int i) => AppBar(
        titleSpacing: 16,
        title: Row(children: [
          const CircleAvatar(radius: 16, backgroundColor: kMint, child: Icon(Icons.eco, size: 18, color: kGreen)),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Titik Daur', style: TextStyle(fontWeight: FontWeight.bold, color: kGreen, fontSize: 18)),
            Text(_titles[i], style: const TextStyle(fontSize: 12, color: kMuted)),
          ]),
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          const Padding(padding: EdgeInsets.only(right: 16), child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18))),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: navIndex,
      builder: (context, i, _) => LayoutBuilder(builder: (context, c) {
        final body = IndexedStack(index: i, children: _pages);
        if (c.maxWidth >= kWide) {
          return Scaffold(
            appBar: _bar(i),
            body: Row(children: [
              NavigationRail(
                extended: c.maxWidth >= 1100,
                selectedIndex: i,
                onDestinationSelected: (v) => navIndex.value = v,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FloatingActionButton(backgroundColor: kGreen, foregroundColor: Colors.white, onPressed: () => _lapor(context), child: const Icon(Icons.add)),
                ),
                destinations: [for (var k = 0; k < 4; k++) NavigationRailDestination(icon: Icon(_icons[k]), label: Text(_titles[k]))],
              ),
              Expanded(child: body),
            ]),
          );
        }
        return Scaffold(
          appBar: _bar(i),
          body: body,
          floatingActionButton: FloatingActionButton(backgroundColor: kGreen, foregroundColor: Colors.white, shape: const CircleBorder(), onPressed: () => _lapor(context), child: const Icon(Icons.add, size: 30)),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            notchMargin: 6,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _item(0, i), _item(1, i), const SizedBox(width: 48), _item(2, i), _item(3, i),
            ]),
          ),
        );
      }),
    );
  }

  Widget _item(int k, int sel) => InkWell(
        onTap: () => navIndex.value = k,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(_icons[k], color: k == sel ? kGreen : kMuted),
          Text(_titles[k], style: TextStyle(fontSize: 11, fontWeight: k == sel ? FontWeight.bold : FontWeight.normal, color: k == sel ? kGreen : kMuted)),
        ]),
      );
}
