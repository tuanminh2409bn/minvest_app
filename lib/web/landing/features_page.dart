import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:minvest_forex_app/web/theme/colors.dart';
import 'package:minvest_forex_app/web/theme/spacing.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/landing/sections/footer_section.dart';
import 'package:minvest_forex_app/web/theme/gradients.dart';
import 'package:minvest_forex_app/web/chat/web_chat_bubble.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';
import 'package:minvest_forex_app/web/widgets/signal_history_table.dart';
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minvest_forex_app/web/widgets/landing_background.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: isMobile ? const TextScaler.linear(0.72) : const TextScaler.linear(1.0),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        floatingActionButton: const WebChatBubble(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const _ContentWrapper(child: LandingNavBar()),
              const SizedBox(height: 24),
              const WinMoreSection(),
              SizedBox(height: isMobile ? 48 : 96),
              const _ContentWrapper(child: SmartToolsSection()),
              SizedBox(height: isMobile ? 48 : 96),
              const _ContentWrapper(child: YourOnDemandSection()),
              SizedBox(height: isMobile ? 48 : 96),
              const _ContentWrapper(child: MaximizeResultsSection()),
              SizedBox(height: isMobile ? 24 : 48),
              const _ContentWrapper(child: FooterSection()),
            ],
          ),
        ),
      ),
    );
  }
}

class WinMoreSection extends StatefulWidget {
  const WinMoreSection({super.key});

  @override
  State<WinMoreSection> createState() => _WinMoreSectionState();
}

class _WinMoreSectionState extends State<WinMoreSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          _ContentWrapper(
            child: Text(
              AppLocalizations.of(context)!.winMoreWithAiSignalsTitle,
              style: AppTextStyles.h2.copyWith(fontSize: 36),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          LandingBackgroundWrapper(
            paddingTop: 0,
            offsetAdjustment: 160,
            child: _PhoneMockup(
              onHoverStart: (index) {},
              onHoverEnd: (index) {},
            ),
          ),
          const SizedBox(height: 120), // Tăng khoảng cách đẩy text/button xuống
          _ContentWrapper(
            child: Text(
              AppLocalizations.of(context)!.winMoreWithAiSignalsDesc,
              style: AppTextStyles.body.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _ContentWrapper(
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.of(context).pushNamed('/ai-signals');
                  } else {
                    Navigator.of(context).pushNamed('/signup');
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(1.2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.startNow,
                      style: AppTextStyles.h3.copyWith(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _PhoneMockup extends StatelessWidget {
  final void Function(int index) onHoverStart;
  final void Function(int index) onHoverEnd;
  const _PhoneMockup({super.key, required this.onHoverStart, required this.onHoverEnd});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final bool isMobileLayout = maxW < 900;
        
        // Desktop: 320px width, 2.05 ratio
        // Mobile: 260px width (tối đa), 2.0 ratio (bớt dài)
        final double width = isMobileLayout ? math.min(maxW * 0.8, 260.0) : 320.0;
        final double height = isMobileLayout ? width * 2.0 : width * 2.05;

        return Center(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.15),
              // Gradient viền kim loại (Titanium)
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF666666), // Xám sáng
                  Color(0xFF2a2a2a), // Xám tối
                  Color(0xFF888888), // Điểm sáng
                  Color(0xFF1a1a1a), // Tối
                ],
                stops: [0.1, 0.4, 0.6, 0.9],
              ),
              boxShadow: [
                 BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 50,
                  offset: const Offset(0, 30),
                  spreadRadius: -10,
                ),
              ],
            ),
            // Padding tạo độ dày viền kim loại
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black, // Viền đen (Bezel)
                  borderRadius: BorderRadius.circular(width * 0.14),
                ),
                padding: EdgeInsets.all(isMobileLayout ? 8.0 : 10.0), // Độ dày Bezel
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width * 0.11),
                  child: Stack(
                    children: [
                      // Nội dung màn hình
                      Positioned.fill(
                        child: _PhoneScreen(
                          onHoverStart: onHoverStart,
                          onHoverEnd: onHoverEnd,
                        ),
                      ),
                      // Dynamic Island
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: isMobileLayout ? 8 : 10),
                          width: width * 0.3,
                          height: width * 0.08,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
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
      },
    );
  }
}

// _PhoneFrame và _PhoneScreenHolder đã được loại bỏ để dùng khung tự vẽ.


