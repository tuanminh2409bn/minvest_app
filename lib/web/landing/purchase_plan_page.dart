import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../theme/breakpoints.dart';
import 'sections/pricing_section.dart';

class PurchasePlanPage extends StatefulWidget {
  final String? initialPlan;

  const PurchasePlanPage({super.key, this.initialPlan});

  @override
  State<PurchasePlanPage> createState() => _PurchasePlanPageState();
}

class _PurchasePlanPageState extends State<PurchasePlanPage> {
  bool _isAnnual = true;
  final Set<String> _selectedPlans = {};

  @override
  void initState() {
    super.initState();
    if (widget.initialPlan != null) {
      _selectedPlans.add(widget.initialPlan!.toLowerCase());
    } else {
      _selectedPlans.add('forex');
    }
  }

  double _getPrice(String planId, AppLocalizations l10n) {
    // For simplicity, all plans have the same price structure in current l10n
    final priceStr = _isAnnual ? l10n.price12Months : l10n.price1Month;
    return double.tryParse(priceStr.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
  }

  String _getPlanTitle(String planId, AppLocalizations l10n) {
    switch (planId) {
      case 'forex':
        return 'Forex Signals';
      case 'gold':
        return 'Gold Signals';
      case 'crypto':
        return 'Crypto Signals';
      default:
        return planId.toUpperCase();
    }
  }

  double _calculateSubtotal(AppLocalizations l10n) {
    double subtotal = 0;
    for (var plan in _selectedPlans) {
      subtotal += _getPrice(plan, l10n);
    }
    return subtotal;
  }

  double _calculateDiscount(double subtotal) {
    if (_selectedPlans.length == 2) {
      return subtotal * 0.10; // 10% discount for 2 plans
    } else if (_selectedPlans.length >= 3) {
      return subtotal * 0.20; // 20% discount for 3+ plans
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        isMobile ? 24 : 64,
                        horizontalPadding,
                        isMobile ? 120 : 64, // Increased bottom padding for mobile
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isMobile)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildBackButton(context),
                                  const SizedBox(height: 32),
                                  _buildSelectionSection(l10n),
                                  const SizedBox(height: 32),
                                  _buildOrderSummary(l10n, isMobile: true),
                                ],
                              )
                            else
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _buildBackButton(context),
                                          const SizedBox(height: 32),
                                          _buildSelectionSection(l10n),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                    Expanded(
                                      flex: 2,
                                      child: _buildOrderSummary(l10n),
                                    ),
                                  ],
                                ),
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

  Widget _buildSelectionSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Purchase Plan',
          style: AppTextStyles.heroTitle.copyWith(
            fontSize: 48,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 48),
        Text(
          'Billing cycle',
          style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 16),
        _buildBillingToggle(l10n),
        const SizedBox(height: 48),
        Text(
          'Signal Plans',
          style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          'Enjoy discounts of up to 20% when you purchase multiple packages at once.',
          style: AppTextStyles.body.copyWith(
            color: const Color(0xFF9A9A9A),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 24),
        _buildPlanItem('forex', 'Forex Signals', l10n),
        const SizedBox(height: 12),
        _buildPlanItem('gold', 'Gold Signals', l10n),
        const SizedBox(height: 12),
        _buildPlanItem('crypto', 'Crypto Signals', l10n),
      ],
    );
  }

  Widget _buildBillingToggle(AppLocalizations l10n) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _toggleItem(
          'Annually (50%)',
          selected: _isAnnual,
          onTap: () => setState(() => _isAnnual = true),
        ),
        _toggleItem(
          '6 Month (50% Off)',
          selected: !_isAnnual,
          onTap: () => setState(() => _isAnnual = false),
        ),
      ],
    );
  }

  Widget _toggleItem(String text, {required bool selected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? const Color(0xFF289EFF) : const Color(0xFF424242),
                width: 2,
              ),
            ),
            child: selected
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
          Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: selected ? const Color(0xFF289EFF) : Colors.white,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanItem(String id, String title, AppLocalizations l10n) {
    final isSelected = _selectedPlans.contains(id);
    final price = _getPrice(id, l10n);

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            if (_selectedPlans.length > 1) {
              _selectedPlans.remove(id);
            }
          } else {
            _selectedPlans.add(id);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? const Color(0xFF289EFF) : const Color(0xFF424242),
            width: 1,
          ),
          boxShadow: isSelected
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
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF289EFF) : const Color(0xFF424242),
                  width: 2,
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
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.body.copyWith(color: Colors.white),
              ),
            ),
            Text(
              '\$${price.toStringAsFixed(0)}',
              style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(AppLocalizations l10n, {bool isMobile = false}) {
    final subtotal = _calculateSubtotal(l10n);
    final discount = _calculateDiscount(subtotal);
    final total = subtotal - discount;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF424242)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Order summary',
            style: AppTextStyles.bodyBold.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 24),
          ..._selectedPlans.map((planId) {
            final title = '${_getPlanTitle(planId, l10n)} (${_isAnnual ? 'Annually' : '6 Month (50% Off)'})';
            final price = '\$${_getPrice(planId, l10n).toStringAsFixed(0)}';
            return _summaryRow(title, price, isSmall: true);
          }),
          const SizedBox(height: 16),
          _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(0)}'),
          if (!isMobile) const Spacer() else const SizedBox(height: 32),
          if (discount > 0)
            _summaryRow('Discount', '-\$${discount.toStringAsFixed(0)}', isDiscount: true),
          _summaryRow('Total', '\$${total.toStringAsFixed(0)}', isTotal: true),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/payment-method',
                  arguments: {
                    'totalAmount': total,
                    'selectedPlans': _selectedPlans.toList(),
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Text(
                'Next',
                style: AppTextStyles.bodyBold.copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isDiscount = false, bool isTotal = false, bool isSmall = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF262626), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: isTotal 
                  ? AppTextStyles.bodyBold.copyWith(fontSize: 18, color: Colors.white)
                  : AppTextStyles.body.copyWith(
                      color: isDiscount ? const Color(0xFF289EFF) : Colors.white,
                      fontSize: isSmall ? 15 : 16,
                    ),
            ),
          ),
          Text(
            value,
            style: isTotal
                ? AppTextStyles.bodyBold.copyWith(fontSize: 20, color: const Color(0xFF289EFF))
                : AppTextStyles.bodyBold.copyWith(
                    color: isDiscount ? const Color(0xFF289EFF) : Colors.white,
                    fontSize: isSmall ? 15 : 16,
                  ),
          ),
        ],
      ),
    );
  }
}
