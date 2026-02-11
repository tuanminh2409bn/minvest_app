import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/services/purchase_service.dart';
import 'package:provider/provider.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  bool isMonthly = true;
  int selectedCategoryIndex = 0; // 0: GOLD, 1: FOREX, 2: CRYPTO

  final List<Map<String, String>> categories = [
    {'name': 'GOLD', 'price': '\$78'},
    {'name': 'FOREX', 'price': '\$78'},
    {'name': 'CRYPTO', 'price': '\$78'},
  ];

  final List<String> features = [
    'Entry, SL, TP included',
    'Detailed signal analysis',
    'Performance statistics',
    'Real-time email alerts',
    '24/7 market updates',
    'Best real-time signals',
  ];

  @override
  Widget build(BuildContext context) {
    final purchaseService = context.watch<PurchaseService>();
    final isPurchasing = purchaseService.isPurchasePending;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Upgrade To Pro',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Features List
                        ...features.map((feature) => _buildFeatureItem(feature)),
                        
                        const SizedBox(height: 40),
                        
                        // Plan Selector Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Choose Your Plan',
                              style: TextStyle(
                                color: Color(0xFF636363),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            _buildPlanToggle(),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Category Selection
                        ...List.generate(categories.length, (index) {
                          final price = isMonthly ? '\$78' : '\$460';
                          return _buildCategoryItem(
                            index,
                            categories[index]['name']!,
                            price,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                
                // Buy Now Button
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GestureDetector(
                    onTap: isPurchasing ? null : () => _handleBuyNow(context, purchaseService),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isPurchasing)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(color: Color(0xFF276EFB)),
            ),
          ),
      ],
    );
  }

  Future<void> _handleBuyNow(BuildContext context, PurchaseService purchaseService) async {
    final String productId;
    if (Platform.isIOS) {
      productId = isMonthly ? 'minvest.01' : 'minvest.12';
    } else {
      productId = isMonthly ? 'elite_1_month' : 'elite_12_months';
    }

    final product = purchaseService.products.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw Exception('Product not found'),
    );

    try {
      await purchaseService.buyProduct(product);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
            ),
            child: const Icon(
              Icons.check,
              color: Color(0xFF276EFB),
              size: 10,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanToggle() {
    return Container(
      width: 161,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: const Color(0xFF289EFF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isMonthly = true),
              child: Container(
                decoration: BoxDecoration(
                  gradient: isMonthly
                      ? const LinearGradient(colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)])
                      : null,
                  borderRadius: BorderRadius.circular(60),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Monthly',
                  style: TextStyle(
                    color: isMonthly ? Colors.white : const Color(0xFF636363),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isMonthly = false),
              child: Container(
                decoration: BoxDecoration(
                  gradient: !isMonthly
                      ? const LinearGradient(colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)])
                      : null,
                  borderRadius: BorderRadius.circular(60),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Annually',
                  style: TextStyle(
                    color: !isMonthly ? Colors.white : const Color(0xFF636363),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(int index, String name, String price) {
    final isSelected = selectedCategoryIndex == index;
    
    return GestureDetector(
      onTap: () => setState(() => selectedCategoryIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: isSelected
                ? [const Color(0xFF0CA3ED).withOpacity(0.3), const Color(0xFF276EFB).withOpacity(0.3)]
                : [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? const Color(0xFF289EFF) : Colors.white.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF289EFF) : const Color(0xFF636363),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFF289EFF),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Text(
                  'Upgrade To Pro',
                  style: TextStyle(
                    color: Color(0xFF636363),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              price,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
