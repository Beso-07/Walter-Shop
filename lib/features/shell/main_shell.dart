import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../state/app_state.dart';
import '../home/home_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pages = const [HomeScreen(), CartScreen(), ProfileScreen()];
    final titles = [
      l10n?.ourProducts ?? 'Our Products',
      l10n?.cart ?? 'Cart',
      l10n?.profile ?? 'Profile',
    ];

    return Scaffold(
      appBar: AppBar(title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
        child: Text(titles[_index], key: ValueKey(titles[_index])),
      )),
      drawer: AppDrawer(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: IndexedStack(key: ValueKey(_index), index: _index, children: pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: l10n?.ourProducts ?? 'Home'),
          BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart), label: l10n?.cart ?? 'Cart'),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: l10n?.profile ?? 'Profile'),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final appState = context.watch<AppState>();
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(appState.userName ?? (l10n?.profile ?? 'Profile')),
              accountEmail: Text(appState.locale.languageCode.toUpperCase()),
              currentAccountPicture: const CircleAvatar(child: Icon(Icons.person)),
            ),
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: Text(l10n?.changeTheme ?? 'Change Theme'),
              onTap: () => context.read<AppState>().toggleTheme(),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n?.changeLanguage ?? 'Change Language'),
              onTap: () => context.read<AppState>().toggleLocale(),
            ),
          ],
        ),
      ),
    );
  }
}


