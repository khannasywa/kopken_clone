import 'package:flutter/material.dart';

import 'main_navigation_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(const KopkenApp());
}

class KopkenApp extends StatelessWidget {
  const KopkenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kopi Kangenan',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F3EB),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7A263D)),
      ),
      home: const LoginHomeScreen(),
    );
  }
}

class MobileFrame extends StatelessWidget {
  final Widget child;

  const MobileFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: Center(
        child: SizedBox(width: 390, height: 844, child: ClipRect(child: child)),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginHomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Image.asset(
              'assets/spark.logo.jpeg',
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            );
          },
        ),
      ),
    );
  }
}

class LoginHomeScreen extends StatefulWidget {
  const LoginHomeScreen({super.key});

  @override
  State<LoginHomeScreen> createState() => _LoginHomeScreenState();
}

class _LoginHomeScreenState extends State<LoginHomeScreen> {
  bool _popupDitutup = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bukaPopupLogin();
    });
  }

  Future<void> _bukaPopupLogin() async {
    if (!mounted || _popupDitutup) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      enableDrag: false,
      isDismissible: false,
      builder: (sheetContext) {
        return Center(
          child: SizedBox(
            width: 390,
            height: 844,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LoginScreen(
                onClose: () {
                  _popupDitutup = true;
                  Navigator.of(sheetContext).pop();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const MainNavigationScreen();
  }
}
