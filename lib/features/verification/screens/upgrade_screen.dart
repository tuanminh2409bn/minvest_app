import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/services/purchase_service.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  bool isMonthly = true;
  int selectedCategoryIndex = 0; // 0: GOLD, 1: FOREX, 2: CRYPTO

  List<String> _getFeatures(AppLocalizations l10n) {
    return [
      l10n.includesEntrySlTp,
      l10n.detailedAnalysis,
      l10n.signalPerformanceStats,
      l10n.realTimeNotifications,
      l10n.continuouslyUpdating,
      l10n.providingBestSignals,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final purchaseService = context.watch<PurchaseService>();
    final isPurchasing = purchaseService.isPurchasePending;
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, String>> categories = [
      {'name': 'GOLD', 'price': isMonthly ? l10n.price1Month : l10n.price12Months},
      {'name': 'FOREX', 'price': isMonthly ? l10n.price1Month : l10n.price12Months},
      {'name': 'CRYPTO', 'price': isMonthly ? l10n.price1Month : l10n.price12Months},
    ];

    final features = _getFeatures(l10n);

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
            title: Text(
              l10n.upgradeAccount,
              style: const TextStyle(
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
                            Text(
                              l10n.choosePlanSubtitle,
                              style: const TextStyle(
                                color: Color(0xFF636363),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            _buildPlanToggle(l10n),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Category Selection
                        ...List.generate(categories.length, (index) {
                          return _buildCategoryItem(
                            index,
                            categories[index]['name']!,
                            categories[index]['price']!,
                            l10n,
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
                      child: Text(
                        l10n.upgradeNow,
                        style: const TextStyle(
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
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorWithMessage(e.toString()))),
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
          Expanded(child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPlanToggle(AppLocalizations l10n) {
    return Container(
      width: 180,
      height: 36,
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
                  l10n.monthly,
                  style: TextStyle(
                    color: isMonthly ? Colors.white : const Color(0xFF636363),
                    fontSize: 13,
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
                  l10n.annually,
                  style: TextStyle(
                    color: !isMonthly ? Colors.white : const Color(0xFF636363),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(int index, String name, String price, AppLocalizations l10n) {
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
                Text(
                  l10n.upgradeToSeeMore,
                  style: const TextStyle(
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
                fontSize: 16,
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
