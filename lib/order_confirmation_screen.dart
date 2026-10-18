import 'package:flutter/material.dart';

import 'qris_payment_screen.dart';

const Color kopi = Color(0xFF7A263D);
const Color merah = Color(0xFFB92429);
const Color emas = Color(0xFFC6A577);
const Color biru = Color(0xFF00A3C8);
const Color mint = Color(0xFF38B2AC);

class OrderConfirmationScreen extends StatefulWidget {
  final String productName;
  final int unitPrice;
  final int quantity;

  const OrderConfirmationScreen({
    super.key,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
  });

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  int selectedPayment = 0;
  bool shoppingBag = false;

  String get productName => widget.productName;
  int get unitPrice => widget.unitPrice;
  int get quantity => widget.quantity;

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

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.unitPrice * widget.quantity + (shoppingBag ? 4000 : 0);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                // Header
                Container(
                  color: const Color(0xFFFBFBFB),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 40,
                        ),
                        icon: const Icon(Icons.arrow_back, size: 24),
                      ),
                      const Expanded(
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),

                // Isi checkout
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    children: [
                      _outletCard(),
                      const SizedBox(height: 16),
                      _paymentSection(),
                      const SizedBox(height: 16),
                      _orderCard(),
                      const SizedBox(height: 16),
                      _shoppingBagCard(),
                      const SizedBox(height: 16),
                      _voucherAlert(),
                      const SizedBox(height: 20),
                      _voucherPackage(),
                    ],
                  ),
                ),

                // Tombol tetap di bawah
                Container(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    12,
                    16,
                    12 + MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: const Border(
                      top: BorderSide(color: Color(0xFFE5E5E5)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          showMessage('Fitur penjadwalan belum tersedia.');
                        },
                        icon: const Icon(Icons.schedule, size: 20),
                        label: const Text('Jadwalkan'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: merah,
                          side: const BorderSide(color: merah),
                          minimumSize: const Size(0, 48),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    QrisPaymentScreen(total: total),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: merah,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Bayar - ${rupiah(total)}',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
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

  Widget _card({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDEDED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _outletCard() {
    return _card(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.radio_button_checked, color: mint, size: 25),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Outlet',
                      style: TextStyle(color: Color(0xFF777777), fontSize: 12),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Ketintang UNESA',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: Color(0xFFEDEDED)),
          ),
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF6F6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.storefront,
                  color: Color(0xFF319795),
                  size: 17,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Opsi Pickup',
                      style: TextStyle(color: Color(0xFF777777), fontSize: 12),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Pickup di Counter',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pembayaran Langsung',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'blu by BCA Digital - Cashback 40% max. 25RB*',
                    style: TextStyle(
                      color: Color(0xFFA6783A),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => showMessage(
                'Daftar metode pembayaran lainnya belum tersedia.',
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 6, top: 0),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Color(0xFF3B82F6),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 142,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _paymentOption(
                index: 0,
                title: 'QRIS',
                subtitle: 'Simpan QR dan bayar',
                icon: Icons.qr_code_2,
              ),
              const SizedBox(width: 12),
              _paymentOption(
                index: 1,
                title: 'blu by BCA Digital',
                subtitle: 'Cashback 40% max. 25RB*',
                icon: Icons.account_balance_wallet,
                brandColor: const Color(0xFF00A3C8),
              ),
              const SizedBox(width: 12),
              _paymentOption(
                index: 2,
                title: 'GoPay',
                subtitle: 'Hubungkan akun',
                icon: Icons.account_balance_wallet,
                brandColor: const Color(0xFF00AED6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paymentOption({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    Color? brandColor,
  }) {
    final selected = selectedPayment == index;

    return GestureDetector(
      onTap: () => setState(() => selectedPayment = index),
      child: Container(
        width: 124,
        height: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? emas : const Color(0xFFEDEDED),
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: brandColor ?? Colors.white,
                shape: BoxShape.circle,
                border: brandColor == null
                    ? Border.all(color: const Color(0xFFEDEDED))
                    : null,
              ),
              child: Icon(
                icon,
                color: brandColor == null ? Colors.black87 : Colors.white,
                size: 23,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 34,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 28,
              child: Center(
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF777777), fontSize: 9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderCard() {
    return _card(
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/logo.png',
                width: 21,
                height: 21,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Pesan',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Total $quantity Items',
                style: const TextStyle(color: Color(0xFF777777), fontSize: 12),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: Color(0xFFEDEDED)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$quantity x',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Normal Ice',
                      style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                rupiah(unitPrice * quantity),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shoppingBagCard() {
    return _card(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => shoppingBag = !shoppingBag),
              child: Row(
                children: [
                  Checkbox(
                    value: shoppingBag,
                    activeColor: kopi,
                    onChanged: (value) =>
                        setState(() => shoppingBag = value ?? false),
                  ),
                  const Expanded(
                    child: Text(
                      'Kantung Belanja',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Text(
            'Rp4.000',
            style: TextStyle(fontSize: 14, color: Color(0xFF777777)),
          ),
        ],
      ),
    );
  }

  Widget _voucherAlert() {
    return InkWell(
      onTap: () =>
          showMessage('Voucher Pengguna Baru - Diskon 50% tidak berlaku.'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: merah, width: 2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: merah.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFF59E0B),
                size: 25,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voucher tidak berlaku',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pengguna Baru - Diskon 50%',
                    style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: merah, size: 23),
          ],
        ),
      ),
    );
  }

  Widget _voucherPackage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Beli Paket Voucher, Langsung Hemat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
        ),
        _card(
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Langganan Voucher Rp24.000',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '1x Voucher Gratis 1 Minuman, 1x...',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Color(0xFF777777)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 56,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  border: Border.all(color: const Color(0xFFE5E5E5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '66x',
                      style: TextStyle(
                        color: merah,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.confirmation_number_outlined, size: 21),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
