import 'package:flutter/material.dart';

const Color profileGold = Color(0xFFD9B54A);
const Color profileRed = Color(0xFFB3262D);
const Color profileGreen = Color(0xFF218B55);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _section(String title, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...items,
        ],
      ),
    );
  }

  Widget _item(
    IconData icon,
    String title, {
    Color iconColor = Colors.black54,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: profileGold),
      dense: true,
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F7F7),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // HEADER PROFIL
                  SizedBox(
                    height: 220,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(height: 145, color: const Color(0xFFF0F0F0)),
                        Positioned(
                          top: 22,
                          left: 20,
                          child: Row(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 34,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Hai, Guest',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 22,
                          right: 20,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: profileGreen,
                              foregroundColor: Colors.white,
                              elevation: 0,
                            ),
                            child: const Text('Masuk'),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                            decoration: _cardDecoration(),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Level Silver',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: 120,
                                        child: LinearProgressIndicator(
                                          value: 0,
                                          color: profileGold,
                                          backgroundColor: Color(0xFFEAEAEA),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        '0%',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 50,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(width: 16),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kangenan Points',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        '0 pts',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
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

                  // PROMO SPESIAL
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                    padding: const EdgeInsets.all(16),
                    decoration: _cardDecoration(),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Promo Spesial Buat Kamu!',
                                    style: TextStyle(
                                      color: profileGreen,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Ikuti channel kami dan jangan lewatkan '
                                    'penawaran menarik setiap saat.',
                                    style: TextStyle(fontSize: 13, height: 1.4),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Container(
                                        width: 34,
                                        height: 34,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF20C96B),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.chat,
                                          color: Colors.white,
                                          size: 21,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Expanded(
                                        child: Text(
                                          'WhatsApp Channel',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),

                            // RUANG GAMBAR ORANG

                            // GAMBAR PROMO
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                height: 140,
                                child: Image.asset(
                                  'assets/images.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.local_cafe,
                                      size: 70,
                                      color: profileGreen,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF20C96B),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Ikuti Sekarang',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // DAILY CHECK-IN
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: const EdgeInsets.all(15),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Daily Check-In',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Detail'),
                            ),
                          ],
                        ),
                        const Text(
                          'Berakhir 31 Okt 2026',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 112,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              final checked = index == 0;
                              final voucher = index == 2 || index == 5;

                              return Container(
                                width: 78,
                                margin: const EdgeInsets.only(right: 7),
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: checked
                                        ? profileGold
                                        : Colors.grey.shade300,
                                    width: checked ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      voucher
                                          ? Icons.confirmation_num_outlined
                                          : Icons.monetization_on,
                                      color: checked
                                          ? profileGold
                                          : Colors.grey.shade400,
                                      size: 24,
                                    ),
                                    Text(
                                      voucher ? 'Voucher' : '+25',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      index == 0
                                          ? 'Check-In'
                                          : 'Hari ke-${index + 1}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // AKUN
                  _section('Akun', [
                    _item(Icons.person_outline, 'Data Diri'),
                    _item(Icons.location_on_outlined, 'Alamat Pengiriman'),
                    _item(Icons.shopping_bag_outlined, 'Scan Merchandise'),
                    _item(Icons.fingerprint, 'Aktifkan Biometric ID'),
                    _item(Icons.language, 'Ubah Bahasa Aplikasi'),
                  ]),

                  // PESAN
                  _section('Pesan', [
                    _item(Icons.inbox_outlined, 'Kotak Masuk'),
                    _item(Icons.receipt_long_outlined, 'Riwayat Pesanan'),
                    _item(
                      Icons.account_balance_wallet_outlined,
                      'Metode Pembayaran',
                    ),
                    _item(
                      Icons.shopping_basket_outlined,
                      'Pesanan Jumlah Besar',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: profileGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Baru',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.chevron_right, color: profileGold),
                        ],
                      ),
                    ),
                  ]),

                  // Kopi Kangenan
                  _section('Kopi Kangenan', [
                    _item(Icons.help_outline, 'Bantuan'),
                    _item(Icons.menu_book_outlined, 'Kebijakan Privasi'),
                    _item(Icons.info_outline, 'Ketentuan Layanan'),
                    _item(Icons.mail_outline, 'Lapor Masalah'),
                    _item(Icons.support_agent, 'Layanan WhatsApp'),
                    _item(
                      Icons.favorite_border,
                      'Tentang Kopi Kangenan',
                      iconColor: profileRed,
                    ),
                  ]),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 24, top: 2),
                    child: Center(
                      child: Text(
                        'Kopi Kangenan • Versi 1.0.0',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
