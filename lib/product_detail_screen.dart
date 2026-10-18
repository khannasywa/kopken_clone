import 'package:flutter/material.dart';

import 'cart_store.dart';
import 'order_confirmation_screen.dart' as order_confirmation;

const Color detailKopi = Color(0xFF7A263D);
const Color detailEmas = Color(0xFFB99565);

class ProductDetailScreen extends StatefulWidget {
  final Map<String, String> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String temperature = 'Ice';
  String size = 'Regular';
  String milk = 'Milk';
  String sugar = 'Normal Sugar';
  String ice = 'Normal Ice';

  int quantity = 1;

  final Set<String> toppings = {};
  final Set<String> syrups = {};

  final Map<String, int> extraPrices = {
    'Large': 4000,
    'Jumbo': 8000,
    'Espresso Shot Kenangan Blend': 6000,
    'Espresso Shot Juwara Beans': 6000,
    'Grass Jelly': 6000,
    'Oreo': 6000,
    'Whipped Cream Chocolate': 6000,
    'Whipped Cream Vanilla': 6000,
    'Caramel Crumble': 6000,
    'Gula Aren': 6000,
    'Vanilla Syrup': 6000,
    'Hazelnut Syrup': 6000,
    'Caramel Syrup': 6000,
    'Salted Caramel Sauce': 6000,
    'Choco Sauce': 6000,
    'Butterscotch Sauce': 6000,
  };

  final List<String> toppingOptions = [
    'Espresso Shot Kenangan Blend',
    'Espresso Shot Juwara Beans',
    'Golden boba',
    'Grass Jelly',
    'Oreo',
    'Whipped Cream Chocolate',
    'Whipped Cream Vanilla',
    'Caramel Crumble',
    'Gula Aren',
  ];

  final List<String> syrupOptions = [
    'Vanilla Syrup',
    'Hazelnut Syrup',
    'Caramel Syrup',
    'Salted Caramel Sauce',
    'Choco Sauce',
    'Butterscotch Sauce',
  ];

  int get basePrice {
    final digits = widget.product['price']!.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }

  int get totalPrice {
    int total = basePrice;

    total += extraPrices[size] ?? 0;

    for (final item in toppings) {
      total += extraPrices[item] ?? 0;
    }

    for (final item in syrups) {
      total += extraPrices[item] ?? 0;
    }

    return total * quantity;
  }

  String rupiah(int value) {
    final text = value.toString();
    final result = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      result.write(text[i]);

      final remaining = text.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        result.write('.');
      }
    }

    return 'Rp$result';
  }

  Widget sectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget singleOptions({
    required String title,
    required String subtitle,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(title, subtitle),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const gap = 8.0;
              final width =
                  (constraints.maxWidth - gap * (options.length - 1)) /
                  options.length;

              return Wrap(
                spacing: gap,
                runSpacing: 8,
                children: options.map((option) {
                  final active = selected == option;

                  return GestureDetector(
                    onTap: () => onSelected(option),
                    child: Container(
                      width: width,
                      height: 82,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: active ? detailEmas : const Color(0xFFF8F8F8),
                          width: active ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        option,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: active ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget multiOptions({
    required String title,
    required List<String> options,
    required Set<String> selected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(title, 'Optional · May select multiple'),
        ...options.map((option) {
          final unavailable = option == 'Golden boba';
          final active = selected.contains(option);

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: InkWell(
              onTap: unavailable
                  ? null
                  : () {
                      setState(() {
                        if (active) {
                          selected.remove(option);
                        } else {
                          selected.add(option);
                        }
                      });
                    },
              child: Container(
                constraints: const BoxConstraints(minHeight: 62),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: unavailable
                      ? const Color(0xFFE0E0E0)
                      : const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: detailKopi, size: 27),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: unavailable ? Colors.grey : Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      unavailable
                          ? 'Out of Stock'
                          : '+ ${rupiah(extraPrices[option] ?? 6000)}',
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      active ? Icons.check_box : Icons.check_box_outline_blank,
                      color: active ? detailKopi : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.product['name'] ?? '';
    final image = widget.product['image'] ?? '';

    final screenSize = MediaQuery.sizeOf(context);

    return Center(
      child: SizedBox(
        width: screenSize.width > 480 ? 390 : screenSize.width,
        height: screenSize.height,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    image,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                // Tombol kembali
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                ),

                                // Tombol share
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.share),
                                  ),
                                ),
                              ],
                            ),

                            // NAMA PRODUK DARI HOMEPAGE
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SliverToBoxAdapter(child: Divider(thickness: 4)),
                      SliverToBoxAdapter(
                        child: singleOptions(
                          title: 'Temperature',
                          subtitle: 'Select 1',
                          options: const ['Ice'],
                          selected: temperature,
                          onSelected: (v) => setState(() => temperature = v),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: singleOptions(
                          title: 'Size',
                          subtitle: 'Select 1',
                          options: const ['Regular', 'Large', 'Jumbo'],
                          selected: size,
                          onSelected: (v) => setState(() => size = v),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: singleOptions(
                          title: 'Milk Option',
                          subtitle: 'Select 1',
                          options: const ['Milk', 'Oatside'],
                          selected: milk,
                          onSelected: (v) => setState(() => milk = v),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: singleOptions(
                          title: 'Sugar Level',
                          subtitle: 'Select 1',
                          options: const [
                            'Normal Sugar',
                            'Less Sugar',
                            'No Sugar',
                          ],
                          selected: sugar,
                          onSelected: (v) => setState(() => sugar = v),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: singleOptions(
                          title: 'Ice Level',
                          subtitle: 'Select 1',
                          options: const ['Normal Ice', 'Less Ice', 'No Ice'],
                          selected: ice,
                          onSelected: (v) => setState(() => ice = v),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Divider(thickness: 5, height: 32),
                      ),
                      SliverToBoxAdapter(
                        child: multiOptions(
                          title: 'Topping',
                          options: toppingOptions,
                          selected: toppings,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: multiOptions(
                          title: 'Syrup',
                          options: syrupOptions,
                          selected: syrups,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: quantity > 1
                                  ? () => setState(() => quantity--)
                                  : null,
                              icon: const Icon(Icons.remove, color: detailEmas),
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() => quantity++),
                              icon: const Icon(Icons.add, color: detailEmas),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB51F2D),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              CartStore.add(
                                CartItem(
                                  name: name,
                                  image: image,
                                  basePrice: basePrice,
                                  quantity: quantity,
                                  size: size,
                                  milk: milk,
                                  sugar: sugar,
                                  ice: ice,
                                  toppings: toppings.toList(),
                                  syrups: syrups.toList(),
                                  unitPrice: totalPrice ~/ quantity,
                                ),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      order_confirmation.OrderConfirmationScreen(
                                        productName: name,
                                        unitPrice: totalPrice ~/ quantity,
                                        quantity: quantity,
                                      ),
                                ),
                              );
                            },
                            child: Text(
                              '+ Keranjang ${rupiah(totalPrice)}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
