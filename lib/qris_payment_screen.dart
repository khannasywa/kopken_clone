import 'dart:async';

import 'package:flutter/material.dart';

const Color qrisRed = Color(0xFFB82025);
const Color qrisBackground = Color(0xFFF8F9FA);
const Color qrisText = Color(0xFF252525);

class QrisPaymentScreen extends StatefulWidget {
  final int total;

  const QrisPaymentScreen({super.key, required this.total});

  @override
  State<QrisPaymentScreen> createState() => _QrisPaymentScreenState();
}

class _QrisPaymentScreenState extends State<QrisPaymentScreen> {
  // Countdown 10 menit
  int remainingSeconds = 10 * 60;

  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds <= 1) {
        timer.cancel();

        if (mounted) {
          setState(() {
            remainingSeconds = 0;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            remainingSeconds--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
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

  String get countdownText {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  bool get isExpired => remainingSeconds == 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: qrisBackground,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Header
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFF0F0F0)),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, size: 23),
                          tooltip: 'Tutup',
                        ),
                        const Expanded(
                          child: Text(
                            'Pembayaran QRIS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: qrisText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  // Main content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Total pembayaran',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF777777),
                            ),
                          ),
                          const SizedBox(height: 5),

                          Text(
                            rupiah(widget.total),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: qrisRed,
                              letterSpacing: -0.7,
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Countdown
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isExpired
                                  ? const Color(0xFFFFE8E8)
                                  : const Color(0xFFF8EFE4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isExpired
                                      ? Icons.error_outline
                                      : Icons.access_time,
                                  size: 17,
                                  color: qrisRed,
                                ),
                                const SizedBox(width: 8),

                                Flexible(
                                  child: Text(
                                    isExpired
                                        ? 'Waktu pembayaran telah habis'
                                        : 'Selesaikan pembayaran dalam',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF38332B),
                                    ),
                                  ),
                                ),

                                if (!isExpired) ...[
                                  const SizedBox(width: 8),
                                  Text(
                                    countdownText,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: qrisRed,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // QRIS payment card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xFFE7E7E7),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 16,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.qr_code_2,
                                      color: qrisRed,
                                      size: 20,
                                    ),
                                    SizedBox(width: 7),
                                    Text(
                                      'SCAN UNTUK MEMBAYAR',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                        color: qrisText,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // QRIS image
                                Opacity(
                                  opacity: isExpired ? 0.35 : 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/qris_kopi.jpeg',
                                      width: 300,
                                      height: 362,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const SizedBox(
                                              width: 300,
                                              height: 362,
                                              child: Center(
                                                child: Text(
                                                  'QRIS gagal dimuat.\n'
                                                  'Periksa lokasi dan nama file gambar.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                const Text(
                                  'Kopi Kangenan',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: qrisText,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  isExpired
                                      ? 'QRIS sudah kadaluarsa.'
                                      : 'Pastikan nominal pembayaran sesuai.',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF777777),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Reminder
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              color: isExpired
                                  ? const Color(0xFF777777)
                                  : qrisRed,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isExpired
                                      ? Icons.timer_off_outlined
                                      : Icons.download_outlined,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    isExpired
                                        ? 'QRIS sudah tidak dapat digunakan'
                                        : 'Simpan atau screenshot gambar QRIS',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Payment instructions
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFEEEEEE),
                              ),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: qrisRed,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cara bayar dengan QRIS',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Buka aplikasi pembayaran yang '
                                        'mendukung QRIS, lalu pindai kode '
                                        'untuk membayar.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          height: 1.5,
                                          color: Color(0xFF777777),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom button
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: qrisText,
                          side: const BorderSide(
                            color: Color(0xFFBE9B6D),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          isExpired
                              ? 'Kembali ke Beranda'
                              : 'Kembali ke Beranda',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
