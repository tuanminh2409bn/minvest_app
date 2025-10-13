// lib/features/verification/screens/package_screen_web.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart'; // <<< THÊM MỚI

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {}
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Yêu cầu 1: Danh sách features giờ đã được chuyển vào trong _PackageCard
    // để xử lý đa ngôn ngữ cho dòng ghi chú mới.

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(l10n.packageTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1117), Color(0xFF161B22), Color.fromARGB(255, 20, 29, 110)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                children: [
                  _PackageCard(
                    tier: l10n.tierElite,
                    duration: l10n.duration1Month,
                    // Yêu cầu 1: Sử dụng giá tiền từ file đa ngôn ngữ
                    price: l10n.price1Month,
                    onPressed: () => _launchURL('https://zalo.me/0969156969'),
                  ),
                  const SizedBox(height: 24),
                  _PackageCard(
                    tier: l10n.tierElite,
                    duration: l10n.duration12Months,
                    // Yêu cầu 1: Sử dụng giá tiền từ file đa ngôn ngữ
                    price: l10n.price12Months,
                    onPressed: () => _launchURL('https://zalo.me/0969156969'),
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

class _PackageCard extends StatelessWidget {
  final String tier;
  final String duration;
  final String price;
  final VoidCallback? onPressed;

  const _PackageCard({
    required this.tier,
    required this.duration,
    required this.price,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Danh sách features gốc
    final features = [
      l10n.featureReceiveAllSignals,
      l10n.featureAnalyzeReason,
      l10n.featureHighPrecisionAI,
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF157CC9), Color(0xFF2A43B9), Color(0xFFC611CE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC611CE).withOpacity(0.5),
                blurRadius: 25.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.diamond_outlined, color: Colors.amber, size: 22),
                  const SizedBox(width: 8),
                  Text(tier, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(duration, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Hiển thị các features gốc
              ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Colors.green, size: 16),
                    const SizedBox(width: 10),
                    Expanded(child: Text(feature, style: const TextStyle(color: Colors.white70, fontSize: 13))),
                  ],
                ),
              )),
              // ▼▼▼ YÊU CẦU 2: THÊM DÒNG GHI CHÚ ĐA NGÔN NGỮ ▼▼▼
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 26.0), // Căn lề với dấu tick
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Roboto'),
                    children: [
                      TextSpan(text: l10n.foreignTraderSupport.split('+84969.15.6969')[0]),
                      TextSpan(
                        text: '+84969.15.6969',
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final Uri url = Uri.parse('https://wa.me/84969156969');
                            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {}
                          },
                      ),
                      TextSpan(text: l10n.foreignTraderSupport.split('+84969.15.6969')[1]),
                    ],
                  ),
                ),
              ),
              // ▲▲▲ KẾT THÚC THÊM MỚI ▲▲▲
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      price,
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.amber),
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _buildActionButton(
                    text: l10n.startNow,
                    onPressed: onPressed,
                    isPrimary: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildActionButton(
    {required String text,
      required VoidCallback? onPressed,
      required bool isPrimary}) {
  final bool isEnabled = onPressed != null;
  return SizedBox(
    height: 45,
    width: 140,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        disabledBackgroundColor: Colors.grey.withOpacity(0.2),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: isEnabled && isPrimary
              ? const LinearGradient(
            colors: [Color(0xFF172AFE), Color(0xFF3C4BFE), Color(0xFF5E69FD)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
              : null,
          color: isEnabled && !isPrimary ? const Color(0xFF151a2e) : null,
          borderRadius: BorderRadius.circular(12),
          border: isEnabled && !isPrimary
              ? Border.all(color: Colors.blueAccent)
              : null,
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isEnabled ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    ),
  );
}