import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/breakpoints.dart';

class PaymentMethodPage extends StatefulWidget {
  final double totalAmount;
  final List<String> selectedPlans;

  const PaymentMethodPage({
    super.key,
    required this.totalAmount,
    required this.selectedPlans,
  });

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? _selectedMethod;
  final String _usdtAddress = 'TLrcYm9p6qXG3T1pP9uG7s9uP9uG7s9uP9'; // Placeholder address

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;
    final isTablet = width < Breakpoints.desktop && width >= Breakpoints.tablet;
    final horizontalPadding = isMobile ? 16.0 : (isTablet ? 32.0 : 64.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: isMobile ? 24 : 80,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: _buildBackButton(context),
                            ),
                            const SizedBox(height: 48),
                            SizedBox(
                              width: 817,
                              child: Text(
                                'Please select your payment method',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 32 : 48,
                                  fontFamily: 'Be Vietnam Pro',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -2.40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            _buildPaymentMethods(isMobile),
                            if (_selectedMethod == 'usdt') ...[
                              const SizedBox(height: 64),
                              _buildUSDTDetail(isMobile),
                            ] else if (_selectedMethod == 'qr') ...[
                              const SizedBox(height: 64),
                              _buildBankQRDetail(isMobile),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            'Back',
            style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(bool isMobile) {
    final List<Widget> methods = [
      _paymentMethodCard(
        'Stripe Payment',
        'assets/images/stripe.png',
        fontSize: 18,
        letterSpacing: -0.90,
        isSelected: _selectedMethod == 'stripe',
        onTap: () => setState(() => _selectedMethod = 'stripe'),
      ),
      if (isMobile) const SizedBox(height: 16) else const SizedBox(width: 10),
      _paymentMethodCard(
        'USDT Wallet Address',
        'assets/images/usdt.png',
        fontSize: 16,
        letterSpacing: -0.80,
        isSelected: _selectedMethod == 'usdt',
        onTap: () => setState(() => _selectedMethod = 'usdt'),
      ),
      if (isMobile) const SizedBox(height: 16) else const SizedBox(width: 10),
      _paymentMethodCard(
        'QR Code ( Vietnamese only)',
        'assets/images/qr.png',
        fontSize: 18,
        letterSpacing: -0.90,
        isSelected: _selectedMethod == 'qr',
        onTap: () => setState(() => _selectedMethod = 'qr'),
      ),
    ];

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: methods,
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: methods.where((w) => w is! SizedBox).toList(),
    );
  }

  Widget _paymentMethodCard(
    String title,
    String imagePath, {
    required double fontSize,
    required double letterSpacing,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 296,
        height: 61,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: ShapeDecoration(
          color: const Color(0xFF111111),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected ? const Color(0xFF289EFF) : const Color(0xFF424242),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          shadows: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF289EFF).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 32),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontFamily: 'Be Vietnam Pro',
                  fontWeight: FontWeight.w600,
                  letterSpacing: letterSpacing,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUSDTDetail(bool isMobile) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF595959), width: 1),
          boxShadow: const [
            BoxShadow(color: Color(0x7FB49CFF), blurRadius: 12),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // USDT TRON Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: const Offset(0, 4), // Shift logo down slightly
                  child: Image.asset(
                    'assets/images/usdttron.png',
                    width: 45, // Enlarged logo
                    height: 45,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'USDT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24, // Slightly larger
                    fontFamily: 'Be Vietnam Pro',
                    fontWeight: FontWeight.w600,
                    height: 1.0, // Consistent text height
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  height: 20, // Matched height to align with text
                  decoration: BoxDecoration(
                    color: const Color(0xFF424242),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Center(
                    child: Text(
                      'TRON',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Be Vietnam Pro',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.60,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12), // Reduced spacing
            Image.asset(
              'assets/images/qrcodeusdt.png',
              width: 220,
              height: 220,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20), // Reduced spacing
            // Address Box styled after Figma
            Container(
              width: 620,
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: ShapeDecoration(
                color: const Color(0xFF111111),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF424242)),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _usdtAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'monospace',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Color(0xFF289EFF), size: 24),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _usdtAddress));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Address copied to clipboard')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Reduced spacing
            SizedBox(
              width: 477,
              child: Text(
                'After completing the payment, \nplease contact us via Whatsapp / Zalo (+84 0969 15 6969) for confirmation and signal usage.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Be Vietnam Pro',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.90,
                ),
              ),
            ),
            const SizedBox(height: 16), // Reduced spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialButton('assets/images/zalo.png', size: 40, url: 'https://zalo.me/84969156969'),
                const SizedBox(width: 6),
                _socialButton('assets/images/whatsapp.png', size: 55, url: 'https://wa.me/84969156969'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(String assetPath, {required double size, required String url}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () async {
          final Uri uri = Uri.parse(url);
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            debugPrint('Could not launch $uri');
          }
        },
        child: Image.asset(assetPath, width: size, height: size, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildBankQRDetail(bool isMobile) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF595959), width: 1),
          boxShadow: const [
            BoxShadow(color: Color(0x7FB49CFF), blurRadius: 12),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'SCAN QR CODE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Be Vietnam Pro',
                fontWeight: FontWeight.w600,
                letterSpacing: -1.20,
              ),
            ),
            const SizedBox(height: 12), // Reduced spacing
            Image.asset(
              'assets/images/qrcodenganhang.png',
              width: 350,
              height: 350,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20), // Reduced spacing
            SizedBox(
              width: 477,
              child: Text(
                'After completing the payment, \nplease contact us via Whatsapp / Zalo (+84 0969 15 6969) for confirmation and signal usage.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Be Vietnam Pro',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.90,
                ),
              ),
            ),
            const SizedBox(height: 16), // Reduced spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialButton('assets/images/zalo.png', size: 40, url: 'https://zalo.me/84969156969'),
                const SizedBox(width: 6),
                _socialButton('assets/images/whatsapp.png', size: 55, url: 'https://wa.me/84969156969'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
