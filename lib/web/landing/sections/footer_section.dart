import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../theme/text_styles.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/mockups/logo.png', height: 64),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Enterprise code: 0107136243 is issued by the Hanoi Department of Finance on 24/11/2015; 6th amendment registered by the Hanoi Department of Finance on 05/08/2025.',
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Address: C2810, 18th Floor, C2 Building, HH Lot, Dong Nam Urban Area, Tran Duy Hung St., Yen Hoa Ward, Hanoi, Vietnam.)',
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pages', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: AppSpacing.sm),
                _link('AI Signals'),
                _link('Features'),
                _link('News'),
                _link('Contact Us'),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Legal & Regulatory', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: AppSpacing.sm),
                _link('Terms Of Registration'),
                _link('Operating Principles'),
                _link('Terms & Conditions'),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text('+84 969 15 6969', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(Icons.email, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text('email@gmail.com', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: List.generate(
                    6,
                    (_) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.circle,
                        ),
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

  Widget _link(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
