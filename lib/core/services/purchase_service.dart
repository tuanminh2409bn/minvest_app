// lib/core/services/purchase_service.dart

import 'dart:async';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class PurchaseService extends ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  FirebaseFunctions get _functions => FirebaseFunctions.instanceFor(region: 'asia-southeast1');
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  final Set<String> _androidIds = {
    'gold_1_month', 'gold_12_months',
    'forex_1_month', 'forex_12_months',
    'crypto_1_month', 'crypto_12_months',
  };
  
  // Các ID iOS mới khớp với Android (thay _ bằng .)
  final Set<String> _iosIds = {
    'gold.1.month', 'gold.12.months',
    'forex.1.month', 'forex.12.months',
    'crypto.1.month', 'crypto.12.months',
  };

  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;
  bool _isStoreAvailable = false;
  bool get isStoreAvailable => _isStoreAvailable;
  bool _isPurchasePending = false;
  bool get isPurchasePending => _isPurchasePending;

  Future<void> initialize() async {
    if (kIsWeb) {
      debugPrint("Store không khả dụng trên Web.");
      return;
    }
    _isStoreAvailable = await _inAppPurchase.isAvailable();
    debugPrint("Store khả dụng: $_isStoreAvailable");
    if (_isStoreAvailable) {
      await _loadProducts();
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
        await _clearStuckTransactions();
      }
      _subscription = _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () { _subscription?.cancel(); }, onError: (error) { _setPurchasePending(false); });
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    final bool isIOS = !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
    final Set<String> kIds = isIOS ? _iosIds : _androidIds;
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(kIds);
    if (response.notFoundIDs.isNotEmpty) {}
    _products = response.productDetails;
    notifyListeners();
  }

  Future<void> buyProduct(ProductDetails productDetails) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending: _setPurchasePending(true); break;
        case PurchaseStatus.error:
          _setPurchasePending(false);
          if (purchaseDetails.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchaseDetails);
          }
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _handleSuccessfulPurchase(purchaseDetails);
          break;
        case PurchaseStatus.canceled:
          _setPurchasePending(false);
          if (purchaseDetails.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchaseDetails);
          }
          break;
      }
    }
  }

  Future<void> _handleSuccessfulPurchase(PurchaseDetails purchaseDetails) async {
    _setPurchasePending(true);

    final String verificationData = purchaseDetails.verificationData.serverVerificationData;

    if (verificationData.isEmpty) {
      debugPrint('❌ CẢNH BÁO: Dữ liệu biên lai (serverVerificationData) bị rỗng!');
      _setPurchasePending(false);
      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
      return;
    }
    debugPrint('🧾 Lấy được biên lai kiểu mới (JWS), độ dài: ${verificationData.length} ký tự.');

    try {
      final String platform = (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) ? 'ios' : 'android';
      final payload = {
        'platform': platform,
        'productId': purchaseDetails.productID,
        'transactionData': {
          platform == 'ios' ? 'receiptData' : 'purchaseToken': verificationData
        },
      };

      debugPrint("🚀 Đang gửi payload lên Cloud Function 'verifyPurchase'...");
      final HttpsCallable callable = _functions.httpsCallable('verifyPurchase');
      final HttpsCallableResult result = await callable.call(payload);

      if (result.data['success'] == true) {
        debugPrint("🎉🎉🎉 XÁC THỰC THÀNH CÔNG! Server đã nâng cấp tài khoản. 🎉🎉🎉");
      } else {
        debugPrint("❌ SERVER TỪ CHỐI XÁC THỰC: ${result.data['message']}");
      }
    } catch (e) {
      debugPrint("🔥 LỖI NGHIÊM TRỌNG KHI GỌI HÀM VERIFYPURCHASE 🔥");
      if (e is FirebaseFunctionsException) {
        debugPrint("   - MÃ LỖI FIREBASE: ${e.code}");
        debugPrint("   - THÔNG ĐIỆP: ${e.message}");
        debugPrint("   - CHI TIẾT: ${e.details}");
      } else {
        debugPrint("   - LỖI KHÔNG XÁC ĐỊNH: $e");
      }
    } finally {
      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
        debugPrint("✅ Đã gọi completePurchase() cho giao dịch.");
      }
      _setPurchasePending(false);
    }
  }

  void _setPurchasePending(bool isPending) {
    _isPurchasePending = isPending;
    notifyListeners();
  }

  Future<void> _clearStuckTransactions() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      try {
        final transactions = await SKPaymentQueueWrapper().transactions();
        if (transactions.isEmpty) { return; }
        for (final skPaymentTransaction in transactions) {
          SKPaymentQueueWrapper().finishTransaction(skPaymentTransaction);
        }
      } catch (e) {}
    }
  }
}