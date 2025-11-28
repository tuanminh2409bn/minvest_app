import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../theme/text_styles.dart';

class HeroSignalsSection extends StatelessWidget {
  const HeroSignalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth.clamp(320.0, 560.0);
        return Center(
          child: Container(
            width: maxWidth,
            padding: const EdgeInsets.all(2),
        constraints: const BoxConstraints(minHeight: 480),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF04B3E9), Color(0xFFD500F9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: AppSpacing.md),
                  _buildTabs(),
                  const SizedBox(height: AppSpacing.md),
                  _SignalCard(
                    icon: Icons.currency_bitcoin,
                    iconColor: const Color(0xFF00B6FF),
                    pair: 'BTC',
                    date: 'June 1, 2025',
                    entry: '30',
                    sl: '3310',
                    tp1: '3330',
                    tp2: '3350',
                    badgeLabel: 'Sell Limit',
                    badgeGradient: const LinearGradient(
                      colors: [Color(0xFFFF00FF), Color(0xFF9B00FF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _SignalCard(
                    icon: Icons.auto_awesome, // sử dụng icon gần giống
                    iconColor: const Color(0xFF00B6FF),
                    pair: 'XAUUSD',
                    date: 'June 1, 2025',
                    entry: '30',
                    sl: '3310',
                    tp1: '3330',
                    tp2: '3350',
                    badgeLabel: 'Buy Limit',
                    badgeGradient: const LinearGradient(
                      colors: [Color(0xFF3DA1FF), Color(0xFF2C6BFF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'AI Signals',
        style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTabs() {
    Widget tab(String text, {bool active = false}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF2B2B2B) : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      );
    }

    return Row(
      children: [
        tab('Gold', active: true),
        const SizedBox(width: AppSpacing.sm),
        tab('Forex'),
        const SizedBox(width: AppSpacing.sm),
        tab('Crypto'),
      ],
    );
  }
}

class _SignalCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String pair;
  final String date;
  final String entry;
  final String sl;
  final String tp1;
  final String tp2;
  final String badgeLabel;
  final LinearGradient badgeGradient;

  const _SignalCard({
    required this.icon,
    required this.iconColor,
    required this.pair,
    required this.date,
    required this.entry,
    required this.sl,
    required this.tp1,
    required this.tp2,
    required this.badgeLabel,
    required this.badgeGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF303030)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF121212),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pair, style: AppTextStyles.h3.copyWith(fontSize: 22, color: Colors.white)),
                  Text(date, style: AppTextStyles.body.copyWith(color: Colors.white70, fontWeight: FontWeight.w600)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  gradient: badgeGradient,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                  badgeLabel,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line('Entry: $entry'),
                  _line('SL : $sl'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line('TP1: $tp1'),
                  _line('TP2 : $tp2'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _line(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: AppTextStyles.h3.copyWith(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
