// lib/features/verification/screens/package_screen_mobile.dart

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});
  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  Map<String, ProductDetails> _products = {};
  bool _isAvailable = false;
  bool _isLoading = true;
  bool _isPurchasing = false;
  String _loadingError = '';
  final Set<String> _kIds = Platform.isIOS
      ? {'minvest.01', 'minvest.12'}
      : {'elite_1_month', 'elite_12_months'};

  bool _isInitialized = false;
  late AppLocalizations l10n;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      l10n = AppLocalizations.of(context)!;
      final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
      _subscription = purchaseUpdated.listen((purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () {
        _subscription.cancel();
      }, onError: (error) {
        if (mounted) setState(() => _isPurchasing = false);
      });
      _initStoreInfo();
      _isInitialized = true;
    }
  }

  Future<void> _initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      if (mounted) {
        setState(() {
          _isAvailable = false;
          _isLoading = false;
          _loadingError = l10n.iapStoreNotAvailable;
        });
      }
      return;
    }
    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_kIds);
    if (mounted) {
      setState(() {
        _isAvailable = true;
        _products = {
          for (var p in productDetailResponse.productDetails) p.id: p
        };
        _isLoading = false;
        if (productDetailResponse.error != null) {
          _loadingError = l10n.iapErrorLoadingProducts(productDetailResponse.error!.message);
        } else if (_products.isEmpty) {
          _loadingError = l10n.iapNoProductsFound;
        }
      });
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        if (mounted) setState(() => _isPurchasing = true);
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          if (mounted) setState(() => _isPurchasing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.iapTransactionError(purchaseDetails.error?.message ?? 'Unknown error'))),
          );
        } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
          _verifyPurchase(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    if (mounted) setState(() => _isPurchasing = true);
    try {
      final HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'asia-southeast1').httpsCallable('verifyPurchase');
      final String platform = Platform.isIOS ? 'ios' : 'android';
      Map<String, dynamic> transactionData = {};
      if (platform == 'ios') {
        transactionData['receiptData'] = purchaseDetails.verificationData.serverVerificationData;
      } else {
        transactionData['purchaseToken'] = purchaseDetails.verificationData.serverVerificationData;
      }
      final HttpsCallableResult result = await callable.call<dynamic>({
        'platform': platform,
        'productId': purchaseDetails.productID,
        'transactionData': transactionData,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.data['message'] ?? l10n.loginSuccess), backgroundColor: Colors.green),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } on FirebaseFunctionsException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.iapVerificationError(e.message ?? '')), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.iapUnknownError(e.toString())), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isPurchasing = false);
    }
  }

  void _handlePurchase(ProductDetails productDetails) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(l10n.packageTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D1117), Color(0xFF161B22), Color.fromARGB(255, 20, 29, 110)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(child: _buildIapContent(l10n)),
          ),
          if (_isPurchasing)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(l10n.iapProcessingTransaction, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIapContent(AppLocalizations l10n) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!_isAvailable || _loadingError.isNotEmpty) {
      return _buildErrorWidget(context, _loadingError);
    }
    final product1Month = _products[Platform.isIOS ? 'minvest.01' : 'elite_1_month'];
    final product12Months = _products[Platform.isIOS ? 'minvest.12' : 'elite_12_months'];
    final features = [
      l10n.featureReceiveAllSignals,
      l10n.featureAnalyzeReason,
      l10n.featureHighPrecisionAI,
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        children: [
          _PackageCard(
            tier: l10n.tierElite,
            duration: l10n.duration1Month,
            price: product1Month?.price ?? '...',
            features: features,
            onPressed: product1Month != null ? () => _handlePurchase(product1Month) : null,
          ),
          const SizedBox(height: 24),
          _PackageCard(
            tier: l10n.tierElite,
            duration: l10n.duration12Months,
            price: product12Months?.price ?? '...',
            features: features,
            onPressed: product12Months != null ? () => _handlePurchase(product12Months) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String errorMessage) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 20),
            Text(
              l10n.errorLoadingPackages,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
              onPressed: () {
                _initStoreInfo();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final String tier;
  final String duration;
  final String price;
  final List<String> features;
  final VoidCallback? onPressed;

  const _PackageCard({
    required this.tier,
    required this.duration,
    required this.price,
    required this.features,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF157CC9), Color(0xFF2A43B9), Color(0xFFC611CE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC611CE).withOpacity(0.5),
                blurRadius: 25.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.diamond_outlined, color: Colors.amber, size: 22),
                  const SizedBox(width: 8),
                  Text(tier, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(duration, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Colors.green, size: 16),
                    const SizedBox(width: 10),
                    Expanded(child: Text(feature, style: const TextStyle(color: Colors.white70, fontSize: 13))),
                  ],
                ),
              )),
              const SizedBox(height: 24),
              // ▼▼▼ BẮT ĐẦU SỬA ĐỔI ▼▼▼
              Center(
                child: Column(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.amber),
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      text: l10n.startNow,
                      onPressed: onPressed,
                      isPrimary: true,
                    ),
                  ],
                ),
              ),
              // ▲▲▲ KẾT THÚC SỬA ĐỔI ▲▲▲
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildActionButton(
    {required String text,
      required VoidCallback? onPressed,
      required bool isPrimary}) {
  final bool isEnabled = onPressed != null;
  // ▼▼▼ BẮT ĐẦU SỬA ĐỔI ▼▼▼
  return SizedBox(
    height: 45,
    width: double.infinity, // Kéo dài nút ra toàn bộ chiều rộng
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        disabledBackgroundColor: Colors.grey.withOpacity(0.2),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: isEnabled && isPrimary
              ? const LinearGradient(
            colors: [Color(0xFF172AFE), Color(0xFF3C4BFE), Color(0xFF5E69FD)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
              : null,
          color: isEnabled && !isPrimary ? const Color(0xFF151a2e) : null,
          borderRadius: BorderRadius.circular(12),
          border: isEnabled && !isPrimary
              ? Border.all(color: Colors.blueAccent)
              : null,
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16), // Thêm padding ngang
          child: FittedBox( // Tự động co chữ nếu cần, nhưng ưu tiên không xuống dòng
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16, // Tăng nhẹ cỡ chữ cho nút
                color: isEnabled ? Colors.white : Colors.grey,
              ),
              maxLines: 1, // Đảm bảo chỉ có 1 dòng
            ),
          ),
        ),
      ),
    ),
  );
  // ▲▲▲ KẾT THÚC SỬA ĐỔI ▲▲▲
}