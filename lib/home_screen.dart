import 'package:flutter/material.dart';

import 'product_detail_screen.dart';

const Color kopi = Color(0xFF7A263D);
const Color pink = Color(0xFFF8DDE1);
const Color abu = Color(0xFF777777);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(22),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Silver  0%',
                    style: TextStyle(color: abu, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(Icons.monetization_on, color: Color(0xFFFFC844)),
                  const SizedBox(width: 6),
                  const Text(
                    '0 pts',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.location_on, color: kopi, size: 25),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tunjungan Plaza 3',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Tunjungan Plaza 3, Lantai 5, Surabaya',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: abu, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: kopi),
                    SizedBox(width: 8),
                    Icon(Icons.qr_code_scanner, color: kopi),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Text('Melayani', style: TextStyle(color: abu, fontSize: 13)),
                  SizedBox(width: 12),
                  Icon(Icons.circle, color: Color(0xFF75B879), size: 10),
                  SizedBox(width: 5),
                  Text('Delivery', style: TextStyle(fontSize: 13)),
                  SizedBox(width: 15),
                  Icon(Icons.circle, color: Color(0xFF64BDB6), size: 10),
                  SizedBox(width: 5),
                  Text('Pickup', style: TextStyle(fontSize: 13)),
                ],
              ),
            ],
          ),
        ),

        // Banner promo
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8),
          child: Image.asset(
            'assets/banner_promo.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 180,
                color: Colors.white,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Gambar gagal dimuat:\n$error',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              );
            },
          ),
        ),

        // Menu pintas
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
          child: Row(
            children: const [
              _QuickMenu(
                icon: Icons.shopping_bag,
                title: 'Order',
                color: Color(0xFFFFE3E5),
              ),
              _QuickMenu(
                icon: Icons.delivery_dining,
                title: 'Delivery\nHemat',
                color: Color(0xFFFFE8C8),
              ),
              _QuickMenu(
                icon: Icons.lunch_dining,
                title: 'Chicken &\nBurger',
                color: Color(0xFFFFE1D5),
              ),
              _QuickMenu(
                icon: Icons.card_giftcard,
                title: 'Catering &\nWedding',
                color: Color(0xFFE4F0D9),
              ),
            ],
          ),
        ),

        // Voucher
        Container(
          margin: const EdgeInsets.fromLTRB(20, 4, 20, 22),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFB98050), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.card_giftcard,
                color: Color(0xFFD2A36D),
                size: 42,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Voucher Buy 1 Get 1\nSEPUASNYA!',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Voucher berhasil diklaim!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB51F2D),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Klaim'),
              ),
            ],
          ),
        ),

        // Paket Hemat
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            'Paket Hemat',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 175,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            children: const [
              _SpecialCard(
                title: 'PaHe 1',
                price: 'Rp19.000',
                image: 'assets/pahe1.png',
                color: Colors.white,
              ),
              _SpecialCard(
                title: 'PaHe 2',
                price: 'Rp27.000',
                image: 'assets/pahe2.png',
                color: Colors.white,
              ),
              _SpecialCard(
                title: 'PaHe 3',
                price: 'Rp29.000',
                image: 'assets/pahe3.png',
                color: Colors.white,
              ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(22, 22, 20, 24),
          child: Row(
            children: [
              Icon(Icons.discount, color: Color(0xFF54A77D), size: 28),
              SizedBox(width: 12),
              Text(
                'Diskon & Cashback',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _QuickMenu({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: kopi, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _SpecialCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final Color color;

  const _SpecialCard({
    required this.title,
    required this.price,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: {
                'name': title,
                'price': price,
                'image': image,
                'description': 'Paket hemat Kopi Kangenan.',
              },
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.local_cafe, size: 38, color: color);
                  },
                ),
              ),
            ),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(price, style: const TextStyle(color: kopi)),
          ],
        ),
      ),
    );
  }
}
