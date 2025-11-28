import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class FaqTile extends StatelessWidget {
  final String question;
  const FaqTile({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Expanded(child: Text(question, style: AppTextStyles.body.copyWith(color: Colors.white))),
          const Icon(Icons.add, color: Colors.white54, size: 16),
        ],
      ),
    );
  }
}
