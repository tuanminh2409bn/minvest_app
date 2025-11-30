import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../theme/text_styles.dart';

class WinMoreSection extends StatefulWidget {
  const WinMoreSection({super.key});

  @override
  State<WinMoreSection> createState() => _WinMoreSectionState();
}

class _WinMoreSectionState extends State<WinMoreSection> {
  int hoveredIndex = -1;

  final List<_CardData> cards = const [
    _CardData(image: 'assets/mockups/card1.png', rotation: -2),
    _CardData(image: 'assets/mockups/card2.png', rotation: 1),
    _CardData(image: 'assets/mockups/card3.png', rotation: -3),
    _CardData(image: 'assets/mockups/card4.png', rotation: -5),
    _CardData(image: 'assets/mockups/card5.png', rotation: -10),
    _CardData(image: 'assets/mockups/card6.png', rotation: -8),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Text(
            'Win More with AI-Powered Signals\nin Every Market',
            style: AppTextStyles.h1.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 640,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Glow image behind phone and cards
                Positioned.fill(
                  child: IgnorePointer(
                    child: Transform.scale(
                      scaleX: 4.0,
                      scaleY: 1.0,
                      child: Opacity(
                        opacity: 0.85,
                        child: Image.asset(
                          'assets/mockups/light.png',
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
                // Left cards (indices 0,1,2) thò ra ngoài nhiều
                Positioned(
                  left: -220,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _floatingCard(0, offsetY: -60),
                      const SizedBox(height: 16),
                      _floatingCard(1, offsetY: 0),
                      const SizedBox(height: 16),
                      _floatingCard(2, offsetY: 40),
                    ],
                  ),
                ),
                // Right cards (indices 3,4,5) thò ra ngoài nhiều
                Positioned(
                  right: -220,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _floatingCard(3, offsetY: -40),
                      const SizedBox(height: 16),
                      _floatingCard(4, offsetY: 10),
                      const SizedBox(height: 16),
                      _floatingCard(5, offsetY: 50),
                    ],
                  ),
                ),
                // Phone frame + custom screen
                SizedBox(
                  width: 320,
                  height: 640,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/mockups/iPhone16.png', fit: BoxFit.contain),
                      Positioned.fill(
                        left: 13,
                        right: 13,
                        top: 38,
                        bottom: 26,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                            bottomLeft: Radius.circular(26),
                            bottomRight: Radius.circular(26),
                          ),
                          child: const _PhoneScreen(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Our multi-market AI scans Forex, Crypto, and Metals in real-time,\n'
            'delivering expert-validated trading signals —\n'
            'with clear entry, stop-loss, and take-profit levels.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(1.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF00BFFF), Color(0xFFD500F9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: Text(
                'Get Signals now',
                style: AppTextStyles.h3.copyWith(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingCard(int index, {double offsetY = 0}) {
    final data = cards[index];
    final isHovered = hoveredIndex == index;
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? offsetY - 12 : offsetY)
          ..rotateZ(data.rotation * 3.1416 / 180),
        child: Image.asset(
          data.image,
          width: 320,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _CardData {
  final String image;
  final double rotation;
  const _CardData({required this.image, required this.rotation});
}

class _PhoneScreen extends StatelessWidget {
  final List<_SignalRowData> rows = const [
    _SignalRowData(icon: Icons.water_drop, pair: 'WTI', side: 'Buy limit'),
    _SignalRowData(icon: Icons.currency_bitcoin, pair: 'XAU/USD', side: 'Sell limit'),
    _SignalRowData(icon: Icons.currency_exchange, pair: 'DXY/USDT', side: 'Buy limit'),
    _SignalRowData(icon: Icons.account_balance, pair: 'XAU/USD', side: 'Sell limit'),
    _SignalRowData(icon: Icons.euro, pair: 'EUR/USD', side: 'Buy limit'),
    _SignalRowData(icon: Icons.currency_bitcoin, pair: 'BTC/USDT', side: 'Sell limit'),
  ];

  const _PhoneScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('9:41', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 12)),
                const Spacer(),
                const Icon(Icons.wifi, size: 14, color: Colors.white),
                const SizedBox(width: 6),
                const Icon(Icons.battery_full, size: 14, color: Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            const Icon(Icons.arrow_back, color: Colors.white, size: 16),
            const SizedBox(height: 10),
            Text('AI Signals', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _chip('Gold', true),
                  const SizedBox(width: 6),
                  _chip('Forex', false),
                  const SizedBox(width: 6),
                  _chip('Crypto', false),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: rows.length,
                itemBuilder: (context, index) {
                  final r = rows[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF242424)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Icon(r.icon, color: const Color(0xFF00A7FF), size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r.pair, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                                Text('Update: dd/mm/yyyy', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 10)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            r.side,
                            style: AppTextStyles.body.copyWith(
                              color: r.side.toLowerCase().contains('buy') ? Colors.greenAccent : Colors.redAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2D2D2D) : const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SignalRowData {
  final IconData icon;
  final String pair;
  final String side;
  const _SignalRowData({required this.icon, required this.pair, required this.side});
}
