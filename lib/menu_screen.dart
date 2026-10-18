import 'package:flutter/material.dart';

import 'product_detail_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final Color kopi = const Color(0xFF7A263D);
  final Color pink = const Color(0xFFF8DDE1);

  int selectedCategory = 0;

  final List<String> categories = [
    'Promo & Combo',
    'Baru!',
    'Coffee',
    'Non Coffee',
    'Makanan',
  ];

  final List<Map<String, String>> products = [
    {
      'name': 'Taro Cloud Matcha',
      'image': 'assets/Taro cloud matcha.png',
      'category': 'Non Coffee',
      'price': 'Rp 28.000',
    },
    {
      'name': 'Taro Milk',
      'image': 'assets/taro milk.png',
      'category': 'Non Coffee',
      'price': 'Rp 25.000',
    },
    {
      'name': 'Taro Cloud Latte',
      'image': 'assets/taro cloud latte.png',
      'category': 'Coffee',
      'price': 'Rp 28.000',
    },
    {
      'name': 'Taro Cloud Milk Tea',
      'image': 'assets/taro cloud milktea.png',
      'category': 'Non Coffee',
      'price': 'Rp 25.000',
    },
    {
      'name': 'Triple Cheese Bagel',
      'image': 'assets/triple cheeze bagel.png',
      'category': 'Makanan',
      'price': 'Rp 22.000',
    },
    {
      'name': 'Beef and Cheese Jalapeno Bagel',
      'image': 'assets/beef and cheese jalapeno bagel.png',
      'category': 'Makanan',
      'price': 'Rp 28.000',
    },
    {
      'name': 'Double Choco Bagel',
      'image': 'assets/double choco bagel.png',
      'category': 'Makanan',
      'price': 'Rp 22.000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = selectedCategory == 0 || selectedCategory == 1
        ? products
        : products
              .where(
                (product) =>
                    product['category'] == categories[selectedCategory],
              )
              .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Text(
            'Menu',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kopi,
            ),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final selected = selectedCategory == index;

              return GestureDetector(
                onTap: () => setState(() => selectedCategory = index),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? kopi : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: kopi),
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: selected ? Colors.white : kopi,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 12.0;
              final itemWidth = (constraints.maxWidth - spacing) / 2;
              final imageHeight = itemWidth * 0.9;

              return Wrap(
                spacing: spacing,
                runSpacing: 16,

                children: filteredProducts.map((product) {
                  return SizedBox(
                    width: itemWidth,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: imageHeight,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: pink,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                product['image']!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.coffee,
                                      size: 50,
                                      color: Colors.brown,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product['name']!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product['price']!,
                            style: TextStyle(
                              fontSize: 13,
                              color: kopi,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