class _PhoneScreen extends StatelessWidget {
  final void Function(int index) onHoverStart;
  final void Function(int index) onHoverEnd;

  const _PhoneScreen({required this.onHoverStart, required this.onHoverEnd});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final bool isMobileLayout = w < 280; // Chiều rộng bên trong màn hình điện thoại giả lập

        final horizontalPad = w * 0.06; 
        final topPad = w * 0.05;

        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F0F0F),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(horizontalPad, topPad, horizontalPad, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Bar
                SizedBox(
                  height: w * 0.12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, top: 4.0),
                        child: Text('9:41', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: isMobileLayout ? 11 : 13, fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0, top: 6.0),
                        child: Row(
                          children: [
                            Icon(Icons.signal_cellular_alt, size: isMobileLayout ? 10 : 14, color: Colors.white),
                            const SizedBox(width: 4),
                            Icon(Icons.wifi, size: isMobileLayout ? 10 : 14, color: Colors.white),
                            const SizedBox(width: 4),
                            Icon(Icons.battery_full, size: isMobileLayout ? 10 : 14, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: w * 0.05), 
                Icon(Icons.arrow_back, color: Colors.white, size: isMobileLayout ? 18 : 20),
                SizedBox(height: w * 0.04),
                Text('AI Signals', style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: isMobileLayout ? 20 : 22, fontWeight: FontWeight.bold)),
                SizedBox(height: w * 0.05),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _chip('Gold', true, isMobileLayout),
                      const SizedBox(width: 8),
                      _chip('Forex', false, isMobileLayout),
                      const SizedBox(width: 8),
                      _chip('Crypto', false, isMobileLayout),
                    ],
                  ),
                ),
                SizedBox(height: w * 0.05),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _InteractivePhoneRow(
                          initialIndex: index,
                          onHoverChange: (isHovering) {
                            if (isHovering) {
                              onHoverStart(index);
                            } else {
                              onHoverEnd(index);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _chip(String text, bool active, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F), // Màu nền trùng màn hình
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white24, width: 1), // Viền mỏng
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white,
          fontSize: isMobile ? 9 : 10,
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

const List<_SignalRowData> _phoneDataPool = [
  _SignalRowData(icon: Icons.water_drop, pair: 'WTI', side: 'Buy Limit'),
  _SignalRowData(icon: Icons.currency_bitcoin, pair: 'XAU/USD', side: 'Sell Limit'),
  _SignalRowData(icon: Icons.currency_exchange, pair: 'DXY/USDT', side: 'Buy Limit'),
  _SignalRowData(icon: Icons.account_balance, pair: 'US30', side: 'Sell Limit'),
  _SignalRowData(icon: Icons.euro, pair: 'EUR/USD', side: 'Buy Limit'),
  _SignalRowData(icon: Icons.currency_bitcoin, pair: 'BTC/USDT', side: 'Sell Limit'),
  _SignalRowData(icon: Icons.currency_pound, pair: 'GBP/JPY', side: 'Buy Limit'),
  _SignalRowData(icon: Icons.show_chart, pair: 'NAS100', side: 'Sell Limit'),
  _SignalRowData(icon: Icons.token, pair: 'ETH/USD', side: 'Buy Limit'),
  _SignalRowData(icon: Icons.candlestick_chart, pair: 'AUD/CAD', side: 'Sell Limit'),
];

class _InteractivePhoneRow extends StatefulWidget {
  final int initialIndex;
  final Function(bool) onHoverChange;

  const _InteractivePhoneRow({
    required this.initialIndex,
    required this.onHoverChange,
  });

  @override
  State<_InteractivePhoneRow> createState() => _InteractivePhoneRowState();
}

class _InteractivePhoneRowState extends State<_InteractivePhoneRow> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late int _currentIndex;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex % _phoneDataPool.length;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _cycleData() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _phoneDataPool.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = _phoneDataPool[_currentIndex];
    
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final bool isMobile = w < 250;

      return MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          widget.onHoverChange(true);
          _controller.forward();
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          widget.onHoverChange(false);
          _controller.reverse();
        },
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _cycleData,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
                    border: Border.all(
                      color: _isHovered ? const Color(0xFF289EFF) : const Color(0xFF242424),
                      width: _isHovered ? 1.5 : 1.0,
                    ),
                    boxShadow: _isHovered ? [
                      BoxShadow(
                        color: const Color(0xFF289EFF).withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ] : [],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 10, vertical: isMobile ? 8 : 10),
                  child: Row(
                    children: [
                      Icon(data.icon, color: const Color(0xFF00A7FF), size: isMobile ? 16 : 18),
                      SizedBox(width: isMobile ? 8 : 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.pair, 
                              style: AppTextStyles.body.copyWith(
                                color: Colors.white, 
                                fontSize: isMobile ? 11 : 13, 
                                fontWeight: FontWeight.w700
                              )
                            ),
                            Text(
                              'Update: dd/mm/yyyy', 
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.white70, 
                                fontSize: isMobile ? 8 : 10
                              )
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        data.side,
                        style: AppTextStyles.body.copyWith(
                          color: data.side.toLowerCase().contains('buy') ? Colors.greenAccent : Colors.redAccent,
                          fontSize: isMobile ? 11 : 13,
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
      );
    });
  }
}

