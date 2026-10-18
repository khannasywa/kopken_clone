import 'package:flutter/material.dart';

const Color vipText = Color(0xFF303030);
const Color vipGrey = Color(0xFF858585);
const Color vipRed = Color(0xFFB51F2D);
const Color vipGreen = Color(0xFF278F59);
const Color vipBlueGrey = Color(0xFFE0E7EE);

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  int selectedTab = 1;
  int selectedLevel = 0;

  final List<String> tabs = ['Voucher', 'Voucher Pack', 'Benefits'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F4F8),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                // HEADER
                SizedBox(
                  height: 58,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        'Kopi Kangenan VIP',
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                // KONTEN YANG BISA DI-SCROLL
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSilverCard(),

                        const SizedBox(height: 14),

                        // INDIKATOR KARTU
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() => selectedLevel = index);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: selectedLevel == index ? 30 : 8,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: selectedLevel == index
                                      ? const Color(0xFFC69A69)
                                      : const Color(0xFFC4C4C4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 18),

                        // PANEL VOUCHER
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(12, 16, 12, 22),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTabs(),

                              const SizedBox(height: 22),

                              Text(
                                selectedTab == 2
                                    ? 'Benefits Member'
                                    : 'Tersedia',
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                  color: vipText,
                                ),
                              ),

                              const SizedBox(height: 16),

                              if (selectedTab == 0) ...[
                                _buildVoucherCard(
                                  title: 'Voucher Gratis 1 Minuman',
                                  description: 'Nikmati 1 minuman pilihan sesuai syarat voucher.',
                                  oldPrice: '',
                                  price: 'GRATIS',
                                  saving: '',
                                  count: '1x',
                                ),
                                const SizedBox(height: 18),
                                _buildVoucherCard(
                                  title: 'Voucher Diskon 10%',
                                  description:
                                      'Diskon untuk pembelian minuman pilihan.',
                                  oldPrice: '',
                                  price: '10%',
                                  saving: '',
                                  count: '1x',
                                ),
                              ] else if (selectedTab == 1) ...[
                                _buildVoucherCard(
                                  title: 'Langganan Voucher Rp9.000',
                                  description:
                                      '1x Voucher B1G1, 2x Voucher B2G1, '
                                      '30x Voucher Diskon 10%, 30x Voucher Diskon...',
                                  oldPrice: 'Rp630.000',
                                  price: 'Rp9.000',
                                  saving: 'Save 98%',
                                  count: '65×',
                                ),
                                const SizedBox(height: 18),
                                _buildVoucherCard(
                                  title: 'Langganan Voucher Rp24.000',
                                  description:
                                      '1x Voucher Gratis 1 Minuman, 1x '
                                      'Voucher B1G1, 2x Voucher B2G1...',
                                  oldPrice: 'Rp680.000',
                                  price: 'Rp24.000',
                                  saving: 'Save 96%',
                                  count: '66×',
                                ),
                              ] else ...[
                                _buildBenefitCard(
                                  Icons.favorite_outline,
                                  'Keuntungan Member',
                                  'Nikmati penawaran khusus untuk member Kangenan VIP.',
                                ),
                                const SizedBox(height: 12),
                                _buildBenefitCard(
                                  Icons.local_cafe_outlined,
                                  'Promo Minuman',
                                  'Akses promo dan penawaran minuman pilihan.',
                                ),
                              ],
                            ],
                          ),
                        ),
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

  // KARTU SILVER RESPONSIF
  Widget _buildSilverCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cardHeight = (width * 0.78).clamp(255.0, 330.0);
        final titleSize = (width * 0.085).clamp(25.0, 34.0);

        return Container(
          height: cardHeight,
          width: double.infinity,
          padding: EdgeInsets.all(width * 0.055),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF9FBFF), Color(0xFFD5DDE7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xFFADB4BE), width: 2),
          ),
          child: Stack(
            children: [
              // Ilustrasi di sisi kanan kartu
              Positioned(
                right: -width * 0.02,
                top: cardHeight * 0.15,
                child: Icon(
                  Icons.workspace_premium,
                  size: width * 0.39,
                  color: Colors.grey.shade400.withValues(alpha: 0.8),
                ),
              ),
              Positioned(
                right: width * 0.09,
                top: cardHeight * 0.30,
                child: Icon(
                  Icons.favorite,
                  size: width * 0.17,
                  color: Colors.white,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'SILVER',
                        style: TextStyle(
                          fontSize: titleSize,
                          height: 1,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF55565B),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF55565B),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Text(
                          '0%',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: cardHeight * 0.065),

                  const Text(
                    'Hai, jibi',
                    style: TextStyle(
                      color: vipText,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: cardHeight * 0.09),

                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: '0',
                          style: TextStyle(
                            fontSize: 28,
                            color: Color(0xFF66666B),
                          ),
                        ),
                        TextSpan(
                          text: ' / 699.999',
                          style: TextStyle(
                            fontSize: width * 0.048,
                            color: const Color(0xFF88888D),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 29,
                        height: 29,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC4A047),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: const Color(0xFF55565B),
                        fontSize: width * 0.037,
                        height: 1.35,
                      ),
                      children: const [
                        TextSpan(text: 'Belanja '),
                        TextSpan(
                          text: 'Rp700.000',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' lagi untuk naik ke Level Gold'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // TAB VOUCHER
  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: vipBlueGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final active = selectedTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = index),
              child: Container(
                height: 46,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: active ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: active
                        ? const Color(0xFFE4E5E8)
                        : Colors.transparent,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    tabs[index],
                    style: const TextStyle(
                      color: vipText,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // KARTU VOUCHER RESPONSIF
  Widget _buildVoucherCard({
    required String title,
    required String description,
    required String oldPrice,
    required String price,
    required String saving,
    required String count,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFC6C6C6), width: 1.3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            offset: Offset(0, 5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: vipText,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: vipGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 58,
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        count,
                        style: const TextStyle(
                          color: vipRed,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Icon(
                        Icons.confirmation_number_outlined,
                        size: 28,
                        color: vipText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Garis putus-putus
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: List.generate(
                35,
                (index) => Expanded(
                  child: Container(
                    height: 1.2,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    color: index.isEven
                        ? const Color(0xFFC6C6C6)
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (oldPrice.isNotEmpty)
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          runSpacing: 3,
                          children: [
                            Text(
                              oldPrice,
                              style: const TextStyle(
                                color: Color(0xFFB8C0BD),
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            if (saving.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: vipGreen,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  saving,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      const SizedBox(height: 3),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          price,
                          style: const TextStyle(
                            color: vipGreen,
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 43,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: vipRed,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Buy Pack',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // BENEFITS
  Widget _buildBenefitCard(IconData icon, String title, String description) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: const Color(0xFFB89B65)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(color: vipGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
