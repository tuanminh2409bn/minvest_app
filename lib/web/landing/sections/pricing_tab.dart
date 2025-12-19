import 'package:flutter/material.dart';
import 'pricing_section.dart';

class PricingTab extends StatelessWidget {
  const PricingTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrapper for PricingSection to ensure consistency
    return const PricingSection();
  }
}
