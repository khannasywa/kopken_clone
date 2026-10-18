import 'package:flutter/material.dart';

const Color kopiMerch = Color(0xFF7A263D);

class MerchScreen extends StatelessWidget {
  const MerchScreen({super.key});

  static const List<Map<String, String>> products = [
    {
      'name': 'ColorPop Cup',
      'price': 'Rp109.650',
      'image': 'assets/merch/ColorPop Cup.png',
    },
    {
      'name': 'ColorPop Sip Tumbler',
      'price': 'Rp177.650',
      'image': 'assets/merch/ColorPop Sip Tumbler.png',
    },
    {
      'name': 'Capybara',
      'price': 'Rp49.000',
      'image': 'assets/merch/Capybara.png',
    },
    {
      'name': 'Playsonality Bottle',
      'price': 'Rp199.000',
      'image': 'assets/merch/Playsonality Bottle.png',
    },
    {
      'name': 'Playsonality Classic Cup',
      'price': 'Rp169.000',
      'image': 'assets/merch/Playsonality  Classic Cup.png',
    },
    {
      'name': 'Playsonality Press Tumbler',
      'price': 'Rp159.000',
      'image': 'assets/merch/Playsonality Press Tumbler.png',
    },
    {
      'name': 'Golden Sling Tumbler',
      'price': 'Rp219.000',
      'image': 'assets/merch/Golden Sling Tumbler.png',
    },
    {
      'name': 'ColorPop Bubble Tumbler',
      'price': 'Rp169.150',
      'image': 'assets/merch/ColorPop Bubble Tumbler.png',
    },
    {
      'name': 'Sigma Slim Bottle',
      'price': 'Rp209.000',
      'image': 'assets/merch/Sigma Slim Bottle.png',
    },
    {
      'name': 'Sigma Sip Cup',
      'price': 'Rp169.000',
      'image': 'assets/merch/Sigma Sip Cup.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 390),
            child: Column(
              children: [
                Container(
                  height: 64,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: const Text(
                    'Merchandise',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF171717),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Banner promo tumbler
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 24),
                          color: Colors.white,
                          child: Image.asset(
                            'assets/merch/promo.tumbler.png',
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/merch/promo.tumbler.png',
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Custom Merchandise',
                                style: TextStyle(
                                  color: Color(0xFFB69A78),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 14),
                              SizedBox(
                                width: 180,
                                child: Divider(
                                  color: Color(0xFFB69A78),
                                  thickness: 4,
                                  height: 2,
                                ),
                              ),
                              SizedBox(height: 22),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 14,
                                  mainAxisSpacing: 24,
                                  childAspectRatio: 0.57,
                                ),
                            itemBuilder: (context, index) {
                              final product = products[index];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Image.asset(
                                        product['image']!,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Center(
                                            child: Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              size: 32,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 4,
                                    ),
                                    color: const Color(0xFFEAF6EF),
                                    child: const Text(
                                      'Gratis Ukir',
                                      style: TextStyle(
                                        color: Color(0xFF65A486),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    product['name']!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF171717),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    product['price']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF171717),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
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
