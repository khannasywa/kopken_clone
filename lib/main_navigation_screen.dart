import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'menu_screen.dart';
import 'vip_screen.dart';
import 'merch_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedIndex = 0;

  final Color kopi = const Color(0xFF7A263D);
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _menuKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveTab);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveTab);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateActiveTab() {
    if (selectedIndex >= 2) return;

    final menuContext = _menuKey.currentContext;
    if (menuContext == null) return;

    final renderObject = menuContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final menuTop = renderObject.localToGlobal(Offset.zero).dy;
    final screenHeight = MediaQuery.of(context).size.height;

    final newIndex = menuTop <= screenHeight * 0.45 ? 1 : 0;

    if (selectedIndex != newIndex) {
      setState(() => selectedIndex = newIndex);
    }
  }

  void _goToMenu() {
    final menuContext = _menuKey.currentContext;
    if (menuContext == null) return;

    Scrollable.ensureVisible(
      menuContext,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
      alignment: 0,
    );
  }

  void _goHome() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    }

    setState(() => selectedIndex = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: selectedIndex == 2
                  ? const VipScreen()
                  : selectedIndex == 3
                  ? const MerchScreen()
                  : selectedIndex == 4
                  ? const ProfileScreen()
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const HomeScreen(),
                              const SizedBox(height: 20),
                              Padding(
                                key: _menuKey,
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  0,
                                  20,
                                  14,
                                ),
                                child: const Text(
                                  'Menu Kopi Kangenan',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const MenuScreen(),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),

            Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  _navItem(
                    icon: Icons.home_outlined,
                    label: 'Beranda',
                    index: 0,
                  ),
                  _navItem(
                    icon: Icons.favorite_border,
                    label: 'Menu',
                    index: 1,
                  ),

                  // Tombol VIP di tengah
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() => selectedIndex = 2);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -8),
                            child: Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFE1E1E6),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.12),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                selectedIndex == 2
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: selectedIndex == 2
                                    ? kopi
                                    : Colors.grey.shade600,
                                size: 27,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -6),
                            child: Text(
                              'VIP',
                              style: TextStyle(
                                fontSize: 10,
                                color: selectedIndex == 2 ? kopi : Colors.grey,
                                fontWeight: selectedIndex == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  _navItem(
                    icon: Icons.local_drink_outlined,
                    label: 'Merch',
                    index: 3,
                  ),
                  _navItem(icon: Icons.person_outline, label: 'Saya', index: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final active = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          if (index == 0) {
            _goHome();
          } else if (index == 1) {
            setState(() => selectedIndex = 1);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _goToMenu();
            });
          } else {
            setState(() => selectedIndex = index);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 23, color: active ? kopi : Colors.grey),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: active ? kopi : Colors.grey,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
