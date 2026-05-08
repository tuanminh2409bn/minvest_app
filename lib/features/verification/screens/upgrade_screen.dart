import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/services/purchase_service.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum PlanDuration { monthly, annually, lifetime }

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  PlanDuration selectedDuration = PlanDuration.monthly;
  final Set<int> selectedCategoryIndices = {0}; // 0: GOLD, 1: FOREX, 2: CRYPTO

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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  String _getPriceForDuration(AppLocalizations l10n) {
    switch (selectedDuration) {
      case PlanDuration.monthly:
        return l10n.price1Month;
      case PlanDuration.annually:
        return l10n.price12Months;
      case PlanDuration.lifetime:
        return l10n.priceLifetime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final purchaseService = context.watch<PurchaseService>();
    final isPurchasing = purchaseService.isPurchasePending;
    final l10n = AppLocalizations.of(context)!;

    final priceStr = _getPriceForDuration(l10n);

    final List<Map<String, String>> categories = [
      {'name': 'GOLD', 'price': priceStr},
      {'name': 'CURRENCY PAIR', 'price': priceStr},
      {'name': 'CRYPTO', 'price': priceStr},
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
                        Text(
                          l10n.choosePlanSubtitle,
                          style: const TextStyle(
                            color: Color(0xFF636363),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(child: _buildPlanToggle(l10n)),
                        
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

                        const SizedBox(height: 16),
                        // Auto-renewal description for Apple requirements
                        const Text(
                          "Subscription will automatically renew unless canceled at least 24 hours before the end of the current period. You can manage and cancel your subscriptions in your App Store account settings. Lifetime plan is a one-time purchase.",
                          style: TextStyle(
                            color: Color(0xFF636363),
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 24),
                        // Legal Links
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => _launchUrl('https://tuanminh2409bn.github.io/Signal-GPT-Privacy/'),
                              child: const Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: Color(0xFF276EFB),
                                  fontSize: 13,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const Text("|", style: TextStyle(color: Color(0xFF636363))),
                            TextButton(
                              onPressed: () => _launchUrl('https://www.apple.com/legal/internet-services/itunes/dev/stdeula/'),
                              child: const Text(
                                "Terms of Use (EULA)",
                                style: TextStyle(
                                  color: Color(0xFF276EFB),
                                  fontSize: 13,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                
                // Buy Now Button
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GestureDetector(
                    onTap: isPurchasing || selectedCategoryIndices.isEmpty 
                      ? null 
                      : () => _handleBuyNow(context, purchaseService),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: selectedCategoryIndices.isEmpty
                          ? const LinearGradient(colors: [Color(0xFF333333), Color(0xFF444444)])
                          : const LinearGradient(
                              colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)],
                            ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        selectedCategoryIndices.length > 1 
                          ? '${l10n.upgradeNow} (${selectedCategoryIndices.length})'
                          : l10n.upgradeNow,
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
    final l10n = AppLocalizations.of(context)!;
    
    // In-App Purchase doesn't support a "cart". We have to process them one by one.
    // If multiple packages are selected, we will process them sequentially.
    
    for (int index in selectedCategoryIndices) {
      String categoryName = '';
      if (index == 0) categoryName = 'gold';
      else if (index == 1) categoryName = 'forex';
      else if (index == 2) categoryName = 'crypto';

      String durationSuffix = '';
      if (selectedDuration == PlanDuration.monthly) {
        durationSuffix = Platform.isIOS ? 'monthly' : '1_month';
      } else if (selectedDuration == PlanDuration.annually) {
        durationSuffix = Platform.isIOS ? 'yearly' : '12_months';
      } else {
        durationSuffix = Platform.isIOS ? 'lifetime' : 'lifetime';
      }

      final String productId = Platform.isIOS ? '$categoryName.$durationSuffix' : '${categoryName}_$durationSuffix';

      final productIndex = purchaseService.products.indexWhere((p) => p.id == productId);
      if (productIndex == -1) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product not found: $productId. Please ensure it is configured in stores.')),
          );
        }
        break;
      }
      
      final product = purchaseService.products[productIndex];

      try {
        await purchaseService.buyProduct(product);
        // Note: the actual update to user data happens in PurchaseService via verifyPurchase Cloud Function.
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorWithMessage(e.toString()))),
          );
        }
        break; // Stop if one fails to prevent messy flow
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
      width: 320,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: const Color(0xFF289EFF)),
      ),
      child: Row(
        children: [
          _buildToggleOption(l10n.monthly, PlanDuration.monthly),
          _buildToggleOption(l10n.annually, PlanDuration.annually),
          _buildToggleOption(l10n.lifetime, PlanDuration.lifetime),
        ],
      ),
    );
  }

  Widget _buildToggleOption(String text, PlanDuration duration) {
    final isSelected = selectedDuration == duration;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedDuration = duration),
        child: Container(
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)])
                : null,
            borderRadius: BorderRadius.circular(60),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF636363),
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(int index, String name, String price, AppLocalizations l10n) {
    final isSelected = selectedCategoryIndices.contains(index);
    
    String durationText = '';
    if (selectedDuration == PlanDuration.monthly) {
      durationText = "/ month";
    } else if (selectedDuration == PlanDuration.annually) {
      durationText = "/ year";
    } else {
      durationText = ""; // no suffix for lifetime
    }
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            if (selectedCategoryIndices.length > 1) {
              selectedCategoryIndices.remove(index);
            }
          } else {
            selectedCategoryIndices.add(index);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        height: 60,
        decoration: isSelected 
          ? ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, 1.00),
                end: const Alignment(1.00, 0.12),
                colors: [
                  const Color(0xFF276EFB).withValues(alpha: 0.1), 
                  Colors.white.withValues(alpha: 0.02)
                ],
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFF276EFB),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            )
          : BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            if (isSelected)
              Image.asset(
                'assets/icons/tick.png',
                width: 18,
                height: 18,
                fit: BoxFit.contain,
              )
            else
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF636363),
                    width: 1.5,
                  ),
                ),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 18,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    l10n.upgradeToSeeMore,
                    style: TextStyle(
                      color: isSelected ? Colors.white.withValues(alpha: 0.7) : const Color(0xFF636363),
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              durationText.isEmpty ? price : "$price $durationText",
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