class _ToolbarShimmer extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  const _ToolbarShimmer({required this.child, this.borderRadius = 12});

  @override
  State<_ToolbarShimmer> createState() => _ToolbarShimmerState();
}

class _ToolbarShimmerState extends State<_ToolbarShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.repeat(reverse: true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.stop();
        _controller.reset();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            foregroundDecoration: _isHovered
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.blue.withOpacity(0.2), // Xanh dương nhẹ
                        Colors.transparent,
                      ],
                      stops: [
                        _controller.value - 0.3,
                        _controller.value,
                        _controller.value + 0.3,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  )
                : null,
            child: widget.child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

class SmartToolsSection extends StatefulWidget {
  const SmartToolsSection({super.key});

  @override
  State<SmartToolsSection> createState() => _SmartToolsSectionState();
}

class _SmartToolsSectionState extends State<SmartToolsSection> with SingleTickerProviderStateMixin {
  bool _isFlipped = false;
  bool _isOuterToolbarHovered = false;
  bool _isInnerToolbarHovered = false; // Add inner toolbar hover state
  int _pageIndex = 0;
  late AnimationController _flipController;
  late Animation<double> _frontAnimation;
  late Animation<double> _backAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    
    // Create sequence for front side: 0 -> 90 degrees (disappear)
    _frontAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -math.pi / 2), weight: 50),
      TweenSequenceItem(tween: ConstantTween(-math.pi / 2), weight: 50),
    ]).animate(CurvedAnimation(parent: _flipController, curve: Curves.easeInOut));

    // Create sequence for back side: -90 degrees -> 0 (appear)
    _backAnimation = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(math.pi / 2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: math.pi / 2, end: 0.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _flipController, curve: Curves.easeInOut));
  }

  HistoryRow _mapSignalToRow(Signal s) {
    DateTime created = s.createdAt is Timestamp ? (s.createdAt as Timestamp).toDate() : DateTime.now();
    // Default to GMT+7 for display consistency in this section
    created = created.toUtc().add(const Duration(hours: 7));

    final dateStr = DateFormat('dd/MM/yyyy').format(created);
    final timeStr = DateFormat('HH:mm').format(created);
    final parts = s.symbol.split('/');
    final asset = parts.isNotEmpty ? (parts.first.toUpperCase() == 'XAU' ? 'GOLD' : parts.first.toUpperCase()) : s.symbol;
    final order = s.type.toUpperCase();
    final status = (s.result ?? s.status).toString();
    final pips = s.pips != null ? (s.pips! >= 0 ? '+${s.pips}' : s.pips.toString()) : '-';

    String _fmt(num? v) {
      if (v == null) return '-';
      if (v >= 1000) return v.toStringAsFixed(2);
      if (v >= 100) return v.toStringAsFixed(3);
      if (v >= 10) return v.toStringAsFixed(4);
      return v.toStringAsFixed(5);
    }

    String _tp(int idx) {
      if (s.takeProfits.length > idx) {
        final v = s.takeProfits[idx];
        if (v is num) return _fmt(v);
        if (v is String) return v;
      }
      return '-';
    }

    return HistoryRow(
      originalSignal: s,
      date: dateStr,
      time: timeStr,
      asset: asset,
      order: order,
      status: status,
      pips: pips,
      entry: _fmt(s.entryPrice),
      closedPrice: _fmt(s.closedPrice),
      sl: _fmt(s.stopLoss),
      tp1: _tp(0),
      tp2: _tp(1),
      tp3: _tp(2),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
      if (_isFlipped) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.smarterToolsTitle,
            style: AppTextStyles.h1.copyWith(fontSize: 36),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            AppLocalizations.of(context)!.smarterToolsDesc,
            style: AppTextStyles.body.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          
          // Flip Container
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _toggleFlip,
              child: Stack(
                children: [
                  // Front Side
                  AnimatedBuilder(
                    animation: _frontAnimation,
                    builder: (context, child) {
                      final angle = _frontAnimation.value;
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(angle),
                        alignment: Alignment.center,
                        child: angle < -math.pi / 2 + 0.01 ? const SizedBox.shrink() : _buildFrontSide(context),
                      );
                    },
                  ),
                  // Back Side
                  AnimatedBuilder(
                    animation: _backAnimation,
                    builder: (context, child) {
                      final angle = _backAnimation.value;
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(angle),
                        alignment: Alignment.center,
                        child: angle > math.pi / 2 - 0.01 ? const SizedBox.shrink() : _buildBackSide(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontSide(BuildContext context) {
    // Dịch chuyển nội dung khi hover thanh trên
    final double translationY = _isOuterToolbarHovered ? 12.0 : 0.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 120), // Responsive padding
          child: MouseRegion(
            onEnter: (_) => setState(() => _isOuterToolbarHovered = true),
            onExit: (_) => setState(() => _isOuterToolbarHovered = false),
            cursor: SystemMouseCursors.click,
            child: _ToolbarShimmer(
              borderRadius: 12,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 44,
                decoration: BoxDecoration(
                  gradient: _isOuterToolbarHovered
                      ? const LinearGradient(
                          colors: [Color(0xFF0C132A), Color(0xFF0A0E1F)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  color: _isOuterToolbarHovered ? null : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  border: Border.all(color: Colors.white12), // Thêm viền mỏng
                  boxShadow: _isOuterToolbarHovered
                      ? [BoxShadow(color: Colors.blue.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 4))]
                      : [],
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: const [
                    Icon(Icons.circle, size: 8, color: Colors.white24),
                    SizedBox(width: 6),
                    Icon(Icons.circle, size: 8, color: Colors.white24),
                    SizedBox(width: 6),
                    Icon(Icons.circle, size: 8, color: Colors.white24),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, translationY, 0),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MouseRegion(
                onEnter: (_) => setState(() => _isInnerToolbarHovered = true),
                onExit: (_) => setState(() => _isInnerToolbarHovered = false),
                child: _ToolbarShimmer(
                  borderRadius: 10,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: _isInnerToolbarHovered
                          ? const LinearGradient(
                              colors: [Color(0xFF0C132A), Color(0xFF0A0E1F)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      color: _isInnerToolbarHovered ? null : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.circle, size: 10, color: Colors.white30),
                        SizedBox(width: 8),
                        Icon(Icons.circle, size: 10, color: Colors.white30),
                        SizedBox(width: 8),
                        Icon(Icons.circle, size: 10, color: Colors.white30),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 1, color: Colors.white12),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.performanceOverviewTitle,
                      style: AppTextStyles.h3.copyWith(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      AppLocalizations.of(context)!.performanceOverviewDesc,
                      style: AppTextStyles.body.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isNarrow = constraints.maxWidth < 900;
                        if (isNarrow) {
                          return Column(
                            children: [
                              _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.totalProfit,
                                value: '9,250.8 pips',
                              ),
                              const SizedBox(height: 12),
                              _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.completionSignal,
                                value: '507',
                              ),
                              const SizedBox(height: 12),
                              _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.winRate,
                                value: '62.7%',
                              ),
                              const SizedBox(height: 12),
                              const _AnimatedStatCard(
                                title: 'Active Member',
                                value: '+10,566',
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.totalProfit,
                                value: '9,250.8 pips',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.completionSignal,
                                value: '507',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.winRate,
                                value: '62.7%',
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: _AnimatedStatCard(
                                title: 'Active Member',
                                value: '+10,566',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackSide(BuildContext context) {
    // Reusing the same container style but showing history table
    return Column(
      children: [
        _ToolbarShimmer(
          borderRadius: 12,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0C132A), Color(0xFF0A0E1F)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 10, color: Colors.white24),
                const SizedBox(width: 8),
                const Icon(Icons.circle, size: 10, color: Colors.white24),
                const SizedBox(width: 8),
                const Icon(Icons.circle, size: 10, color: Colors.white24),
                const Spacer(),
                Text(
                  'Signal History',
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: StreamBuilder<List<Signal>>(
              stream: SignalService().getSignals(isLive: false, userTier: 'web', allowUnauthenticated: true, limit: 50),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
                }
                final allSignals = snapshot.data ?? [];
                if (allSignals.isEmpty) {
                  return const Center(child: Text('No history available', style: TextStyle(color: Colors.white70)));
                }

                // Pagination Logic
                const pageSize = 10;
                final totalItems = allSignals.length;
                final totalPages = (totalItems / pageSize).ceil();

                // Ensure pageIndex is valid
                if (_pageIndex >= totalPages) _pageIndex = 0;

                final start = _pageIndex * pageSize;
                final displayedSignals = allSignals.skip(start).take(pageSize).toList();

                final rows = displayedSignals.map(_mapSignalToRow).toList();

                return Column(
                  children: [
                    SignalHistoryTable(rows: rows),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left, color: Colors.white),
                          onPressed: _pageIndex > 0 ? () {
                            setState(() {
                              _pageIndex--;
                            });
                          } : null,
                          disabledColor: Colors.white24,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${_pageIndex + 1} / $totalPages',
                          style: AppTextStyles.body.copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: Colors.white),
                          onPressed: _pageIndex < totalPages - 1 ? () {
                            setState(() {
                              _pageIndex++;
                            });
                          } : null,
                          disabledColor: Colors.white24,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedStatCard extends StatefulWidget {

  final String title;

  final String value;

  const _AnimatedStatCard({required this.title, required this.value});



  @override

  State<_AnimatedStatCard> createState() => _AnimatedStatCardState();

}



class _AnimatedStatCardState extends State<_AnimatedStatCard> with SingleTickerProviderStateMixin {

  bool _isHovered = false;

  late AnimationController _shimmerController;



  @override

  void initState() {

    super.initState();

    _shimmerController = AnimationController(

      vsync: this,

      duration: const Duration(milliseconds: 600),

    );

  }



  @override

  void dispose() {

    _shimmerController.dispose();

    super.dispose();

  }



  @override

  Widget build(BuildContext context) {

    return MouseRegion(

      onEnter: (_) {

        setState(() => _isHovered = true);

        _shimmerController.forward();

      },

      onExit: (_) {

        setState(() => _isHovered = false);

        _shimmerController.reverse();

      },

      child: AnimatedBuilder(

        animation: _shimmerController,

        builder: (context, child) {

          return AnimatedScale(

            scale: _isHovered ? 1.05 : 1.0,

            duration: const Duration(milliseconds: 200),

            curve: Curves.easeOut,

            child: Container(

              width: double.infinity,

              padding: const EdgeInsets.all(1.5),

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10),

                gradient: const LinearGradient(

                  colors: [Color(0xFF00BFFF), Color(0xFF7B61FF), Color(0xFFD500F9)],

                  begin: Alignment.topLeft,

                  end: Alignment.bottomRight,

                ),

                boxShadow: [

                  BoxShadow(

                    color: const Color(0xFF00BFFF).withOpacity(_isHovered ? 0.5 : 0.15),

                    blurRadius: _isHovered ? 20 : 10,

                    spreadRadius: _isHovered ? 2 : 0,

                  ),

                ],

              ),

              child: Container(

                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

                decoration: BoxDecoration(

                  color: Colors.black,

                  borderRadius: BorderRadius.circular(8),

                ),

                                foregroundDecoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(8),

                                  gradient: LinearGradient(

                                    colors: [

                                      Colors.transparent,

                                      const Color(0xFF00BFFF).withOpacity(0.3), // Ánh sáng xanh lướt qua

                                      Colors.transparent,

                                    ],

                                    // Mở rộng stops để vệt sáng lan tỏa rộng hơn

                                    stops: [

                                      (_shimmerController.value * 3.0) - 1.5,

                                      (_shimmerController.value * 3.0) - 1.0,

                                      (_shimmerController.value * 3.0) - 0.5,

                                    ],

                                    begin: const Alignment(-1.0, -0.3),

                                    end: const Alignment(1.0, 0.3),

                                  ),

                                ),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(widget.title, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),

                    const SizedBox(height: 10),

                    Text(

                      widget.value,

                      style: AppTextStyles.h1.copyWith(fontSize: 26, fontWeight: FontWeight.w700, color: const Color(0xFF00BFFF)),

                    ),

                  ],

                ),

              ),

            ),

          );

        },

      ),

    );

  }

}

class YourOnDemandSection extends StatelessWidget {
  const YourOnDemandSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return Column(
      children: [
        SizedBox(height: isMobile ? 0 : 48),
        Column(
          children: [
            Text(
              AppLocalizations.of(context)!.onDemandFinancialExpertTitle,
              style: AppTextStyles.h1.copyWith(fontSize: 36),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              AppLocalizations.of(context)!.onDemandFinancialExpertDesc,
              style: AppTextStyles.body.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(height: isMobile ? 60 : 250), // Tăng khoảng cách lên 250
        const _LaptopShowcase(),
      ],
    );
  }
}

class _LaptopShowcase extends StatelessWidget {
  const _LaptopShowcase();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: LayoutBuilder(
      builder: (context, constraints) {
        final double maxW = constraints.maxWidth;
        final bool isNarrow = maxW < 900;
        // Desktop: Tăng lên 1350. Mobile: Tăng kích thước lên 0.95
        final double laptopWidth = isNarrow ? maxW * 0.95 : 1350;
        final double height = isNarrow ? maxW * 0.65 : 780; // Tăng nhẹ height container
        final double offsetY = isNarrow ? 0 : -30;

        if (isNarrow) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    _LaptopGlow(isNarrow: isNarrow, screenWidth: maxW),
                    _LaptopImage(width: laptopWidth, offsetY: offsetY),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _LaptopCardsInline(maxWidth: maxW),
            ],
          );
        }

        return SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              _LaptopGlow(isNarrow: isNarrow, screenWidth: maxW),
              _LaptopImage(width: laptopWidth, offsetY: offsetY),
              _LaptopCards(availableWidth: laptopWidth),
            ],
          ),
        );
      },
    ));
  }
}

class _LaptopGlow extends StatelessWidget {
  final bool isNarrow;
  final double screenWidth;
  const _LaptopGlow({required this.isNarrow, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    // Desktop (Original values)
    double top = -400;
    double containerWidth = 1000;
    double glowSize = 500;
    double glowOffsetWidth = 600;
    double blur = 800;
    double spread = 50;

    // Mobile (Adjusted for focus)
    if (isNarrow) {
      top = -20; // Hạ quầng sáng xuống thấp hơn nữa
      containerWidth = screenWidth;
      glowSize = screenWidth * 0.8;
      glowOffsetWidth = screenWidth * 0.7; // Tăng width để hai nguồn sáng giao thoa mạnh ở giữa
      blur = 300;
      spread = 10;
    }

    return Positioned.fill(
      top: top,
      bottom: 100,
      child: Center(
        child: SizedBox(
          width: containerWidth,
          child: Stack(
            children: [
              // Nguồn sáng Xanh (Bên Trái)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: glowOffsetWidth,
                child: Center(
                  child: Container(
                    width: glowSize,
                    height: glowSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF2E60FF).withOpacity(0.5),
                          const Color(0xFF2E60FF).withOpacity(0.2),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E60FF).withOpacity(0.4),
                          blurRadius: blur,
                          spreadRadius: spread,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Nguồn sáng Hồng/Tím (Bên Phải)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: glowOffsetWidth,
                child: Center(
                  child: Container(
                    width: glowSize,
                    height: glowSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFBF4ED2).withOpacity(0.5),
                          const Color(0xFFBF4ED2).withOpacity(0.2),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFBF4ED2).withOpacity(0.4),
                          blurRadius: blur,
                          spreadRadius: spread,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LaptopImage extends StatelessWidget {
  final double width;
  final double offsetY;
  const _LaptopImage({required this.width, required this.offsetY});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Transform.translate(
        offset: Offset(0, offsetY),
        child: SizedBox(
          width: width,
          child: Image.asset(
            'assets/mockups/laptop.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _LaptopCards extends StatelessWidget {
  final double availableWidth;
  const _LaptopCards({required this.availableWidth});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isNarrow = constraints.maxWidth < 900;
          final double baseW = constraints.maxWidth;
          // Tăng kích thước thẻ trên Desktop
          final double cardWidth = isNarrow ? baseW * 0.6 : 500;
          final double cardHeight = isNarrow ? 72 : 130;

          if (isNarrow) {
            return Column(
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _InteractiveInfoCard(
                    text: AppLocalizations.of(context)!.aiPoweredSignalPlatform,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: cardWidth,
                  child: _InteractiveInfoCard(
                    text: AppLocalizations.of(context)!.selfLearningSystems,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: cardWidth,
                  child: _InteractiveInfoCard(
                    text: AppLocalizations.of(context)!.emotionlessExecution,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: cardWidth,
                  child: _InteractiveInfoCard(
                    text: AppLocalizations.of(context)!.analysingMarket247,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              Row(
                children: [
                  _InteractiveInfoCard(text: AppLocalizations.of(context)!.aiPoweredSignalPlatform, width: cardWidth, height: cardHeight),
                  SizedBox(width: 16),
                  _InteractiveInfoCard(text: AppLocalizations.of(context)!.selfLearningSystems, width: cardWidth, height: cardHeight),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _InteractiveInfoCard(text: AppLocalizations.of(context)!.emotionlessExecution, width: cardWidth, height: cardHeight),
                  SizedBox(width: 16),
                  _InteractiveInfoCard(text: AppLocalizations.of(context)!.analysingMarket247, width: cardWidth, height: cardHeight),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LaptopCardsInline extends StatelessWidget {
  final double maxWidth;
  const _LaptopCardsInline({required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    final double cardWidth = maxWidth * 0.8;
    const double cardHeight = 90; // Tăng chiều cao lên 90
    return Column(
      children: [
        SizedBox(
          width: cardWidth,
          child: _InteractiveInfoCard(
            text: AppLocalizations.of(context)!.aiPoweredSignalPlatform,
            width: cardWidth,
            height: cardHeight,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: cardWidth,
          child: _InteractiveInfoCard(
            text: AppLocalizations.of(context)!.selfLearningSystems,
            width: cardWidth,
            height: cardHeight,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: cardWidth,
          child: _InteractiveInfoCard(
            text: AppLocalizations.of(context)!.emotionlessExecution,
            width: cardWidth,
            height: cardHeight,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: cardWidth,
          child: _InteractiveInfoCard(
            text: AppLocalizations.of(context)!.analysingMarket247,
            width: cardWidth,
            height: cardHeight,
          ),
        ),
      ],
    );
  }
}

class _InteractiveInfoCard extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  const _InteractiveInfoCard({
    required this.text,
    this.width = 440,
    this.height = 108,
  });

  @override
  State<_InteractiveInfoCard> createState() => _InteractiveInfoCardState();
}

class _InteractiveInfoCardState extends State<_InteractiveInfoCard> with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _shake() {
    _shakeController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _shake,
      child: AnimatedBuilder(
        animation: _shakeController,
        builder: (context, child) {
          final t = _shakeController.value;
          // Hiệu ứng lắc tắt dần: sin(t * pi * 4) * biên_độ * (1 - t)
          final dx = math.sin(t * math.pi * 4) * 8 * (1 - t);
          
          return Transform.translate(
            offset: Offset(dx, 0),
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00BFFF), Color(0xFF7B61FF), Color(0xFFD500F9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00BFFF).withOpacity(0.15),
                    blurRadius: 18,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Center(
                  child: Text(
                    widget.text,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MaximizeResultsSection extends StatelessWidget {
  const MaximizeResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.maximizeResultsFeaturesTitle,
            style: AppTextStyles.h1.copyWith(fontSize: 36),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            AppLocalizations.of(context)!.minvestAiRegistrationDesc,
            style: AppTextStyles.body.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          _ctaButton(),
        ],
      ),
    );
  }

  Widget _ctaButton() {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.of(context).pushNamed('/ai-signals');
          } else {
            Navigator.of(context).pushNamed('/signup');
          }
        },
        child: Container(
          padding: const EdgeInsets.all(1.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
            ),
            child: Text(
              AppLocalizations.of(context)!.startNow,
              style: AppTextStyles.h3.copyWith(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContentWrapper extends StatelessWidget {
  final Widget child;
  const _ContentWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: child,
        ),
      ),
    );
  }
}